import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RealtimeSyncDemo extends StatefulWidget {
  const RealtimeSyncDemo({super.key});

  @override
  State<RealtimeSyncDemo> createState() => _RealtimeSyncDemoState();
}

class _RealtimeSyncDemoState extends State<RealtimeSyncDemo> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  
  String _currentUserId = 'demo_user_${DateTime.now().millisecondsSinceEpoch}';
  bool _isListening = false;
  List<String> _activityLog = [];

  @override
  void initState() {
    super.initState();
    _startManualListeners();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _taskController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  void _startManualListeners() {
    setState(() {
      _isListening = true;
    });

    // Listen to messages collection for custom logic
    FirebaseFirestore.instance
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      for (var change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.added) {
          _addToActivityLog('New message added: ${change.doc['text']}');
        } else if (change.type == DocumentChangeType.modified) {
          _addToActivityLog('Message updated: ${change.doc['text']}');
        } else if (change.type == DocumentChangeType.removed) {
          _addToActivityLog('Message removed: ${change.doc['text']}');
        }
      }
    });

    // Listen to tasks collection
    FirebaseFirestore.instance
        .collection('tasks')
        .snapshots()
        .listen((snapshot) {
      for (var change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.added) {
          _addToActivityLog('New task created: ${change.doc['title']}');
          _showNotification('New Task', change.doc['title']);
        }
      }
    });
  }

  void _addToActivityLog(String activity) {
    setState(() {
      _activityLog.insert(0, '${DateTime.now().toString().substring(11, 19)}: $activity');
      if (_activityLog.length > 10) {
        _activityLog = _activityLog.take(10).toList();
      }
    });
  }

  void _showNotification(String title, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title: $message'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _addMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    try {
      await FirebaseFirestore.instance.collection('messages').add({
        'text': _messageController.text.trim(),
        'userId': _currentUserId,
        'timestamp': FieldValue.serverTimestamp(),
        'type': 'user_message',
      });
      _messageController.clear();
      _addToActivityLog('Message sent successfully');
    } catch (e) {
      _showNotification('Error', 'Failed to send message: $e');
    }
  }

  Future<void> _addTask() async {
    if (_taskController.text.trim().isEmpty) return;

    try {
      await FirebaseFirestore.instance.collection('tasks').add({
        'title': _taskController.text.trim(),
        'completed': false,
        'userId': _currentUserId,
        'createdAt': FieldValue.serverTimestamp(),
        'priority': 'normal',
      });
      _taskController.clear();
      _addToActivityLog('Task created successfully');
    } catch (e) {
      _showNotification('Error', 'Failed to create task: $e');
    }
  }

  Future<void> _updateUserStatus() async {
    if (_statusController.text.trim().isEmpty) return;

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUserId)
          .set({
        'status': _statusController.text.trim(),
        'lastUpdated': FieldValue.serverTimestamp(),
        'name': 'Demo User',
        'email': 'demo@example.com',
      }, SetOptions(merge: true));
      _statusController.clear();
      _addToActivityLog('Status updated successfully');
    } catch (e) {
      _showNotification('Error', 'Failed to update status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Real-Time Firestore Sync'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          Icon(
            _isListening ? Icons.sync : Icons.sync_disabled,
            color: _isListening ? Colors.green : Colors.grey,
          ),
          const SizedBox(width: 8),
          Text(
            _isListening ? 'Listening' : 'Offline',
            style: TextStyle(
              color: _isListening ? Colors.green : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Real-Time Messages Section
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.message, color: Colors.blue),
                        const SizedBox(width: 8),
                        Text(
                          'Live Messages',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 200,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('messages')
                            .orderBy('timestamp', descending: true)
                            .limit(10)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }

                          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                            return const Center(
                              child: Text(
                                'No messages yet. Send one below!',
                                style: TextStyle(color: Colors.grey),
                              ),
                            );
                          }

                          final messages = snapshot.data!.docs;

                          return ListView.builder(
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              final message = messages[index];
                              final data = message.data() as Map<String, dynamic>;
                              final timestamp = data['timestamp'] as Timestamp?;
                              final timeString = timestamp != null
                                  ? '${timestamp.toDate().hour.toString().padLeft(2, '0')}:'
                                    '${timestamp.toDate().minute.toString().padLeft(2, '0')}'
                                  : 'Just now';

                              return Card(
                                color: Colors.blue.shade50,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  title: Text(data['text'] ?? 'No message'),
                                  subtitle: Text(timeString),
                                  trailing: Text(
                                    timeString,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            decoration: const InputDecoration(
                              labelText: 'Type a message',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.message),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _addMessage,
                          child: const Text('Send'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Real-Time Tasks Section
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.task, color: Colors.green),
                        const SizedBox(width: 8),
                        Text(
                          'Live Tasks',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 150,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('tasks')
                            .where('userId', isEqualTo: _currentUserId)
                            .orderBy('createdAt', descending: true)
                            .limit(5)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }

                          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                            return const Center(
                              child: Text(
                                'No tasks yet. Create one below!',
                                style: TextStyle(color: Colors.grey),
                              ),
                            );
                          }

                          final tasks = snapshot.data!.docs;

                          return ListView.builder(
                            itemCount: tasks.length,
                            itemBuilder: (context, index) {
                              final task = tasks[index];
                              final data = task.data() as Map<String, dynamic>;
                              final isCompleted = data['completed'] ?? false;

                              return Card(
                                color: isCompleted ? Colors.green.shade50 : Colors.orange.shade50,
                                child: ListTile(
                                  leading: Icon(
                                    isCompleted ? Icons.check_circle : Icons.circle,
                                    color: isCompleted ? Colors.green : Colors.orange,
                                  ),
                                  title: Text(data['title'] ?? 'No title'),
                                  subtitle: Text(
                                    isCompleted ? 'Completed' : 'Pending',
                                    style: TextStyle(
                                      color: isCompleted ? Colors.green : Colors.orange,
                                    ),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          isCompleted ? Icons.undo : Icons.check,
                                          color: isCompleted ? Colors.orange : Colors.green,
                                        ),
                                        onPressed: () => _toggleTask(task.id, !isCompleted),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete, color: Colors.red),
                                        onPressed: () => _deleteTask(task.id),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _taskController,
                            decoration: const InputDecoration(
                              labelText: 'New task',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.add_task),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _addTask,
                          child: const Text('Add Task'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Real-Time User Status Section
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, color: Colors.purple),
                        const SizedBox(width: 8),
                        Text(
                          'Live User Status',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(_currentUserId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        if (!snapshot.hasData || !snapshot.data!.exists) {
                          return const Center(
                            child: Text(
                              'No user data yet. Update status below!',
                              style: TextStyle(color: Colors.grey),
                            ),
                          );
                        }

                        final data = snapshot.data!.data() as Map<String, dynamic>?;
                        final status = data?['status'] ?? 'No status';
                        final lastUpdated = data?['lastUpdated'] as Timestamp?;
                        final timeString = lastUpdated != null
                            ? 'Updated: ${lastUpdated.toDate().toString().substring(11, 19)}'
                            : 'Never updated';

                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.purple.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Status: $status',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                timeString,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _statusController,
                            decoration: const InputDecoration(
                              labelText: 'Update status',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.edit),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _updateUserStatus,
                          child: const Text('Update'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Activity Log Section
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.history, color: Colors.orange),
                        const SizedBox(width: 8),
                        Text(
                          'Activity Log',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: _activityLog.isEmpty
                          ? const Center(
                              child: Text(
                                'No activities yet. Start interacting!',
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          : ListView.builder(
                              itemCount: _activityLog.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2,
                                    horizontal: 8,
                                  ),
                                  child: Text(
                                    _activityLog[index],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'monospace',
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _toggleTask(String taskId, bool completed) async {
    try {
      await FirebaseFirestore.instance
          .collection('tasks')
          .doc(taskId)
          .update({'completed': completed});
      _addToActivityLog('Task ${completed ? 'completed' : 'reopened'}');
    } catch (e) {
      _showNotification('Error', 'Failed to toggle task: $e');
    }
  }

  Future<void> _deleteTask(String taskId) async {
    try {
      await FirebaseFirestore.instance
          .collection('tasks')
          .doc(taskId)
          .delete();
      _addToActivityLog('Task deleted');
    } catch (e) {
      _showNotification('Error', 'Failed to delete task: $e');
    }
  }
}

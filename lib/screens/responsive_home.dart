import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResponsiveHome extends StatefulWidget {
  const ResponsiveHome({Key? key}) : super(key: key);

  @override
  State<ResponsiveHome> createState() => _ResponsiveHomeState();
}

class _ResponsiveHomeState extends State<ResponsiveHome> {
  int _selectedEventIndex = 0;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late final Stream<QuerySnapshot<Map<String, dynamic>>> _tasksStream;
  late final Future<QuerySnapshot<Map<String, dynamic>>> _tasksOnceFuture;
  Future<DocumentSnapshot<Map<String, dynamic>>>? _userFuture;
  String? _currentUserUid;

  final List<Map<String, String>> _eventCategories = [
    {
      'title': 'Creative Events',
      'description': 'Unconventional ideas that inspire creativity',
      'icon': 'lightbulb',
      'color': 'amber'
    },
    {
      'title': 'Sports Activities',
      'description': 'Physical challenges and competitions',
      'icon': 'sports_soccer',
      'color': 'green'
    },
    {
      'title': 'Academic Competitions',
      'description': 'Intellectual challenges and learning',
      'icon': 'school',
      'color': 'blue'
    },
    {
      'title': 'Social Gatherings',
      'description': 'Community building and networking',
      'icon': 'groups',
      'color': 'purple'
    },
    {
      'title': 'Cultural Events',
      'description': 'Celebrating diversity and traditions',
      'icon': 'celebration',
      'color': 'red'
    },
    {
      'title': 'Tech Workshops',
      'description': 'Hands-on technology learning',
      'icon': 'computer',
      'color': 'indigo'
    }
  ];

  @override
  void initState() {
    super.initState();
    _tasksStream = _firestore.collection('tasks').snapshots();
    _tasksOnceFuture = _firestore.collection('tasks').get();
    _currentUserUid = _auth.currentUser?.uid;
    if (_currentUserUid != null) {
      _userFuture = _firestore.collection('users').doc(_currentUserUid).get();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;
          bool isTablet = screenWidth > 600;
          bool isDesktop = screenWidth > 1200;
          bool isLandscape = constraints.maxWidth > constraints.maxHeight;

          return Column(
            children: [
              // Responsive Header
              _buildResponsiveHeader(screenWidth, isTablet, isLandscape),
              
              // Main Content Area
              Expanded(
                child: _buildMainContent(screenWidth, screenHeight, isTablet, isDesktop, isLandscape),
              ),
              
              // Responsive Footer
              _buildResponsiveFooter(screenWidth, isTablet),
            ],
          );
        },
      ),
    );
  }

  Widget _buildResponsiveHeader(double screenWidth, bool isTablet, bool isLandscape) {
    double headerHeight = isLandscape ? 80 : (isTablet ? 120 : 100);
    double fontSize = isTablet ? 24 : 20;
    double iconSize = isTablet ? 32 : 24;

    return Container(
      height: headerHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple.shade600, Colors.blue.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 24 : 16,
          vertical: 8,
        ),
        child: Row(
          children: [
            Icon(
              Icons.event,
              size: iconSize,
              color: Colors.white,
            ),
            SizedBox(width: isTablet ? 16 : 12),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'School Event Planner',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (isTablet) ...[
              Icon(
                Icons.phone_android,
                size: iconSize,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              Text(
                '${screenWidth.toInt()}px',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: fontSize * 0.7,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent(double screenWidth, double screenHeight, bool isTablet, bool isDesktop, bool isLandscape) {
    if (isDesktop) {
      return _buildDesktopLayout(screenWidth, screenHeight);
    } else if (isTablet && !isLandscape) {
      return _buildTabletLayout(screenWidth, screenHeight);
    } else {
      return _buildMobileLayout(screenWidth, screenHeight);
    }
  }

  Widget _buildDesktopLayout(double screenWidth, double screenHeight) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          // Left Panel - Categories
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Event Categories',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.shade800,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: _eventCategories.length,
                    itemBuilder: (context, index) {
                      return _buildCategoryCard(_eventCategories[index], true);
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          // Right Panel - Selected Category Details
          Expanded(
            flex: 1,
            child: _buildCategoryDetails(_eventCategories[_selectedEventIndex]),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(double screenWidth, double screenHeight) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Choose Event Category',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple.shade800,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 240,
            child: _buildFirestoreSection(isCompact: true),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.1,
              ),
              itemCount: _eventCategories.length,
              itemBuilder: (context, index) {
                return _buildCategoryCard(_eventCategories[index], false);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(double screenWidth, double screenHeight) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Text(
            'Event Categories',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple.shade800,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 220,
            child: _buildFirestoreSection(isCompact: true),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: _eventCategories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: _buildCategoryCard(_eventCategories[index], false),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, String> category, bool isDesktop) {
    IconData iconData = _getIconData(category['icon']!);
    Color cardColor = _getColorFromName(category['color']!);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedEventIndex = _eventCategories.indexOf(category);
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(isDesktop ? 16 : 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [cardColor.withOpacity(0.1), cardColor.withOpacity(0.05)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: isDesktop ? 40 : 32,
                color: cardColor,
              ),
              SizedBox(height: isDesktop ? 12 : 8),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  category['title']!,
                  style: TextStyle(
                    fontSize: isDesktop ? 16 : 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.shade800,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              if (isDesktop) ...[
                const SizedBox(height: 8),
                Text(
                  category['description']!,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryDetails(Map<String, String> category) {
    IconData iconData = _getIconData(category['icon']!);
    Color cardColor = _getColorFromName(category['color']!);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(iconData, size: 48, color: cardColor),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  category['title']!,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.shade800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            category['description']!,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: _buildFirestoreSection(isCompact: false),
          ),
        ],
      ),
    );
  }

  Widget _buildFirestoreSection({required bool isCompact}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isCompact ? 12 : 16),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepPurple.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Live Firestore Tasks',
            style: TextStyle(
              fontSize: isCompact ? 15 : 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple.shade700,
            ),
          ),
          const SizedBox(height: 6),
          _buildTasksSummary(),
          const SizedBox(height: 6),
          _buildUserSummary(),
          const SizedBox(height: 8),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: _showAddTaskDialog,
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Add Task'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  textStyle: const TextStyle(fontSize: 12),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Edit/Delete from list',
                style: TextStyle(color: Colors.grey.shade700, fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: _buildLiveTasksList(maxItems: isCompact ? 3 : null),
          ),
        ],
      ),
    );
  }

  Widget _buildTasksSummary() {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: _tasksOnceFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text(
            'Loading task count...',
            style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
          );
        }

        if (snapshot.hasError) {
          return Text(
            'Task count unavailable',
            style: TextStyle(color: Colors.red.shade700, fontSize: 12),
          );
        }

        final count = snapshot.data?.docs.length ?? 0;
        return Text(
          'One-time read: $count task(s) found',
          style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
        );
      },
    );
  }

  Widget _buildUserSummary() {
    if (_currentUserUid == null || _userFuture == null) {
      return Text(
        'Single-doc read: no signed-in user',
        style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
      );
    }

    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: _userFuture!,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text(
            'Loading user profile...',
            style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
          );
        }

        if (snapshot.hasError) {
          return Text(
            'User read failed',
            style: TextStyle(color: Colors.red.shade700, fontSize: 12),
          );
        }

        final doc = snapshot.data;
        if (doc == null || !doc.exists) {
          return Text(
            'Single-doc read: user not found',
            style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
          );
        }

        final userData = doc.data() ?? <String, dynamic>{};
        final userName = _safeString(userData['name'], fallback: 'No name');
        return Text(
          'Single-doc read: $userName (${_currentUserUid!.substring(0, _currentUserUid!.length > 8 ? 8 : _currentUserUid!.length)}...)',
          style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
        );
      },
    );
  }

  Widget _buildLiveTasksList({int? maxItems}) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _tasksStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Could not load tasks',
              style: TextStyle(color: Colors.red.shade700),
            ),
          );
        }

        final allDocs = snapshot.data?.docs ?? [];
        final docs = maxItems == null ? allDocs : allDocs.take(maxItems).toList();

        if (docs.isEmpty) {
          return Center(
            child: Text(
              'No tasks yet. Add one in Firebase Console.',
              style: TextStyle(color: Colors.grey.shade700),
              textAlign: TextAlign.center,
            ),
          );
        }

        return ListView.separated(
          itemCount: docs.length,
          separatorBuilder: (_, __) => const Divider(height: 8),
          itemBuilder: (context, index) {
            final taskData = docs[index].data();
            final title = _safeString(taskData['title'], fallback: 'Untitled');
            final description = _safeString(taskData['description'], fallback: 'No description');

            return ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.task_alt, size: 18),
              title: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, size: 18),
                    tooltip: 'Edit task',
                    onPressed: () => _showEditTaskDialog(docs[index]),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 18),
                    tooltip: 'Delete task',
                    onPressed: () => _deleteTask(docs[index]),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _showAddTaskDialog() async {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Firestore Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                minLines: 2,
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final title = titleController.text.trim();
                final description = descriptionController.text.trim();

                if (title.isEmpty) {
                  ScaffoldMessenger.of(this.context).showSnackBar(
                    const SnackBar(content: Text('Title is required')),
                  );
                  return;
                }

                try {
                  await _firestore.collection('tasks').add({
                    'title': title,
                    'description': description.isEmpty ? 'No description' : description,
                    'ownerUid': _currentUserUid,
                    'updatedAt': FieldValue.serverTimestamp(),
                  });
                  if (mounted) {
                    Navigator.of(this.context, rootNavigator: true).pop();
                    ScaffoldMessenger.of(this.context).showSnackBar(
                      const SnackBar(content: Text('Task added')),
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(this.context).showSnackBar(
                      SnackBar(content: Text('Add failed: $e')),
                    );
                  }
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditTaskDialog(DocumentSnapshot<Map<String, dynamic>> doc) async {
    final data = doc.data() ?? <String, dynamic>{};
    final titleController = TextEditingController(
      text: _safeString(data['title'], fallback: ''),
    );
    final descriptionController = TextEditingController(
      text: _safeString(data['description'], fallback: ''),
    );

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Firestore Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                minLines: 2,
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final title = titleController.text.trim();
                final description = descriptionController.text.trim();

                if (title.isEmpty) {
                  ScaffoldMessenger.of(this.context).showSnackBar(
                    const SnackBar(content: Text('Title is required')),
                  );
                  return;
                }

                try {
                  await doc.reference.update({
                    'title': title,
                    'description': description.isEmpty ? 'No description' : description,
                    'updatedAt': FieldValue.serverTimestamp(),
                  });
                  if (mounted) {
                    Navigator.of(this.context, rootNavigator: true).pop();
                    ScaffoldMessenger.of(this.context).showSnackBar(
                      const SnackBar(content: Text('Task updated')),
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(this.context).showSnackBar(
                      SnackBar(content: Text('Update failed: $e')),
                    );
                  }
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteTask(DocumentSnapshot<Map<String, dynamic>> doc) async {
    final taskData = doc.data() ?? <String, dynamic>{};
    final title = _safeString(taskData['title'], fallback: 'Untitled');
    final shouldDelete = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Task'),
            content: Text('Delete "$title"?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Delete'),
              ),
            ],
          ),
        ) ??
        false;

    if (!shouldDelete) return;

    try {
      await doc.reference.delete();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task deleted')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Delete failed: $e')),
        );
      }
    }
  }

  String _safeString(dynamic value, {required String fallback}) {
    if (value == null) return fallback;
    if (value is String) {
      final trimmed = value.trim();
      return trimmed.isEmpty ? fallback : trimmed;
    }

    return value.toString();
  }

  Widget _buildResponsiveFooter(double screenWidth, bool isTablet) {
    double footerHeight = isTablet ? 80 : 70;
    double buttonHeight = isTablet ? 48 : 40;
    double fontSize = isTablet ? 16 : 14;

    return Container(
      height: footerHeight,
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 24 : 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border(
          top: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Creating new event...'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: Text(
                'Create Event',
                style: TextStyle(fontSize: fontSize),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple.shade600,
                foregroundColor: Colors.white,
                minimumSize: Size(0, buttonHeight),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          if (isTablet) ...[
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Viewing all events...'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                icon: const Icon(Icons.list),
                label: Text(
                  'View All Events',
                  style: TextStyle(fontSize: fontSize),
                ),
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(0, buttonHeight),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'lightbulb':
        return Icons.lightbulb;
      case 'sports_soccer':
        return Icons.sports_soccer;
      case 'school':
        return Icons.school;
      case 'groups':
        return Icons.groups;
      case 'celebration':
        return Icons.celebration;
      case 'computer':
        return Icons.computer;
      default:
        return Icons.event;
    }
  }

  Color _getColorFromName(String colorName) {
    switch (colorName) {
      case 'amber':
        return Colors.amber;
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      case 'purple':
        return Colors.purple;
      case 'red':
        return Colors.red;
      case 'indigo':
        return Colors.indigo;
      default:
        return Colors.grey;
    }
  }
}

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

  Future<DocumentSnapshot<Map<String, dynamic>>>? _userFuture;
  String? _currentUserUid;

  bool _showOnlyIncomplete = true;
  bool _showOnlyFeatured = false;
  bool _priorityDescending = false;
  int _minimumPriority = 1;
  int _queryLimit = 10;
  String _statusFilter = 'active';

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
    _currentUserUid = _auth.currentUser?.uid;
    if (_currentUserUid != null) {
      _userFuture = _firestore.collection('users').doc(_currentUserUid).get();
    }
  }

  Query<Map<String, dynamic>> _buildTasksQuery() {
    Query<Map<String, dynamic>> query = _firestore.collection('tasks');

    if (_statusFilter != 'all') {
      query = query.where('status', isEqualTo: _statusFilter);
    }

    if (_showOnlyIncomplete) {
      query = query.where('isCompleted', isEqualTo: false);
    }

    if (_showOnlyFeatured) {
      query = query.where('tags', arrayContains: 'featured');
    }

    query = query
        .where('priority', isGreaterThanOrEqualTo: _minimumPriority)
        .orderBy('priority', descending: _priorityDescending)
        .orderBy('createdAt', descending: true)
        .limit(_queryLimit);

    return query;
  }

  String _queryPreviewText() {
    final statusLabel = _statusFilter == 'all' ? 'all statuses' : _statusFilter;
    final completionLabel = _showOnlyIncomplete ? 'incomplete only' : 'all tasks';
    final featuredLabel = _showOnlyFeatured ? 'featured only' : 'all tags';
    final direction = _priorityDescending ? 'DESC' : 'ASC';

    return 'where(status==$statusLabel) + where(priority>=${_minimumPriority.toString()}) + '
        '$completionLabel + $featuredLabel | orderBy(priority $direction), orderBy(createdAt DESC) | limit($_queryLimit)';
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
          _buildQueryControls(isCompact: isCompact),
          const SizedBox(height: 6),
          Text(
            _queryPreviewText(),
            style: TextStyle(color: Colors.grey.shade700, fontSize: 11),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
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
            child: _buildLiveTasksList(),
          ),
        ],
      ),
    );
  }

  Widget _buildQueryControls({required bool isCompact}) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        DropdownButton<String>(
          value: _statusFilter,
          items: const [
            DropdownMenuItem(value: 'active', child: Text('Status: active')),
            DropdownMenuItem(value: 'paused', child: Text('Status: paused')),
            DropdownMenuItem(value: 'done', child: Text('Status: done')),
            DropdownMenuItem(value: 'all', child: Text('Status: all')),
          ],
          onChanged: (value) {
            if (value == null) return;
            setState(() => _statusFilter = value);
          },
        ),
        DropdownButton<int>(
          value: _minimumPriority,
          items: const [
            DropdownMenuItem(value: 1, child: Text('Min P: 1')),
            DropdownMenuItem(value: 2, child: Text('Min P: 2')),
            DropdownMenuItem(value: 3, child: Text('Min P: 3')),
            DropdownMenuItem(value: 4, child: Text('Min P: 4')),
            DropdownMenuItem(value: 5, child: Text('Min P: 5')),
          ],
          onChanged: (value) {
            if (value == null) return;
            setState(() => _minimumPriority = value);
          },
        ),
        DropdownButton<int>(
          value: _queryLimit,
          items: const [
            DropdownMenuItem(value: 5, child: Text('Limit 5')),
            DropdownMenuItem(value: 10, child: Text('Limit 10')),
            DropdownMenuItem(value: 20, child: Text('Limit 20')),
          ],
          onChanged: (value) {
            if (value == null) return;
            setState(() => _queryLimit = value);
          },
        ),
        FilterChip(
          label: Text(isCompact ? 'Incomplete' : 'Incomplete only'),
          selected: _showOnlyIncomplete,
          onSelected: (value) => setState(() => _showOnlyIncomplete = value),
        ),
        FilterChip(
          label: const Text('Featured'),
          selected: _showOnlyFeatured,
          onSelected: (value) => setState(() => _showOnlyFeatured = value),
        ),
        FilterChip(
          label: Text(_priorityDescending ? 'Priority DESC' : 'Priority ASC'),
          selected: _priorityDescending,
          onSelected: (value) => setState(() => _priorityDescending = value),
        ),
      ],
    );
  }

  Widget _buildTasksSummary() {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: _buildTasksQuery().get(),
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

  Widget _buildLiveTasksList() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _buildTasksQuery().snapshots(),
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

        final docs = snapshot.data?.docs ?? [];

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
            final status = _safeString(taskData['status'], fallback: 'active');
            final priority = _safeInt(taskData['priority'], fallback: 3);
            final isCompleted = _safeBool(taskData['isCompleted'], fallback: false);

            return ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                size: 18,
                color: isCompleted ? Colors.green : Colors.orange,
              ),
              title: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                '$description\nPriority: $priority | Status: $status',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              isThreeLine: true,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      isCompleted ? Icons.undo : Icons.check,
                      size: 18,
                    ),
                    tooltip: isCompleted ? 'Mark incomplete' : 'Mark complete',
                    onPressed: () => _toggleTaskCompletion(docs[index], !isCompleted),
                  ),
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
    int priority = 3;
    String status = 'active';
    bool isCompleted = false;
    bool featured = false;

    await showDialog<void>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Add Firestore Task'),
              content: SingleChildScrollView(
                child: Column(
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
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: status,
                      decoration: const InputDecoration(labelText: 'Status'),
                      items: const [
                        DropdownMenuItem(value: 'active', child: Text('active')),
                        DropdownMenuItem(value: 'paused', child: Text('paused')),
                        DropdownMenuItem(value: 'done', child: Text('done')),
                      ],
                      onChanged: (value) {
                        if (value == null) return;
                        setDialogState(() => status = value);
                      },
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<int>(
                      value: priority,
                      decoration: const InputDecoration(labelText: 'Priority (1-5)'),
                      items: const [
                        DropdownMenuItem(value: 1, child: Text('1')),
                        DropdownMenuItem(value: 2, child: Text('2')),
                        DropdownMenuItem(value: 3, child: Text('3')),
                        DropdownMenuItem(value: 4, child: Text('4')),
                        DropdownMenuItem(value: 5, child: Text('5')),
                      ],
                      onChanged: (value) {
                        if (value == null) return;
                        setDialogState(() => priority = value);
                      },
                    ),
                    const SizedBox(height: 4),
                    CheckboxListTile(
                      value: isCompleted,
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Completed'),
                      onChanged: (value) => setDialogState(() => isCompleted = value ?? false),
                    ),
                    CheckboxListTile(
                      value: featured,
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Featured tag'),
                      onChanged: (value) => setDialogState(() => featured = value ?? false),
                    ),
                  ],
                ),
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
                        'status': status,
                        'priority': priority,
                        'isCompleted': isCompleted,
                        'tags': featured ? ['featured'] : <String>[],
                        'ownerUid': _currentUserUid,
                        'createdAt': FieldValue.serverTimestamp(),
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
    int priority = _safeInt(data['priority'], fallback: 3);
    String status = _safeString(data['status'], fallback: 'active');
    bool isCompleted = _safeBool(data['isCompleted'], fallback: false);
    final tags = _safeStringList(data['tags']);
    bool featured = tags.contains('featured');

    await showDialog<void>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Edit Firestore Task'),
              content: SingleChildScrollView(
                child: Column(
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
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: status,
                      decoration: const InputDecoration(labelText: 'Status'),
                      items: const [
                        DropdownMenuItem(value: 'active', child: Text('active')),
                        DropdownMenuItem(value: 'paused', child: Text('paused')),
                        DropdownMenuItem(value: 'done', child: Text('done')),
                      ],
                      onChanged: (value) {
                        if (value == null) return;
                        setDialogState(() => status = value);
                      },
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<int>(
                      value: priority,
                      decoration: const InputDecoration(labelText: 'Priority (1-5)'),
                      items: const [
                        DropdownMenuItem(value: 1, child: Text('1')),
                        DropdownMenuItem(value: 2, child: Text('2')),
                        DropdownMenuItem(value: 3, child: Text('3')),
                        DropdownMenuItem(value: 4, child: Text('4')),
                        DropdownMenuItem(value: 5, child: Text('5')),
                      ],
                      onChanged: (value) {
                        if (value == null) return;
                        setDialogState(() => priority = value);
                      },
                    ),
                    const SizedBox(height: 4),
                    CheckboxListTile(
                      value: isCompleted,
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Completed'),
                      onChanged: (value) => setDialogState(() => isCompleted = value ?? false),
                    ),
                    CheckboxListTile(
                      value: featured,
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Featured tag'),
                      onChanged: (value) => setDialogState(() => featured = value ?? false),
                    ),
                  ],
                ),
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
                        'status': status,
                        'priority': priority,
                        'isCompleted': isCompleted,
                        'tags': featured ? ['featured'] : <String>[],
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
      },
    );
  }

  Future<void> _toggleTaskCompletion(
    DocumentSnapshot<Map<String, dynamic>> doc,
    bool nextValue,
  ) async {
    try {
      await doc.reference.update({
        'isCompleted': nextValue,
        'status': nextValue ? 'done' : 'active',
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Status update failed: $e')),
        );
      }
    }
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

  int _safeInt(dynamic value, {required int fallback}) {
    if (value == null) return fallback;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString()) ?? fallback;
  }

  bool _safeBool(dynamic value, {required bool fallback}) {
    if (value == null) return fallback;
    if (value is bool) return value;
    final text = value.toString().toLowerCase();
    if (text == 'true') return true;
    if (text == 'false') return false;
    return fallback;
  }

  List<String> _safeStringList(dynamic value) {
    if (value is List) {
      return value.map((item) => item.toString()).toList();
    }

    return <String>[];
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

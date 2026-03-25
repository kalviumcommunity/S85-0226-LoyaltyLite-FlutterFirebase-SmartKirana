import 'dart:async';

import 'package:flutter/material.dart';

enum LiveItemsMode { success, empty, error }

class LiveItemsViewerScreen extends StatefulWidget {
  const LiveItemsViewerScreen({super.key});

  @override
  State<LiveItemsViewerScreen> createState() => _LiveItemsViewerScreenState();
}

class _LiveItemsViewerScreenState extends State<LiveItemsViewerScreen> {
  late Future<List<LiveItem>> _itemsFuture;
  LiveItemsMode _mode = LiveItemsMode.success;

  @override
  void initState() {
    super.initState();
    _itemsFuture = _fetchItems();
  }

  Future<List<LiveItem>> _fetchItems() async {
    await Future<void>.delayed(const Duration(seconds: 2));

    switch (_mode) {
      case LiveItemsMode.error:
        throw Exception('Items service is unavailable right now.');
      case LiveItemsMode.empty:
        return <LiveItem>[];
      case LiveItemsMode.success:
        return <LiveItem>[
          const LiveItem(name: 'Basmati Rice 5kg', subtitle: 'In stock: 20 bags'),
          const LiveItem(name: 'Cold Drink Combo', subtitle: 'In stock: 12 packs'),
          const LiveItem(name: 'Fresh Milk 1L', subtitle: 'In stock: 35 units'),
          const LiveItem(name: 'Premium Tea Pack', subtitle: 'In stock: 16 boxes'),
        ];
    }
  }

  void _reload() {
    setState(() {
      _itemsFuture = _fetchItems();
    });
  }

  String _readableMode(LiveItemsMode mode) {
    switch (mode) {
      case LiveItemsMode.success:
        return 'Success (Data Available)';
      case LiveItemsMode.empty:
        return 'Empty Response';
      case LiveItemsMode.error:
        return 'Error Response';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Items Viewer'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Colors.deepPurple.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Demo Controls',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<LiveItemsMode>(
                        value: _mode,
                        decoration: const InputDecoration(
                          labelText: 'Scenario Mode',
                          border: OutlineInputBorder(),
                        ),
                        items: LiveItemsMode.values
                            .map(
                              (mode) => DropdownMenuItem<LiveItemsMode>(
                                value: mode,
                                child: Text(_readableMode(mode)),
                              ),
                            )
                            .toList(),
                        onChanged: (selected) {
                          if (selected == null) {
                            return;
                          }

                          setState(() {
                            _mode = selected;
                            _itemsFuture = _fetchItems();
                          });
                        },
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Tip: switch mode to Empty or Error to demonstrate required states.',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: FutureBuilder<List<LiveItem>>(
                  future: _itemsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const _LoaderState();
                    }

                    if (snapshot.hasError) {
                      return _ErrorState(
                        message: 'Could not load items. Please try again.',
                        onRetry: _reload,
                      );
                    }

                    final items = snapshot.data ?? <LiveItem>[];
                    if (items.isEmpty) {
                      return const _EmptyState();
                    }

                    return _ItemsList(items: items, onRefresh: _reload);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoaderState extends StatelessWidget {
  const _LoaderState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          CircularProgressIndicator(),
          SizedBox(height: 12),
          Text('Fetching live items...'),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 60,
              color: Colors.grey.shade500,
            ),
            const SizedBox(height: 12),
            const Text(
              'No items found',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Try adding your first item or check again later.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: null,
              icon: const Icon(Icons.add),
              label: const Text('Add your first item'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 60,
              color: Colors.red.shade400,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemsList extends StatelessWidget {
  const _ItemsList({required this.items, required this.onRefresh});

  final List<LiveItem> items;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        onRefresh();
      },
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.deepPurple.shade100,
                child: Text('${index + 1}'),
              ),
              title: Text(item.name),
              subtitle: Text(item.subtitle),
              trailing: const Icon(Icons.chevron_right),
            ),
          );
        },
      ),
    );
  }
}

class LiveItem {
  const LiveItem({required this.name, required this.subtitle});

  final String name;
  final String subtitle;
}

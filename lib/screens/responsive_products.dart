import 'package:flutter/material.dart';

class ResponsiveProducts extends StatelessWidget {
  const ResponsiveProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final columns = width < 600 ? 2 : (width < 1000 ? 3 : 4);

    return Scaffold(
      appBar: AppBar(title: const Text('Responsive Products')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.78,
        ),
        itemCount: 12,
        itemBuilder: (context, index) {
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    color: Colors.orange.shade100,
                    child: const Center(child: Icon(Icons.inventory_2, size: 40)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text('Product ${index + 1}'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

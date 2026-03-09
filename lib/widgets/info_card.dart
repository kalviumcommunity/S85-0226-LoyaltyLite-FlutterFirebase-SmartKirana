import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  final List<Widget>? actions;
  final bool showShadow;

  const InfoCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.color = Colors.orange,
    this.onTap,
    this.actions,
    this.showShadow = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: showShadow ? 4 : 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.1),
                color.withOpacity(0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      color: color,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (actions != null) ...[
                    const SizedBox(width: 8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: actions!,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final double? percentage;
  final String? trend;

  const StatsCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    this.color = Colors.orange,
    this.percentage,
    this.trend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.1),
              color.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const Spacer(),
                if (trend != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: trend!.startsWith('+') ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      trend!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            if (percentage != null) ...[
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: percentage! / 100,
                backgroundColor: color.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

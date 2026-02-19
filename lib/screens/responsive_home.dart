import 'package:flutter/material.dart';

class ResponsiveHome extends StatefulWidget {
  const ResponsiveHome({Key? key}) : super(key: key);

  @override
  State<ResponsiveHome> createState() => _ResponsiveHomeState();
}

class _ResponsiveHomeState extends State<ResponsiveHome> {
  int _selectedEventIndex = 0;

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
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [cardColor.withOpacity(0.1), cardColor.withOpacity(0.05)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.event_available,
                    size: 64,
                    color: cardColor.withOpacity(0.7),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Event Ideas Coming Soon',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepPurple.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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

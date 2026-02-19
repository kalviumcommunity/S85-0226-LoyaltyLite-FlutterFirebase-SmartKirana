import 'package:flutter/material.dart';
import 'welcome_screen.dart';

class ResponsiveHome extends StatefulWidget {
  const ResponsiveHome({Key? key}) : super(key: key);

  @override
  State<ResponsiveHome> createState() => _ResponsiveHomeState();
}

class _ResponsiveHomeState extends State<ResponsiveHome> {
  int _selectedTabIndex = 0;

  final List<Map<String, dynamic>> _eventCategories = [
    {
      'title': 'Creative Events',
      'icon': Icons.lightbulb_outline,
      'color': Colors.amber,
      'count': 12,
      'description': 'Innovative and unique event ideas'
    },
    {
      'title': 'Sports Activities',
      'icon': Icons.sports_soccer,
      'color': Colors.green,
      'count': 8,
      'description': 'Physical and competitive events'
    },
    {
      'title': 'Cultural Programs',
      'icon': Icons.theater_comedy,
      'color': Colors.purple,
      'count': 15,
      'description': 'Arts and cultural celebrations'
    },
    {
      'title': 'Tech Workshops',
      'icon': Icons.computer,
      'color': Colors.blue,
      'count': 10,
      'description': 'Technology and innovation workshops'
    },
    {
      'title': 'Social Gatherings',
      'icon': Icons.groups,
      'color': Colors.red,
      'count': 6,
      'description': 'Community building activities'
    },
    {
      'title': 'Academic Events',
      'icon': Icons.school,
      'color': Colors.indigo,
      'count': 9,
      'description': 'Educational and learning events'
    }
  ];

  final List<Map<String, String>> _upcomingEvents = [
    {
      'title': 'Reverse Day Festival',
      'date': 'Dec 15, 2024',
      'time': '9:00 AM',
      'type': 'Creative'
    },
    {
      'title': 'Tech Innovation Summit',
      'date': 'Dec 18, 2024',
      'time': '2:00 PM',
      'type': 'Tech'
    },
    {
      'title': 'Cultural Heritage Day',
      'date': 'Dec 20, 2024',
      'time': '10:00 AM',
      'type': 'Cultural'
    },
    {
      'title': 'Sports Championship',
      'date': 'Dec 22, 2024',
      'time': '3:00 PM',
      'type': 'Sports'
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
          bool isLandscape = screenWidth > screenHeight;

          return CustomScrollView(
            slivers: [
              _buildAppBar(screenWidth, isTablet),
              SliverToBoxAdapter(
                child: _buildHeaderSection(screenWidth, isTablet),
              ),
              SliverToBoxAdapter(
                child: _buildCategoriesSection(screenWidth, isTablet, isDesktop),
              ),
              SliverToBoxAdapter(
                child: _buildUpcomingEventsSection(screenWidth, isTablet, isLandscape),
              ),
              SliverToBoxAdapter(
                child: _buildFooterSection(screenWidth, isTablet),
              ),
            ],
          );
        },
      ),
      floatingActionButton: _buildFloatingActionButton(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildAppBar(double screenWidth, bool isTablet) {
    return SliverAppBar(
      expandedHeight: isTablet ? 120 : 100,
      floating: false,
      pinned: true,
      backgroundColor: Colors.deepPurple,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'Event Planner',
          style: TextStyle(
            fontSize: isTablet ? 28 : 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        titlePadding: EdgeInsets.only(
          left: isTablet ? 20 : 16,
          bottom: isTablet ? 20 : 16,
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.deepPurple,
                Colors.blue.shade600,
              ],
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search, size: isTablet ? 28 : 24),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.notifications, size: isTablet ? 28 : 24),
          onPressed: () {},
        ),
        if (isTablet)
          IconButton(
            icon: Icon(Icons.settings, size: 28),
            onPressed: () {},
          ),
      ],
    );
  }

  Widget _buildHeaderSection(double screenWidth, bool isTablet) {
    double padding = isTablet ? 24.0 : 16.0;
    double titleSize = isTablet ? 32 : 24;
    double subtitleSize = isTablet ? 18 : 14;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.deepPurple.shade50, Colors.white],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome Back!',
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple.shade800,
            ),
          ),
          SizedBox(height: isTablet ? 12 : 8),
          Text(
            'Discover and plan amazing school events using creative thinking techniques',
            style: TextStyle(
              fontSize: subtitleSize,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: isTablet ? 20 : 16),
          _buildQuickActionButtons(screenWidth, isTablet),
        ],
      ),
    );
  }

  Widget _buildQuickActionButtons(double screenWidth, bool isTablet) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WelcomeScreen()),
              );
            },
            icon: Icon(Icons.lightbulb, size: isTablet ? 24 : 20),
            label: Text(
              'Generate Ideas',
              style: TextStyle(fontSize: isTablet ? 16 : 14),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                vertical: isTablet ? 16 : 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        SizedBox(width: isTablet ? 16 : 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.calendar_today, size: isTablet ? 24 : 20),
            label: Text(
              'View Calendar',
              style: TextStyle(fontSize: isTablet ? 16 : 14),
            ),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                vertical: isTablet ? 16 : 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesSection(double screenWidth, bool isTablet, bool isDesktop) {
    int crossAxisCount = isDesktop ? 3 : (isTablet ? 2 : 1);
    double childAspectRatio = isDesktop ? 1.2 : (isTablet ? 1.4 : 1.6);
    double spacing = isDesktop ? 20 : (isTablet ? 16 : 12);

    return Container(
      padding: EdgeInsets.all(isTablet ? 24 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Event Categories',
            style: TextStyle(
              fontSize: isTablet ? 28 : 22,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple.shade800,
            ),
          ),
          SizedBox(height: isTablet ? 20 : 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: childAspectRatio,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
            ),
            itemCount: _eventCategories.length,
            itemBuilder: (context, index) {
              final category = _eventCategories[index];
              return _buildCategoryCard(category, isTablet);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category, bool isTablet) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(isTablet ? 16 : 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(isTablet ? 12 : 8),
                decoration: BoxDecoration(
                  color: category['color'].shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  category['icon'],
                  size: isTablet ? 32 : 24,
                  color: category['color'].shade600,
                ),
              ),
              SizedBox(height: isTablet ? 12 : 8),
              Expanded(
                child: Text(
                  category['title'],
                  style: TextStyle(
                    fontSize: isTablet ? 18 : 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: isTablet ? 8 : 4),
              Text(
                category['description'],
                style: TextStyle(
                  fontSize: isTablet ? 14 : 12,
                  color: Colors.grey.shade600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: isTablet ? 8 : 4),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 8 : 6,
                  vertical: isTablet ? 4 : 2,
                ),
                decoration: BoxDecoration(
                  color: category['color'].shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${category['count']} events',
                  style: TextStyle(
                    fontSize: isTablet ? 12 : 10,
                    color: category['color'].shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUpcomingEventsSection(double screenWidth, bool isTablet, bool isLandscape) {
    return Container(
      padding: EdgeInsets.all(isTablet ? 24 : 16),
      color: Colors.grey.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Upcoming Events',
            style: TextStyle(
              fontSize: isTablet ? 28 : 22,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple.shade800,
            ),
          ),
          SizedBox(height: isTablet ? 20 : 16),
          if (isLandscape && isTablet)
            _buildLandscapeEventsGrid(isTablet)
          else
            _buildPortraitEventsList(isTablet),
        ],
      ),
    );
  }

  Widget _buildLandscapeEventsGrid(bool isTablet) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        crossAxisSpacing: isTablet ? 16 : 12,
        mainAxisSpacing: isTablet ? 16 : 12,
      ),
      itemCount: _upcomingEvents.length,
      itemBuilder: (context, index) {
        final event = _upcomingEvents[index];
        return _buildEventCard(event, isTablet);
      },
    );
  }

  Widget _buildPortraitEventsList(bool isTablet) {
    return Column(
      children: _upcomingEvents.map((event) {
        return Padding(
          padding: EdgeInsets.only(bottom: isTablet ? 16 : 12),
          child: _buildEventCard(event, isTablet),
        );
      }).toList(),
    );
  }

  Widget _buildEventCard(Map<String, String> event, bool isTablet) {
    return Card(
      elevation: 2,
      child: ListTile(
        contentPadding: EdgeInsets.all(isTablet ? 16 : 12),
        leading: Container(
          padding: EdgeInsets.all(isTablet ? 8 : 6),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.event,
            color: Colors.deepPurple.shade600,
            size: isTablet ? 24 : 20,
          ),
        ),
        title: Text(
          event['title']!,
          style: TextStyle(
            fontSize: isTablet ? 16 : 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: isTablet ? 4 : 2),
            Text(
              '${event['date']} • ${event['time']}',
              style: TextStyle(
                fontSize: isTablet ? 14 : 12,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: isTablet ? 4 : 2),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 8 : 6,
                vertical: isTablet ? 2 : 1,
              ),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                event['type']!,
                style: TextStyle(
                  fontSize: isTablet ? 12 : 10,
                  color: Colors.green.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: isTablet ? 20 : 16,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }

  Widget _buildFooterSection(double screenWidth, bool isTablet) {
    return Container(
      padding: EdgeInsets.all(isTablet ? 24 : 16),
      child: Column(
        children: [
          Divider(height: isTablet ? 32 : 24),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: isTablet ? 16 : 12,
            runSpacing: isTablet ? 12 : 8,
            children: [
              _buildFooterButton('About Us', Icons.info, isTablet),
              _buildFooterButton('Contact', Icons.contact_mail, isTablet),
              _buildFooterButton('Settings', Icons.settings, isTablet),
              _buildFooterButton('Help', Icons.help_outline, isTablet),
            ],
          ),
          SizedBox(height: isTablet ? 20 : 16),
          Text(
            '© 2024 School Event Planner. Made with ❤️ using Flutter',
            style: TextStyle(
              fontSize: isTablet ? 14 : 12,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFooterButton(String text, IconData icon, bool isTablet) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: isTablet ? 20 : 16),
      label: Text(
        text,
        style: TextStyle(fontSize: isTablet ? 14 : 12),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WelcomeScreen()),
        );
      },
      icon: const Icon(Icons.add),
      label: const Text('New Event'),
      backgroundColor: Colors.deepPurple,
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedTabIndex,
      onTap: (index) {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepPurple,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Events',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.lightbulb),
          label: 'Ideas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}

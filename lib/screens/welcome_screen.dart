import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _currentIdeaIndex = 0;
  bool _showDetails = false;

  final List<Map<String, String>> _eventIdeas = [
    {
      'title': 'Reverse Day Festival',
      'description': 'Students attend classes backwards, eat dinner for lunch, and teachers become students',
      'technique': 'Reversal Thinking'
    },
    {
      'title': 'Silent Disco Library',
      'description': 'Transform the library into a silent disco where students dance to wireless headphones while studying',
      'technique': 'Random Association'
    },
    {
      'title': 'Problem-Solving Olympics',
      'description': 'Teams compete to solve real school problems using creative thinking techniques',
      'technique': 'Analogical Thinking'
    }
  ];

  void _nextIdea() {
    setState(() {
      _currentIdeaIndex = (_currentIdeaIndex + 1) % _eventIdeas.length;
      _showDetails = false;
    });
  }

  void _toggleDetails() {
    setState(() {
      _showDetails = !_showDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentIdea = _eventIdeas[_currentIdeaIndex];
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Ideas Generator'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple.shade50, Colors.blue.shade50],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'School Event Planning',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.shade800,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Think Outside the Box!',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.deepPurple.shade600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 40),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.lightbulb_outline,
                          size: 60,
                          color: Colors.amber.shade600,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          currentIdea['title']!,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            currentIdea['technique']!,
                            style: TextStyle(
                              color: Colors.green.shade800,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        if (_showDetails) ...[
                          const SizedBox(height: 16),
                          Text(
                            currentIdea['description']!,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _toggleDetails,
                      icon: Icon(_showDetails ? Icons.visibility_off : Icons.visibility),
                      label: Text(_showDetails ? 'Hide Details' : 'Show Details'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade600,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _nextIdea,
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text('Next Idea'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple.shade600,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

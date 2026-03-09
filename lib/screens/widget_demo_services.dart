import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';
import '../widgets/product_card.dart';
import '../widgets/info_card.dart';
import '../widgets/like_button.dart';

class WidgetDemoServices extends StatefulWidget {
  const WidgetDemoServices({Key? key}) : super(key: key);

  @override
  State<WidgetDemoServices> createState() => _WidgetDemoServicesState();
}

class _WidgetDemoServicesState extends State<WidgetDemoServices> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_nameController.text.trim().isEmpty || _emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields! ⚠️'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Form submitted successfully! Welcome ${_nameController.text.trim()}! 🎉'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );
      
      _nameController.clear();
      _emailController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🛠️ Custom Inputs & Services'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            InfoCard(
              title: 'Custom Input Widgets',
              subtitle: 'Reusable form components with validation and styling',
              icon: Icons.input,
              color: Colors.purple,
            ),
            
            const SizedBox(height: 24),
            
            // Search Bar
            Text(
              '🔍 Search Component',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade800,
              ),
            ),
            const SizedBox(height: 16),
            
            CustomSearchBar(
              hint: 'Search services...',
              controller: _searchController,
              onChanged: (value) {
                // Handle search
              },
              onClear: () {
                _searchController.clear();
              },
            ),
            
            const SizedBox(height: 24),
            
            // Form Section
            Text(
              '📝 Contact Form',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade800,
              ),
            ),
            const SizedBox(height: 16),
            
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    CustomTextField(
                      label: 'Your Name',
                      hint: 'Enter your full name',
                      prefixIcon: Icons.person,
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 16),
                    
                    CustomTextField(
                      label: 'Email Address',
                      hint: 'Enter your email',
                      prefixIcon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 24),
                    
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            label: _isLoading ? 'Submitting...' : 'Submit Form',
                            onPressed: _isLoading ? null : () => _submitForm(),
                            icon: _isLoading ? null : Icons.send,
                            isLoading: _isLoading,
                            color: Colors.purple,
                          ),
                        ),
                        const SizedBox(width: 12),
                        CustomOutlineButton(
                          label: 'Clear',
                          onPressed: () {
                            _nameController.clear();
                            _emailController.clear();
                          },
                          icon: Icons.clear,
                          color: Colors.purple,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Service Cards
            Text(
              '⭐ Rate Our Services',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade800,
              ),
            ),
            const SizedBox(height: 16),
            
            ServiceCard(
              title: 'Widget Development',
              description: 'Custom Flutter widgets for your app',
              icon: Icons.code,
              color: Colors.blue,
              features: [
                'Reusable components',
                'Custom styling',
                'State management',
                'Event handling',
              ],
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Widget development service selected! 💻'),
                    backgroundColor: Colors.blue,
                  ),
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            ServiceCard(
              title: 'UI/UX Design',
              description: 'Beautiful and intuitive interfaces',
              icon: Icons.palette,
              color: Colors.pink,
              features: [
                'Material Design',
                'Responsive layouts',
                'Custom animations',
                'User research',
              ],
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('UI/UX design service selected! 🎨'),
                    backgroundColor: Colors.pink,
                  ),
                );
              },
            ),
            
            const SizedBox(height: 24),
            
            // Interactive Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '❤️ Interactive Demo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple.shade800,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  Row(
                    children: [
                      const Text('Like this demo: '),
                      LikeButton(
                        initialLikes: 89,
                        size: 28,
                        onLikeChanged: (isLiked) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(isLiked ? 'Thanks for your support! ❤️' : 'Unliked 😔'),
                              backgroundColor: Colors.purple,
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Row(
                    children: [
                      const Text('Rate this service: '),
                      LikeButton(
                        initialLikes: 156,
                        showCount: false,
                        size: 32,
                        activeColor: Colors.purple,
                        onLikeChanged: (isLiked) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(isLiked ? 'Rated! ⭐' : 'Rating removed'),
                              backgroundColor: Colors.purple,
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Bottom Actions
            CustomButton(
              label: 'Back to Home',
              onPressed: () => Navigator.pop(context),
              icon: Icons.home,
              color: Colors.grey,
              isFullWidth: true,
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

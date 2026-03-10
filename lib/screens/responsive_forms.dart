import 'package:flutter/material.dart';

class ResponsiveForms extends StatefulWidget {
  const ResponsiveForms({Key? key}) : super(key: key);

  @override
  State<ResponsiveForms> createState() => _ResponsiveFormsState();
}

class _ResponsiveFormsState extends State<ResponsiveForms> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Form submitted successfully! 🎉'),
            backgroundColor: Colors.purple,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final orientation = MediaQuery.of(context).orientation;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '📝 Responsive Forms',
          style: TextStyle(
            fontSize: screenWidth < 600 ? 18 : 22,
          ),
        ),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: screenWidth < 600 ? 20 : 24,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            // Mobile Layout
            return _buildMobileLayout(context, screenWidth, screenHeight);
          } else if (constraints.maxWidth < 1200) {
            // Tablet Layout
            return _buildTabletLayout(context, screenWidth, screenHeight);
          } else {
            // Desktop Layout
            return _buildDesktopLayout(context, screenWidth, screenHeight);
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, double screenWidth, double screenHeight) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Form Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(screenWidth * 0.04),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.deepPurple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '📝 Contact Form',
                    style: TextStyle(
                      fontSize: screenWidth < 600 ? 20 : 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.02),
                  Text(
                    'Fill in your details below',
                    style: TextStyle(
                      fontSize: screenWidth < 600 ? 14 : 16,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: screenHeight * 0.03),
            
            // Form Fields
            _buildTextField('Full Name', 'Enter your name', Icons.person, _nameController, screenWidth),
            SizedBox(height: screenHeight * 0.02),
            _buildTextField('Email Address', 'Enter your email', Icons.email, _emailController, screenWidth),
            SizedBox(height: screenHeight * 0.02),
            _buildTextField('Phone Number', 'Enter your phone', Icons.phone, _phoneController, screenWidth),
            SizedBox(height: screenHeight * 0.02),
            _buildMessageField('Message', 'Enter your message', _messageController, screenWidth),
            SizedBox(height: screenHeight * 0.03),
            
            // Submit Button
            SizedBox(
              width: double.infinity,
              height: screenWidth * 0.14,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'Submit Form',
                        style: TextStyle(
                          fontSize: screenWidth < 600 ? 16 : 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context, double screenWidth, double screenHeight) {
    return Row(
      children: [
        // Left Panel - Form
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(screenWidth * 0.03),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Form Header
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(screenWidth * 0.03),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.purple, Colors.deepPurple],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '📝 Contact Form',
                          style: TextStyle(
                            fontSize: screenWidth < 600 ? 20 : 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: screenWidth * 0.02),
                        Text(
                          'Fill in your details below',
                          style: TextStyle(
                            fontSize: screenWidth < 600 ? 14 : 16,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: screenHeight * 0.03),
                  
                  // Form Fields
                  _buildTextField('Full Name', 'Enter your name', Icons.person, _nameController, screenWidth),
                  SizedBox(height: screenHeight * 0.02),
                  _buildTextField('Email Address', 'Enter your email', Icons.email, _emailController, screenWidth),
                  SizedBox(height: screenHeight * 0.02),
                  _buildTextField('Phone Number', 'Enter your phone', Icons.phone, _phoneController, screenWidth),
                  SizedBox(height: screenHeight * 0.02),
                  _buildMessageField('Message', 'Enter your message', _messageController, screenWidth),
                  SizedBox(height: screenHeight * 0.03),
                  
                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    height: screenWidth * 0.12,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'Submit Form',
                              style: TextStyle(
                                fontSize: screenWidth < 600 ? 16 : 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        
        // Right Panel - Info
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.all(screenWidth * 0.03),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              border: Border(left: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '📋 Why Contact Us?',
                  style: TextStyle(
                    fontSize: screenWidth < 600 ? 18 : 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                _buildInfoItem('💬', 'Get Support', 'Our team is here to help you with any questions or issues.'),
                _buildInfoItem('🚀', 'Feature Requests', 'Have an idea? We\'d love to hear from you!'),
                _buildInfoItem('🤝', 'Partnerships', 'Interested in collaborating? Let\'s discuss opportunities.'),
                _buildInfoItem('📊', 'Feedback', 'Help us improve by sharing your experience.'),
                _buildInfoItem('🎁', 'Special Offers', 'Get exclusive deals and updates.'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context, double screenWidth, double screenHeight) {
    return Row(
      children: [
        // Left Panel - Form
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(screenWidth * 0.03),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Form Header
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(screenWidth * 0.03),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.purple, Colors.deepPurple],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '📝 Contact Form',
                          style: TextStyle(
                            fontSize: screenWidth < 600 ? 20 : 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: screenWidth * 0.02),
                        Text(
                          'Fill in your details below',
                          style: TextStyle(
                            fontSize: screenWidth < 600 ? 14 : 16,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: screenHeight * 0.03),
                  
                  // Form Fields in Two Columns
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField('Full Name', 'Enter your name', Icons.person, _nameController, screenWidth),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Expanded(
                        child: _buildTextField('Email Address', 'Enter your email', Icons.email, _emailController, screenWidth),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField('Phone Number', 'Enter your phone', Icons.phone, _phoneController, screenWidth),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Expanded(
                        child: _buildTextField('Subject', 'Enter subject', Icons.subject, TextEditingController(), screenWidth),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  _buildMessageField('Message', 'Enter your message', _messageController, screenWidth),
                  SizedBox(height: screenHeight * 0.03),
                  
                  // Submit Buttons Row
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: screenWidth * 0.12,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: _isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : Text(
                                    'Submit Form',
                                    style: TextStyle(
                                      fontSize: screenWidth < 600 ? 16 : 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Expanded(
                        child: SizedBox(
                          height: screenWidth * 0.12,
                          child: OutlinedButton(
                            onPressed: () {
                              _formKey.currentState!.reset();
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.purple,
                              side: BorderSide(color: Colors.purple),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Clear Form',
                              style: TextStyle(
                                fontSize: screenWidth < 600 ? 16 : 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
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
        
        // Right Panel - Info & Stats
        Expanded(
          child: Column(
            children: [
              // Info Section
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    border: Border(left: BorderSide(color: Colors.grey.shade200)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '📋 Why Contact Us?',
                        style: TextStyle(
                          fontSize: screenWidth < 600 ? 18 : 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      _buildInfoItem('💬', 'Get Support', 'Our team is here to help you with any questions or issues.'),
                      _buildInfoItem('🚀', 'Feature Requests', 'Have an idea? We\'d love to hear from you!'),
                      _buildInfoItem('🤝', 'Partnerships', 'Interested in collaborating? Let\'s discuss opportunities.'),
                      _buildInfoItem('📊', 'Feedback', 'Help us improve by sharing your experience.'),
                      _buildInfoItem('🎁', 'Special Offers', 'Get exclusive deals and updates.'),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: screenHeight * 0.02),
              
              // Stats Section
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '📊 Contact Stats',
                        style: TextStyle(
                          fontSize: screenWidth < 600 ? 18 : 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      _buildStatItem('Response Time', '< 2 hours', Colors.green),
                      _buildStatItem('Satisfaction Rate', '98%', Colors.blue),
                      _buildStatItem('Tickets Today', '47', Colors.orange),
                      _buildStatItem('Resolved Today', '43', Colors.purple),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, String hint, IconData icon, TextEditingController controller, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: screenWidth < 600 ? 14 : 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: screenWidth * 0.01),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: Colors.purple),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.purple, width: 2),
            ),
            contentPadding: EdgeInsets.all(screenWidth * 0.03),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter $label';
            }
            if (label.contains('Email') && !value!.contains('@')) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildMessageField(String label, String hint, TextEditingController controller, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: screenWidth < 600 ? 14 : 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: screenWidth * 0.01),
        TextFormField(
          controller: controller,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.purple, width: 2),
            ),
            contentPadding: EdgeInsets.all(screenWidth * 0.03),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter $label';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildInfoItem(String emoji, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 24),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

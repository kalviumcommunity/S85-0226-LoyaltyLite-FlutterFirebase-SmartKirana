import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class AnimationsDemo extends StatefulWidget {
  const AnimationsDemo({Key? key}) : super(key: key);

  @override
  State<AnimationsDemo> createState() => _AnimationsDemoState();
}

class _AnimationsDemoState extends State<AnimationsDemo> 
    with TickerProviderStateMixin {
  
  // Animation Controllers
  late AnimationController _containerController;
  late AnimationController _opacityController;
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  late AnimationController _slideController;
  
  // Animation Values
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  
  // State Variables
  bool _isContainerToggled = false;
  bool _isOpacityToggled = false;
  bool _isScaleToggled = false;
  bool _isSlideToggled = false;
  Color _containerColor = Colors.blue;
  double _containerWidth = 100.0;
  double _containerHeight = 100.0;
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();
    
    // Initialize Animation Controllers
    _containerController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    
    _opacityController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    
    _rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    // Initialize Animations
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 0.1,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.easeInOut,
    ));
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.fastOutSlowIn,
    ));
  }

  @override
  void dispose() {
    _containerController.dispose();
    _opacityController.dispose();
    _rotationController.dispose();
    _scaleController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _toggleContainer() {
    setState(() {
      _isContainerToggled = !_isContainerToggled;
      _containerWidth = _isContainerToggled ? 200.0 : 100.0;
      _containerHeight = _isContainerToggled ? 100.0 : 200.0;
      _containerColor = _isContainerToggled ? Colors.teal : Colors.blue;
    });
  }

  void _toggleOpacity() {
    setState(() {
      _isOpacityToggled = !_isOpacityToggled;
      _opacity = _isOpacityToggled ? 0.2 : 1.0;
    });
  }

  void _triggerScaleAnimation() {
    if (_isScaleToggled) {
      _scaleController.reverse();
    } else {
      _scaleController.forward();
    }
    setState(() {
      _isScaleToggled = !_isScaleToggled;
    });
  }

  void _triggerSlideAnimation() {
    if (_isSlideToggled) {
      _slideController.reverse();
    } else {
      _slideController.forward();
    }
    setState(() {
      _isSlideToggled = !_isSlideToggled;
    });
  }

  void _navigateWithTransition() {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 700),
        pageBuilder: (context, animation, secondaryAnimation) => 
          const AnimationDetailScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            )),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '🎨 Flutter Animations Demo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AnimatedContainer Demo
            _buildSectionTitle('AnimatedContainer'),
            const SizedBox(height: 16),
            _buildAnimatedContainerDemo(),
            const SizedBox(height: 32),
            
            // AnimatedOpacity Demo
            _buildSectionTitle('AnimatedOpacity'),
            const SizedBox(height: 16),
            _buildAnimatedOpacityDemo(),
            const SizedBox(height: 32),
            
            // RotationTransition Demo
            _buildSectionTitle('RotationTransition'),
            const SizedBox(height: 16),
            _buildRotationTransitionDemo(),
            const SizedBox(height: 32),
            
            // ScaleTransition Demo
            _buildSectionTitle('ScaleTransition'),
            const SizedBox(height: 16),
            _buildScaleTransitionDemo(),
            const SizedBox(height: 32),
            
            // SlideTransition Demo
            _buildSectionTitle('SlideTransition'),
            const SizedBox(height: 16),
            _buildSlideTransitionDemo(),
            const SizedBox(height: 32),
            
            // Page Transition Demo
            _buildSectionTitle('Page Transitions'),
            const SizedBox(height: 16),
            _buildPageTransitionDemo(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.deepPurple,
      ),
    );
  }

  Widget _buildAnimatedContainerDemo() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: AnimatedContainer(
                width: _containerWidth,
                height: _containerHeight,
                decoration: BoxDecoration(
                  color: _containerColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
                child: const Center(
                  child: Text(
                    'Tap Me!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _toggleContainer,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              child: const Text('Toggle Container'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedOpacityDemo() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: AnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.orange, Colors.red],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.star,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _toggleOpacity,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              child: const Text('Toggle Opacity'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRotationTransitionDemo() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: RotationTransition(
                turns: _rotationAnimation,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.refresh,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Continuous Rotation Animation',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScaleTransitionDemo() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.favorite,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _triggerScaleAnimation,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
              ),
              child: const Text('Trigger Scale'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlideTransitionDemo() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: SlideTransition(
                position: _slideAnimation,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_forward,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _triggerSlideAnimation,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Trigger Slide'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageTransitionDemo() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Container(
                width: 150,
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.indigo, Colors.blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.open_in_new,
                        size: 30,
                        color: Colors.white,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Navigate',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _navigateWithTransition,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
              child: const Text('Navigate with Animation'),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimationDetailScreen extends StatelessWidget {
  const AnimationDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Details'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                size: 100,
                color: Colors.green,
              ),
              SizedBox(height: 20),
              Text(
                'Page Transition Successful!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                'This screen was reached using a smooth slide transition animation.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

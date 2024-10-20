import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  double _opacity = 0.0;
  double _scale = 0.5;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1), // Animation duration
    );

    // Start the fade and scale animations
    _startAnimation();
    _navigateToLogin();
  }

  _startAnimation() {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0; // Fade in
        _scale = 1.0; // Scale to original size
      });
    });
  }

  _navigateToLogin() async {
    await Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: Duration(seconds: 1), // Duration of fade-in
          child: AnimatedScale(
            scale: _scale,
            duration: Duration(seconds: 1), // Duration of scaling
            curve: Curves.easeInOut, // Smooth animation curve
            child: Image.asset(
              'assets/logo.png',
              width: 150,
              height: 150,
            ),
          ),
        ),
      ),
    );
  }
}

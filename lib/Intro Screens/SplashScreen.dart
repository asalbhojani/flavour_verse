import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Stack(
        children: [
          // Full Screen Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://images.pexels.com/photos/1109197/pexels-photo-1109197.jpeg?auto=compress&cs=tinysrgb&w=600"), // Provide your image path here
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Opacity Layer
          Container(
            color: Colors.black.withOpacity(0.75), // Adjust opacity level here
          ),
          // Add additional widgets or content here
          Center(
            child: Text(
              'Taste Trov',
              style: TextStyle(
                color: Color(0xff1f9fb6),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

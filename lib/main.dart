import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart'; // Ensure you have a `login_screen.dart` file properly set up

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LeisureSync App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF00AFDF), // Splash Screen Theme
          primary: Color(0xFF00AFDF),
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: Image.asset(
          'images/LeisureSync.png', // Ensure this asset exists and is declared in pubspec.yaml
          fit: BoxFit.contain,
        ),
        splashIconSize: 250,
        duration: 3000,
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.white,
        nextScreen: const LoginScreen(), // Redirect to Login Screen after splash
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import the HomeScreen
import 'signup_screen.dart';  // Import the LoginScreen
import 'globals.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF00AFDF), // Top gradient color
                Colors.white, //Middle gradient color
                Colors.white, //Middle gradient color
                Colors.white, // Bottom gradient color
              ],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Page Header
                  const Text(
                    "Log In",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Enter your username and password to get started",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Form Fields
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _usernameController,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: "Username",
                            labelStyle: const TextStyle(color: Colors.black54),
                            prefixIcon: Icon(Icons.person_outline, color: Colors.black54),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF00AFDF)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: const TextStyle(color: Colors.black54),
                            prefixIcon: const Icon(Icons.lock_outline, color: Colors.black54),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                color: Colors.black54,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF00AFDF)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  if (_errorMessage != null)
                    Center(
                      child: Text(
                        _errorMessage!,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  const SizedBox(height: 20),

                  // Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
                          setState(() {
                            _errorMessage = "Please fill out all fields!";
                          });
                        } else {
                          // Navigate to HomeScreen after login
                          globalUsername = _usernameController.text;
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => home_screen(username: globalUsername),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00AFDF),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Social Sign Up Section
                  const Center(
                    child: Text(
                      "or login with",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialButton(Icons.mail, () {}),
                      const SizedBox(width: 20),
                      _buildSocialButton(Icons.apple, () {}),
                      const SizedBox(width: 20),
                      _buildSocialButton(Icons.facebook, () {}),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // Back to Sign Up Button
                  Center(
                    child: TextButton(
                      onPressed: () {
                        // Navigate to the SignUp screen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Do not have an account? Sign up',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Utility Method: Build Social Button
  Widget _buildSocialButton(IconData icon, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
      ),
      child: Icon(icon, color: const Color(0xFF00AFDF), size: 24),
    );
  }
}
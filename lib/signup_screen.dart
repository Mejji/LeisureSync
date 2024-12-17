import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import the HomeScreen
import 'login_screen.dart'; // Import the LoginScreen
import 'globals.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _showError = false;

  // Validation Functions (from your second code snippet)
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) return 'Required';
    if (value.length > 20) return 'Max 20 characters';
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Required';
    if (!RegExp(r'^[^@]+@[^@]+\.(com|ph)$').hasMatch(value)) {
      return 'Invalid email';
    }
    if (value.length > 30) return 'Max 30 characters';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Required';
    if (!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[A-Za-z\d]{1,30}$')
        .hasMatch(value)) {
      return 'Must contain uppercase, lowercase, and number';
    }
    if (value.length > 30) return 'Max 30 characters';
    return null;
  }

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
                Colors.white, // Middle gradient color
                Colors.white, // Middle gradient color
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
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Create an account to get started",
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
                        _buildTextField(
                          controller: _usernameController,
                          label: "Username",
                          icon: Icons.person_outline,
                          validator: _validateName, // Add validator here
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(
                          controller: _emailController,
                          label: "Email",
                          icon: Icons.mail_outlined,
                          validator: _validateEmail, // Add validator here
                        ),
                        const SizedBox(height: 20),
                        _buildPasswordField(
                          controller: _passwordController,
                          label: "Password",
                          obscureText: _obscurePassword,
                          onToggleVisibility: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          validator: _validatePassword, // Add validator here
                        ),
                        const SizedBox(height: 20),
                        _buildPasswordField(
                          controller: _confirmPasswordController,
                          label: "Confirm Password",
                          obscureText: _obscureConfirmPassword,
                          onToggleVisibility: () {
                            setState(() {
                              _obscureConfirmPassword =
                              !_obscureConfirmPassword;
                            });
                          },
                          validator: (value) {
                            // Add confirm password validator
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),

                        // Error Message Below Confirm Password
                        if (_showError)
                          const Center(
                            child: Text(
                              "Please fill out all fields!",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _showError = _usernameController.text.isEmpty ||
                              _emailController.text.isEmpty ||
                              _passwordController.text.isEmpty ||
                              _confirmPasswordController.text.isEmpty;
                        });

                        if (!_showError && _formKey.currentState!.validate()) {
                          // Navigate to HomeScreen after sign up
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
                        "Sign Up",
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
                      "or sign up with",
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

                  // Back to Login Button
                  Center(
                    child: TextButton(
                      onPressed: () {
                        // Navigate back to the Login screen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Already have an account? Login',
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

  // Utility Method: Build Text Field
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required FormFieldValidator<String> validator, // Add validator parameter
  }) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black54),
        prefixIcon: Icon(icon, color: Colors.black54),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF00AFDF)),
        ),
      ),
      validator: validator, // Use the validator here
    );
  }

  // Utility Method: Build Password Field
  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
    required FormFieldValidator<String> validator, // Add validator parameter
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black54),
        prefixIcon: const Icon(Icons.lock_outline, color: Colors.black54),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.black54,
          ),
          onPressed: onToggleVisibility,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF00AFDF)),
        ),
      ),
      validator: validator, // Use the validator here
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
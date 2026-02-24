import 'package:flutter/material.dart';
import 'admin_dashboard.dart'; // Import your dashboard here

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String selectedRole = "";
  bool forgotClicked = false;

  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _mobileError;
  String? _passwordError;

  void _validateFields() {
    String mobile = _mobileController.text.trim();
    String password = _passwordController.text.trim();

    setState(() {
      _mobileError = null;
      _passwordError = null;

      if (mobile.isEmpty) {
        _mobileError = "Mobile number is required.";
      } else if (mobile.length != 10 ||
          !RegExp(r'^[0-9]+$').hasMatch(mobile)) {
        _mobileError = "Please enter a valid 10-digit mobile number.";
      }

      if (password.isEmpty) {
        _passwordError = "Password is required.";
      } else if (password.length < 8) {
        _passwordError = "Password must be at least 8 characters long.";
      } else if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&]).+$')
          .hasMatch(password)) {
        _passwordError =
        "Password must include letters, numbers, and a special symbol.";
      }
    });

    // If validation passed
    if (_mobileError == null && _passwordError == null) {
      // Show login success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login successful!"),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to Dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AdminDashboard(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/bg.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Center(
            child: SingleChildScrollView(
              padding:
              const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "LOGIN",
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 35),
                  _buildTextField(
                    controller: _mobileController,
                    hint: "Mobile Number",
                    icon: Icons.phone,
                    obscure: false,
                    errorText: _mobileError,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _passwordController,
                    hint: "Password",
                    icon: Icons.lock,
                    obscure: true,
                    errorText: _passwordError,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFEFEF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.account_circle,
                            color: Color(0xFF0F5272)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DropdownButton<String>(
                            value:
                            selectedRole.isEmpty ? null : selectedRole,
                            isExpanded: true,
                            underline: const SizedBox(),
                            hint: const Text(
                              "Select Role",
                              style: TextStyle(
                                color: Color(0xFF3C3C3C),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            icon: const Icon(Icons.arrow_drop_down,
                                color: Color(0xFF0F5272)),
                            items: const [
                              DropdownMenuItem(
                                value: "Admin",
                                child: Text("Admin"),
                              ),
                              DropdownMenuItem(
                                value: "SuperAdmin",
                                child: Text("Super Admin"),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedRole = value ?? "";
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFBE0108),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: _validateFields,
                      child: const Text(
                        "LOGIN",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        forgotClicked = true;
                      });
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        decoration: forgotClicked
                            ? TextDecoration.underline
                            : TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required bool obscure,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color(0xFF3C3C3C),
              fontWeight: FontWeight.w500,
            ),
            prefixIcon: Icon(icon, color: const Color(0xFF0F5272)),
            filled: true,
            fillColor: const Color(0xFFEFEFEF),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 5),
            child: Text(
              errorText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}
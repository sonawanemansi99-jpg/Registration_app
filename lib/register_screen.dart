import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'otp_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  String? selectedRole;

  final List<String> roles = ["Admin"];
  final List<String> locations = ["Nashik road", "Dwarka", "Panchavati", "Satpur"];

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void registerUser() {
    if (_formKey.currentState!.validate()) {
      String mobile = mobileController.text.trim();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpScreen(mobileNumber: mobile),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F5272),
        title: const Text(
          "Registration Form",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/bg.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.05),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: pickImage,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundColor: const Color(0xFFEFEFEF),
                            backgroundImage: _image != null ? FileImage(_image!) : null,
                            child: _image == null
                                ? const Icon(Icons.camera_alt, size: 35, color: Color(0xFF0F5272))
                                : null,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Upload Profile Photo",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    buildTextField(nameController, "Name", icon: Icons.person),
                    buildTextField(
                      mobileController,
                      "Mobile No",
                      keyboardType: TextInputType.phone,
                      icon: Icons.phone,
                    ),
                    buildTextField(
                      emailController,
                      "Gmail",
                      keyboardType: TextInputType.emailAddress,
                      icon: Icons.email,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Autocomplete<String>(
                        optionsBuilder: (TextEditingValue value) {
                          if (value.text.isEmpty) return locations;
                          return locations.where((loc) => loc.toUpperCase().contains(value.text.toUpperCase()));
                        },
                        onSelected: (value) {
                          locationController.text = value;
                        },
                        fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
                          controller.text = locationController.text;
                          return TextFormField(
                            controller: controller,
                            focusNode: focusNode,
                            validator: (value) {
                              if (value == null || value.isEmpty) return "Please enter Location";
                              return null;
                            },
                            onChanged: (value) {
                              locationController.text = value;
                            },
                            decoration: inputDecoration("Location", Icons.location_on),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: DropdownButtonFormField<String>(
                        value: selectedRole,
                        decoration: inputDecoration("Select Role", Icons.admin_panel_settings),
                        items: roles
                            .map((role) => DropdownMenuItem(value: role, child: Text(role)))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedRole = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) return "Please select Role";
                          return null;
                        },
                      ),
                    ),
                    buildTextField(passwordController, "Password", obscureText: true, icon: Icons.lock),
                    buildTextField(confirmPasswordController, "Confirm Password", obscureText: true, icon: Icons.lock_outline),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFBE0108),
                        minimumSize: const Size(double.infinity, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: registerUser,
                      child: const Text(
                        "Register",
                        style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(
      TextEditingController controller,
      String label, {
        bool obscureText = false,
        TextInputType keyboardType = TextInputType.text,
        required IconData icon,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) return "Please enter $label";
          if (label == "Confirm Password" && value != passwordController.text) {
            return "Passwords do not match";
          }
          return null;
        },
        decoration: inputDecoration(label, icon),
      ),
    );
  }

  InputDecoration inputDecoration(String label, IconData icon) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: const Color(0xFF0F5272)),
      labelText: label,
      filled: true,
      fillColor: const Color(0xFFEFEFEF),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }
}
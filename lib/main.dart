import 'package:flutter/material.dart';
import 'register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Corporate App',
      theme: ThemeData(
        primaryColor: const Color(0xFF0F5272),
        scaffoldBackgroundColor: const Color(0xFFFEFEFE),
        fontFamily: 'Roboto',
      ),
      home: const RegisterScreen(),
    );
  }
}
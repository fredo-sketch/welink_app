import 'package:flutter/material.dart';
import 'core/constants/colors.dart';
import 'features/auth/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeLink App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundLight,
        primaryColor: AppColors.deepBlue,
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}

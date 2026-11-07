import 'package:flutter/material.dart';

import 'screens/registration/registration_screen.dart';
import 'theme/app_colors.dart';

void main() {
  runApp(const AvonApp());
}

class AvonApp extends StatelessWidget {
  const AvonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Avon',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),
      home: const RegistrationScreen(),
    );
  }
}

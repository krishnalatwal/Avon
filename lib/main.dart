import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'screens/registration/registration_screen.dart';
import 'theme/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const AvonApp());
}

class AvonApp extends StatelessWidget {
  const AvonApp({super.key, this.firebaseAuth});

  final FirebaseAuth? firebaseAuth;

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
      home: RegistrationScreen(auth: firebaseAuth),
    );
  }
}

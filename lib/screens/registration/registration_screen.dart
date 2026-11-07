import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/aven_primary_button.dart';
import '../../widgets/aven_text_field.dart';
import '../home/home_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email address is required';
    }
    final emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailPattern.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  void _onCreateAccount() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => HomeScreen(email: _emailController.text.trim()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 44, 24, 28),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _BrandBar(),
                const SizedBox(height: 40),
                Text('Create your account', style: AppTextStyles.title),
                const SizedBox(height: 12),
                Text(
                  "A few details, and you're ready to go.",
                  style: AppTextStyles.subtitle,
                ),
                const SizedBox(height: 40),
                Text('Email address', style: AppTextStyles.fieldLabel),
                const SizedBox(height: 8),
                AvenTextField(
                  controller: _emailController,
                  hintText: 'you@example.com',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: _validateEmail,
                ),
                const SizedBox(height: 20),
                Text('Password', style: AppTextStyles.fieldLabel),
                const SizedBox(height: 8),
                AvenTextField(
                  controller: _passwordController,
                  hintText: 'Create a password',
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  validator: _validatePassword,
                ),
                const SizedBox(height: 24),
                AvenPrimaryButton(
                  label: 'Create account',
                  onPressed: _onCreateAccount,
                ),
                const SizedBox(height: 16),
                _LegalDisclosure(),
                const SizedBox(height: 40),
                _ExistingAccountRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BrandBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Text('a', style: AppTextStyles.monogram),
        ),
        const SizedBox(width: 9),
        Text('Avon', style: AppTextStyles.wordmark),
      ],
    );
  }
}

class _LegalDisclosure extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: AppTextStyles.legal,
        children: [
          const TextSpan(text: 'By creating an account, you agree to our'),
          TextSpan(
            text: ' Terms of Service',
            style: AppTextStyles.legalLink,
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
          const TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy',
            style: AppTextStyles.legalLink,
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
          const TextSpan(text: '.'),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _ExistingAccountRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: 5,
        children: [
          Text('Already have an account?', style: AppTextStyles.footer),
          GestureDetector(
            onTap: () {},
            child: Text('Log in', style: AppTextStyles.footerLink),
          ),
        ],
      ),
    );
  }
}

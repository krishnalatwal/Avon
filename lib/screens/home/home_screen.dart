import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/aven_primary_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 44, 24, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
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
              ),
              const Spacer(),
              Text("You're in!", style: AppTextStyles.title),
              const SizedBox(height: 12),
              Text(
                'Account created locally for $email.\nThis is a placeholder home screen until a real design and backend are ready.',
                style: AppTextStyles.subtitle,
              ),
              const Spacer(),
              AvenPrimaryButton(
                label: 'Log out',
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

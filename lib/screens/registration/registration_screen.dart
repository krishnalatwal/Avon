import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:country_picker/country_picker.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/aven_checkbox_row.dart';
import '../../widgets/aven_primary_button.dart';
import '../../widgets/aven_social_button.dart';
import '../../widgets/aven_text_field.dart';
import '../home/home_screen.dart';

enum _PasswordStrength { weak, fair, good, strong }

class _PasswordStrengthResult {
  const _PasswordStrengthResult(
    this.strength,
    this.label,
    this.hint,
    this.color,
  );

  final _PasswordStrength strength;
  final String label;
  final String hint;
  final Color color;
}

_PasswordStrengthResult _passwordStrength(String password) {
  var score = 0;
  if (password.length >= 8) score++;
  if (password.length >= 12) score++;
  if (RegExp(r'[0-9]').hasMatch(password)) score++;
  if (RegExp(r'[^a-zA-Z0-9]').hasMatch(password)) score++;

  switch (score) {
    case 0:
    case 1:
      return const _PasswordStrengthResult(
        _PasswordStrength.weak,
        'Weak password',
        'Add a number or symbol',
        AppColors.strengthWeak,
      );
    case 2:
      return const _PasswordStrengthResult(
        _PasswordStrength.fair,
        'Fair password',
        'Getting better',
        AppColors.strengthFair,
      );
    case 3:
      return const _PasswordStrengthResult(
        _PasswordStrength.good,
        'Good password',
        'Almost there',
        AppColors.strengthGood,
      );
    default:
      return const _PasswordStrengthResult(
        _PasswordStrength.strong,
        'Strong password',
        'Nice and secure',
        AppColors.strengthStrong,
      );
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _agreedToTerms = false;
  bool _showTermsError = false;
  _PasswordStrengthResult _strength = _passwordStrength('');
  Country _selectedCountry = Country.parse('US');

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() => _strength = _passwordStrength(_passwordController.text));
    });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full name is required';
    }
    return null;
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

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 7 || digits.length > 15) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  void _openCountryPicker() {
    showCountryPicker(
      context: context,
      onSelect: (country) => setState(() => _selectedCountry = country),
    );
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    final hasNumberOrSymbol = RegExp(r'[0-9]|[^a-zA-Z0-9]').hasMatch(value);
    if (!hasNumberOrSymbol) {
      return 'Include at least one number or symbol';
    }
    return null;
  }

  void _onCreateAccount() {
    final isFormValid = _formKey.currentState!.validate();
    setState(() => _showTermsError = !_agreedToTerms);

    if (isFormValid && _agreedToTerms) {
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
                const SizedBox(height: 32),
                AvenSocialButton(
                  icon: const Icon(
                    Icons.apple,
                    size: 22,
                    color: AppColors.textPrimary,
                  ),
                  label: 'Continue with Apple',
                  onPressed: () {},
                ),
                const SizedBox(height: 12),
                AvenSocialButton(
                  icon: Text(
                    'G',
                    style: AppTextStyles.fieldLabel.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  label: 'Continue with Google',
                  onPressed: () {},
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const Expanded(
                      child: Divider(color: AppColors.inputBorder),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        'or sign up with email',
                        style: AppTextStyles.fieldGuidance,
                      ),
                    ),
                    const Expanded(
                      child: Divider(color: AppColors.inputBorder),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Text('Full name', style: AppTextStyles.fieldLabel),
                const SizedBox(height: 8),
                AvenTextField(
                  controller: _fullNameController,
                  hintText: 'Your name',
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: _validateFullName,
                ),
                const SizedBox(height: 20),
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
                Text.rich(
                  TextSpan(
                    style: AppTextStyles.fieldLabel,
                    children: [
                      const TextSpan(text: 'Phone number'),
                      TextSpan(
                        text: ' · Optional',
                        style: AppTextStyles.fieldGuidance,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                AvenTextField(
                  controller: _phoneController,
                  hintText: '(555) 000-0000',
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  validator: _validatePhone,
                  prefix: GestureDetector(
                    onTap: _openCountryPicker,
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${_selectedCountry.countryCode} +${_selectedCountry.phoneCode}',
                            style: AppTextStyles.inputText.copyWith(
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            size: 18,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 5),
                          Container(
                            width: 1,
                            height: 24,
                            color: AppColors.inputBorder,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Only for account recovery.',
                  style: AppTextStyles.fieldGuidance,
                ),
                const SizedBox(height: 20),
                Text('Password', style: AppTextStyles.fieldLabel),
                const SizedBox(height: 8),
                AvenTextField(
                  controller: _passwordController,
                  hintText: 'Create a password',
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.done,
                  validator: _validatePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: List.generate(4, (index) {
                    final filled = index < _strength.strength.index + 1;
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: index < 3 ? 5 : 0),
                        child: Container(
                          height: 4,
                          decoration: BoxDecoration(
                            color: filled
                                ? _strength.color
                                : AppColors.inputBorder,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                if (_passwordController.text.isNotEmpty) ...[
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _strength.label,
                        style: AppTextStyles.fieldGuidance.copyWith(
                          color: _strength.color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(_strength.hint, style: AppTextStyles.fieldGuidance),
                    ],
                  ),
                ],
                const SizedBox(height: 24),
                AvenCheckboxRow(
                  value: _agreedToTerms,
                  onChanged: (value) {
                    setState(() {
                      _agreedToTerms = value;
                      _showTermsError = false;
                    });
                  },
                  label: _TermsLabel(),
                ),
                if (_showTermsError) ...[
                  const SizedBox(height: 6),
                  Text(
                    'You must accept the terms to continue',
                    style: AppTextStyles.errorText,
                  ),
                ],
                const SizedBox(height: 24),
                AvenPrimaryButton(
                  label: 'Create account',
                  onPressed: _onCreateAccount,
                ),
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

class _TermsLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: AppTextStyles.checkboxLabel,
        children: [
          const TextSpan(text: 'I agree to the '),
          TextSpan(
            text: 'Terms of Service',
            style: AppTextStyles.checkboxLink,
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
          const TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy',
            style: AppTextStyles.checkboxLink,
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
          const TextSpan(text: '.'),
        ],
      ),
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

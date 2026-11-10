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

enum _RegistrationMethod { email, phone }

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
  final _confirmPasswordController = TextEditingController();

  _RegistrationMethod _method = _RegistrationMethod.email;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreedToTerms = false;
  bool _showTermsError = false;
  bool _marketingConsent = false;
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
    _confirmPasswordController.dispose();
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

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
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
                        'or create an account',
                        style: AppTextStyles.fieldGuidance,
                      ),
                    ),
                    const Expanded(
                      child: Divider(color: AppColors.inputBorder),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F0ED),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _MethodTab(
                          icon: Icons.mail_outline,
                          label: 'Email',
                          selected: _method == _RegistrationMethod.email,
                          onTap: () => setState(
                            () => _method = _RegistrationMethod.email,
                          ),
                        ),
                      ),
                      Expanded(
                        child: _MethodTab(
                          icon: Icons.smartphone,
                          label: 'Phone',
                          selected: _method == _RegistrationMethod.phone,
                          onTap: () => setState(
                            () => _method = _RegistrationMethod.phone,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _method == _RegistrationMethod.email
                      ? 'Use your email to sign up. Prefer a text? Choose Phone.'
                      : 'Use your phone to sign up. Prefer email? Choose Email.',
                  style: AppTextStyles.fieldGuidance,
                ),
                const SizedBox(height: 24),
                Text(
                  'All fields are required unless marked optional.',
                  style: AppTextStyles.fieldGuidance,
                ),
                const SizedBox(height: 8),
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
                const SizedBox(height: 8),
                Text(
                  "We'll send a verification link to this address.",
                  style: AppTextStyles.fieldGuidance,
                ),
                const SizedBox(height: 20),
                Text.rich(
                  TextSpan(
                    style: AppTextStyles.fieldLabel,
                    children: [
                      const TextSpan(text: 'Recovery phone'),
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
                  'A backup way to get in. Never used for marketing.',
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
                  const SizedBox(height: 10),
                  _PasswordRequirement(
                    met: _passwordController.text.length >= 8,
                    label: 'At least 8 characters',
                  ),
                  const SizedBox(height: 6),
                  _PasswordRequirement(
                    met:
                        RegExp(r'[a-z]').hasMatch(_passwordController.text) &&
                        RegExp(r'[A-Z]').hasMatch(_passwordController.text),
                    label: 'Uppercase and lowercase letters',
                  ),
                  const SizedBox(height: 6),
                  _PasswordRequirement(
                    met: RegExp(r'[0-9]|[^a-zA-Z0-9]')
                        .hasMatch(_passwordController.text),
                    label: 'A number or symbol',
                  ),
                ],
                const SizedBox(height: 20),
                Text('Confirm password', style: AppTextStyles.fieldLabel),
                const SizedBox(height: 8),
                AvenTextField(
                  controller: _confirmPasswordController,
                  hintText: 'Re-enter your password',
                  obscureText: _obscureConfirmPassword,
                  textInputAction: TextInputAction.done,
                  validator: _validateConfirmPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(
                        () =>
                            _obscureConfirmPassword = !_obscureConfirmPassword,
                      );
                    },
                  ),
                ),
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
                const SizedBox(height: 12),
                AvenCheckboxRow(
                  value: _marketingConsent,
                  onChanged: (value) =>
                      setState(() => _marketingConsent = value),
                  label: Text(
                    'Email me occasional product updates and tips. (Optional)',
                    style: AppTextStyles.checkboxLabel,
                  ),
                ),
                const SizedBox(height: 24),
                AvenPrimaryButton(
                  label: 'Create account',
                  onPressed: _onCreateAccount,
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.lock_outline,
                      size: 14,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Your details are private and secure.',
                      style: AppTextStyles.fieldGuidance,
                    ),
                  ],
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              const Icon(
                Icons.help_outline,
                size: 20,
                color: AppColors.primary,
              ),
              const SizedBox(width: 6),
              Text(
                'Help',
                style: AppTextStyles.fieldLabel.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
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

class _MethodTab extends StatelessWidget {
  const _MethodTab({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
          border: selected ? Border.all(color: AppColors.inputBorder) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 17,
              color: selected ? AppColors.primary : AppColors.textSecondary,
            ),
            const SizedBox(width: 7),
            Text(
              label,
              style: AppTextStyles.fieldLabel.copyWith(
                color: selected ? AppColors.primary : AppColors.textSecondary,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PasswordRequirement extends StatelessWidget {
  const _PasswordRequirement({required this.met, required this.label});

  final bool met;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          met ? Icons.check_circle : Icons.radio_button_unchecked,
          size: 14,
          color: met ? AppColors.strengthStrong : AppColors.textSecondary,
        ),
        const SizedBox(width: 8),
        Text(label, style: AppTextStyles.fieldGuidance),
      ],
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

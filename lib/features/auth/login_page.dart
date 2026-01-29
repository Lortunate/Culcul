import 'dart:async';
import 'package:cilixili/core/theme/app_colors.dart';
import 'package:cilixili/features/auth/auth_provider.dart';
import 'package:cilixili/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tabController = useTabController(initialLength: 3);

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkScaffoldBackground : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark
            ? AppColors.darkScaffoldBackground
            : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.close_rounded,
            color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
            size: 24,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const _HeaderSection(),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF2C2C2E)
                      : const Color(0xFFF1F2F3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TabBar(
                  controller: tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: isDark ? const Color(0xFF3A3A3C) : Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  labelColor: AppColors.primary,
                  unselectedLabelColor: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.textSecondary,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                  tabs: [
                    Tab(text: t.auth.account_login),
                    Tab(text: t.auth.sms_login),
                    Tab(text: t.auth.qr_login),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [_PasswordView(), _SmsView(), _QrView()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.bolt_rounded,
            color: AppColors.primary,
            size: 32,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Cilixili',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          Translations.of(context).auth.subtitle,
          style: TextStyle(
            fontSize: 12,
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.textTertiary,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}

class _PasswordView extends HookConsumerWidget {
  const _PasswordView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final userController = useTextEditingController();
    final passController = useTextEditingController();
    final obscureText = useState(true);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          _InputField(
            controller: userController,
            hint: t.auth.username_hint,
            icon: Icons.person_outline_rounded,
          ),
          const SizedBox(height: 16),
          _InputField(
            controller: passController,
            hint: t.auth.password,
            icon: Icons.lock_outline_rounded,
            obscure: obscureText.value,
            suffix: IconButton(
              icon: Icon(
                obscureText.value
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded,
                size: 18,
                color: AppColors.textTertiary,
              ),
              onPressed: () => obscureText.value = !obscureText.value,
            ),
          ),
          const SizedBox(height: 40),
          _SubmitButton(
            text: t.auth.login,
            onPressed: () {
              if (userController.text.isNotEmpty) {
                ref.read(authProvider.notifier).login(userController.text);
                context.pop();
              }
            },
          ),
        ],
      ),
    );
  }
}

class _SmsView extends HookConsumerWidget {
  const _SmsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final phoneController = useTextEditingController();
    final codeController = useTextEditingController();
    final countdown = useState(0);

    useEffect(() {
      Timer? timer;
      if (countdown.value > 0) {
        timer = Timer.periodic(const Duration(seconds: 1), (t) {
          if (countdown.value > 0) {
            countdown.value--;
          } else {
            t.cancel();
          }
        });
      }
      return () => timer?.cancel();
    }, [countdown.value]);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          _InputField(
            controller: phoneController,
            hint: t.auth.phone,
            icon: Icons.phone_iphone_rounded,
            type: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _InputField(
                  controller: codeController,
                  hint: t.auth.sms_code,
                  icon: Icons.verified_user_outlined,
                  type: TextInputType.number,
                ),
              ),
              const SizedBox(width: 12),
              _SmsCodeButton(
                seconds: countdown.value,
                onTap: () => countdown.value = 60,
                label: t.auth.get_code,
              ),
            ],
          ),
          const SizedBox(height: 40),
          _SubmitButton(
            text: t.auth.login,
            onPressed: () {
              if (phoneController.text.isNotEmpty) {
                ref.read(authProvider.notifier).login(phoneController.text);
                context.pop();
              }
            },
          ),
        ],
      ),
    );
  }
}

class _QrView extends StatelessWidget {
  const _QrView();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCardBackground : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark
                    ? const Color(0xFF2C2C2E)
                    : const Color(0xFFE3E5E7),
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.qr_code_scanner_rounded,
                  size: 120,
                  color: isDark
                      ? AppColors.darkTextPrimary
                      : AppColors.textPrimary,
                ),
                const SizedBox(height: 16),
                Text(
                  t.auth.qr_refresh,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            t.auth.qr_hint,
            style: TextStyle(color: AppColors.textTertiary, fontSize: 13),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool obscure;
  final Widget? suffix;
  final TextInputType? type;

  const _InputField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.suffix,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C1C1E) : const Color(0xFFF6F7F8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: type,
        style: TextStyle(
          fontSize: 14,
          color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: AppColors.textTertiary, fontSize: 14),
          prefixIcon: Icon(icon, size: 18, color: AppColors.textTertiary),
          suffixIcon: suffix,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _SubmitButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _SmsCodeButton extends StatelessWidget {
  final int seconds;
  final VoidCallback onTap;
  final String label;

  const _SmsCodeButton({
    required this.seconds,
    required this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final active = seconds == 0;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: active ? onTap : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 48,
        decoration: BoxDecoration(
          color: active
              ? AppColors.primary.withOpacity(0.1)
              : (isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF1F2F3)),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          active ? label : t.auth.get_code_retry(seconds: seconds.toString()),
          style: TextStyle(
            color: active ? AppColors.primary : AppColors.textTertiary,
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/security/security_provider.dart';
import '../../../core/security/security_service.dart';

class AppLockScreen extends ConsumerStatefulWidget {
  const AppLockScreen({super.key});

  @override
  ConsumerState<AppLockScreen> createState() => _AppLockScreenState();
}

class _AppLockScreenState extends ConsumerState<AppLockScreen> {
  String _enteredPin = '';
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkBiometricsIfAvailable();
    });
  }

  Future<void> _checkBiometricsIfAvailable() async {
    final lockState = ref.read(appLockProvider);
    if (lockState.securityMode == SecurityMode.biometric &&
        lockState.canUseBiometrics) {
      final success =
          await ref.read(appLockProvider.notifier).unlockWithBiometrics();
      if (!success && mounted) {
        setState(() {
          _errorMessage = 'فشل التحقق الحيوي، يمكنك استخدام رمز PIN';
        });
      }
    }
  }

  void _onDigitPressed(String digit) async {
    if (_enteredPin.length >= 6) return;

    setState(() {
      _enteredPin += digit;
      _errorMessage = null;
    });

    if (_enteredPin.length >= 4) {
      final ok =
          await ref.read(appLockProvider.notifier).unlockWithPin(_enteredPin);
      if (!ok && _enteredPin.length == 6) {
        setState(() {
          _errorMessage = 'رمز PIN غير صحيح';
          _enteredPin = '';
        });
      }
    }
  }

  void _onDeletePressed() {
    if (_enteredPin.isNotEmpty) {
      setState(() {
        _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1);
        _errorMessage = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lockState = ref.watch(appLockProvider);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withAlpha(25),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.lock_rounded,
                    size: 64,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'نظام إدارة مكتب المحاماة',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'أدخل رمز المرور الشخصي (PIN) للمتابعة',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.brightness == Brightness.dark
                        ? const Color(0xFF94A3B8)
                        : const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 28),
                // دوائر رمز PIN
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(6, (index) {
                    final filled = index < _enteredPin.length;
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: filled
                            ? theme.colorScheme.primary
                            : Colors.transparent,
                        border: Border.all(
                          color: theme.colorScheme.primary,
                          width: 2,
                        ),
                      ),
                    );
                  }),
                ),
                if (_errorMessage != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    _errorMessage!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                const SizedBox(height: 36),
                // لوحة المفاتيح الرقمية
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 320),
                  child: Column(
                    children: [
                      _buildKeyRow(['1', '2', '3']),
                      const SizedBox(height: 16),
                      _buildKeyRow(['4', '5', '6']),
                      const SizedBox(height: 16),
                      _buildKeyRow(['7', '8', '9']),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (lockState.canUseBiometrics)
                            IconButton(
                              iconSize: 32,
                              icon: const Icon(Icons.fingerprint),
                              color: theme.colorScheme.primary,
                              onPressed: _checkBiometricsIfAvailable,
                            )
                          else
                            const SizedBox(width: 48),
                          _buildNumberKey('0'),
                          IconButton(
                            iconSize: 32,
                            icon: const Icon(Icons.backspace_outlined),
                            color: theme.colorScheme.onSurface,
                            onPressed: _onDeletePressed,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildKeyRow(List<String> digits) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: digits.map(_buildNumberKey).toList(),
    );
  }

  Widget _buildNumberKey(String digit) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => _onDigitPressed(digit),
      borderRadius: BorderRadius.circular(40),
      child: Container(
        width: 70,
        height: 70,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: theme.brightness == Brightness.dark
              ? const Color(0xFF1E293B)
              : const Color(0xFFF1F5F9),
        ),
        child: Text(
          digit,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}


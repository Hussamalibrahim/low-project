import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SecurityMode {
  disabled('معطل'),
  pin('رمز PIN'),
  biometric('القياسات الحيوية (بصمة)');

  final String arabicLabel;
  const SecurityMode(this.arabicLabel);
}

class SecurityService {
  static const _pinHashKey = 'sec_pin_hash';
  static const _pinSaltKey = 'sec_pin_salt';
  static const _geminiApiKey = 'sec_gemini_api_key';
  static const _securityModeKey = 'pref_security_mode';
  static const _autoLockMinutesKey = 'pref_auto_lock_minutes';

  final FlutterSecureStorage _secureStorage;
  final LocalAuthentication _localAuth;

  SecurityService({
    FlutterSecureStorage? secureStorage,
    LocalAuthentication? localAuth,
  })  : _secureStorage = secureStorage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(encryptedSharedPreferences: true),
            ),
        _localAuth = localAuth ?? LocalAuthentication();

  // --- إدارة وضع الحماية ---
  Future<SecurityMode> getSecurityMode() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(_securityModeKey);
    if (index != null && index >= 0 && index < SecurityMode.values.length) {
      return SecurityMode.values[index];
    }
    return SecurityMode.disabled;
  }

  Future<void> setSecurityMode(SecurityMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_securityModeKey, mode.index);
  }

  // --- مهلة القفل التلقائي ---
  Future<int> getAutoLockMinutes() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_autoLockMinutesKey) ?? 5; // 5 دقائق افتراضياً
  }

  Future<void> setAutoLockMinutes(int minutes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_autoLockMinutesKey, minutes);
  }

  // --- التحقق من PIN ---
  Future<bool> hasPinSet() async {
    final hash = await _secureStorage.read(key: _pinHashKey);
    return hash != null && hash.isNotEmpty;
  }

  Future<void> setPin(String pin) async {
    final salt = DateTime.now().microsecondsSinceEpoch.toString();
    final hash = _hashPin(pin, salt);
    await _secureStorage.write(key: _pinSaltKey, value: salt);
    await _secureStorage.write(key: _pinHashKey, value: hash);
  }

  Future<bool> verifyPin(String pin) async {
    final storedHash = await _secureStorage.read(key: _pinHashKey);
    final salt = await _secureStorage.read(key: _pinSaltKey);
    if (storedHash == null || salt == null) return false;

    final computedHash = _hashPin(pin, salt);
    return computedHash == storedHash;
  }

  Future<void> removePin() async {
    await _secureStorage.delete(key: _pinHashKey);
    await _secureStorage.delete(key: _pinSaltKey);
  }

  String _hashPin(String pin, String salt) {
    final bytes = utf8.encode('$pin:$salt:LawOfficeDamascusSecure2026');
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  // --- القياسات الحيوية ---
  Future<bool> canCheckBiometrics() async {
    try {
      final canCheck = await _localAuth.canCheckBiometrics;
      final isDeviceSupported = await _localAuth.isDeviceSupported();
      return canCheck && isDeviceSupported;
    } catch (_) {
      return false;
    }
  }

  Future<bool> authenticateBiometric({
    String reason = 'يرجى تأكيد الهوية للوصول إلى نظام إدارة مكتب المحاماة',
  }) async {
    try {
      return await _localAuth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } catch (_) {
      return false;
    }
  }

  // --- مفتاح Google Gemini API الآمن ---
  Future<String?> getGeminiApiKey() async {
    return await _secureStorage.read(key: _geminiApiKey);
  }

  Future<void> setGeminiApiKey(String apiKey) async {
    await _secureStorage.write(key: _geminiApiKey, value: apiKey.trim());
  }

  Future<void> removeGeminiApiKey() async {
    await _secureStorage.delete(key: _geminiApiKey);
  }
}


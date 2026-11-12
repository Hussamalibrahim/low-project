import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'security_service.dart';

class AppLockState {
  final bool isLocked;
  final SecurityMode securityMode;
  final bool hasPin;
  final bool canUseBiometrics;
  final int autoLockMinutes;

  const AppLockState({
    required this.isLocked,
    required this.securityMode,
    required this.hasPin,
    required this.canUseBiometrics,
    required this.autoLockMinutes,
  });

  AppLockState copyWith({
    bool? isLocked,
    SecurityMode? securityMode,
    bool? hasPin,
    bool? canUseBiometrics,
    int? autoLockMinutes,
  }) {
    return AppLockState(
      isLocked: isLocked ?? this.isLocked,
      securityMode: securityMode ?? this.securityMode,
      hasPin: hasPin ?? this.hasPin,
      canUseBiometrics: canUseBiometrics ?? this.canUseBiometrics,
      autoLockMinutes: autoLockMinutes ?? this.autoLockMinutes,
    );
  }
}

class AppLockNotifier extends StateNotifier<AppLockState> {
  final SecurityService _securityService;
  DateTime _lastActiveTime = DateTime.now();

  AppLockNotifier(this._securityService)
      : super(const AppLockState(
          isLocked: false,
          securityMode: SecurityMode.disabled,
          hasPin: false,
          canUseBiometrics: false,
          autoLockMinutes: 5,
        )) {
    init();
  }

  Future<void> init() async {
    final mode = await _securityService.getSecurityMode();
    final hasPin = await _securityService.hasPinSet();
    final canBio = await _securityService.canCheckBiometrics();
    final lockMin = await _securityService.getAutoLockMinutes();

    final shouldLock = mode != SecurityMode.disabled && (hasPin || canBio);

    _lastActiveTime = DateTime.now();
    state = state.copyWith(
      securityMode: mode,
      hasPin: hasPin,
      canUseBiometrics: canBio,
      autoLockMinutes: lockMin,
      isLocked: shouldLock,
    );
  }

  void recordActivity() {
    _lastActiveTime = DateTime.now();
  }

  void checkInactivityTimeout() {
    if (state.securityMode == SecurityMode.disabled) return;
    if (state.isLocked) return;

    final diff = DateTime.now().difference(_lastActiveTime).inMinutes;
    if (diff >= state.autoLockMinutes) {
      lock();
    }
  }

  void lock() {
    if (state.securityMode != SecurityMode.disabled) {
      state = state.copyWith(isLocked: true);
    }
  }

  Future<bool> unlockWithPin(String pin) async {
    final ok = await _securityService.verifyPin(pin);
    if (ok) {
      _lastActiveTime = DateTime.now();
      state = state.copyWith(isLocked: false);
    }
    return ok;
  }

  Future<bool> unlockWithBiometrics() async {
    final ok = await _securityService.authenticateBiometric();
    if (ok) {
      _lastActiveTime = DateTime.now();
      state = state.copyWith(isLocked: false);
    }
    return ok;
  }

  Future<void> updateMode(SecurityMode mode) async {
    await _securityService.setSecurityMode(mode);
    state = state.copyWith(securityMode: mode);
    if (mode == SecurityMode.disabled) {
      state = state.copyWith(isLocked: false);
    }
  }
}

final securityServiceProvider = Provider<SecurityService>((ref) {
  return SecurityService();
});

final appLockProvider =
    StateNotifierProvider<AppLockNotifier, AppLockState>((ref) {
  final secService = ref.watch(securityServiceProvider);
  return AppLockNotifier(secService);
});

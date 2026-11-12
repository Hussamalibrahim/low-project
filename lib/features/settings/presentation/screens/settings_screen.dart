import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/security/security_provider.dart';
import '../../../../core/security/security_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../legal_ai/presentation/providers/legal_ai_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _apiKeyCtrl = TextEditingController();
  bool _obscureKey = true;
  bool _isTestingKey = false;
  String? _keyStatus;

  @override
  void initState() {
    super.initState();
    _loadApiKey();
  }

  Future<void> _loadApiKey() async {
    final sec = ref.read(securityServiceProvider);
    final key = await sec.getGeminiApiKey();
    if (key != null && mounted) {
      _apiKeyCtrl.text = key;
    }
  }

  @override
  void dispose() {
    _apiKeyCtrl.dispose();
    super.dispose();
  }

  Future<void> _testAndSaveKey() async {
    final key = _apiKeyCtrl.text.trim();
    if (key.isEmpty) return;

    setState(() {
      _isTestingKey = true;
      _keyStatus = 'جاري اختبار الاتصال بخوادم Google Gemini...';
    });

    final gemini = ref.read(geminiServiceProvider);
    final ok = await gemini.testConnection(key);

    if (ok) {
      final sec = ref.read(securityServiceProvider);
      await sec.setGeminiApiKey(key);
      setState(() {
        _isTestingKey = false;
        _keyStatus = 'الاتصال ناجح وتم حفظ المفتاح بأمان في مخزن الجهاز المشفر.';
      });
    } else {
      setState(() {
        _isTestingKey = false;
        _keyStatus = 'فشل الاتصال: تأكد من صحة المفتاح واتصالك بالإنترنت.';
      });
    }
  }

  void _showSetPinDialog() {
    final pinCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('تعيين رمز المرور الشخصي (PIN)'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'أدخل رمز PIN مؤلف من 4 إلى 6 أرقام لحماية التطبيق عند الخمول.',
              style: TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: pinCtrl,
              keyboardType: TextInputType.number,
              obscureText: true,
              maxLength: 6,
              decoration: const InputDecoration(labelText: 'رمز PIN الجديد'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (pinCtrl.text.length >= 4) {
                final sec = ref.read(securityServiceProvider);
                await sec.setPin(pinCtrl.text.trim());
                await ref
                    .read(appLockProvider.notifier)
                    .updateMode(SecurityMode.pin);
                if (ctx.mounted) Navigator.of(ctx).pop();
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم تعيين رمز PIN بنجاح')),
                  );
                }
              }
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeState = ref.watch(themeProvider);
    final lockState = ref.watch(appLockProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات والمظهر'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 1. المظهر والسمات اللونية
          Text(
            'المظهر والسمات اللونية',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('وضع الإضاءة:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                SegmentedButton<ThemeMode>(
                  segments: const [
                    ButtonSegment(
                      value: ThemeMode.light,
                      label: Text('نهاري'),
                      icon: Icon(Icons.wb_sunny_outlined),
                    ),
                    ButtonSegment(
                      value: ThemeMode.dark,
                      label: Text('ليلي'),
                      icon: Icon(Icons.dark_mode_outlined),
                    ),
                    ButtonSegment(
                      value: ThemeMode.system,
                      label: Text('تلقائي'),
                      icon: Icon(Icons.brightness_auto),
                    ),
                  ],
                  selected: {themeState.themeMode},
                  onSelectionChanged: (set) {
                    ref.read(themeProvider.notifier).setThemeMode(set.first);
                  },
                ),
                const Divider(height: 24),
                const Text('السمة اللونية الفاخرة:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: AppColorTheme.values.map((colTheme) {
                    final palette = AppPalettes.palettes[colTheme]!;
                    final isSelected = themeState.colorTheme == colTheme;

                    return ChoiceChip(
                      avatar: CircleAvatar(
                        backgroundColor: palette.primary,
                        radius: 8,
                      ),
                      label: Text(colTheme.arabicName),
                      selected: isSelected,
                      onSelected: (_) {
                        ref
                            .read(themeProvider.notifier)
                            .setColorTheme(colTheme);
                      },
                    );
                  }).toList(),
                ),
                const Divider(height: 24),
                const Text('حجم الخط في التطبيق:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: AppFontSize.values.map((fs) {
                    final isSelected = themeState.fontSize == fs;
                    return ChoiceChip(
                      label: Text(fs.arabicName),
                      selected: isSelected,
                      onSelected: (_) {
                        ref.read(themeProvider.notifier).setFontSize(fs);
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 2. الأمان وقفل التطبيق
          Text(
            'الأمان وقفل التطبيق',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<SecurityMode>(
                  initialValue: lockState.securityMode,
                  decoration: const InputDecoration(
                    labelText: 'وضع القفل والحماية',
                    prefixIcon: Icon(Icons.security),
                  ),
                  items: SecurityMode.values
                      .map((m) => DropdownMenuItem(
                            value: m,
                            child: Text(m.arabicLabel),
                          ))
                      .toList(),
                  onChanged: (mode) {
                    if (mode != null) {
                      if (mode == SecurityMode.pin && !lockState.hasPin) {
                        _showSetPinDialog();
                      } else {
                        ref.read(appLockProvider.notifier).updateMode(mode);
                      }
                    }
                  },
                ),
                const SizedBox(height: 12),
                if (lockState.securityMode != SecurityMode.disabled) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('رمز المرور الشخصي (PIN):'),
                      OutlinedButton.icon(
                        onPressed: _showSetPinDialog,
                        icon: const Icon(Icons.pin, size: 16),
                        label: Text(
                            lockState.hasPin ? 'تغيير الرمز' : 'تعيين الرمز'),
                      ),
                    ],
                  ),
                  const Divider(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('قفل بعد خمول:'),
                      DropdownButton<int>(
                        value: lockState.autoLockMinutes,
                        items: const [
                          DropdownMenuItem(value: 1, child: Text('1 دقيقة')),
                          DropdownMenuItem(value: 5, child: Text('5 دقائق')),
                          DropdownMenuItem(value: 15, child: Text('15 دقيقة')),
                          DropdownMenuItem(value: 30, child: Text('30 دقيقة')),
                        ],
                        onChanged: (val) {
                          if (val != null) {
                            ref
                                .read(securityServiceProvider)
                                .setAutoLockMinutes(val);
                            ref.read(appLockProvider.notifier).init();
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 3. مفتاح Google Gemini API
          Text(
            'مساعد الذكاء الاصطناعي (Google Gemini)',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'للحصول على مفتاح API مجاني: توجه إلى موقع Google AI Studio:\nhttps://aistudio.google.com/ والصق المفتاح هنا.',
                  style: TextStyle(fontSize: 12, height: 1.4),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _apiKeyCtrl,
                  obscureText: _obscureKey,
                  decoration: InputDecoration(
                    labelText: 'مفتاح Gemini API Key',
                    prefixIcon: const Icon(Icons.vpn_key),
                    suffixIcon: IconButton(
                      icon: Icon(_obscureKey
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () =>
                          setState(() => _obscureKey = !_obscureKey),
                    ),
                  ),
                ),
                if (_keyStatus != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    _keyStatus!,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _keyStatus!.contains('ناجح')
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ],
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _isTestingKey ? null : _testAndSaveKey,
                        icon: _isTestingKey
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.check_circle_outline),
                        label: const Text('اختبار وحفظ المفتاح'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      tooltip: 'حذف المفتاح',
                      onPressed: () async {
                        final sec = ref.read(securityServiceProvider);
                        await sec.removeGeminiApiKey();
                        _apiKeyCtrl.clear();
                        setState(() => _keyStatus = 'تم حذف المفتاح');
                      },
                    ),
                  ],
                ),
                const Divider(height: 24),
                const Text(
                  'الأمان: يُخزن المفتاح مشفراً في مخزن Android Keystore ولا يتم تضمينه في النسخ الاحتياطية أو قاعدة البيانات.',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

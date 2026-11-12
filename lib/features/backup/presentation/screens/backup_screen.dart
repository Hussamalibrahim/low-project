import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_empty_state.dart';
import '../../../../shared/widgets/app_status_badge.dart';
import '../providers/backup_provider.dart';

class BackupScreen extends ConsumerStatefulWidget {
  const BackupScreen({super.key});

  @override
  ConsumerState<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends ConsumerState<BackupScreen> {
  bool _isLoading = false;
  String? _statusText;

  Future<void> _createBackup() async {
    final passCtrl = TextEditingController();

    final password = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('إنشاء نسخة احتياطية مشفرة (AES-256)'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ستحتوي النسخة على قاعدة البيانات وجميع المستندات المرتبطة بالقضايا مشفرة بالكامل.',
              style: TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: passCtrl,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'كلمة مرور تشفير النسخة *',
                hintText: 'احفظ كلمة المرور بعناية لاستعادتها',
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'تنبيه: لا يمكن استعادة النسخة الاحتياطية في حال نسيان كلمة المرور.',
              style: TextStyle(fontSize: 11, color: Colors.red),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              if (passCtrl.text.trim().isNotEmpty) {
                Navigator.of(ctx).pop(passCtrl.text.trim());
              }
            },
            child: const Text('تأكيد وبدء النسخ'),
          ),
        ],
      ),
    );

    if (password == null || password.isEmpty) return;

    setState(() {
      _isLoading = true;
      _statusText = 'جاري جمع المستندات وضغط وتشفير الأرشيف...';
    });

    try {
      final engine = ref.read(backupEngineProvider);
      final result = await engine.createFullEncryptedBackup(password: password);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'تم إنشاء النسخة الاحتياطية بنجاح (${result.documentsCount} مستند)',
            ),
            backgroundColor: Colors.green,
            action: SnackBarAction(
              label: 'مشاركة / حفظ',
              textColor: Colors.white,
              onPressed: () {
                Share.shareXFiles([
                  XFile(result.backupPath),
                ], text: 'نسخة احتياطية لنظام إدارة مكتب المحاماة');
              },
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('فشل إنشاء النسخة الاحتياطية: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _statusText = null;
        });
      }
    }
  }

  Future<void> _restoreBackup() async {
    final result = await FilePicker.platform.pickFiles(
      dialogTitle: 'اختر ملف النسخة الاحتياطية المشفرة (.enc.zip)',
      type: FileType.any,
    );

    if (result == null || result.files.single.path == null) return;
    final filePath = result.files.single.path!;

    final passCtrl = TextEditingController();

    if (!mounted) return;
    final password = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('فك تشفير واستعادة النسخة الاحتياطية'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'أدخل كلمة المرور التي تم استخدامها لتشفير هذه النسخة.',
              style: TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: passCtrl,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'كلمة مرور فك التشفير *',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              if (passCtrl.text.trim().isNotEmpty) {
                Navigator.of(ctx).pop(passCtrl.text.trim());
              }
            },
            child: const Text('بدء الاستعادة'),
          ),
        ],
      ),
    );

    if (password == null || password.isEmpty) return;

    setState(() {
      _isLoading = true;
      _statusText =
          'جاري فك التشفير والتحقق من سلامة الأرشيف واستعادة البيانات...';
    });

    try {
      final engine = ref.read(backupEngineProvider);
      final manifest = await engine.restoreBackup(
        backupFilePath: filePath,
        password: password,
      );

      if (mounted) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('اكتملت الاستعادة بنجاح'),
            content: Text(
              'تم استعادة قاعدة البيانات و${manifest.documentsCount} مستند بنجاح.\nيرجى إعادة تشغيل التطبيق لتحديث كافة الجداول.',
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('حسناً'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('فشل استعادة النسخة الاحتياطية: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _statusText = null;
        });
      }
    }
  }

  Future<void> _uploadToGoogleDrive(String localPath) async {
    setState(() {
      _isLoading = true;
      _statusText = 'جاري رفع النسخة الاحتياطية المشفرة إلى Google Drive...';
    });

    try {
      final drive = ref.read(googleDriveServiceProvider);
      final fileId = await drive.uploadBackupFile(localPath);

      if (mounted && fileId != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم رفع النسخة الاحتياطية بنجاح إلى Google Drive'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تعذر الرفع إلى Google Drive: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _statusText = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final historyAsync = ref.watch(backupHistoryStreamProvider);
    final driveService = ref.watch(googleDriveServiceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('مركز النسخ الاحتياطي والاستعادة')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // شاشة التحميل إن وجدت
          if (_isLoading) ...[
            AppCard(
              color: Colors.blue.withAlpha(20),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  const CircularProgressIndicator(),
                  const SizedBox(height: 14),
                  Text(
                    _statusText ?? 'جاري تنفيذ العملية...',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],

          // أزرار العمليات الرئيسية بحجم متطابق تماماً
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _createBackup,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 8),
                      minimumSize: const Size(0, 52),
                    ),
                    icon: const Icon(Icons.lock, size: 20),
                    label: const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text('إنشاء نسخة احتياطية', maxLines: 1),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _restoreBackup,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 8),
                      minimumSize: const Size(0, 52),
                    ),
                    icon: const Icon(Icons.restore, size: 20),
                    label: const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text('استعادة نسخة احتياطية', maxLines: 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // تكامل Google Drive
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.cloud_upload_outlined, color: Colors.blue),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'التخزين السحابي (Google Drive)',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (driveService.isSignedIn)
                      const AppStatusBadge(label: 'متصل', color: Colors.green)
                    else
                      const AppStatusBadge(
                        label: 'غير متصل',
                        color: Colors.grey,
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'يتم رفع النسخ الاحتياطية المشفرة يدوياً إلى مساحتك في Google Drive لضمان عدم ضياعها في حال تلف الجهاز.',
                  style: TextStyle(fontSize: 12, color: theme.hintColor),
                ),
                const SizedBox(height: 12),
                if (!driveService.isSignedIn)
                  ElevatedButton.icon(
                    onPressed: () async {
                      await driveService.signIn();
                      setState(() {});
                    },
                    icon: const Icon(Icons.login),
                    label: const Text('تسجيل الدخول إلى Google Drive'),
                  )
                else
                  Row(
                    children: [
                      Text(
                        'الحساب: ${driveService.currentUser?.email ?? ""}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () async {
                          await driveService.signOut();
                          setState(() {});
                        },
                        child: const Text('تسجيل الخروج'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // سجل النسخ الاحتياطية السابقة
          Text(
            'سجل النسخ الاحتياطية المحلية',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          historyAsync.when(
            data: (history) {
              if (history.isEmpty) {
                return const AppEmptyState(
                  icon: Icons.history,
                  title: 'لا توجد نسخ احتياطية مسجلة',
                  subtitle:
                      'قم بإنشاء أول نسخة احتياطية مشفرة لحماية بيانات مكتبك ومستنداتك',
                );
              }

              return Column(
                children: history.map((b) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  b.backupName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8),
                              AppStatusBadge(
                                label:
                                    '${(b.fileSize / (1024 * 1024)).toStringAsFixed(2)} MB',
                                color: Colors.blue,
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Text(
                                'التاريخ: ${AppDateFormatter.formatTimestampWithTime(b.createdAt)}',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: theme.hintColor,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '• ${b.documentsCount} مستند',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: theme.colorScheme.secondary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'SHA-256: ${b.sha256Checksum.substring(0, 16)}...',
                            style: const TextStyle(
                              fontSize: 10,
                              fontFamily: 'monospace',
                            ),
                          ),
                          const Divider(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.share_outlined,
                                  size: 20,
                                ),
                                tooltip: 'مشاركة ملف النسخة',
                                onPressed: () {
                                  Share.shareXFiles([
                                    XFile(b.filePath),
                                  ], text: b.backupName);
                                },
                              ),
                              if (driveService.isSignedIn)
                                IconButton(
                                  icon: const Icon(
                                    Icons.cloud_upload_outlined,
                                    size: 20,
                                    color: Colors.blue,
                                  ),
                                  tooltip: 'رفع إلى Google Drive',
                                  onPressed: () =>
                                      _uploadToGoogleDrive(b.filePath),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
            loading: () => const LinearProgressIndicator(),
            error: (e, _) => Text('خطأ: $e'),
          ),
        ],
      ),
    );
  }
}

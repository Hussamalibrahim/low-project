import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;

class DiscoveredFile {
  final String path;
  final String name;
  final String extension;
  final String mimeType;
  final int size;
  final int lastModified;

  DiscoveredFile({
    required this.path,
    required this.name,
    required this.extension,
    required this.mimeType,
    required this.size,
    required this.lastModified,
  });
}

class SafStorageService {
  /// فتح منتقي المجلدات (Folder Picker) باستخدام Storage Access Framework
  Future<String?> pickDirectory() async {
    try {
      final selectedDirectory = await FilePicker.platform.getDirectoryPath(
        dialogTitle: 'اختر مجلد القضايا والمستندات لربطه بالنظام',
      );
      return selectedDirectory;
    } catch (_) {
      return null;
    }
  }

  /// فحص المجلد المختار واستكشاف الملفات داخله تكرارياً (Recursive Scan)
  /// دون نسخها أو نقلها من مكانها الأصلي إطلاقاً
  Stream<DiscoveredFile> scanDirectoryRecursively(String directoryPath) async* {
    final dir = Directory(directoryPath);
    if (!await dir.exists()) return;

    await for (final entity
        in dir.list(recursive: true, followLinks: false)) {
      if (entity is File) {
        try {
          final stat = await entity.stat();
          final ext = p.extension(entity.path).replaceAll('.', '').toLowerCase();
          final mime = _getMimeFallback(ext);

          yield DiscoveredFile(
            path: entity.path,
            name: p.basename(entity.path),
            extension: ext,
            mimeType: mime,
            size: stat.size,
            lastModified: stat.modified.millisecondsSinceEpoch,
          );
        } catch (_) {
          // تجاوز الملفات غير المتاحة للقراءة دون تعطيل الفحص
          continue;
        }
      }
    }
  }

  /// التحقق من بقاء الملف متاحاً في مساره الأصلي (Missing File Check)
  Future<bool> checkFileExists(String path) async {
    try {
      return await File(path).exists();
    } catch (_) {
      return false;
    }
  }

  /// التحقق من بقاء المجلد متاحاً (Missing Folder Check)
  Future<bool> checkDirectoryExists(String path) async {
    try {
      return await Directory(path).exists();
    } catch (_) {
      return false;
    }
  }

  String _getMimeFallback(String ext) {
    switch (ext) {
      case 'pdf':
        return 'application/pdf';
      case 'doc':
        return 'application/msword';
      case 'docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      case 'xls':
        return 'application/vnd.ms-excel';
      case 'xlsx':
        return 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
      case 'ppt':
        return 'application/vnd.ms-powerpoint';
      case 'pptx':
        return 'application/vnd.openxmlformats-officedocument.presentationml.presentation';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'webp':
        return 'image/webp';
      case 'txt':
        return 'text/plain';
      case 'mp3':
      case 'm4a':
      case 'wav':
        return 'audio/mpeg';
      case 'mp4':
      case 'mov':
        return 'video/mp4';
      case 'zip':
        return 'application/zip';
      case 'rar':
        return 'application/x-rar-compressed';
      default:
        return 'application/octet-stream';
    }
  }
}

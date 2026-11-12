import 'dart:io';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final http.Client _client = http.Client();

  GoogleAuthClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _client.send(request..headers.addAll(_headers));
  }
}

class GoogleDriveService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      drive.DriveApi.driveFileScope,
      drive.DriveApi.driveAppdataScope,
    ],
  );

  GoogleSignInAccount? _currentUser;
  drive.DriveApi? _driveApi;

  GoogleSignInAccount? get currentUser => _currentUser;
  bool get isSignedIn => _currentUser != null;

  Future<bool> signIn() async {
    try {
      _currentUser = await _googleSignIn.signIn();
      if (_currentUser != null) {
        final authHeaders = await _currentUser!.authHeaders;
        final authClient = GoogleAuthClient(authHeaders);
        _driveApi = drive.DriveApi(authClient);
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    _currentUser = null;
    _driveApi = null;
  }

  /// رفع ملف النسخة الاحتياطية إلى Google Drive
  Future<String?> uploadBackupFile(String localFilePath) async {
    if (_driveApi == null) {
      final ok = await signIn();
      if (!ok || _driveApi == null) {
        throw Exception('يرجى تسجيل الدخول إلى Google Drive أولاً');
      }
    }

    final file = File(localFilePath);
    if (!await file.exists()) {
      throw Exception('ملف النسخة الاحتياطية غير موجود محلياً');
    }

    final driveFile = drive.File()
      ..name = p.basename(localFilePath)
      ..description = 'نسخة احتياطية مشفرة لنظام إدارة مكتب المحاماة';

    final media = drive.Media(
      file.openRead(),
      await file.length(),
    );

    final uploaded = await _driveApi!.files.create(
      driveFile,
      uploadMedia: media,
    );

    return uploaded.id;
  }

  /// استعراض النسخ الاحتياطية المرفوعة في Google Drive
  Future<List<drive.File>> listDriveBackups() async {
    if (_driveApi == null) {
      final ok = await signIn();
      if (!ok || _driveApi == null) return [];
    }

    final fileList = await _driveApi!.files.list(
      q: "name contains 'LawOffice_Backup' and trashed = false",
      $fields: 'files(id, name, size, createdTime, modifiedTime)',
    );

    return fileList.files ?? [];
  }

  /// تنزيل نسخة احتياطية من Google Drive
  Future<File> downloadBackup(String driveFileId, String targetLocalPath) async {
    if (_driveApi == null) {
      final ok = await signIn();
      if (!ok || _driveApi == null) {
        throw Exception('يرجى تسجيل الدخول إلى Google Drive أولاً');
      }
    }

    final media = await _driveApi!.files.get(
      driveFileId,
      downloadOptions: drive.DownloadOptions.fullMedia,
    ) as drive.Media;

    final targetFile = File(targetLocalPath);
    await targetFile.parent.create(recursive: true);

    final sink = targetFile.openWrite();
    await media.stream.pipe(sink);
    await sink.flush();
    await sink.close();

    return targetFile;
  }
}


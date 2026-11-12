import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/backup/backup_engine.dart';
import '../../../../core/backup/google_drive_service.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/database_provider.dart';

final backupEngineProvider = Provider<BackupEngine>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return BackupEngine(db);
});

final googleDriveServiceProvider = Provider<GoogleDriveService>((ref) {
  return GoogleDriveService();
});

final backupHistoryStreamProvider =
    StreamProvider<List<BackupHistoryData>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.backupHistory)
        ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)]))
      .watch();
});


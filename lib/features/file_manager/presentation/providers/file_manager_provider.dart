import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/database_provider.dart';
import '../../data/repositories/file_manager_repository.dart';
import '../../data/services/saf_storage_service.dart';

final safStorageServiceProvider = Provider<SafStorageService>((ref) {
  return SafStorageService();
});

final fileManagerRepositoryProvider = Provider<FileManagerRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final saf = ref.watch(safStorageServiceProvider);
  return FileManagerRepository(db, saf);
});

final linkedFoldersStreamProvider = StreamProvider<List<FolderLink>>((ref) {
  final repo = ref.watch(fileManagerRepositoryProvider);
  return repo.watchLinkedFolders();
});

final documentSearchQueryProvider = StateProvider<String>((ref) => '');
final documentCategoryFilterProvider = StateProvider<String?>((ref) => null);
final documentExtensionFilterProvider = StateProvider<String?>((ref) => null);

final allDocumentsStreamProvider = StreamProvider<List<Document>>((ref) {
  final repo = ref.watch(fileManagerRepositoryProvider);
  final search = ref.watch(documentSearchQueryProvider);
  final cat = ref.watch(documentCategoryFilterProvider);
  final ext = ref.watch(documentExtensionFilterProvider);

  return repo.watchAllDocuments(
    searchQuery: search,
    categoryFilter: cat,
    extensionFilter: ext,
  );
});

final clientFoldersStreamProvider =
    StreamProvider<List<ClientFolderWithDocuments>>((ref) {
  final repo = ref.watch(fileManagerRepositoryProvider);
  final search = ref.watch(documentSearchQueryProvider);
  return repo.watchDocumentsGroupedByClient(searchQuery: search);
});

final folderDocumentsStreamProvider =
    StreamProvider.family<List<Document>, String>((ref, folderId) {
  final repo = ref.watch(fileManagerRepositoryProvider);
  return repo.watchFolderDocuments(folderId);
});

final caseDocumentsStreamProvider =
    StreamProvider.family<List<Document>, String>((ref, caseId) {
  final repo = ref.watch(fileManagerRepositoryProvider);
  return repo.watchCaseDocuments(caseId);
});

final documentCasesStreamProvider =
    StreamProvider.family<List<Case>, String>((ref, documentId) {
  final repo = ref.watch(fileManagerRepositoryProvider);
  return repo.watchDocumentCases(documentId);
});

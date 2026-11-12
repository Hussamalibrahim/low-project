import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/utils/arabic_normalizer.dart';

class LegalLibraryRepository {
  final AppDatabase _db;

  LegalLibraryRepository(this._db);

  Stream<List<LegalReference>> watchReferences({
    String? categoryFilter,
    String? typeFilter,
    String? search,
  }) {
    final query = _db.select(_db.legalReferences)
      ..where((tbl) => tbl.deletedAt.isNull());

    if (categoryFilter != null && categoryFilter.isNotEmpty) {
      query.where((tbl) => tbl.category.equals(categoryFilter));
    }

    if (typeFilter != null && typeFilter.isNotEmpty) {
      query.where((tbl) => tbl.referenceType.equals(typeFilter));
    }

    query.orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)]);

    return query.watch().map((list) {
      if (search == null || search.trim().isEmpty) return list;
      return list.where((ref) {
        final matchTitle = ArabicNormalizer.contains(ref.title, search);
        final matchText = ArabicNormalizer.contains(ref.fullText, search);
        final matchSource = ref.source != null &&
            ArabicNormalizer.contains(ref.source!, search);
        return matchTitle || matchText || matchSource;
      }).toList();
    });
  }

  Future<String> addReference({
    required String title,
    required String referenceType,
    String? lawNumber,
    int? year,
    String? issuingAuthority,
    required String category,
    required String fullText,
    String? source,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final id = const Uuid().v4();

    await _db.into(_db.legalReferences).insert(
          LegalReferencesCompanion.insert(
            id: id,
            title: title.trim(),
            referenceType: referenceType,
            lawNumber: Value(lawNumber?.trim()),
            year: Value(year),
            issuingAuthority: Value(issuingAuthority?.trim()),
            category: category,
            fullText: fullText.trim(),
            source: Value(source?.trim()),
            isVerified: const Value(1),
            createdAt: now,
          ),
        );

    return id;
  }
}


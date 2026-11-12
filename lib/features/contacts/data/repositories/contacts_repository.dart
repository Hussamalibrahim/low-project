import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/utils/arabic_normalizer.dart';

class ContactsRepository {
  final AppDatabase _db;

  ContactsRepository(this._db);

  Stream<List<Contact>> watchContacts({String? categoryFilter, String? search}) {
    final query = _db.select(_db.contacts)
      ..where((tbl) => tbl.deletedAt.isNull());

    if (categoryFilter != null && categoryFilter.isNotEmpty) {
      query.where((tbl) => tbl.category.equals(categoryFilter));
    }

    query.orderBy([(tbl) => OrderingTerm.asc(tbl.name)]);

    return query.watch().map((list) {
      if (search == null || search.trim().isEmpty) return list;
      return list.where((c) {
        final matchName = ArabicNormalizer.contains(c.name, search);
        final matchOrg = c.organization != null &&
            ArabicNormalizer.contains(c.organization!, search);
        final matchPhone = c.phone?.contains(search) ?? false;
        return matchName || matchOrg || matchPhone;
      }).toList();
    });
  }

  Future<String> addContact({
    required String name,
    required String category,
    String? phone,
    String? phoneSecondary,
    String? email,
    String? address,
    String? organization,
    String? notes,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final id = const Uuid().v4();

    await _db.into(_db.contacts).insert(
          ContactsCompanion.insert(
            id: id,
            name: name.trim(),
            category: category,
            phone: Value(phone?.trim()),
            phoneSecondary: Value(phoneSecondary?.trim()),
            email: Value(email?.trim()),
            address: Value(address?.trim()),
            organization: Value(organization?.trim()),
            notes: Value(notes?.trim()),
            createdAt: now,
          ),
        );

    return id;
  }
}


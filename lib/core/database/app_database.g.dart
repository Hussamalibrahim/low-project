// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ClientsTable extends Clients with TableInfo<$ClientsTable, Client> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clientTypeMeta = const VerificationMeta(
    'clientType',
  );
  @override
  late final GeneratedColumn<String> clientType = GeneratedColumn<String>(
    'client_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nationalIdMeta = const VerificationMeta(
    'nationalId',
  );
  @override
  late final GeneratedColumn<String> nationalId = GeneratedColumn<String>(
    'national_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneSecondaryMeta = const VerificationMeta(
    'phoneSecondary',
  );
  @override
  late final GeneratedColumn<String> phoneSecondary = GeneratedColumn<String>(
    'phone_secondary',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _occupationMeta = const VerificationMeta(
    'occupation',
  );
  @override
  late final GeneratedColumn<String> occupation = GeneratedColumn<String>(
    'occupation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _companyNameMeta = const VerificationMeta(
    'companyName',
  );
  @override
  late final GeneratedColumn<String> companyName = GeneratedColumn<String>(
    'company_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _commercialRecordMeta = const VerificationMeta(
    'commercialRecord',
  );
  @override
  late final GeneratedColumn<String> commercialRecord = GeneratedColumn<String>(
    'commercial_record',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clientType,
    fullName,
    nationalId,
    phone,
    phoneSecondary,
    email,
    address,
    occupation,
    companyName,
    commercialRecord,
    notes,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clients';
  @override
  VerificationContext validateIntegrity(
    Insertable<Client> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('client_type')) {
      context.handle(
        _clientTypeMeta,
        clientType.isAcceptableOrUnknown(data['client_type']!, _clientTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_clientTypeMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('national_id')) {
      context.handle(
        _nationalIdMeta,
        nationalId.isAcceptableOrUnknown(data['national_id']!, _nationalIdMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('phone_secondary')) {
      context.handle(
        _phoneSecondaryMeta,
        phoneSecondary.isAcceptableOrUnknown(
          data['phone_secondary']!,
          _phoneSecondaryMeta,
        ),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('occupation')) {
      context.handle(
        _occupationMeta,
        occupation.isAcceptableOrUnknown(data['occupation']!, _occupationMeta),
      );
    }
    if (data.containsKey('company_name')) {
      context.handle(
        _companyNameMeta,
        companyName.isAcceptableOrUnknown(
          data['company_name']!,
          _companyNameMeta,
        ),
      );
    }
    if (data.containsKey('commercial_record')) {
      context.handle(
        _commercialRecordMeta,
        commercialRecord.isAcceptableOrUnknown(
          data['commercial_record']!,
          _commercialRecordMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Client map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Client(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      clientType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_type'],
      )!,
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      )!,
      nationalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}national_id'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      phoneSecondary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_secondary'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      occupation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}occupation'],
      ),
      companyName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company_name'],
      ),
      commercialRecord: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}commercial_record'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $ClientsTable createAlias(String alias) {
    return $ClientsTable(attachedDatabase, alias);
  }
}

class Client extends DataClass implements Insertable<Client> {
  final String id;
  final String clientType;
  final String fullName;
  final String? nationalId;
  final String phone;
  final String? phoneSecondary;
  final String? email;
  final String? address;
  final String? occupation;
  final String? companyName;
  final String? commercialRecord;
  final String? notes;
  final int createdAt;
  final int updatedAt;
  final int? deletedAt;
  const Client({
    required this.id,
    required this.clientType,
    required this.fullName,
    this.nationalId,
    required this.phone,
    this.phoneSecondary,
    this.email,
    this.address,
    this.occupation,
    this.companyName,
    this.commercialRecord,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['client_type'] = Variable<String>(clientType);
    map['full_name'] = Variable<String>(fullName);
    if (!nullToAbsent || nationalId != null) {
      map['national_id'] = Variable<String>(nationalId);
    }
    map['phone'] = Variable<String>(phone);
    if (!nullToAbsent || phoneSecondary != null) {
      map['phone_secondary'] = Variable<String>(phoneSecondary);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || occupation != null) {
      map['occupation'] = Variable<String>(occupation);
    }
    if (!nullToAbsent || companyName != null) {
      map['company_name'] = Variable<String>(companyName);
    }
    if (!nullToAbsent || commercialRecord != null) {
      map['commercial_record'] = Variable<String>(commercialRecord);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  ClientsCompanion toCompanion(bool nullToAbsent) {
    return ClientsCompanion(
      id: Value(id),
      clientType: Value(clientType),
      fullName: Value(fullName),
      nationalId: nationalId == null && nullToAbsent
          ? const Value.absent()
          : Value(nationalId),
      phone: Value(phone),
      phoneSecondary: phoneSecondary == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneSecondary),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      occupation: occupation == null && nullToAbsent
          ? const Value.absent()
          : Value(occupation),
      companyName: companyName == null && nullToAbsent
          ? const Value.absent()
          : Value(companyName),
      commercialRecord: commercialRecord == null && nullToAbsent
          ? const Value.absent()
          : Value(commercialRecord),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Client.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Client(
      id: serializer.fromJson<String>(json['id']),
      clientType: serializer.fromJson<String>(json['clientType']),
      fullName: serializer.fromJson<String>(json['fullName']),
      nationalId: serializer.fromJson<String?>(json['nationalId']),
      phone: serializer.fromJson<String>(json['phone']),
      phoneSecondary: serializer.fromJson<String?>(json['phoneSecondary']),
      email: serializer.fromJson<String?>(json['email']),
      address: serializer.fromJson<String?>(json['address']),
      occupation: serializer.fromJson<String?>(json['occupation']),
      companyName: serializer.fromJson<String?>(json['companyName']),
      commercialRecord: serializer.fromJson<String?>(json['commercialRecord']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'clientType': serializer.toJson<String>(clientType),
      'fullName': serializer.toJson<String>(fullName),
      'nationalId': serializer.toJson<String?>(nationalId),
      'phone': serializer.toJson<String>(phone),
      'phoneSecondary': serializer.toJson<String?>(phoneSecondary),
      'email': serializer.toJson<String?>(email),
      'address': serializer.toJson<String?>(address),
      'occupation': serializer.toJson<String?>(occupation),
      'companyName': serializer.toJson<String?>(companyName),
      'commercialRecord': serializer.toJson<String?>(commercialRecord),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  Client copyWith({
    String? id,
    String? clientType,
    String? fullName,
    Value<String?> nationalId = const Value.absent(),
    String? phone,
    Value<String?> phoneSecondary = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> address = const Value.absent(),
    Value<String?> occupation = const Value.absent(),
    Value<String?> companyName = const Value.absent(),
    Value<String?> commercialRecord = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    int? createdAt,
    int? updatedAt,
    Value<int?> deletedAt = const Value.absent(),
  }) => Client(
    id: id ?? this.id,
    clientType: clientType ?? this.clientType,
    fullName: fullName ?? this.fullName,
    nationalId: nationalId.present ? nationalId.value : this.nationalId,
    phone: phone ?? this.phone,
    phoneSecondary: phoneSecondary.present
        ? phoneSecondary.value
        : this.phoneSecondary,
    email: email.present ? email.value : this.email,
    address: address.present ? address.value : this.address,
    occupation: occupation.present ? occupation.value : this.occupation,
    companyName: companyName.present ? companyName.value : this.companyName,
    commercialRecord: commercialRecord.present
        ? commercialRecord.value
        : this.commercialRecord,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Client copyWithCompanion(ClientsCompanion data) {
    return Client(
      id: data.id.present ? data.id.value : this.id,
      clientType: data.clientType.present
          ? data.clientType.value
          : this.clientType,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      nationalId: data.nationalId.present
          ? data.nationalId.value
          : this.nationalId,
      phone: data.phone.present ? data.phone.value : this.phone,
      phoneSecondary: data.phoneSecondary.present
          ? data.phoneSecondary.value
          : this.phoneSecondary,
      email: data.email.present ? data.email.value : this.email,
      address: data.address.present ? data.address.value : this.address,
      occupation: data.occupation.present
          ? data.occupation.value
          : this.occupation,
      companyName: data.companyName.present
          ? data.companyName.value
          : this.companyName,
      commercialRecord: data.commercialRecord.present
          ? data.commercialRecord.value
          : this.commercialRecord,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Client(')
          ..write('id: $id, ')
          ..write('clientType: $clientType, ')
          ..write('fullName: $fullName, ')
          ..write('nationalId: $nationalId, ')
          ..write('phone: $phone, ')
          ..write('phoneSecondary: $phoneSecondary, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('occupation: $occupation, ')
          ..write('companyName: $companyName, ')
          ..write('commercialRecord: $commercialRecord, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    clientType,
    fullName,
    nationalId,
    phone,
    phoneSecondary,
    email,
    address,
    occupation,
    companyName,
    commercialRecord,
    notes,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Client &&
          other.id == this.id &&
          other.clientType == this.clientType &&
          other.fullName == this.fullName &&
          other.nationalId == this.nationalId &&
          other.phone == this.phone &&
          other.phoneSecondary == this.phoneSecondary &&
          other.email == this.email &&
          other.address == this.address &&
          other.occupation == this.occupation &&
          other.companyName == this.companyName &&
          other.commercialRecord == this.commercialRecord &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class ClientsCompanion extends UpdateCompanion<Client> {
  final Value<String> id;
  final Value<String> clientType;
  final Value<String> fullName;
  final Value<String?> nationalId;
  final Value<String> phone;
  final Value<String?> phoneSecondary;
  final Value<String?> email;
  final Value<String?> address;
  final Value<String?> occupation;
  final Value<String?> companyName;
  final Value<String?> commercialRecord;
  final Value<String?> notes;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const ClientsCompanion({
    this.id = const Value.absent(),
    this.clientType = const Value.absent(),
    this.fullName = const Value.absent(),
    this.nationalId = const Value.absent(),
    this.phone = const Value.absent(),
    this.phoneSecondary = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.occupation = const Value.absent(),
    this.companyName = const Value.absent(),
    this.commercialRecord = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClientsCompanion.insert({
    required String id,
    required String clientType,
    required String fullName,
    this.nationalId = const Value.absent(),
    required String phone,
    this.phoneSecondary = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.occupation = const Value.absent(),
    this.companyName = const Value.absent(),
    this.commercialRecord = const Value.absent(),
    this.notes = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       clientType = Value(clientType),
       fullName = Value(fullName),
       phone = Value(phone),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Client> custom({
    Expression<String>? id,
    Expression<String>? clientType,
    Expression<String>? fullName,
    Expression<String>? nationalId,
    Expression<String>? phone,
    Expression<String>? phoneSecondary,
    Expression<String>? email,
    Expression<String>? address,
    Expression<String>? occupation,
    Expression<String>? companyName,
    Expression<String>? commercialRecord,
    Expression<String>? notes,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientType != null) 'client_type': clientType,
      if (fullName != null) 'full_name': fullName,
      if (nationalId != null) 'national_id': nationalId,
      if (phone != null) 'phone': phone,
      if (phoneSecondary != null) 'phone_secondary': phoneSecondary,
      if (email != null) 'email': email,
      if (address != null) 'address': address,
      if (occupation != null) 'occupation': occupation,
      if (companyName != null) 'company_name': companyName,
      if (commercialRecord != null) 'commercial_record': commercialRecord,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClientsCompanion copyWith({
    Value<String>? id,
    Value<String>? clientType,
    Value<String>? fullName,
    Value<String?>? nationalId,
    Value<String>? phone,
    Value<String?>? phoneSecondary,
    Value<String?>? email,
    Value<String?>? address,
    Value<String?>? occupation,
    Value<String?>? companyName,
    Value<String?>? commercialRecord,
    Value<String?>? notes,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int?>? deletedAt,
    Value<int>? rowid,
  }) {
    return ClientsCompanion(
      id: id ?? this.id,
      clientType: clientType ?? this.clientType,
      fullName: fullName ?? this.fullName,
      nationalId: nationalId ?? this.nationalId,
      phone: phone ?? this.phone,
      phoneSecondary: phoneSecondary ?? this.phoneSecondary,
      email: email ?? this.email,
      address: address ?? this.address,
      occupation: occupation ?? this.occupation,
      companyName: companyName ?? this.companyName,
      commercialRecord: commercialRecord ?? this.commercialRecord,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (clientType.present) {
      map['client_type'] = Variable<String>(clientType.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (nationalId.present) {
      map['national_id'] = Variable<String>(nationalId.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (phoneSecondary.present) {
      map['phone_secondary'] = Variable<String>(phoneSecondary.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (occupation.present) {
      map['occupation'] = Variable<String>(occupation.value);
    }
    if (companyName.present) {
      map['company_name'] = Variable<String>(companyName.value);
    }
    if (commercialRecord.present) {
      map['commercial_record'] = Variable<String>(commercialRecord.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientsCompanion(')
          ..write('id: $id, ')
          ..write('clientType: $clientType, ')
          ..write('fullName: $fullName, ')
          ..write('nationalId: $nationalId, ')
          ..write('phone: $phone, ')
          ..write('phoneSecondary: $phoneSecondary, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('occupation: $occupation, ')
          ..write('companyName: $companyName, ')
          ..write('commercialRecord: $commercialRecord, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CourtsTable extends Courts with TableInfo<$CourtsTable, Court> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CourtsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _courtTypeMeta = const VerificationMeta(
    'courtType',
  );
  @override
  late final GeneratedColumn<String> courtType = GeneratedColumn<String>(
    'court_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _governorateMeta = const VerificationMeta(
    'governorate',
  );
  @override
  late final GeneratedColumn<String> governorate = GeneratedColumn<String>(
    'governorate',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    courtType,
    governorate,
    city,
    address,
    phone,
    notes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'courts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Court> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('court_type')) {
      context.handle(
        _courtTypeMeta,
        courtType.isAcceptableOrUnknown(data['court_type']!, _courtTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_courtTypeMeta);
    }
    if (data.containsKey('governorate')) {
      context.handle(
        _governorateMeta,
        governorate.isAcceptableOrUnknown(
          data['governorate']!,
          _governorateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_governorateMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Court map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Court(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      courtType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}court_type'],
      )!,
      governorate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}governorate'],
      )!,
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CourtsTable createAlias(String alias) {
    return $CourtsTable(attachedDatabase, alias);
  }
}

class Court extends DataClass implements Insertable<Court> {
  final String id;
  final String name;
  final String courtType;
  final String governorate;
  final String city;
  final String? address;
  final String? phone;
  final String? notes;
  final int createdAt;
  const Court({
    required this.id,
    required this.name,
    required this.courtType,
    required this.governorate,
    required this.city,
    this.address,
    this.phone,
    this.notes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['court_type'] = Variable<String>(courtType);
    map['governorate'] = Variable<String>(governorate);
    map['city'] = Variable<String>(city);
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  CourtsCompanion toCompanion(bool nullToAbsent) {
    return CourtsCompanion(
      id: Value(id),
      name: Value(name),
      courtType: Value(courtType),
      governorate: Value(governorate),
      city: Value(city),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory Court.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Court(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      courtType: serializer.fromJson<String>(json['courtType']),
      governorate: serializer.fromJson<String>(json['governorate']),
      city: serializer.fromJson<String>(json['city']),
      address: serializer.fromJson<String?>(json['address']),
      phone: serializer.fromJson<String?>(json['phone']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'courtType': serializer.toJson<String>(courtType),
      'governorate': serializer.toJson<String>(governorate),
      'city': serializer.toJson<String>(city),
      'address': serializer.toJson<String?>(address),
      'phone': serializer.toJson<String?>(phone),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  Court copyWith({
    String? id,
    String? name,
    String? courtType,
    String? governorate,
    String? city,
    Value<String?> address = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    int? createdAt,
  }) => Court(
    id: id ?? this.id,
    name: name ?? this.name,
    courtType: courtType ?? this.courtType,
    governorate: governorate ?? this.governorate,
    city: city ?? this.city,
    address: address.present ? address.value : this.address,
    phone: phone.present ? phone.value : this.phone,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
  );
  Court copyWithCompanion(CourtsCompanion data) {
    return Court(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      courtType: data.courtType.present ? data.courtType.value : this.courtType,
      governorate: data.governorate.present
          ? data.governorate.value
          : this.governorate,
      city: data.city.present ? data.city.value : this.city,
      address: data.address.present ? data.address.value : this.address,
      phone: data.phone.present ? data.phone.value : this.phone,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Court(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('courtType: $courtType, ')
          ..write('governorate: $governorate, ')
          ..write('city: $city, ')
          ..write('address: $address, ')
          ..write('phone: $phone, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    courtType,
    governorate,
    city,
    address,
    phone,
    notes,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Court &&
          other.id == this.id &&
          other.name == this.name &&
          other.courtType == this.courtType &&
          other.governorate == this.governorate &&
          other.city == this.city &&
          other.address == this.address &&
          other.phone == this.phone &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class CourtsCompanion extends UpdateCompanion<Court> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> courtType;
  final Value<String> governorate;
  final Value<String> city;
  final Value<String?> address;
  final Value<String?> phone;
  final Value<String?> notes;
  final Value<int> createdAt;
  final Value<int> rowid;
  const CourtsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.courtType = const Value.absent(),
    this.governorate = const Value.absent(),
    this.city = const Value.absent(),
    this.address = const Value.absent(),
    this.phone = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CourtsCompanion.insert({
    required String id,
    required String name,
    required String courtType,
    required String governorate,
    required String city,
    this.address = const Value.absent(),
    this.phone = const Value.absent(),
    this.notes = const Value.absent(),
    required int createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       courtType = Value(courtType),
       governorate = Value(governorate),
       city = Value(city),
       createdAt = Value(createdAt);
  static Insertable<Court> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? courtType,
    Expression<String>? governorate,
    Expression<String>? city,
    Expression<String>? address,
    Expression<String>? phone,
    Expression<String>? notes,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (courtType != null) 'court_type': courtType,
      if (governorate != null) 'governorate': governorate,
      if (city != null) 'city': city,
      if (address != null) 'address': address,
      if (phone != null) 'phone': phone,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CourtsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? courtType,
    Value<String>? governorate,
    Value<String>? city,
    Value<String?>? address,
    Value<String?>? phone,
    Value<String?>? notes,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return CourtsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      courtType: courtType ?? this.courtType,
      governorate: governorate ?? this.governorate,
      city: city ?? this.city,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (courtType.present) {
      map['court_type'] = Variable<String>(courtType.value);
    }
    if (governorate.present) {
      map['governorate'] = Variable<String>(governorate.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CourtsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('courtType: $courtType, ')
          ..write('governorate: $governorate, ')
          ..write('city: $city, ')
          ..write('address: $address, ')
          ..write('phone: $phone, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ContactsTable extends Contacts with TableInfo<$ContactsTable, Contact> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContactsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneSecondaryMeta = const VerificationMeta(
    'phoneSecondary',
  );
  @override
  late final GeneratedColumn<String> phoneSecondary = GeneratedColumn<String>(
    'phone_secondary',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _organizationMeta = const VerificationMeta(
    'organization',
  );
  @override
  late final GeneratedColumn<String> organization = GeneratedColumn<String>(
    'organization',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    category,
    phone,
    phoneSecondary,
    email,
    address,
    organization,
    notes,
    createdAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contacts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Contact> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('phone_secondary')) {
      context.handle(
        _phoneSecondaryMeta,
        phoneSecondary.isAcceptableOrUnknown(
          data['phone_secondary']!,
          _phoneSecondaryMeta,
        ),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('organization')) {
      context.handle(
        _organizationMeta,
        organization.isAcceptableOrUnknown(
          data['organization']!,
          _organizationMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Contact map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Contact(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      phoneSecondary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_secondary'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      organization: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organization'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $ContactsTable createAlias(String alias) {
    return $ContactsTable(attachedDatabase, alias);
  }
}

class Contact extends DataClass implements Insertable<Contact> {
  final String id;
  final String name;
  final String category;
  final String? phone;
  final String? phoneSecondary;
  final String? email;
  final String? address;
  final String? organization;
  final String? notes;
  final int createdAt;
  final int? deletedAt;
  const Contact({
    required this.id,
    required this.name,
    required this.category,
    this.phone,
    this.phoneSecondary,
    this.email,
    this.address,
    this.organization,
    this.notes,
    required this.createdAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || phoneSecondary != null) {
      map['phone_secondary'] = Variable<String>(phoneSecondary);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || organization != null) {
      map['organization'] = Variable<String>(organization);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<int>(createdAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  ContactsCompanion toCompanion(bool nullToAbsent) {
    return ContactsCompanion(
      id: Value(id),
      name: Value(name),
      category: Value(category),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      phoneSecondary: phoneSecondary == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneSecondary),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      organization: organization == null && nullToAbsent
          ? const Value.absent()
          : Value(organization),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Contact.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Contact(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      phone: serializer.fromJson<String?>(json['phone']),
      phoneSecondary: serializer.fromJson<String?>(json['phoneSecondary']),
      email: serializer.fromJson<String?>(json['email']),
      address: serializer.fromJson<String?>(json['address']),
      organization: serializer.fromJson<String?>(json['organization']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'phone': serializer.toJson<String?>(phone),
      'phoneSecondary': serializer.toJson<String?>(phoneSecondary),
      'email': serializer.toJson<String?>(email),
      'address': serializer.toJson<String?>(address),
      'organization': serializer.toJson<String?>(organization),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<int>(createdAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  Contact copyWith({
    String? id,
    String? name,
    String? category,
    Value<String?> phone = const Value.absent(),
    Value<String?> phoneSecondary = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> address = const Value.absent(),
    Value<String?> organization = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    int? createdAt,
    Value<int?> deletedAt = const Value.absent(),
  }) => Contact(
    id: id ?? this.id,
    name: name ?? this.name,
    category: category ?? this.category,
    phone: phone.present ? phone.value : this.phone,
    phoneSecondary: phoneSecondary.present
        ? phoneSecondary.value
        : this.phoneSecondary,
    email: email.present ? email.value : this.email,
    address: address.present ? address.value : this.address,
    organization: organization.present ? organization.value : this.organization,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Contact copyWithCompanion(ContactsCompanion data) {
    return Contact(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      phone: data.phone.present ? data.phone.value : this.phone,
      phoneSecondary: data.phoneSecondary.present
          ? data.phoneSecondary.value
          : this.phoneSecondary,
      email: data.email.present ? data.email.value : this.email,
      address: data.address.present ? data.address.value : this.address,
      organization: data.organization.present
          ? data.organization.value
          : this.organization,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Contact(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('phone: $phone, ')
          ..write('phoneSecondary: $phoneSecondary, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('organization: $organization, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    category,
    phone,
    phoneSecondary,
    email,
    address,
    organization,
    notes,
    createdAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Contact &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.phone == this.phone &&
          other.phoneSecondary == this.phoneSecondary &&
          other.email == this.email &&
          other.address == this.address &&
          other.organization == this.organization &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.deletedAt == this.deletedAt);
}

class ContactsCompanion extends UpdateCompanion<Contact> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> category;
  final Value<String?> phone;
  final Value<String?> phoneSecondary;
  final Value<String?> email;
  final Value<String?> address;
  final Value<String?> organization;
  final Value<String?> notes;
  final Value<int> createdAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const ContactsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.phone = const Value.absent(),
    this.phoneSecondary = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.organization = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ContactsCompanion.insert({
    required String id,
    required String name,
    required String category,
    this.phone = const Value.absent(),
    this.phoneSecondary = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.organization = const Value.absent(),
    this.notes = const Value.absent(),
    required int createdAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       category = Value(category),
       createdAt = Value(createdAt);
  static Insertable<Contact> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? phone,
    Expression<String>? phoneSecondary,
    Expression<String>? email,
    Expression<String>? address,
    Expression<String>? organization,
    Expression<String>? notes,
    Expression<int>? createdAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (phone != null) 'phone': phone,
      if (phoneSecondary != null) 'phone_secondary': phoneSecondary,
      if (email != null) 'email': email,
      if (address != null) 'address': address,
      if (organization != null) 'organization': organization,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ContactsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? category,
    Value<String?>? phone,
    Value<String?>? phoneSecondary,
    Value<String?>? email,
    Value<String?>? address,
    Value<String?>? organization,
    Value<String?>? notes,
    Value<int>? createdAt,
    Value<int?>? deletedAt,
    Value<int>? rowid,
  }) {
    return ContactsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      phone: phone ?? this.phone,
      phoneSecondary: phoneSecondary ?? this.phoneSecondary,
      email: email ?? this.email,
      address: address ?? this.address,
      organization: organization ?? this.organization,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (phoneSecondary.present) {
      map['phone_secondary'] = Variable<String>(phoneSecondary.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (organization.present) {
      map['organization'] = Variable<String>(organization.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('phone: $phone, ')
          ..write('phoneSecondary: $phoneSecondary, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('organization: $organization, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CasesTable extends Cases with TableInfo<$CasesTable, Case> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CasesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caseNumberMeta = const VerificationMeta(
    'caseNumber',
  );
  @override
  late final GeneratedColumn<String> caseNumber = GeneratedColumn<String>(
    'case_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caseYearMeta = const VerificationMeta(
    'caseYear',
  );
  @override
  late final GeneratedColumn<int> caseYear = GeneratedColumn<int>(
    'case_year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caseTypeMeta = const VerificationMeta(
    'caseType',
  );
  @override
  late final GeneratedColumn<String> caseType = GeneratedColumn<String>(
    'case_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _courtIdMeta = const VerificationMeta(
    'courtId',
  );
  @override
  late final GeneratedColumn<String> courtId = GeneratedColumn<String>(
    'court_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES courts (id)',
    ),
  );
  static const VerificationMeta _circuitMeta = const VerificationMeta(
    'circuit',
  );
  @override
  late final GeneratedColumn<String> circuit = GeneratedColumn<String>(
    'circuit',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stageMeta = const VerificationMeta('stage');
  @override
  late final GeneratedColumn<String> stage = GeneratedColumn<String>(
    'stage',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _registrationDateMeta = const VerificationMeta(
    'registrationDate',
  );
  @override
  late final GeneratedColumn<int> registrationDate = GeneratedColumn<int>(
    'registration_date',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _subjectMeta = const VerificationMeta(
    'subject',
  );
  @override
  late final GeneratedColumn<String> subject = GeneratedColumn<String>(
    'subject',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _claimAmountMeta = const VerificationMeta(
    'claimAmount',
  );
  @override
  late final GeneratedColumn<int> claimAmount = GeneratedColumn<int>(
    'claim_amount',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('SYP'),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _outcomeMeta = const VerificationMeta(
    'outcome',
  );
  @override
  late final GeneratedColumn<String> outcome = GeneratedColumn<String>(
    'outcome',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _closingDateMeta = const VerificationMeta(
    'closingDate',
  );
  @override
  late final GeneratedColumn<int> closingDate = GeneratedColumn<int>(
    'closing_date',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    caseNumber,
    caseYear,
    title,
    caseType,
    courtId,
    circuit,
    stage,
    registrationDate,
    subject,
    claimAmount,
    currency,
    status,
    outcome,
    closingDate,
    notes,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cases';
  @override
  VerificationContext validateIntegrity(
    Insertable<Case> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('case_number')) {
      context.handle(
        _caseNumberMeta,
        caseNumber.isAcceptableOrUnknown(data['case_number']!, _caseNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_caseNumberMeta);
    }
    if (data.containsKey('case_year')) {
      context.handle(
        _caseYearMeta,
        caseYear.isAcceptableOrUnknown(data['case_year']!, _caseYearMeta),
      );
    } else if (isInserting) {
      context.missing(_caseYearMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('case_type')) {
      context.handle(
        _caseTypeMeta,
        caseType.isAcceptableOrUnknown(data['case_type']!, _caseTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_caseTypeMeta);
    }
    if (data.containsKey('court_id')) {
      context.handle(
        _courtIdMeta,
        courtId.isAcceptableOrUnknown(data['court_id']!, _courtIdMeta),
      );
    }
    if (data.containsKey('circuit')) {
      context.handle(
        _circuitMeta,
        circuit.isAcceptableOrUnknown(data['circuit']!, _circuitMeta),
      );
    }
    if (data.containsKey('stage')) {
      context.handle(
        _stageMeta,
        stage.isAcceptableOrUnknown(data['stage']!, _stageMeta),
      );
    } else if (isInserting) {
      context.missing(_stageMeta);
    }
    if (data.containsKey('registration_date')) {
      context.handle(
        _registrationDateMeta,
        registrationDate.isAcceptableOrUnknown(
          data['registration_date']!,
          _registrationDateMeta,
        ),
      );
    }
    if (data.containsKey('subject')) {
      context.handle(
        _subjectMeta,
        subject.isAcceptableOrUnknown(data['subject']!, _subjectMeta),
      );
    }
    if (data.containsKey('claim_amount')) {
      context.handle(
        _claimAmountMeta,
        claimAmount.isAcceptableOrUnknown(
          data['claim_amount']!,
          _claimAmountMeta,
        ),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('outcome')) {
      context.handle(
        _outcomeMeta,
        outcome.isAcceptableOrUnknown(data['outcome']!, _outcomeMeta),
      );
    }
    if (data.containsKey('closing_date')) {
      context.handle(
        _closingDateMeta,
        closingDate.isAcceptableOrUnknown(
          data['closing_date']!,
          _closingDateMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Case map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Case(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      caseNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}case_number'],
      )!,
      caseYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}case_year'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      caseType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}case_type'],
      )!,
      courtId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}court_id'],
      ),
      circuit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}circuit'],
      ),
      stage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stage'],
      )!,
      registrationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}registration_date'],
      ),
      subject: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject'],
      ),
      claimAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}claim_amount'],
      ),
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      outcome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}outcome'],
      ),
      closingDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}closing_date'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $CasesTable createAlias(String alias) {
    return $CasesTable(attachedDatabase, alias);
  }
}

class Case extends DataClass implements Insertable<Case> {
  final String id;
  final String caseNumber;
  final int caseYear;
  final String title;
  final String caseType;
  final String? courtId;
  final String? circuit;
  final String stage;
  final int? registrationDate;
  final String? subject;
  final int? claimAmount;
  final String currency;
  final String status;
  final String? outcome;
  final int? closingDate;
  final String? notes;
  final int createdAt;
  final int updatedAt;
  final int? deletedAt;
  const Case({
    required this.id,
    required this.caseNumber,
    required this.caseYear,
    required this.title,
    required this.caseType,
    this.courtId,
    this.circuit,
    required this.stage,
    this.registrationDate,
    this.subject,
    this.claimAmount,
    required this.currency,
    required this.status,
    this.outcome,
    this.closingDate,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['case_number'] = Variable<String>(caseNumber);
    map['case_year'] = Variable<int>(caseYear);
    map['title'] = Variable<String>(title);
    map['case_type'] = Variable<String>(caseType);
    if (!nullToAbsent || courtId != null) {
      map['court_id'] = Variable<String>(courtId);
    }
    if (!nullToAbsent || circuit != null) {
      map['circuit'] = Variable<String>(circuit);
    }
    map['stage'] = Variable<String>(stage);
    if (!nullToAbsent || registrationDate != null) {
      map['registration_date'] = Variable<int>(registrationDate);
    }
    if (!nullToAbsent || subject != null) {
      map['subject'] = Variable<String>(subject);
    }
    if (!nullToAbsent || claimAmount != null) {
      map['claim_amount'] = Variable<int>(claimAmount);
    }
    map['currency'] = Variable<String>(currency);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || outcome != null) {
      map['outcome'] = Variable<String>(outcome);
    }
    if (!nullToAbsent || closingDate != null) {
      map['closing_date'] = Variable<int>(closingDate);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  CasesCompanion toCompanion(bool nullToAbsent) {
    return CasesCompanion(
      id: Value(id),
      caseNumber: Value(caseNumber),
      caseYear: Value(caseYear),
      title: Value(title),
      caseType: Value(caseType),
      courtId: courtId == null && nullToAbsent
          ? const Value.absent()
          : Value(courtId),
      circuit: circuit == null && nullToAbsent
          ? const Value.absent()
          : Value(circuit),
      stage: Value(stage),
      registrationDate: registrationDate == null && nullToAbsent
          ? const Value.absent()
          : Value(registrationDate),
      subject: subject == null && nullToAbsent
          ? const Value.absent()
          : Value(subject),
      claimAmount: claimAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(claimAmount),
      currency: Value(currency),
      status: Value(status),
      outcome: outcome == null && nullToAbsent
          ? const Value.absent()
          : Value(outcome),
      closingDate: closingDate == null && nullToAbsent
          ? const Value.absent()
          : Value(closingDate),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Case.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Case(
      id: serializer.fromJson<String>(json['id']),
      caseNumber: serializer.fromJson<String>(json['caseNumber']),
      caseYear: serializer.fromJson<int>(json['caseYear']),
      title: serializer.fromJson<String>(json['title']),
      caseType: serializer.fromJson<String>(json['caseType']),
      courtId: serializer.fromJson<String?>(json['courtId']),
      circuit: serializer.fromJson<String?>(json['circuit']),
      stage: serializer.fromJson<String>(json['stage']),
      registrationDate: serializer.fromJson<int?>(json['registrationDate']),
      subject: serializer.fromJson<String?>(json['subject']),
      claimAmount: serializer.fromJson<int?>(json['claimAmount']),
      currency: serializer.fromJson<String>(json['currency']),
      status: serializer.fromJson<String>(json['status']),
      outcome: serializer.fromJson<String?>(json['outcome']),
      closingDate: serializer.fromJson<int?>(json['closingDate']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'caseNumber': serializer.toJson<String>(caseNumber),
      'caseYear': serializer.toJson<int>(caseYear),
      'title': serializer.toJson<String>(title),
      'caseType': serializer.toJson<String>(caseType),
      'courtId': serializer.toJson<String?>(courtId),
      'circuit': serializer.toJson<String?>(circuit),
      'stage': serializer.toJson<String>(stage),
      'registrationDate': serializer.toJson<int?>(registrationDate),
      'subject': serializer.toJson<String?>(subject),
      'claimAmount': serializer.toJson<int?>(claimAmount),
      'currency': serializer.toJson<String>(currency),
      'status': serializer.toJson<String>(status),
      'outcome': serializer.toJson<String?>(outcome),
      'closingDate': serializer.toJson<int?>(closingDate),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  Case copyWith({
    String? id,
    String? caseNumber,
    int? caseYear,
    String? title,
    String? caseType,
    Value<String?> courtId = const Value.absent(),
    Value<String?> circuit = const Value.absent(),
    String? stage,
    Value<int?> registrationDate = const Value.absent(),
    Value<String?> subject = const Value.absent(),
    Value<int?> claimAmount = const Value.absent(),
    String? currency,
    String? status,
    Value<String?> outcome = const Value.absent(),
    Value<int?> closingDate = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    int? createdAt,
    int? updatedAt,
    Value<int?> deletedAt = const Value.absent(),
  }) => Case(
    id: id ?? this.id,
    caseNumber: caseNumber ?? this.caseNumber,
    caseYear: caseYear ?? this.caseYear,
    title: title ?? this.title,
    caseType: caseType ?? this.caseType,
    courtId: courtId.present ? courtId.value : this.courtId,
    circuit: circuit.present ? circuit.value : this.circuit,
    stage: stage ?? this.stage,
    registrationDate: registrationDate.present
        ? registrationDate.value
        : this.registrationDate,
    subject: subject.present ? subject.value : this.subject,
    claimAmount: claimAmount.present ? claimAmount.value : this.claimAmount,
    currency: currency ?? this.currency,
    status: status ?? this.status,
    outcome: outcome.present ? outcome.value : this.outcome,
    closingDate: closingDate.present ? closingDate.value : this.closingDate,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Case copyWithCompanion(CasesCompanion data) {
    return Case(
      id: data.id.present ? data.id.value : this.id,
      caseNumber: data.caseNumber.present
          ? data.caseNumber.value
          : this.caseNumber,
      caseYear: data.caseYear.present ? data.caseYear.value : this.caseYear,
      title: data.title.present ? data.title.value : this.title,
      caseType: data.caseType.present ? data.caseType.value : this.caseType,
      courtId: data.courtId.present ? data.courtId.value : this.courtId,
      circuit: data.circuit.present ? data.circuit.value : this.circuit,
      stage: data.stage.present ? data.stage.value : this.stage,
      registrationDate: data.registrationDate.present
          ? data.registrationDate.value
          : this.registrationDate,
      subject: data.subject.present ? data.subject.value : this.subject,
      claimAmount: data.claimAmount.present
          ? data.claimAmount.value
          : this.claimAmount,
      currency: data.currency.present ? data.currency.value : this.currency,
      status: data.status.present ? data.status.value : this.status,
      outcome: data.outcome.present ? data.outcome.value : this.outcome,
      closingDate: data.closingDate.present
          ? data.closingDate.value
          : this.closingDate,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Case(')
          ..write('id: $id, ')
          ..write('caseNumber: $caseNumber, ')
          ..write('caseYear: $caseYear, ')
          ..write('title: $title, ')
          ..write('caseType: $caseType, ')
          ..write('courtId: $courtId, ')
          ..write('circuit: $circuit, ')
          ..write('stage: $stage, ')
          ..write('registrationDate: $registrationDate, ')
          ..write('subject: $subject, ')
          ..write('claimAmount: $claimAmount, ')
          ..write('currency: $currency, ')
          ..write('status: $status, ')
          ..write('outcome: $outcome, ')
          ..write('closingDate: $closingDate, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    caseNumber,
    caseYear,
    title,
    caseType,
    courtId,
    circuit,
    stage,
    registrationDate,
    subject,
    claimAmount,
    currency,
    status,
    outcome,
    closingDate,
    notes,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Case &&
          other.id == this.id &&
          other.caseNumber == this.caseNumber &&
          other.caseYear == this.caseYear &&
          other.title == this.title &&
          other.caseType == this.caseType &&
          other.courtId == this.courtId &&
          other.circuit == this.circuit &&
          other.stage == this.stage &&
          other.registrationDate == this.registrationDate &&
          other.subject == this.subject &&
          other.claimAmount == this.claimAmount &&
          other.currency == this.currency &&
          other.status == this.status &&
          other.outcome == this.outcome &&
          other.closingDate == this.closingDate &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class CasesCompanion extends UpdateCompanion<Case> {
  final Value<String> id;
  final Value<String> caseNumber;
  final Value<int> caseYear;
  final Value<String> title;
  final Value<String> caseType;
  final Value<String?> courtId;
  final Value<String?> circuit;
  final Value<String> stage;
  final Value<int?> registrationDate;
  final Value<String?> subject;
  final Value<int?> claimAmount;
  final Value<String> currency;
  final Value<String> status;
  final Value<String?> outcome;
  final Value<int?> closingDate;
  final Value<String?> notes;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const CasesCompanion({
    this.id = const Value.absent(),
    this.caseNumber = const Value.absent(),
    this.caseYear = const Value.absent(),
    this.title = const Value.absent(),
    this.caseType = const Value.absent(),
    this.courtId = const Value.absent(),
    this.circuit = const Value.absent(),
    this.stage = const Value.absent(),
    this.registrationDate = const Value.absent(),
    this.subject = const Value.absent(),
    this.claimAmount = const Value.absent(),
    this.currency = const Value.absent(),
    this.status = const Value.absent(),
    this.outcome = const Value.absent(),
    this.closingDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CasesCompanion.insert({
    required String id,
    required String caseNumber,
    required int caseYear,
    required String title,
    required String caseType,
    this.courtId = const Value.absent(),
    this.circuit = const Value.absent(),
    required String stage,
    this.registrationDate = const Value.absent(),
    this.subject = const Value.absent(),
    this.claimAmount = const Value.absent(),
    this.currency = const Value.absent(),
    required String status,
    this.outcome = const Value.absent(),
    this.closingDate = const Value.absent(),
    this.notes = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       caseNumber = Value(caseNumber),
       caseYear = Value(caseYear),
       title = Value(title),
       caseType = Value(caseType),
       stage = Value(stage),
       status = Value(status),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Case> custom({
    Expression<String>? id,
    Expression<String>? caseNumber,
    Expression<int>? caseYear,
    Expression<String>? title,
    Expression<String>? caseType,
    Expression<String>? courtId,
    Expression<String>? circuit,
    Expression<String>? stage,
    Expression<int>? registrationDate,
    Expression<String>? subject,
    Expression<int>? claimAmount,
    Expression<String>? currency,
    Expression<String>? status,
    Expression<String>? outcome,
    Expression<int>? closingDate,
    Expression<String>? notes,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (caseNumber != null) 'case_number': caseNumber,
      if (caseYear != null) 'case_year': caseYear,
      if (title != null) 'title': title,
      if (caseType != null) 'case_type': caseType,
      if (courtId != null) 'court_id': courtId,
      if (circuit != null) 'circuit': circuit,
      if (stage != null) 'stage': stage,
      if (registrationDate != null) 'registration_date': registrationDate,
      if (subject != null) 'subject': subject,
      if (claimAmount != null) 'claim_amount': claimAmount,
      if (currency != null) 'currency': currency,
      if (status != null) 'status': status,
      if (outcome != null) 'outcome': outcome,
      if (closingDate != null) 'closing_date': closingDate,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CasesCompanion copyWith({
    Value<String>? id,
    Value<String>? caseNumber,
    Value<int>? caseYear,
    Value<String>? title,
    Value<String>? caseType,
    Value<String?>? courtId,
    Value<String?>? circuit,
    Value<String>? stage,
    Value<int?>? registrationDate,
    Value<String?>? subject,
    Value<int?>? claimAmount,
    Value<String>? currency,
    Value<String>? status,
    Value<String?>? outcome,
    Value<int?>? closingDate,
    Value<String?>? notes,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int?>? deletedAt,
    Value<int>? rowid,
  }) {
    return CasesCompanion(
      id: id ?? this.id,
      caseNumber: caseNumber ?? this.caseNumber,
      caseYear: caseYear ?? this.caseYear,
      title: title ?? this.title,
      caseType: caseType ?? this.caseType,
      courtId: courtId ?? this.courtId,
      circuit: circuit ?? this.circuit,
      stage: stage ?? this.stage,
      registrationDate: registrationDate ?? this.registrationDate,
      subject: subject ?? this.subject,
      claimAmount: claimAmount ?? this.claimAmount,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      outcome: outcome ?? this.outcome,
      closingDate: closingDate ?? this.closingDate,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (caseNumber.present) {
      map['case_number'] = Variable<String>(caseNumber.value);
    }
    if (caseYear.present) {
      map['case_year'] = Variable<int>(caseYear.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (caseType.present) {
      map['case_type'] = Variable<String>(caseType.value);
    }
    if (courtId.present) {
      map['court_id'] = Variable<String>(courtId.value);
    }
    if (circuit.present) {
      map['circuit'] = Variable<String>(circuit.value);
    }
    if (stage.present) {
      map['stage'] = Variable<String>(stage.value);
    }
    if (registrationDate.present) {
      map['registration_date'] = Variable<int>(registrationDate.value);
    }
    if (subject.present) {
      map['subject'] = Variable<String>(subject.value);
    }
    if (claimAmount.present) {
      map['claim_amount'] = Variable<int>(claimAmount.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (outcome.present) {
      map['outcome'] = Variable<String>(outcome.value);
    }
    if (closingDate.present) {
      map['closing_date'] = Variable<int>(closingDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CasesCompanion(')
          ..write('id: $id, ')
          ..write('caseNumber: $caseNumber, ')
          ..write('caseYear: $caseYear, ')
          ..write('title: $title, ')
          ..write('caseType: $caseType, ')
          ..write('courtId: $courtId, ')
          ..write('circuit: $circuit, ')
          ..write('stage: $stage, ')
          ..write('registrationDate: $registrationDate, ')
          ..write('subject: $subject, ')
          ..write('claimAmount: $claimAmount, ')
          ..write('currency: $currency, ')
          ..write('status: $status, ')
          ..write('outcome: $outcome, ')
          ..write('closingDate: $closingDate, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CaseClientsTable extends CaseClients
    with TableInfo<$CaseClientsTable, CaseClient> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CaseClientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caseIdMeta = const VerificationMeta('caseId');
  @override
  late final GeneratedColumn<String> caseId = GeneratedColumn<String>(
    'case_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cases (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clients (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, caseId, clientId, role, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'case_clients';
  @override
  VerificationContext validateIntegrity(
    Insertable<CaseClient> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('case_id')) {
      context.handle(
        _caseIdMeta,
        caseId.isAcceptableOrUnknown(data['case_id']!, _caseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_caseIdMeta);
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CaseClient map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CaseClient(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      caseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}case_id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_id'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CaseClientsTable createAlias(String alias) {
    return $CaseClientsTable(attachedDatabase, alias);
  }
}

class CaseClient extends DataClass implements Insertable<CaseClient> {
  final String id;
  final String caseId;
  final String clientId;
  final String role;
  final int createdAt;
  const CaseClient({
    required this.id,
    required this.caseId,
    required this.clientId,
    required this.role,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['case_id'] = Variable<String>(caseId);
    map['client_id'] = Variable<String>(clientId);
    map['role'] = Variable<String>(role);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  CaseClientsCompanion toCompanion(bool nullToAbsent) {
    return CaseClientsCompanion(
      id: Value(id),
      caseId: Value(caseId),
      clientId: Value(clientId),
      role: Value(role),
      createdAt: Value(createdAt),
    );
  }

  factory CaseClient.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CaseClient(
      id: serializer.fromJson<String>(json['id']),
      caseId: serializer.fromJson<String>(json['caseId']),
      clientId: serializer.fromJson<String>(json['clientId']),
      role: serializer.fromJson<String>(json['role']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'caseId': serializer.toJson<String>(caseId),
      'clientId': serializer.toJson<String>(clientId),
      'role': serializer.toJson<String>(role),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  CaseClient copyWith({
    String? id,
    String? caseId,
    String? clientId,
    String? role,
    int? createdAt,
  }) => CaseClient(
    id: id ?? this.id,
    caseId: caseId ?? this.caseId,
    clientId: clientId ?? this.clientId,
    role: role ?? this.role,
    createdAt: createdAt ?? this.createdAt,
  );
  CaseClient copyWithCompanion(CaseClientsCompanion data) {
    return CaseClient(
      id: data.id.present ? data.id.value : this.id,
      caseId: data.caseId.present ? data.caseId.value : this.caseId,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      role: data.role.present ? data.role.value : this.role,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CaseClient(')
          ..write('id: $id, ')
          ..write('caseId: $caseId, ')
          ..write('clientId: $clientId, ')
          ..write('role: $role, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, caseId, clientId, role, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CaseClient &&
          other.id == this.id &&
          other.caseId == this.caseId &&
          other.clientId == this.clientId &&
          other.role == this.role &&
          other.createdAt == this.createdAt);
}

class CaseClientsCompanion extends UpdateCompanion<CaseClient> {
  final Value<String> id;
  final Value<String> caseId;
  final Value<String> clientId;
  final Value<String> role;
  final Value<int> createdAt;
  final Value<int> rowid;
  const CaseClientsCompanion({
    this.id = const Value.absent(),
    this.caseId = const Value.absent(),
    this.clientId = const Value.absent(),
    this.role = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CaseClientsCompanion.insert({
    required String id,
    required String caseId,
    required String clientId,
    required String role,
    required int createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       caseId = Value(caseId),
       clientId = Value(clientId),
       role = Value(role),
       createdAt = Value(createdAt);
  static Insertable<CaseClient> custom({
    Expression<String>? id,
    Expression<String>? caseId,
    Expression<String>? clientId,
    Expression<String>? role,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (caseId != null) 'case_id': caseId,
      if (clientId != null) 'client_id': clientId,
      if (role != null) 'role': role,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CaseClientsCompanion copyWith({
    Value<String>? id,
    Value<String>? caseId,
    Value<String>? clientId,
    Value<String>? role,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return CaseClientsCompanion(
      id: id ?? this.id,
      caseId: caseId ?? this.caseId,
      clientId: clientId ?? this.clientId,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (caseId.present) {
      map['case_id'] = Variable<String>(caseId.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CaseClientsCompanion(')
          ..write('id: $id, ')
          ..write('caseId: $caseId, ')
          ..write('clientId: $clientId, ')
          ..write('role: $role, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CasePartiesTable extends CaseParties
    with TableInfo<$CasePartiesTable, CaseParty> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CasePartiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caseIdMeta = const VerificationMeta('caseId');
  @override
  late final GeneratedColumn<String> caseId = GeneratedColumn<String>(
    'case_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cases (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lawyerNameMeta = const VerificationMeta(
    'lawyerName',
  );
  @override
  late final GeneratedColumn<String> lawyerName = GeneratedColumn<String>(
    'lawyer_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lawyerPhoneMeta = const VerificationMeta(
    'lawyerPhone',
  );
  @override
  late final GeneratedColumn<String> lawyerPhone = GeneratedColumn<String>(
    'lawyer_phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    caseId,
    name,
    role,
    lawyerName,
    lawyerPhone,
    notes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'case_parties';
  @override
  VerificationContext validateIntegrity(
    Insertable<CaseParty> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('case_id')) {
      context.handle(
        _caseIdMeta,
        caseId.isAcceptableOrUnknown(data['case_id']!, _caseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_caseIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('lawyer_name')) {
      context.handle(
        _lawyerNameMeta,
        lawyerName.isAcceptableOrUnknown(data['lawyer_name']!, _lawyerNameMeta),
      );
    }
    if (data.containsKey('lawyer_phone')) {
      context.handle(
        _lawyerPhoneMeta,
        lawyerPhone.isAcceptableOrUnknown(
          data['lawyer_phone']!,
          _lawyerPhoneMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CaseParty map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CaseParty(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      caseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}case_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      lawyerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lawyer_name'],
      ),
      lawyerPhone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lawyer_phone'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CasePartiesTable createAlias(String alias) {
    return $CasePartiesTable(attachedDatabase, alias);
  }
}

class CaseParty extends DataClass implements Insertable<CaseParty> {
  final String id;
  final String caseId;
  final String name;
  final String role;
  final String? lawyerName;
  final String? lawyerPhone;
  final String? notes;
  final int createdAt;
  const CaseParty({
    required this.id,
    required this.caseId,
    required this.name,
    required this.role,
    this.lawyerName,
    this.lawyerPhone,
    this.notes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['case_id'] = Variable<String>(caseId);
    map['name'] = Variable<String>(name);
    map['role'] = Variable<String>(role);
    if (!nullToAbsent || lawyerName != null) {
      map['lawyer_name'] = Variable<String>(lawyerName);
    }
    if (!nullToAbsent || lawyerPhone != null) {
      map['lawyer_phone'] = Variable<String>(lawyerPhone);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  CasePartiesCompanion toCompanion(bool nullToAbsent) {
    return CasePartiesCompanion(
      id: Value(id),
      caseId: Value(caseId),
      name: Value(name),
      role: Value(role),
      lawyerName: lawyerName == null && nullToAbsent
          ? const Value.absent()
          : Value(lawyerName),
      lawyerPhone: lawyerPhone == null && nullToAbsent
          ? const Value.absent()
          : Value(lawyerPhone),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory CaseParty.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CaseParty(
      id: serializer.fromJson<String>(json['id']),
      caseId: serializer.fromJson<String>(json['caseId']),
      name: serializer.fromJson<String>(json['name']),
      role: serializer.fromJson<String>(json['role']),
      lawyerName: serializer.fromJson<String?>(json['lawyerName']),
      lawyerPhone: serializer.fromJson<String?>(json['lawyerPhone']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'caseId': serializer.toJson<String>(caseId),
      'name': serializer.toJson<String>(name),
      'role': serializer.toJson<String>(role),
      'lawyerName': serializer.toJson<String?>(lawyerName),
      'lawyerPhone': serializer.toJson<String?>(lawyerPhone),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  CaseParty copyWith({
    String? id,
    String? caseId,
    String? name,
    String? role,
    Value<String?> lawyerName = const Value.absent(),
    Value<String?> lawyerPhone = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    int? createdAt,
  }) => CaseParty(
    id: id ?? this.id,
    caseId: caseId ?? this.caseId,
    name: name ?? this.name,
    role: role ?? this.role,
    lawyerName: lawyerName.present ? lawyerName.value : this.lawyerName,
    lawyerPhone: lawyerPhone.present ? lawyerPhone.value : this.lawyerPhone,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
  );
  CaseParty copyWithCompanion(CasePartiesCompanion data) {
    return CaseParty(
      id: data.id.present ? data.id.value : this.id,
      caseId: data.caseId.present ? data.caseId.value : this.caseId,
      name: data.name.present ? data.name.value : this.name,
      role: data.role.present ? data.role.value : this.role,
      lawyerName: data.lawyerName.present
          ? data.lawyerName.value
          : this.lawyerName,
      lawyerPhone: data.lawyerPhone.present
          ? data.lawyerPhone.value
          : this.lawyerPhone,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CaseParty(')
          ..write('id: $id, ')
          ..write('caseId: $caseId, ')
          ..write('name: $name, ')
          ..write('role: $role, ')
          ..write('lawyerName: $lawyerName, ')
          ..write('lawyerPhone: $lawyerPhone, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    caseId,
    name,
    role,
    lawyerName,
    lawyerPhone,
    notes,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CaseParty &&
          other.id == this.id &&
          other.caseId == this.caseId &&
          other.name == this.name &&
          other.role == this.role &&
          other.lawyerName == this.lawyerName &&
          other.lawyerPhone == this.lawyerPhone &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class CasePartiesCompanion extends UpdateCompanion<CaseParty> {
  final Value<String> id;
  final Value<String> caseId;
  final Value<String> name;
  final Value<String> role;
  final Value<String?> lawyerName;
  final Value<String?> lawyerPhone;
  final Value<String?> notes;
  final Value<int> createdAt;
  final Value<int> rowid;
  const CasePartiesCompanion({
    this.id = const Value.absent(),
    this.caseId = const Value.absent(),
    this.name = const Value.absent(),
    this.role = const Value.absent(),
    this.lawyerName = const Value.absent(),
    this.lawyerPhone = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CasePartiesCompanion.insert({
    required String id,
    required String caseId,
    required String name,
    required String role,
    this.lawyerName = const Value.absent(),
    this.lawyerPhone = const Value.absent(),
    this.notes = const Value.absent(),
    required int createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       caseId = Value(caseId),
       name = Value(name),
       role = Value(role),
       createdAt = Value(createdAt);
  static Insertable<CaseParty> custom({
    Expression<String>? id,
    Expression<String>? caseId,
    Expression<String>? name,
    Expression<String>? role,
    Expression<String>? lawyerName,
    Expression<String>? lawyerPhone,
    Expression<String>? notes,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (caseId != null) 'case_id': caseId,
      if (name != null) 'name': name,
      if (role != null) 'role': role,
      if (lawyerName != null) 'lawyer_name': lawyerName,
      if (lawyerPhone != null) 'lawyer_phone': lawyerPhone,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CasePartiesCompanion copyWith({
    Value<String>? id,
    Value<String>? caseId,
    Value<String>? name,
    Value<String>? role,
    Value<String?>? lawyerName,
    Value<String?>? lawyerPhone,
    Value<String?>? notes,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return CasePartiesCompanion(
      id: id ?? this.id,
      caseId: caseId ?? this.caseId,
      name: name ?? this.name,
      role: role ?? this.role,
      lawyerName: lawyerName ?? this.lawyerName,
      lawyerPhone: lawyerPhone ?? this.lawyerPhone,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (caseId.present) {
      map['case_id'] = Variable<String>(caseId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (lawyerName.present) {
      map['lawyer_name'] = Variable<String>(lawyerName.value);
    }
    if (lawyerPhone.present) {
      map['lawyer_phone'] = Variable<String>(lawyerPhone.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CasePartiesCompanion(')
          ..write('id: $id, ')
          ..write('caseId: $caseId, ')
          ..write('name: $name, ')
          ..write('role: $role, ')
          ..write('lawyerName: $lawyerName, ')
          ..write('lawyerPhone: $lawyerPhone, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FolderLinksTable extends FolderLinks
    with TableInfo<$FolderLinksTable, FolderLink> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FolderLinksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _uriStringMeta = const VerificationMeta(
    'uriString',
  );
  @override
  late final GeneratedColumn<String> uriString = GeneratedColumn<String>(
    'uri_string',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pathHintMeta = const VerificationMeta(
    'pathHint',
  );
  @override
  late final GeneratedColumn<String> pathHint = GeneratedColumn<String>(
    'path_hint',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isAccessibleMeta = const VerificationMeta(
    'isAccessible',
  );
  @override
  late final GeneratedColumn<int> isAccessible = GeneratedColumn<int>(
    'is_accessible',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _lastScannedAtMeta = const VerificationMeta(
    'lastScannedAt',
  );
  @override
  late final GeneratedColumn<int> lastScannedAt = GeneratedColumn<int>(
    'last_scanned_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scanStatusMeta = const VerificationMeta(
    'scanStatus',
  );
  @override
  late final GeneratedColumn<String> scanStatus = GeneratedColumn<String>(
    'scan_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('IDLE'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    uriString,
    displayName,
    pathHint,
    isAccessible,
    lastScannedAt,
    scanStatus,
    notes,
    createdAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'folder_links';
  @override
  VerificationContext validateIntegrity(
    Insertable<FolderLink> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('uri_string')) {
      context.handle(
        _uriStringMeta,
        uriString.isAcceptableOrUnknown(data['uri_string']!, _uriStringMeta),
      );
    } else if (isInserting) {
      context.missing(_uriStringMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('path_hint')) {
      context.handle(
        _pathHintMeta,
        pathHint.isAcceptableOrUnknown(data['path_hint']!, _pathHintMeta),
      );
    }
    if (data.containsKey('is_accessible')) {
      context.handle(
        _isAccessibleMeta,
        isAccessible.isAcceptableOrUnknown(
          data['is_accessible']!,
          _isAccessibleMeta,
        ),
      );
    }
    if (data.containsKey('last_scanned_at')) {
      context.handle(
        _lastScannedAtMeta,
        lastScannedAt.isAcceptableOrUnknown(
          data['last_scanned_at']!,
          _lastScannedAtMeta,
        ),
      );
    }
    if (data.containsKey('scan_status')) {
      context.handle(
        _scanStatusMeta,
        scanStatus.isAcceptableOrUnknown(data['scan_status']!, _scanStatusMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FolderLink map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FolderLink(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      uriString: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uri_string'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      pathHint: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}path_hint'],
      ),
      isAccessible: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_accessible'],
      )!,
      lastScannedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_scanned_at'],
      ),
      scanStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scan_status'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $FolderLinksTable createAlias(String alias) {
    return $FolderLinksTable(attachedDatabase, alias);
  }
}

class FolderLink extends DataClass implements Insertable<FolderLink> {
  final String id;
  final String uriString;
  final String displayName;
  final String? pathHint;
  final int isAccessible;
  final int? lastScannedAt;
  final String scanStatus;
  final String? notes;
  final int createdAt;
  final int? deletedAt;
  const FolderLink({
    required this.id,
    required this.uriString,
    required this.displayName,
    this.pathHint,
    required this.isAccessible,
    this.lastScannedAt,
    required this.scanStatus,
    this.notes,
    required this.createdAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['uri_string'] = Variable<String>(uriString);
    map['display_name'] = Variable<String>(displayName);
    if (!nullToAbsent || pathHint != null) {
      map['path_hint'] = Variable<String>(pathHint);
    }
    map['is_accessible'] = Variable<int>(isAccessible);
    if (!nullToAbsent || lastScannedAt != null) {
      map['last_scanned_at'] = Variable<int>(lastScannedAt);
    }
    map['scan_status'] = Variable<String>(scanStatus);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<int>(createdAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  FolderLinksCompanion toCompanion(bool nullToAbsent) {
    return FolderLinksCompanion(
      id: Value(id),
      uriString: Value(uriString),
      displayName: Value(displayName),
      pathHint: pathHint == null && nullToAbsent
          ? const Value.absent()
          : Value(pathHint),
      isAccessible: Value(isAccessible),
      lastScannedAt: lastScannedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastScannedAt),
      scanStatus: Value(scanStatus),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory FolderLink.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FolderLink(
      id: serializer.fromJson<String>(json['id']),
      uriString: serializer.fromJson<String>(json['uriString']),
      displayName: serializer.fromJson<String>(json['displayName']),
      pathHint: serializer.fromJson<String?>(json['pathHint']),
      isAccessible: serializer.fromJson<int>(json['isAccessible']),
      lastScannedAt: serializer.fromJson<int?>(json['lastScannedAt']),
      scanStatus: serializer.fromJson<String>(json['scanStatus']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'uriString': serializer.toJson<String>(uriString),
      'displayName': serializer.toJson<String>(displayName),
      'pathHint': serializer.toJson<String?>(pathHint),
      'isAccessible': serializer.toJson<int>(isAccessible),
      'lastScannedAt': serializer.toJson<int?>(lastScannedAt),
      'scanStatus': serializer.toJson<String>(scanStatus),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<int>(createdAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  FolderLink copyWith({
    String? id,
    String? uriString,
    String? displayName,
    Value<String?> pathHint = const Value.absent(),
    int? isAccessible,
    Value<int?> lastScannedAt = const Value.absent(),
    String? scanStatus,
    Value<String?> notes = const Value.absent(),
    int? createdAt,
    Value<int?> deletedAt = const Value.absent(),
  }) => FolderLink(
    id: id ?? this.id,
    uriString: uriString ?? this.uriString,
    displayName: displayName ?? this.displayName,
    pathHint: pathHint.present ? pathHint.value : this.pathHint,
    isAccessible: isAccessible ?? this.isAccessible,
    lastScannedAt: lastScannedAt.present
        ? lastScannedAt.value
        : this.lastScannedAt,
    scanStatus: scanStatus ?? this.scanStatus,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  FolderLink copyWithCompanion(FolderLinksCompanion data) {
    return FolderLink(
      id: data.id.present ? data.id.value : this.id,
      uriString: data.uriString.present ? data.uriString.value : this.uriString,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      pathHint: data.pathHint.present ? data.pathHint.value : this.pathHint,
      isAccessible: data.isAccessible.present
          ? data.isAccessible.value
          : this.isAccessible,
      lastScannedAt: data.lastScannedAt.present
          ? data.lastScannedAt.value
          : this.lastScannedAt,
      scanStatus: data.scanStatus.present
          ? data.scanStatus.value
          : this.scanStatus,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FolderLink(')
          ..write('id: $id, ')
          ..write('uriString: $uriString, ')
          ..write('displayName: $displayName, ')
          ..write('pathHint: $pathHint, ')
          ..write('isAccessible: $isAccessible, ')
          ..write('lastScannedAt: $lastScannedAt, ')
          ..write('scanStatus: $scanStatus, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    uriString,
    displayName,
    pathHint,
    isAccessible,
    lastScannedAt,
    scanStatus,
    notes,
    createdAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FolderLink &&
          other.id == this.id &&
          other.uriString == this.uriString &&
          other.displayName == this.displayName &&
          other.pathHint == this.pathHint &&
          other.isAccessible == this.isAccessible &&
          other.lastScannedAt == this.lastScannedAt &&
          other.scanStatus == this.scanStatus &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.deletedAt == this.deletedAt);
}

class FolderLinksCompanion extends UpdateCompanion<FolderLink> {
  final Value<String> id;
  final Value<String> uriString;
  final Value<String> displayName;
  final Value<String?> pathHint;
  final Value<int> isAccessible;
  final Value<int?> lastScannedAt;
  final Value<String> scanStatus;
  final Value<String?> notes;
  final Value<int> createdAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const FolderLinksCompanion({
    this.id = const Value.absent(),
    this.uriString = const Value.absent(),
    this.displayName = const Value.absent(),
    this.pathHint = const Value.absent(),
    this.isAccessible = const Value.absent(),
    this.lastScannedAt = const Value.absent(),
    this.scanStatus = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FolderLinksCompanion.insert({
    required String id,
    required String uriString,
    required String displayName,
    this.pathHint = const Value.absent(),
    this.isAccessible = const Value.absent(),
    this.lastScannedAt = const Value.absent(),
    this.scanStatus = const Value.absent(),
    this.notes = const Value.absent(),
    required int createdAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       uriString = Value(uriString),
       displayName = Value(displayName),
       createdAt = Value(createdAt);
  static Insertable<FolderLink> custom({
    Expression<String>? id,
    Expression<String>? uriString,
    Expression<String>? displayName,
    Expression<String>? pathHint,
    Expression<int>? isAccessible,
    Expression<int>? lastScannedAt,
    Expression<String>? scanStatus,
    Expression<String>? notes,
    Expression<int>? createdAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uriString != null) 'uri_string': uriString,
      if (displayName != null) 'display_name': displayName,
      if (pathHint != null) 'path_hint': pathHint,
      if (isAccessible != null) 'is_accessible': isAccessible,
      if (lastScannedAt != null) 'last_scanned_at': lastScannedAt,
      if (scanStatus != null) 'scan_status': scanStatus,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FolderLinksCompanion copyWith({
    Value<String>? id,
    Value<String>? uriString,
    Value<String>? displayName,
    Value<String?>? pathHint,
    Value<int>? isAccessible,
    Value<int?>? lastScannedAt,
    Value<String>? scanStatus,
    Value<String?>? notes,
    Value<int>? createdAt,
    Value<int?>? deletedAt,
    Value<int>? rowid,
  }) {
    return FolderLinksCompanion(
      id: id ?? this.id,
      uriString: uriString ?? this.uriString,
      displayName: displayName ?? this.displayName,
      pathHint: pathHint ?? this.pathHint,
      isAccessible: isAccessible ?? this.isAccessible,
      lastScannedAt: lastScannedAt ?? this.lastScannedAt,
      scanStatus: scanStatus ?? this.scanStatus,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (uriString.present) {
      map['uri_string'] = Variable<String>(uriString.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (pathHint.present) {
      map['path_hint'] = Variable<String>(pathHint.value);
    }
    if (isAccessible.present) {
      map['is_accessible'] = Variable<int>(isAccessible.value);
    }
    if (lastScannedAt.present) {
      map['last_scanned_at'] = Variable<int>(lastScannedAt.value);
    }
    if (scanStatus.present) {
      map['scan_status'] = Variable<String>(scanStatus.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FolderLinksCompanion(')
          ..write('id: $id, ')
          ..write('uriString: $uriString, ')
          ..write('displayName: $displayName, ')
          ..write('pathHint: $pathHint, ')
          ..write('isAccessible: $isAccessible, ')
          ..write('lastScannedAt: $lastScannedAt, ')
          ..write('scanStatus: $scanStatus, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DocumentsTable extends Documents
    with TableInfo<$DocumentsTable, Document> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _folderLinkIdMeta = const VerificationMeta(
    'folderLinkId',
  );
  @override
  late final GeneratedColumn<String> folderLinkId = GeneratedColumn<String>(
    'folder_link_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES folder_links (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _fileNameMeta = const VerificationMeta(
    'fileName',
  );
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
    'file_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _uriStringMeta = const VerificationMeta(
    'uriString',
  );
  @override
  late final GeneratedColumn<String> uriString = GeneratedColumn<String>(
    'uri_string',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mimeTypeMeta = const VerificationMeta(
    'mimeType',
  );
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
    'mime_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _extensionMeta = const VerificationMeta(
    'extension',
  );
  @override
  late final GeneratedColumn<String> extension = GeneratedColumn<String>(
    'extension',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileSizeMeta = const VerificationMeta(
    'fileSize',
  );
  @override
  late final GeneratedColumn<int> fileSize = GeneratedColumn<int>(
    'file_size',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastModifiedMeta = const VerificationMeta(
    'lastModified',
  );
  @override
  late final GeneratedColumn<int> lastModified = GeneratedColumn<int>(
    'last_modified',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sha256HashMeta = const VerificationMeta(
    'sha256Hash',
  );
  @override
  late final GeneratedColumn<String> sha256Hash = GeneratedColumn<String>(
    'sha256_hash',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isAvailableMeta = const VerificationMeta(
    'isAvailable',
  );
  @override
  late final GeneratedColumn<int> isAvailable = GeneratedColumn<int>(
    'is_available',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _hasExtractedTextMeta = const VerificationMeta(
    'hasExtractedText',
  );
  @override
  late final GeneratedColumn<int> hasExtractedText = GeneratedColumn<int>(
    'has_extracted_text',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    folderLinkId,
    fileName,
    uriString,
    mimeType,
    extension,
    fileSize,
    lastModified,
    sha256Hash,
    category,
    isAvailable,
    hasExtractedText,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'documents';
  @override
  VerificationContext validateIntegrity(
    Insertable<Document> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('folder_link_id')) {
      context.handle(
        _folderLinkIdMeta,
        folderLinkId.isAcceptableOrUnknown(
          data['folder_link_id']!,
          _folderLinkIdMeta,
        ),
      );
    }
    if (data.containsKey('file_name')) {
      context.handle(
        _fileNameMeta,
        fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('uri_string')) {
      context.handle(
        _uriStringMeta,
        uriString.isAcceptableOrUnknown(data['uri_string']!, _uriStringMeta),
      );
    } else if (isInserting) {
      context.missing(_uriStringMeta);
    }
    if (data.containsKey('mime_type')) {
      context.handle(
        _mimeTypeMeta,
        mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_mimeTypeMeta);
    }
    if (data.containsKey('extension')) {
      context.handle(
        _extensionMeta,
        extension.isAcceptableOrUnknown(data['extension']!, _extensionMeta),
      );
    } else if (isInserting) {
      context.missing(_extensionMeta);
    }
    if (data.containsKey('file_size')) {
      context.handle(
        _fileSizeMeta,
        fileSize.isAcceptableOrUnknown(data['file_size']!, _fileSizeMeta),
      );
    } else if (isInserting) {
      context.missing(_fileSizeMeta);
    }
    if (data.containsKey('last_modified')) {
      context.handle(
        _lastModifiedMeta,
        lastModified.isAcceptableOrUnknown(
          data['last_modified']!,
          _lastModifiedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastModifiedMeta);
    }
    if (data.containsKey('sha256_hash')) {
      context.handle(
        _sha256HashMeta,
        sha256Hash.isAcceptableOrUnknown(data['sha256_hash']!, _sha256HashMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('is_available')) {
      context.handle(
        _isAvailableMeta,
        isAvailable.isAcceptableOrUnknown(
          data['is_available']!,
          _isAvailableMeta,
        ),
      );
    }
    if (data.containsKey('has_extracted_text')) {
      context.handle(
        _hasExtractedTextMeta,
        hasExtractedText.isAcceptableOrUnknown(
          data['has_extracted_text']!,
          _hasExtractedTextMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Document map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Document(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      folderLinkId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}folder_link_id'],
      ),
      fileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_name'],
      )!,
      uriString: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uri_string'],
      )!,
      mimeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mime_type'],
      )!,
      extension: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}extension'],
      )!,
      fileSize: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}file_size'],
      )!,
      lastModified: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_modified'],
      )!,
      sha256Hash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sha256_hash'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      isAvailable: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_available'],
      )!,
      hasExtractedText: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}has_extracted_text'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $DocumentsTable createAlias(String alias) {
    return $DocumentsTable(attachedDatabase, alias);
  }
}

class Document extends DataClass implements Insertable<Document> {
  final String id;
  final String? folderLinkId;
  final String fileName;
  final String uriString;
  final String mimeType;
  final String extension;
  final int fileSize;
  final int lastModified;
  final String? sha256Hash;
  final String category;
  final int isAvailable;
  final int hasExtractedText;
  final int createdAt;
  final int updatedAt;
  final int? deletedAt;
  const Document({
    required this.id,
    this.folderLinkId,
    required this.fileName,
    required this.uriString,
    required this.mimeType,
    required this.extension,
    required this.fileSize,
    required this.lastModified,
    this.sha256Hash,
    required this.category,
    required this.isAvailable,
    required this.hasExtractedText,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || folderLinkId != null) {
      map['folder_link_id'] = Variable<String>(folderLinkId);
    }
    map['file_name'] = Variable<String>(fileName);
    map['uri_string'] = Variable<String>(uriString);
    map['mime_type'] = Variable<String>(mimeType);
    map['extension'] = Variable<String>(extension);
    map['file_size'] = Variable<int>(fileSize);
    map['last_modified'] = Variable<int>(lastModified);
    if (!nullToAbsent || sha256Hash != null) {
      map['sha256_hash'] = Variable<String>(sha256Hash);
    }
    map['category'] = Variable<String>(category);
    map['is_available'] = Variable<int>(isAvailable);
    map['has_extracted_text'] = Variable<int>(hasExtractedText);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  DocumentsCompanion toCompanion(bool nullToAbsent) {
    return DocumentsCompanion(
      id: Value(id),
      folderLinkId: folderLinkId == null && nullToAbsent
          ? const Value.absent()
          : Value(folderLinkId),
      fileName: Value(fileName),
      uriString: Value(uriString),
      mimeType: Value(mimeType),
      extension: Value(extension),
      fileSize: Value(fileSize),
      lastModified: Value(lastModified),
      sha256Hash: sha256Hash == null && nullToAbsent
          ? const Value.absent()
          : Value(sha256Hash),
      category: Value(category),
      isAvailable: Value(isAvailable),
      hasExtractedText: Value(hasExtractedText),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Document.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Document(
      id: serializer.fromJson<String>(json['id']),
      folderLinkId: serializer.fromJson<String?>(json['folderLinkId']),
      fileName: serializer.fromJson<String>(json['fileName']),
      uriString: serializer.fromJson<String>(json['uriString']),
      mimeType: serializer.fromJson<String>(json['mimeType']),
      extension: serializer.fromJson<String>(json['extension']),
      fileSize: serializer.fromJson<int>(json['fileSize']),
      lastModified: serializer.fromJson<int>(json['lastModified']),
      sha256Hash: serializer.fromJson<String?>(json['sha256Hash']),
      category: serializer.fromJson<String>(json['category']),
      isAvailable: serializer.fromJson<int>(json['isAvailable']),
      hasExtractedText: serializer.fromJson<int>(json['hasExtractedText']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'folderLinkId': serializer.toJson<String?>(folderLinkId),
      'fileName': serializer.toJson<String>(fileName),
      'uriString': serializer.toJson<String>(uriString),
      'mimeType': serializer.toJson<String>(mimeType),
      'extension': serializer.toJson<String>(extension),
      'fileSize': serializer.toJson<int>(fileSize),
      'lastModified': serializer.toJson<int>(lastModified),
      'sha256Hash': serializer.toJson<String?>(sha256Hash),
      'category': serializer.toJson<String>(category),
      'isAvailable': serializer.toJson<int>(isAvailable),
      'hasExtractedText': serializer.toJson<int>(hasExtractedText),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  Document copyWith({
    String? id,
    Value<String?> folderLinkId = const Value.absent(),
    String? fileName,
    String? uriString,
    String? mimeType,
    String? extension,
    int? fileSize,
    int? lastModified,
    Value<String?> sha256Hash = const Value.absent(),
    String? category,
    int? isAvailable,
    int? hasExtractedText,
    int? createdAt,
    int? updatedAt,
    Value<int?> deletedAt = const Value.absent(),
  }) => Document(
    id: id ?? this.id,
    folderLinkId: folderLinkId.present ? folderLinkId.value : this.folderLinkId,
    fileName: fileName ?? this.fileName,
    uriString: uriString ?? this.uriString,
    mimeType: mimeType ?? this.mimeType,
    extension: extension ?? this.extension,
    fileSize: fileSize ?? this.fileSize,
    lastModified: lastModified ?? this.lastModified,
    sha256Hash: sha256Hash.present ? sha256Hash.value : this.sha256Hash,
    category: category ?? this.category,
    isAvailable: isAvailable ?? this.isAvailable,
    hasExtractedText: hasExtractedText ?? this.hasExtractedText,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Document copyWithCompanion(DocumentsCompanion data) {
    return Document(
      id: data.id.present ? data.id.value : this.id,
      folderLinkId: data.folderLinkId.present
          ? data.folderLinkId.value
          : this.folderLinkId,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      uriString: data.uriString.present ? data.uriString.value : this.uriString,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      extension: data.extension.present ? data.extension.value : this.extension,
      fileSize: data.fileSize.present ? data.fileSize.value : this.fileSize,
      lastModified: data.lastModified.present
          ? data.lastModified.value
          : this.lastModified,
      sha256Hash: data.sha256Hash.present
          ? data.sha256Hash.value
          : this.sha256Hash,
      category: data.category.present ? data.category.value : this.category,
      isAvailable: data.isAvailable.present
          ? data.isAvailable.value
          : this.isAvailable,
      hasExtractedText: data.hasExtractedText.present
          ? data.hasExtractedText.value
          : this.hasExtractedText,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Document(')
          ..write('id: $id, ')
          ..write('folderLinkId: $folderLinkId, ')
          ..write('fileName: $fileName, ')
          ..write('uriString: $uriString, ')
          ..write('mimeType: $mimeType, ')
          ..write('extension: $extension, ')
          ..write('fileSize: $fileSize, ')
          ..write('lastModified: $lastModified, ')
          ..write('sha256Hash: $sha256Hash, ')
          ..write('category: $category, ')
          ..write('isAvailable: $isAvailable, ')
          ..write('hasExtractedText: $hasExtractedText, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    folderLinkId,
    fileName,
    uriString,
    mimeType,
    extension,
    fileSize,
    lastModified,
    sha256Hash,
    category,
    isAvailable,
    hasExtractedText,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Document &&
          other.id == this.id &&
          other.folderLinkId == this.folderLinkId &&
          other.fileName == this.fileName &&
          other.uriString == this.uriString &&
          other.mimeType == this.mimeType &&
          other.extension == this.extension &&
          other.fileSize == this.fileSize &&
          other.lastModified == this.lastModified &&
          other.sha256Hash == this.sha256Hash &&
          other.category == this.category &&
          other.isAvailable == this.isAvailable &&
          other.hasExtractedText == this.hasExtractedText &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class DocumentsCompanion extends UpdateCompanion<Document> {
  final Value<String> id;
  final Value<String?> folderLinkId;
  final Value<String> fileName;
  final Value<String> uriString;
  final Value<String> mimeType;
  final Value<String> extension;
  final Value<int> fileSize;
  final Value<int> lastModified;
  final Value<String?> sha256Hash;
  final Value<String> category;
  final Value<int> isAvailable;
  final Value<int> hasExtractedText;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const DocumentsCompanion({
    this.id = const Value.absent(),
    this.folderLinkId = const Value.absent(),
    this.fileName = const Value.absent(),
    this.uriString = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.extension = const Value.absent(),
    this.fileSize = const Value.absent(),
    this.lastModified = const Value.absent(),
    this.sha256Hash = const Value.absent(),
    this.category = const Value.absent(),
    this.isAvailable = const Value.absent(),
    this.hasExtractedText = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DocumentsCompanion.insert({
    required String id,
    this.folderLinkId = const Value.absent(),
    required String fileName,
    required String uriString,
    required String mimeType,
    required String extension,
    required int fileSize,
    required int lastModified,
    this.sha256Hash = const Value.absent(),
    required String category,
    this.isAvailable = const Value.absent(),
    this.hasExtractedText = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       fileName = Value(fileName),
       uriString = Value(uriString),
       mimeType = Value(mimeType),
       extension = Value(extension),
       fileSize = Value(fileSize),
       lastModified = Value(lastModified),
       category = Value(category),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Document> custom({
    Expression<String>? id,
    Expression<String>? folderLinkId,
    Expression<String>? fileName,
    Expression<String>? uriString,
    Expression<String>? mimeType,
    Expression<String>? extension,
    Expression<int>? fileSize,
    Expression<int>? lastModified,
    Expression<String>? sha256Hash,
    Expression<String>? category,
    Expression<int>? isAvailable,
    Expression<int>? hasExtractedText,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (folderLinkId != null) 'folder_link_id': folderLinkId,
      if (fileName != null) 'file_name': fileName,
      if (uriString != null) 'uri_string': uriString,
      if (mimeType != null) 'mime_type': mimeType,
      if (extension != null) 'extension': extension,
      if (fileSize != null) 'file_size': fileSize,
      if (lastModified != null) 'last_modified': lastModified,
      if (sha256Hash != null) 'sha256_hash': sha256Hash,
      if (category != null) 'category': category,
      if (isAvailable != null) 'is_available': isAvailable,
      if (hasExtractedText != null) 'has_extracted_text': hasExtractedText,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DocumentsCompanion copyWith({
    Value<String>? id,
    Value<String?>? folderLinkId,
    Value<String>? fileName,
    Value<String>? uriString,
    Value<String>? mimeType,
    Value<String>? extension,
    Value<int>? fileSize,
    Value<int>? lastModified,
    Value<String?>? sha256Hash,
    Value<String>? category,
    Value<int>? isAvailable,
    Value<int>? hasExtractedText,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int?>? deletedAt,
    Value<int>? rowid,
  }) {
    return DocumentsCompanion(
      id: id ?? this.id,
      folderLinkId: folderLinkId ?? this.folderLinkId,
      fileName: fileName ?? this.fileName,
      uriString: uriString ?? this.uriString,
      mimeType: mimeType ?? this.mimeType,
      extension: extension ?? this.extension,
      fileSize: fileSize ?? this.fileSize,
      lastModified: lastModified ?? this.lastModified,
      sha256Hash: sha256Hash ?? this.sha256Hash,
      category: category ?? this.category,
      isAvailable: isAvailable ?? this.isAvailable,
      hasExtractedText: hasExtractedText ?? this.hasExtractedText,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (folderLinkId.present) {
      map['folder_link_id'] = Variable<String>(folderLinkId.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (uriString.present) {
      map['uri_string'] = Variable<String>(uriString.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (extension.present) {
      map['extension'] = Variable<String>(extension.value);
    }
    if (fileSize.present) {
      map['file_size'] = Variable<int>(fileSize.value);
    }
    if (lastModified.present) {
      map['last_modified'] = Variable<int>(lastModified.value);
    }
    if (sha256Hash.present) {
      map['sha256_hash'] = Variable<String>(sha256Hash.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (isAvailable.present) {
      map['is_available'] = Variable<int>(isAvailable.value);
    }
    if (hasExtractedText.present) {
      map['has_extracted_text'] = Variable<int>(hasExtractedText.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentsCompanion(')
          ..write('id: $id, ')
          ..write('folderLinkId: $folderLinkId, ')
          ..write('fileName: $fileName, ')
          ..write('uriString: $uriString, ')
          ..write('mimeType: $mimeType, ')
          ..write('extension: $extension, ')
          ..write('fileSize: $fileSize, ')
          ..write('lastModified: $lastModified, ')
          ..write('sha256Hash: $sha256Hash, ')
          ..write('category: $category, ')
          ..write('isAvailable: $isAvailable, ')
          ..write('hasExtractedText: $hasExtractedText, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CaseDocumentsTable extends CaseDocuments
    with TableInfo<$CaseDocumentsTable, CaseDocument> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CaseDocumentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caseIdMeta = const VerificationMeta('caseId');
  @override
  late final GeneratedColumn<String> caseId = GeneratedColumn<String>(
    'case_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cases (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _documentIdMeta = const VerificationMeta(
    'documentId',
  );
  @override
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
    'document_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES documents (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _relationNoteMeta = const VerificationMeta(
    'relationNote',
  );
  @override
  late final GeneratedColumn<String> relationNote = GeneratedColumn<String>(
    'relation_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    caseId,
    documentId,
    relationNote,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'case_documents';
  @override
  VerificationContext validateIntegrity(
    Insertable<CaseDocument> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('case_id')) {
      context.handle(
        _caseIdMeta,
        caseId.isAcceptableOrUnknown(data['case_id']!, _caseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_caseIdMeta);
    }
    if (data.containsKey('document_id')) {
      context.handle(
        _documentIdMeta,
        documentId.isAcceptableOrUnknown(data['document_id']!, _documentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_documentIdMeta);
    }
    if (data.containsKey('relation_note')) {
      context.handle(
        _relationNoteMeta,
        relationNote.isAcceptableOrUnknown(
          data['relation_note']!,
          _relationNoteMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CaseDocument map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CaseDocument(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      caseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}case_id'],
      )!,
      documentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_id'],
      )!,
      relationNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relation_note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CaseDocumentsTable createAlias(String alias) {
    return $CaseDocumentsTable(attachedDatabase, alias);
  }
}

class CaseDocument extends DataClass implements Insertable<CaseDocument> {
  final String id;
  final String caseId;
  final String documentId;
  final String? relationNote;
  final int createdAt;
  const CaseDocument({
    required this.id,
    required this.caseId,
    required this.documentId,
    this.relationNote,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['case_id'] = Variable<String>(caseId);
    map['document_id'] = Variable<String>(documentId);
    if (!nullToAbsent || relationNote != null) {
      map['relation_note'] = Variable<String>(relationNote);
    }
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  CaseDocumentsCompanion toCompanion(bool nullToAbsent) {
    return CaseDocumentsCompanion(
      id: Value(id),
      caseId: Value(caseId),
      documentId: Value(documentId),
      relationNote: relationNote == null && nullToAbsent
          ? const Value.absent()
          : Value(relationNote),
      createdAt: Value(createdAt),
    );
  }

  factory CaseDocument.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CaseDocument(
      id: serializer.fromJson<String>(json['id']),
      caseId: serializer.fromJson<String>(json['caseId']),
      documentId: serializer.fromJson<String>(json['documentId']),
      relationNote: serializer.fromJson<String?>(json['relationNote']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'caseId': serializer.toJson<String>(caseId),
      'documentId': serializer.toJson<String>(documentId),
      'relationNote': serializer.toJson<String?>(relationNote),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  CaseDocument copyWith({
    String? id,
    String? caseId,
    String? documentId,
    Value<String?> relationNote = const Value.absent(),
    int? createdAt,
  }) => CaseDocument(
    id: id ?? this.id,
    caseId: caseId ?? this.caseId,
    documentId: documentId ?? this.documentId,
    relationNote: relationNote.present ? relationNote.value : this.relationNote,
    createdAt: createdAt ?? this.createdAt,
  );
  CaseDocument copyWithCompanion(CaseDocumentsCompanion data) {
    return CaseDocument(
      id: data.id.present ? data.id.value : this.id,
      caseId: data.caseId.present ? data.caseId.value : this.caseId,
      documentId: data.documentId.present
          ? data.documentId.value
          : this.documentId,
      relationNote: data.relationNote.present
          ? data.relationNote.value
          : this.relationNote,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CaseDocument(')
          ..write('id: $id, ')
          ..write('caseId: $caseId, ')
          ..write('documentId: $documentId, ')
          ..write('relationNote: $relationNote, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, caseId, documentId, relationNote, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CaseDocument &&
          other.id == this.id &&
          other.caseId == this.caseId &&
          other.documentId == this.documentId &&
          other.relationNote == this.relationNote &&
          other.createdAt == this.createdAt);
}

class CaseDocumentsCompanion extends UpdateCompanion<CaseDocument> {
  final Value<String> id;
  final Value<String> caseId;
  final Value<String> documentId;
  final Value<String?> relationNote;
  final Value<int> createdAt;
  final Value<int> rowid;
  const CaseDocumentsCompanion({
    this.id = const Value.absent(),
    this.caseId = const Value.absent(),
    this.documentId = const Value.absent(),
    this.relationNote = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CaseDocumentsCompanion.insert({
    required String id,
    required String caseId,
    required String documentId,
    this.relationNote = const Value.absent(),
    required int createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       caseId = Value(caseId),
       documentId = Value(documentId),
       createdAt = Value(createdAt);
  static Insertable<CaseDocument> custom({
    Expression<String>? id,
    Expression<String>? caseId,
    Expression<String>? documentId,
    Expression<String>? relationNote,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (caseId != null) 'case_id': caseId,
      if (documentId != null) 'document_id': documentId,
      if (relationNote != null) 'relation_note': relationNote,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CaseDocumentsCompanion copyWith({
    Value<String>? id,
    Value<String>? caseId,
    Value<String>? documentId,
    Value<String?>? relationNote,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return CaseDocumentsCompanion(
      id: id ?? this.id,
      caseId: caseId ?? this.caseId,
      documentId: documentId ?? this.documentId,
      relationNote: relationNote ?? this.relationNote,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (caseId.present) {
      map['case_id'] = Variable<String>(caseId.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (relationNote.present) {
      map['relation_note'] = Variable<String>(relationNote.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CaseDocumentsCompanion(')
          ..write('id: $id, ')
          ..write('caseId: $caseId, ')
          ..write('documentId: $documentId, ')
          ..write('relationNote: $relationNote, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DocumentTextIndexTable extends DocumentTextIndex
    with TableInfo<$DocumentTextIndexTable, DocumentTextIndexData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentTextIndexTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _documentIdMeta = const VerificationMeta(
    'documentId',
  );
  @override
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
    'document_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES documents (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _extractedTextMeta = const VerificationMeta(
    'extractedText',
  );
  @override
  late final GeneratedColumn<String> extractedText = GeneratedColumn<String>(
    'extracted_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _normalizedTextMeta = const VerificationMeta(
    'normalizedText',
  );
  @override
  late final GeneratedColumn<String> normalizedText = GeneratedColumn<String>(
    'normalized_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _extractionMethodMeta = const VerificationMeta(
    'extractionMethod',
  );
  @override
  late final GeneratedColumn<String> extractionMethod = GeneratedColumn<String>(
    'extraction_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _indexedAtMeta = const VerificationMeta(
    'indexedAt',
  );
  @override
  late final GeneratedColumn<int> indexedAt = GeneratedColumn<int>(
    'indexed_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    documentId,
    extractedText,
    normalizedText,
    extractionMethod,
    indexedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'document_text_index';
  @override
  VerificationContext validateIntegrity(
    Insertable<DocumentTextIndexData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('document_id')) {
      context.handle(
        _documentIdMeta,
        documentId.isAcceptableOrUnknown(data['document_id']!, _documentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_documentIdMeta);
    }
    if (data.containsKey('extracted_text')) {
      context.handle(
        _extractedTextMeta,
        extractedText.isAcceptableOrUnknown(
          data['extracted_text']!,
          _extractedTextMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_extractedTextMeta);
    }
    if (data.containsKey('normalized_text')) {
      context.handle(
        _normalizedTextMeta,
        normalizedText.isAcceptableOrUnknown(
          data['normalized_text']!,
          _normalizedTextMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_normalizedTextMeta);
    }
    if (data.containsKey('extraction_method')) {
      context.handle(
        _extractionMethodMeta,
        extractionMethod.isAcceptableOrUnknown(
          data['extraction_method']!,
          _extractionMethodMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_extractionMethodMeta);
    }
    if (data.containsKey('indexed_at')) {
      context.handle(
        _indexedAtMeta,
        indexedAt.isAcceptableOrUnknown(data['indexed_at']!, _indexedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_indexedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DocumentTextIndexData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DocumentTextIndexData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      documentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_id'],
      )!,
      extractedText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}extracted_text'],
      )!,
      normalizedText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_text'],
      )!,
      extractionMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}extraction_method'],
      )!,
      indexedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}indexed_at'],
      )!,
    );
  }

  @override
  $DocumentTextIndexTable createAlias(String alias) {
    return $DocumentTextIndexTable(attachedDatabase, alias);
  }
}

class DocumentTextIndexData extends DataClass
    implements Insertable<DocumentTextIndexData> {
  final String id;
  final String documentId;
  final String extractedText;
  final String normalizedText;
  final String extractionMethod;
  final int indexedAt;
  const DocumentTextIndexData({
    required this.id,
    required this.documentId,
    required this.extractedText,
    required this.normalizedText,
    required this.extractionMethod,
    required this.indexedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['document_id'] = Variable<String>(documentId);
    map['extracted_text'] = Variable<String>(extractedText);
    map['normalized_text'] = Variable<String>(normalizedText);
    map['extraction_method'] = Variable<String>(extractionMethod);
    map['indexed_at'] = Variable<int>(indexedAt);
    return map;
  }

  DocumentTextIndexCompanion toCompanion(bool nullToAbsent) {
    return DocumentTextIndexCompanion(
      id: Value(id),
      documentId: Value(documentId),
      extractedText: Value(extractedText),
      normalizedText: Value(normalizedText),
      extractionMethod: Value(extractionMethod),
      indexedAt: Value(indexedAt),
    );
  }

  factory DocumentTextIndexData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DocumentTextIndexData(
      id: serializer.fromJson<String>(json['id']),
      documentId: serializer.fromJson<String>(json['documentId']),
      extractedText: serializer.fromJson<String>(json['extractedText']),
      normalizedText: serializer.fromJson<String>(json['normalizedText']),
      extractionMethod: serializer.fromJson<String>(json['extractionMethod']),
      indexedAt: serializer.fromJson<int>(json['indexedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'documentId': serializer.toJson<String>(documentId),
      'extractedText': serializer.toJson<String>(extractedText),
      'normalizedText': serializer.toJson<String>(normalizedText),
      'extractionMethod': serializer.toJson<String>(extractionMethod),
      'indexedAt': serializer.toJson<int>(indexedAt),
    };
  }

  DocumentTextIndexData copyWith({
    String? id,
    String? documentId,
    String? extractedText,
    String? normalizedText,
    String? extractionMethod,
    int? indexedAt,
  }) => DocumentTextIndexData(
    id: id ?? this.id,
    documentId: documentId ?? this.documentId,
    extractedText: extractedText ?? this.extractedText,
    normalizedText: normalizedText ?? this.normalizedText,
    extractionMethod: extractionMethod ?? this.extractionMethod,
    indexedAt: indexedAt ?? this.indexedAt,
  );
  DocumentTextIndexData copyWithCompanion(DocumentTextIndexCompanion data) {
    return DocumentTextIndexData(
      id: data.id.present ? data.id.value : this.id,
      documentId: data.documentId.present
          ? data.documentId.value
          : this.documentId,
      extractedText: data.extractedText.present
          ? data.extractedText.value
          : this.extractedText,
      normalizedText: data.normalizedText.present
          ? data.normalizedText.value
          : this.normalizedText,
      extractionMethod: data.extractionMethod.present
          ? data.extractionMethod.value
          : this.extractionMethod,
      indexedAt: data.indexedAt.present ? data.indexedAt.value : this.indexedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DocumentTextIndexData(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('extractedText: $extractedText, ')
          ..write('normalizedText: $normalizedText, ')
          ..write('extractionMethod: $extractionMethod, ')
          ..write('indexedAt: $indexedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    documentId,
    extractedText,
    normalizedText,
    extractionMethod,
    indexedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DocumentTextIndexData &&
          other.id == this.id &&
          other.documentId == this.documentId &&
          other.extractedText == this.extractedText &&
          other.normalizedText == this.normalizedText &&
          other.extractionMethod == this.extractionMethod &&
          other.indexedAt == this.indexedAt);
}

class DocumentTextIndexCompanion
    extends UpdateCompanion<DocumentTextIndexData> {
  final Value<String> id;
  final Value<String> documentId;
  final Value<String> extractedText;
  final Value<String> normalizedText;
  final Value<String> extractionMethod;
  final Value<int> indexedAt;
  final Value<int> rowid;
  const DocumentTextIndexCompanion({
    this.id = const Value.absent(),
    this.documentId = const Value.absent(),
    this.extractedText = const Value.absent(),
    this.normalizedText = const Value.absent(),
    this.extractionMethod = const Value.absent(),
    this.indexedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DocumentTextIndexCompanion.insert({
    required String id,
    required String documentId,
    required String extractedText,
    required String normalizedText,
    required String extractionMethod,
    required int indexedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       documentId = Value(documentId),
       extractedText = Value(extractedText),
       normalizedText = Value(normalizedText),
       extractionMethod = Value(extractionMethod),
       indexedAt = Value(indexedAt);
  static Insertable<DocumentTextIndexData> custom({
    Expression<String>? id,
    Expression<String>? documentId,
    Expression<String>? extractedText,
    Expression<String>? normalizedText,
    Expression<String>? extractionMethod,
    Expression<int>? indexedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (documentId != null) 'document_id': documentId,
      if (extractedText != null) 'extracted_text': extractedText,
      if (normalizedText != null) 'normalized_text': normalizedText,
      if (extractionMethod != null) 'extraction_method': extractionMethod,
      if (indexedAt != null) 'indexed_at': indexedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DocumentTextIndexCompanion copyWith({
    Value<String>? id,
    Value<String>? documentId,
    Value<String>? extractedText,
    Value<String>? normalizedText,
    Value<String>? extractionMethod,
    Value<int>? indexedAt,
    Value<int>? rowid,
  }) {
    return DocumentTextIndexCompanion(
      id: id ?? this.id,
      documentId: documentId ?? this.documentId,
      extractedText: extractedText ?? this.extractedText,
      normalizedText: normalizedText ?? this.normalizedText,
      extractionMethod: extractionMethod ?? this.extractionMethod,
      indexedAt: indexedAt ?? this.indexedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (extractedText.present) {
      map['extracted_text'] = Variable<String>(extractedText.value);
    }
    if (normalizedText.present) {
      map['normalized_text'] = Variable<String>(normalizedText.value);
    }
    if (extractionMethod.present) {
      map['extraction_method'] = Variable<String>(extractionMethod.value);
    }
    if (indexedAt.present) {
      map['indexed_at'] = Variable<int>(indexedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentTextIndexCompanion(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('extractedText: $extractedText, ')
          ..write('normalizedText: $normalizedText, ')
          ..write('extractionMethod: $extractionMethod, ')
          ..write('indexedAt: $indexedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HearingsTable extends Hearings with TableInfo<$HearingsTable, Hearing> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HearingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caseIdMeta = const VerificationMeta('caseId');
  @override
  late final GeneratedColumn<String> caseId = GeneratedColumn<String>(
    'case_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cases (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _courtIdMeta = const VerificationMeta(
    'courtId',
  );
  @override
  late final GeneratedColumn<String> courtId = GeneratedColumn<String>(
    'court_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES courts (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _hearingDateMeta = const VerificationMeta(
    'hearingDate',
  );
  @override
  late final GeneratedColumn<int> hearingDate = GeneratedColumn<int>(
    'hearing_date',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hearingTypeMeta = const VerificationMeta(
    'hearingType',
  );
  @override
  late final GeneratedColumn<String> hearingType = GeneratedColumn<String>(
    'hearing_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('SCHEDULED'),
  );
  static const VerificationMeta _decisionMeta = const VerificationMeta(
    'decision',
  );
  @override
  late final GeneratedColumn<String> decision = GeneratedColumn<String>(
    'decision',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _postponementReasonMeta =
      const VerificationMeta('postponementReason');
  @override
  late final GeneratedColumn<String> postponementReason =
      GeneratedColumn<String>(
        'postponement_reason',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _nextHearingDateMeta = const VerificationMeta(
    'nextHearingDate',
  );
  @override
  late final GeneratedColumn<int> nextHearingDate = GeneratedColumn<int>(
    'next_hearing_date',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lawyerNotesMeta = const VerificationMeta(
    'lawyerNotes',
  );
  @override
  late final GeneratedColumn<String> lawyerNotes = GeneratedColumn<String>(
    'lawyer_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    caseId,
    courtId,
    hearingDate,
    hearingType,
    status,
    decision,
    postponementReason,
    nextHearingDate,
    lawyerNotes,
    createdAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'hearings';
  @override
  VerificationContext validateIntegrity(
    Insertable<Hearing> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('case_id')) {
      context.handle(
        _caseIdMeta,
        caseId.isAcceptableOrUnknown(data['case_id']!, _caseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_caseIdMeta);
    }
    if (data.containsKey('court_id')) {
      context.handle(
        _courtIdMeta,
        courtId.isAcceptableOrUnknown(data['court_id']!, _courtIdMeta),
      );
    }
    if (data.containsKey('hearing_date')) {
      context.handle(
        _hearingDateMeta,
        hearingDate.isAcceptableOrUnknown(
          data['hearing_date']!,
          _hearingDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_hearingDateMeta);
    }
    if (data.containsKey('hearing_type')) {
      context.handle(
        _hearingTypeMeta,
        hearingType.isAcceptableOrUnknown(
          data['hearing_type']!,
          _hearingTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_hearingTypeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('decision')) {
      context.handle(
        _decisionMeta,
        decision.isAcceptableOrUnknown(data['decision']!, _decisionMeta),
      );
    }
    if (data.containsKey('postponement_reason')) {
      context.handle(
        _postponementReasonMeta,
        postponementReason.isAcceptableOrUnknown(
          data['postponement_reason']!,
          _postponementReasonMeta,
        ),
      );
    }
    if (data.containsKey('next_hearing_date')) {
      context.handle(
        _nextHearingDateMeta,
        nextHearingDate.isAcceptableOrUnknown(
          data['next_hearing_date']!,
          _nextHearingDateMeta,
        ),
      );
    }
    if (data.containsKey('lawyer_notes')) {
      context.handle(
        _lawyerNotesMeta,
        lawyerNotes.isAcceptableOrUnknown(
          data['lawyer_notes']!,
          _lawyerNotesMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Hearing map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Hearing(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      caseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}case_id'],
      )!,
      courtId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}court_id'],
      ),
      hearingDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hearing_date'],
      )!,
      hearingType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hearing_type'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      decision: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}decision'],
      ),
      postponementReason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}postponement_reason'],
      ),
      nextHearingDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_hearing_date'],
      ),
      lawyerNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lawyer_notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $HearingsTable createAlias(String alias) {
    return $HearingsTable(attachedDatabase, alias);
  }
}

class Hearing extends DataClass implements Insertable<Hearing> {
  final String id;
  final String caseId;
  final String? courtId;
  final int hearingDate;
  final String hearingType;
  final String status;
  final String? decision;
  final String? postponementReason;
  final int? nextHearingDate;
  final String? lawyerNotes;
  final int createdAt;
  final int? deletedAt;
  const Hearing({
    required this.id,
    required this.caseId,
    this.courtId,
    required this.hearingDate,
    required this.hearingType,
    required this.status,
    this.decision,
    this.postponementReason,
    this.nextHearingDate,
    this.lawyerNotes,
    required this.createdAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['case_id'] = Variable<String>(caseId);
    if (!nullToAbsent || courtId != null) {
      map['court_id'] = Variable<String>(courtId);
    }
    map['hearing_date'] = Variable<int>(hearingDate);
    map['hearing_type'] = Variable<String>(hearingType);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || decision != null) {
      map['decision'] = Variable<String>(decision);
    }
    if (!nullToAbsent || postponementReason != null) {
      map['postponement_reason'] = Variable<String>(postponementReason);
    }
    if (!nullToAbsent || nextHearingDate != null) {
      map['next_hearing_date'] = Variable<int>(nextHearingDate);
    }
    if (!nullToAbsent || lawyerNotes != null) {
      map['lawyer_notes'] = Variable<String>(lawyerNotes);
    }
    map['created_at'] = Variable<int>(createdAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  HearingsCompanion toCompanion(bool nullToAbsent) {
    return HearingsCompanion(
      id: Value(id),
      caseId: Value(caseId),
      courtId: courtId == null && nullToAbsent
          ? const Value.absent()
          : Value(courtId),
      hearingDate: Value(hearingDate),
      hearingType: Value(hearingType),
      status: Value(status),
      decision: decision == null && nullToAbsent
          ? const Value.absent()
          : Value(decision),
      postponementReason: postponementReason == null && nullToAbsent
          ? const Value.absent()
          : Value(postponementReason),
      nextHearingDate: nextHearingDate == null && nullToAbsent
          ? const Value.absent()
          : Value(nextHearingDate),
      lawyerNotes: lawyerNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(lawyerNotes),
      createdAt: Value(createdAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Hearing.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Hearing(
      id: serializer.fromJson<String>(json['id']),
      caseId: serializer.fromJson<String>(json['caseId']),
      courtId: serializer.fromJson<String?>(json['courtId']),
      hearingDate: serializer.fromJson<int>(json['hearingDate']),
      hearingType: serializer.fromJson<String>(json['hearingType']),
      status: serializer.fromJson<String>(json['status']),
      decision: serializer.fromJson<String?>(json['decision']),
      postponementReason: serializer.fromJson<String?>(
        json['postponementReason'],
      ),
      nextHearingDate: serializer.fromJson<int?>(json['nextHearingDate']),
      lawyerNotes: serializer.fromJson<String?>(json['lawyerNotes']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'caseId': serializer.toJson<String>(caseId),
      'courtId': serializer.toJson<String?>(courtId),
      'hearingDate': serializer.toJson<int>(hearingDate),
      'hearingType': serializer.toJson<String>(hearingType),
      'status': serializer.toJson<String>(status),
      'decision': serializer.toJson<String?>(decision),
      'postponementReason': serializer.toJson<String?>(postponementReason),
      'nextHearingDate': serializer.toJson<int?>(nextHearingDate),
      'lawyerNotes': serializer.toJson<String?>(lawyerNotes),
      'createdAt': serializer.toJson<int>(createdAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  Hearing copyWith({
    String? id,
    String? caseId,
    Value<String?> courtId = const Value.absent(),
    int? hearingDate,
    String? hearingType,
    String? status,
    Value<String?> decision = const Value.absent(),
    Value<String?> postponementReason = const Value.absent(),
    Value<int?> nextHearingDate = const Value.absent(),
    Value<String?> lawyerNotes = const Value.absent(),
    int? createdAt,
    Value<int?> deletedAt = const Value.absent(),
  }) => Hearing(
    id: id ?? this.id,
    caseId: caseId ?? this.caseId,
    courtId: courtId.present ? courtId.value : this.courtId,
    hearingDate: hearingDate ?? this.hearingDate,
    hearingType: hearingType ?? this.hearingType,
    status: status ?? this.status,
    decision: decision.present ? decision.value : this.decision,
    postponementReason: postponementReason.present
        ? postponementReason.value
        : this.postponementReason,
    nextHearingDate: nextHearingDate.present
        ? nextHearingDate.value
        : this.nextHearingDate,
    lawyerNotes: lawyerNotes.present ? lawyerNotes.value : this.lawyerNotes,
    createdAt: createdAt ?? this.createdAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Hearing copyWithCompanion(HearingsCompanion data) {
    return Hearing(
      id: data.id.present ? data.id.value : this.id,
      caseId: data.caseId.present ? data.caseId.value : this.caseId,
      courtId: data.courtId.present ? data.courtId.value : this.courtId,
      hearingDate: data.hearingDate.present
          ? data.hearingDate.value
          : this.hearingDate,
      hearingType: data.hearingType.present
          ? data.hearingType.value
          : this.hearingType,
      status: data.status.present ? data.status.value : this.status,
      decision: data.decision.present ? data.decision.value : this.decision,
      postponementReason: data.postponementReason.present
          ? data.postponementReason.value
          : this.postponementReason,
      nextHearingDate: data.nextHearingDate.present
          ? data.nextHearingDate.value
          : this.nextHearingDate,
      lawyerNotes: data.lawyerNotes.present
          ? data.lawyerNotes.value
          : this.lawyerNotes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Hearing(')
          ..write('id: $id, ')
          ..write('caseId: $caseId, ')
          ..write('courtId: $courtId, ')
          ..write('hearingDate: $hearingDate, ')
          ..write('hearingType: $hearingType, ')
          ..write('status: $status, ')
          ..write('decision: $decision, ')
          ..write('postponementReason: $postponementReason, ')
          ..write('nextHearingDate: $nextHearingDate, ')
          ..write('lawyerNotes: $lawyerNotes, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    caseId,
    courtId,
    hearingDate,
    hearingType,
    status,
    decision,
    postponementReason,
    nextHearingDate,
    lawyerNotes,
    createdAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Hearing &&
          other.id == this.id &&
          other.caseId == this.caseId &&
          other.courtId == this.courtId &&
          other.hearingDate == this.hearingDate &&
          other.hearingType == this.hearingType &&
          other.status == this.status &&
          other.decision == this.decision &&
          other.postponementReason == this.postponementReason &&
          other.nextHearingDate == this.nextHearingDate &&
          other.lawyerNotes == this.lawyerNotes &&
          other.createdAt == this.createdAt &&
          other.deletedAt == this.deletedAt);
}

class HearingsCompanion extends UpdateCompanion<Hearing> {
  final Value<String> id;
  final Value<String> caseId;
  final Value<String?> courtId;
  final Value<int> hearingDate;
  final Value<String> hearingType;
  final Value<String> status;
  final Value<String?> decision;
  final Value<String?> postponementReason;
  final Value<int?> nextHearingDate;
  final Value<String?> lawyerNotes;
  final Value<int> createdAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const HearingsCompanion({
    this.id = const Value.absent(),
    this.caseId = const Value.absent(),
    this.courtId = const Value.absent(),
    this.hearingDate = const Value.absent(),
    this.hearingType = const Value.absent(),
    this.status = const Value.absent(),
    this.decision = const Value.absent(),
    this.postponementReason = const Value.absent(),
    this.nextHearingDate = const Value.absent(),
    this.lawyerNotes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HearingsCompanion.insert({
    required String id,
    required String caseId,
    this.courtId = const Value.absent(),
    required int hearingDate,
    required String hearingType,
    this.status = const Value.absent(),
    this.decision = const Value.absent(),
    this.postponementReason = const Value.absent(),
    this.nextHearingDate = const Value.absent(),
    this.lawyerNotes = const Value.absent(),
    required int createdAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       caseId = Value(caseId),
       hearingDate = Value(hearingDate),
       hearingType = Value(hearingType),
       createdAt = Value(createdAt);
  static Insertable<Hearing> custom({
    Expression<String>? id,
    Expression<String>? caseId,
    Expression<String>? courtId,
    Expression<int>? hearingDate,
    Expression<String>? hearingType,
    Expression<String>? status,
    Expression<String>? decision,
    Expression<String>? postponementReason,
    Expression<int>? nextHearingDate,
    Expression<String>? lawyerNotes,
    Expression<int>? createdAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (caseId != null) 'case_id': caseId,
      if (courtId != null) 'court_id': courtId,
      if (hearingDate != null) 'hearing_date': hearingDate,
      if (hearingType != null) 'hearing_type': hearingType,
      if (status != null) 'status': status,
      if (decision != null) 'decision': decision,
      if (postponementReason != null) 'postponement_reason': postponementReason,
      if (nextHearingDate != null) 'next_hearing_date': nextHearingDate,
      if (lawyerNotes != null) 'lawyer_notes': lawyerNotes,
      if (createdAt != null) 'created_at': createdAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HearingsCompanion copyWith({
    Value<String>? id,
    Value<String>? caseId,
    Value<String?>? courtId,
    Value<int>? hearingDate,
    Value<String>? hearingType,
    Value<String>? status,
    Value<String?>? decision,
    Value<String?>? postponementReason,
    Value<int?>? nextHearingDate,
    Value<String?>? lawyerNotes,
    Value<int>? createdAt,
    Value<int?>? deletedAt,
    Value<int>? rowid,
  }) {
    return HearingsCompanion(
      id: id ?? this.id,
      caseId: caseId ?? this.caseId,
      courtId: courtId ?? this.courtId,
      hearingDate: hearingDate ?? this.hearingDate,
      hearingType: hearingType ?? this.hearingType,
      status: status ?? this.status,
      decision: decision ?? this.decision,
      postponementReason: postponementReason ?? this.postponementReason,
      nextHearingDate: nextHearingDate ?? this.nextHearingDate,
      lawyerNotes: lawyerNotes ?? this.lawyerNotes,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (caseId.present) {
      map['case_id'] = Variable<String>(caseId.value);
    }
    if (courtId.present) {
      map['court_id'] = Variable<String>(courtId.value);
    }
    if (hearingDate.present) {
      map['hearing_date'] = Variable<int>(hearingDate.value);
    }
    if (hearingType.present) {
      map['hearing_type'] = Variable<String>(hearingType.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (decision.present) {
      map['decision'] = Variable<String>(decision.value);
    }
    if (postponementReason.present) {
      map['postponement_reason'] = Variable<String>(postponementReason.value);
    }
    if (nextHearingDate.present) {
      map['next_hearing_date'] = Variable<int>(nextHearingDate.value);
    }
    if (lawyerNotes.present) {
      map['lawyer_notes'] = Variable<String>(lawyerNotes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HearingsCompanion(')
          ..write('id: $id, ')
          ..write('caseId: $caseId, ')
          ..write('courtId: $courtId, ')
          ..write('hearingDate: $hearingDate, ')
          ..write('hearingType: $hearingType, ')
          ..write('status: $status, ')
          ..write('decision: $decision, ')
          ..write('postponementReason: $postponementReason, ')
          ..write('nextHearingDate: $nextHearingDate, ')
          ..write('lawyerNotes: $lawyerNotes, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CaseProceduresTable extends CaseProcedures
    with TableInfo<$CaseProceduresTable, CaseProcedure> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CaseProceduresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caseIdMeta = const VerificationMeta('caseId');
  @override
  late final GeneratedColumn<String> caseId = GeneratedColumn<String>(
    'case_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cases (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _procedureDateMeta = const VerificationMeta(
    'procedureDate',
  );
  @override
  late final GeneratedColumn<int> procedureDate = GeneratedColumn<int>(
    'procedure_date',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _procedureTypeMeta = const VerificationMeta(
    'procedureType',
  );
  @override
  late final GeneratedColumn<String> procedureType = GeneratedColumn<String>(
    'procedure_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _resultMeta = const VerificationMeta('result');
  @override
  late final GeneratedColumn<String> result = GeneratedColumn<String>(
    'result',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _documentIdMeta = const VerificationMeta(
    'documentId',
  );
  @override
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
    'document_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES documents (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    caseId,
    procedureDate,
    title,
    procedureType,
    description,
    result,
    documentId,
    createdAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'case_procedures';
  @override
  VerificationContext validateIntegrity(
    Insertable<CaseProcedure> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('case_id')) {
      context.handle(
        _caseIdMeta,
        caseId.isAcceptableOrUnknown(data['case_id']!, _caseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_caseIdMeta);
    }
    if (data.containsKey('procedure_date')) {
      context.handle(
        _procedureDateMeta,
        procedureDate.isAcceptableOrUnknown(
          data['procedure_date']!,
          _procedureDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_procedureDateMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('procedure_type')) {
      context.handle(
        _procedureTypeMeta,
        procedureType.isAcceptableOrUnknown(
          data['procedure_type']!,
          _procedureTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_procedureTypeMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('result')) {
      context.handle(
        _resultMeta,
        result.isAcceptableOrUnknown(data['result']!, _resultMeta),
      );
    }
    if (data.containsKey('document_id')) {
      context.handle(
        _documentIdMeta,
        documentId.isAcceptableOrUnknown(data['document_id']!, _documentIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CaseProcedure map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CaseProcedure(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      caseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}case_id'],
      )!,
      procedureDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}procedure_date'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      procedureType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}procedure_type'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      result: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}result'],
      ),
      documentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $CaseProceduresTable createAlias(String alias) {
    return $CaseProceduresTable(attachedDatabase, alias);
  }
}

class CaseProcedure extends DataClass implements Insertable<CaseProcedure> {
  final String id;
  final String caseId;
  final int procedureDate;
  final String title;
  final String procedureType;
  final String? description;
  final String? result;
  final String? documentId;
  final int createdAt;
  final int? deletedAt;
  const CaseProcedure({
    required this.id,
    required this.caseId,
    required this.procedureDate,
    required this.title,
    required this.procedureType,
    this.description,
    this.result,
    this.documentId,
    required this.createdAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['case_id'] = Variable<String>(caseId);
    map['procedure_date'] = Variable<int>(procedureDate);
    map['title'] = Variable<String>(title);
    map['procedure_type'] = Variable<String>(procedureType);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || result != null) {
      map['result'] = Variable<String>(result);
    }
    if (!nullToAbsent || documentId != null) {
      map['document_id'] = Variable<String>(documentId);
    }
    map['created_at'] = Variable<int>(createdAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  CaseProceduresCompanion toCompanion(bool nullToAbsent) {
    return CaseProceduresCompanion(
      id: Value(id),
      caseId: Value(caseId),
      procedureDate: Value(procedureDate),
      title: Value(title),
      procedureType: Value(procedureType),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      result: result == null && nullToAbsent
          ? const Value.absent()
          : Value(result),
      documentId: documentId == null && nullToAbsent
          ? const Value.absent()
          : Value(documentId),
      createdAt: Value(createdAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory CaseProcedure.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CaseProcedure(
      id: serializer.fromJson<String>(json['id']),
      caseId: serializer.fromJson<String>(json['caseId']),
      procedureDate: serializer.fromJson<int>(json['procedureDate']),
      title: serializer.fromJson<String>(json['title']),
      procedureType: serializer.fromJson<String>(json['procedureType']),
      description: serializer.fromJson<String?>(json['description']),
      result: serializer.fromJson<String?>(json['result']),
      documentId: serializer.fromJson<String?>(json['documentId']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'caseId': serializer.toJson<String>(caseId),
      'procedureDate': serializer.toJson<int>(procedureDate),
      'title': serializer.toJson<String>(title),
      'procedureType': serializer.toJson<String>(procedureType),
      'description': serializer.toJson<String?>(description),
      'result': serializer.toJson<String?>(result),
      'documentId': serializer.toJson<String?>(documentId),
      'createdAt': serializer.toJson<int>(createdAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  CaseProcedure copyWith({
    String? id,
    String? caseId,
    int? procedureDate,
    String? title,
    String? procedureType,
    Value<String?> description = const Value.absent(),
    Value<String?> result = const Value.absent(),
    Value<String?> documentId = const Value.absent(),
    int? createdAt,
    Value<int?> deletedAt = const Value.absent(),
  }) => CaseProcedure(
    id: id ?? this.id,
    caseId: caseId ?? this.caseId,
    procedureDate: procedureDate ?? this.procedureDate,
    title: title ?? this.title,
    procedureType: procedureType ?? this.procedureType,
    description: description.present ? description.value : this.description,
    result: result.present ? result.value : this.result,
    documentId: documentId.present ? documentId.value : this.documentId,
    createdAt: createdAt ?? this.createdAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  CaseProcedure copyWithCompanion(CaseProceduresCompanion data) {
    return CaseProcedure(
      id: data.id.present ? data.id.value : this.id,
      caseId: data.caseId.present ? data.caseId.value : this.caseId,
      procedureDate: data.procedureDate.present
          ? data.procedureDate.value
          : this.procedureDate,
      title: data.title.present ? data.title.value : this.title,
      procedureType: data.procedureType.present
          ? data.procedureType.value
          : this.procedureType,
      description: data.description.present
          ? data.description.value
          : this.description,
      result: data.result.present ? data.result.value : this.result,
      documentId: data.documentId.present
          ? data.documentId.value
          : this.documentId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CaseProcedure(')
          ..write('id: $id, ')
          ..write('caseId: $caseId, ')
          ..write('procedureDate: $procedureDate, ')
          ..write('title: $title, ')
          ..write('procedureType: $procedureType, ')
          ..write('description: $description, ')
          ..write('result: $result, ')
          ..write('documentId: $documentId, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    caseId,
    procedureDate,
    title,
    procedureType,
    description,
    result,
    documentId,
    createdAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CaseProcedure &&
          other.id == this.id &&
          other.caseId == this.caseId &&
          other.procedureDate == this.procedureDate &&
          other.title == this.title &&
          other.procedureType == this.procedureType &&
          other.description == this.description &&
          other.result == this.result &&
          other.documentId == this.documentId &&
          other.createdAt == this.createdAt &&
          other.deletedAt == this.deletedAt);
}

class CaseProceduresCompanion extends UpdateCompanion<CaseProcedure> {
  final Value<String> id;
  final Value<String> caseId;
  final Value<int> procedureDate;
  final Value<String> title;
  final Value<String> procedureType;
  final Value<String?> description;
  final Value<String?> result;
  final Value<String?> documentId;
  final Value<int> createdAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const CaseProceduresCompanion({
    this.id = const Value.absent(),
    this.caseId = const Value.absent(),
    this.procedureDate = const Value.absent(),
    this.title = const Value.absent(),
    this.procedureType = const Value.absent(),
    this.description = const Value.absent(),
    this.result = const Value.absent(),
    this.documentId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CaseProceduresCompanion.insert({
    required String id,
    required String caseId,
    required int procedureDate,
    required String title,
    required String procedureType,
    this.description = const Value.absent(),
    this.result = const Value.absent(),
    this.documentId = const Value.absent(),
    required int createdAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       caseId = Value(caseId),
       procedureDate = Value(procedureDate),
       title = Value(title),
       procedureType = Value(procedureType),
       createdAt = Value(createdAt);
  static Insertable<CaseProcedure> custom({
    Expression<String>? id,
    Expression<String>? caseId,
    Expression<int>? procedureDate,
    Expression<String>? title,
    Expression<String>? procedureType,
    Expression<String>? description,
    Expression<String>? result,
    Expression<String>? documentId,
    Expression<int>? createdAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (caseId != null) 'case_id': caseId,
      if (procedureDate != null) 'procedure_date': procedureDate,
      if (title != null) 'title': title,
      if (procedureType != null) 'procedure_type': procedureType,
      if (description != null) 'description': description,
      if (result != null) 'result': result,
      if (documentId != null) 'document_id': documentId,
      if (createdAt != null) 'created_at': createdAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CaseProceduresCompanion copyWith({
    Value<String>? id,
    Value<String>? caseId,
    Value<int>? procedureDate,
    Value<String>? title,
    Value<String>? procedureType,
    Value<String?>? description,
    Value<String?>? result,
    Value<String?>? documentId,
    Value<int>? createdAt,
    Value<int?>? deletedAt,
    Value<int>? rowid,
  }) {
    return CaseProceduresCompanion(
      id: id ?? this.id,
      caseId: caseId ?? this.caseId,
      procedureDate: procedureDate ?? this.procedureDate,
      title: title ?? this.title,
      procedureType: procedureType ?? this.procedureType,
      description: description ?? this.description,
      result: result ?? this.result,
      documentId: documentId ?? this.documentId,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (caseId.present) {
      map['case_id'] = Variable<String>(caseId.value);
    }
    if (procedureDate.present) {
      map['procedure_date'] = Variable<int>(procedureDate.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (procedureType.present) {
      map['procedure_type'] = Variable<String>(procedureType.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (result.present) {
      map['result'] = Variable<String>(result.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CaseProceduresCompanion(')
          ..write('id: $id, ')
          ..write('caseId: $caseId, ')
          ..write('procedureDate: $procedureDate, ')
          ..write('title: $title, ')
          ..write('procedureType: $procedureType, ')
          ..write('description: $description, ')
          ..write('result: $result, ')
          ..write('documentId: $documentId, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _caseIdMeta = const VerificationMeta('caseId');
  @override
  late final GeneratedColumn<String> caseId = GeneratedColumn<String>(
    'case_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cases (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
    'client_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clients (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('PENDING'),
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<int> dueDate = GeneratedColumn<int>(
    'due_date',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reminderTimeMeta = const VerificationMeta(
    'reminderTime',
  );
  @override
  late final GeneratedColumn<int> reminderTime = GeneratedColumn<int>(
    'reminder_time',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<int> completedAt = GeneratedColumn<int>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    caseId,
    clientId,
    priority,
    status,
    dueDate,
    reminderTime,
    completedAt,
    createdAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Task> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('case_id')) {
      context.handle(
        _caseIdMeta,
        caseId.isAcceptableOrUnknown(data['case_id']!, _caseIdMeta),
      );
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('reminder_time')) {
      context.handle(
        _reminderTimeMeta,
        reminderTime.isAcceptableOrUnknown(
          data['reminder_time']!,
          _reminderTimeMeta,
        ),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Task(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      caseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}case_id'],
      ),
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_id'],
      ),
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}priority'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}due_date'],
      )!,
      reminderTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reminder_time'],
      ),
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completed_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }
}

class Task extends DataClass implements Insertable<Task> {
  final String id;
  final String title;
  final String? description;
  final String? caseId;
  final String? clientId;
  final String priority;
  final String status;
  final int dueDate;
  final int? reminderTime;
  final int? completedAt;
  final int createdAt;
  final int? deletedAt;
  const Task({
    required this.id,
    required this.title,
    this.description,
    this.caseId,
    this.clientId,
    required this.priority,
    required this.status,
    required this.dueDate,
    this.reminderTime,
    this.completedAt,
    required this.createdAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || caseId != null) {
      map['case_id'] = Variable<String>(caseId);
    }
    if (!nullToAbsent || clientId != null) {
      map['client_id'] = Variable<String>(clientId);
    }
    map['priority'] = Variable<String>(priority);
    map['status'] = Variable<String>(status);
    map['due_date'] = Variable<int>(dueDate);
    if (!nullToAbsent || reminderTime != null) {
      map['reminder_time'] = Variable<int>(reminderTime);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<int>(completedAt);
    }
    map['created_at'] = Variable<int>(createdAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      caseId: caseId == null && nullToAbsent
          ? const Value.absent()
          : Value(caseId),
      clientId: clientId == null && nullToAbsent
          ? const Value.absent()
          : Value(clientId),
      priority: Value(priority),
      status: Value(status),
      dueDate: Value(dueDate),
      reminderTime: reminderTime == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderTime),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      createdAt: Value(createdAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Task.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      caseId: serializer.fromJson<String?>(json['caseId']),
      clientId: serializer.fromJson<String?>(json['clientId']),
      priority: serializer.fromJson<String>(json['priority']),
      status: serializer.fromJson<String>(json['status']),
      dueDate: serializer.fromJson<int>(json['dueDate']),
      reminderTime: serializer.fromJson<int?>(json['reminderTime']),
      completedAt: serializer.fromJson<int?>(json['completedAt']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'caseId': serializer.toJson<String?>(caseId),
      'clientId': serializer.toJson<String?>(clientId),
      'priority': serializer.toJson<String>(priority),
      'status': serializer.toJson<String>(status),
      'dueDate': serializer.toJson<int>(dueDate),
      'reminderTime': serializer.toJson<int?>(reminderTime),
      'completedAt': serializer.toJson<int?>(completedAt),
      'createdAt': serializer.toJson<int>(createdAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  Task copyWith({
    String? id,
    String? title,
    Value<String?> description = const Value.absent(),
    Value<String?> caseId = const Value.absent(),
    Value<String?> clientId = const Value.absent(),
    String? priority,
    String? status,
    int? dueDate,
    Value<int?> reminderTime = const Value.absent(),
    Value<int?> completedAt = const Value.absent(),
    int? createdAt,
    Value<int?> deletedAt = const Value.absent(),
  }) => Task(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    caseId: caseId.present ? caseId.value : this.caseId,
    clientId: clientId.present ? clientId.value : this.clientId,
    priority: priority ?? this.priority,
    status: status ?? this.status,
    dueDate: dueDate ?? this.dueDate,
    reminderTime: reminderTime.present ? reminderTime.value : this.reminderTime,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    createdAt: createdAt ?? this.createdAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Task copyWithCompanion(TasksCompanion data) {
    return Task(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      caseId: data.caseId.present ? data.caseId.value : this.caseId,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      priority: data.priority.present ? data.priority.value : this.priority,
      status: data.status.present ? data.status.value : this.status,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      reminderTime: data.reminderTime.present
          ? data.reminderTime.value
          : this.reminderTime,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('caseId: $caseId, ')
          ..write('clientId: $clientId, ')
          ..write('priority: $priority, ')
          ..write('status: $status, ')
          ..write('dueDate: $dueDate, ')
          ..write('reminderTime: $reminderTime, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    caseId,
    clientId,
    priority,
    status,
    dueDate,
    reminderTime,
    completedAt,
    createdAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.caseId == this.caseId &&
          other.clientId == this.clientId &&
          other.priority == this.priority &&
          other.status == this.status &&
          other.dueDate == this.dueDate &&
          other.reminderTime == this.reminderTime &&
          other.completedAt == this.completedAt &&
          other.createdAt == this.createdAt &&
          other.deletedAt == this.deletedAt);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<String?> caseId;
  final Value<String?> clientId;
  final Value<String> priority;
  final Value<String> status;
  final Value<int> dueDate;
  final Value<int?> reminderTime;
  final Value<int?> completedAt;
  final Value<int> createdAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.caseId = const Value.absent(),
    this.clientId = const Value.absent(),
    this.priority = const Value.absent(),
    this.status = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.reminderTime = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TasksCompanion.insert({
    required String id,
    required String title,
    this.description = const Value.absent(),
    this.caseId = const Value.absent(),
    this.clientId = const Value.absent(),
    required String priority,
    this.status = const Value.absent(),
    required int dueDate,
    this.reminderTime = const Value.absent(),
    this.completedAt = const Value.absent(),
    required int createdAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       priority = Value(priority),
       dueDate = Value(dueDate),
       createdAt = Value(createdAt);
  static Insertable<Task> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? caseId,
    Expression<String>? clientId,
    Expression<String>? priority,
    Expression<String>? status,
    Expression<int>? dueDate,
    Expression<int>? reminderTime,
    Expression<int>? completedAt,
    Expression<int>? createdAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (caseId != null) 'case_id': caseId,
      if (clientId != null) 'client_id': clientId,
      if (priority != null) 'priority': priority,
      if (status != null) 'status': status,
      if (dueDate != null) 'due_date': dueDate,
      if (reminderTime != null) 'reminder_time': reminderTime,
      if (completedAt != null) 'completed_at': completedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TasksCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String?>? description,
    Value<String?>? caseId,
    Value<String?>? clientId,
    Value<String>? priority,
    Value<String>? status,
    Value<int>? dueDate,
    Value<int?>? reminderTime,
    Value<int?>? completedAt,
    Value<int>? createdAt,
    Value<int?>? deletedAt,
    Value<int>? rowid,
  }) {
    return TasksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      caseId: caseId ?? this.caseId,
      clientId: clientId ?? this.clientId,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      dueDate: dueDate ?? this.dueDate,
      reminderTime: reminderTime ?? this.reminderTime,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (caseId.present) {
      map['case_id'] = Variable<String>(caseId.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<int>(dueDate.value);
    }
    if (reminderTime.present) {
      map['reminder_time'] = Variable<int>(reminderTime.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<int>(completedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('caseId: $caseId, ')
          ..write('clientId: $clientId, ')
          ..write('priority: $priority, ')
          ..write('status: $status, ')
          ..write('dueDate: $dueDate, ')
          ..write('reminderTime: $reminderTime, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FeeAgreementsTable extends FeeAgreements
    with TableInfo<$FeeAgreementsTable, FeeAgreement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeeAgreementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clients (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _caseIdMeta = const VerificationMeta('caseId');
  @override
  late final GeneratedColumn<String> caseId = GeneratedColumn<String>(
    'case_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cases (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _agreedAmountMeta = const VerificationMeta(
    'agreedAmount',
  );
  @override
  late final GeneratedColumn<int> agreedAmount = GeneratedColumn<int>(
    'agreed_amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('SYP'),
  );
  static const VerificationMeta _agreementTypeMeta = const VerificationMeta(
    'agreementType',
  );
  @override
  late final GeneratedColumn<String> agreementType = GeneratedColumn<String>(
    'agreement_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _agreementDateMeta = const VerificationMeta(
    'agreementDate',
  );
  @override
  late final GeneratedColumn<int> agreementDate = GeneratedColumn<int>(
    'agreement_date',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clientId,
    caseId,
    agreedAmount,
    currency,
    agreementType,
    agreementDate,
    notes,
    createdAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fee_agreements';
  @override
  VerificationContext validateIntegrity(
    Insertable<FeeAgreement> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('case_id')) {
      context.handle(
        _caseIdMeta,
        caseId.isAcceptableOrUnknown(data['case_id']!, _caseIdMeta),
      );
    }
    if (data.containsKey('agreed_amount')) {
      context.handle(
        _agreedAmountMeta,
        agreedAmount.isAcceptableOrUnknown(
          data['agreed_amount']!,
          _agreedAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_agreedAmountMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('agreement_type')) {
      context.handle(
        _agreementTypeMeta,
        agreementType.isAcceptableOrUnknown(
          data['agreement_type']!,
          _agreementTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_agreementTypeMeta);
    }
    if (data.containsKey('agreement_date')) {
      context.handle(
        _agreementDateMeta,
        agreementDate.isAcceptableOrUnknown(
          data['agreement_date']!,
          _agreementDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_agreementDateMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FeeAgreement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeeAgreement(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_id'],
      )!,
      caseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}case_id'],
      ),
      agreedAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}agreed_amount'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      agreementType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}agreement_type'],
      )!,
      agreementDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}agreement_date'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $FeeAgreementsTable createAlias(String alias) {
    return $FeeAgreementsTable(attachedDatabase, alias);
  }
}

class FeeAgreement extends DataClass implements Insertable<FeeAgreement> {
  final String id;
  final String clientId;
  final String? caseId;
  final int agreedAmount;
  final String currency;
  final String agreementType;
  final int agreementDate;
  final String? notes;
  final int createdAt;
  final int? deletedAt;
  const FeeAgreement({
    required this.id,
    required this.clientId,
    this.caseId,
    required this.agreedAmount,
    required this.currency,
    required this.agreementType,
    required this.agreementDate,
    this.notes,
    required this.createdAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['client_id'] = Variable<String>(clientId);
    if (!nullToAbsent || caseId != null) {
      map['case_id'] = Variable<String>(caseId);
    }
    map['agreed_amount'] = Variable<int>(agreedAmount);
    map['currency'] = Variable<String>(currency);
    map['agreement_type'] = Variable<String>(agreementType);
    map['agreement_date'] = Variable<int>(agreementDate);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<int>(createdAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  FeeAgreementsCompanion toCompanion(bool nullToAbsent) {
    return FeeAgreementsCompanion(
      id: Value(id),
      clientId: Value(clientId),
      caseId: caseId == null && nullToAbsent
          ? const Value.absent()
          : Value(caseId),
      agreedAmount: Value(agreedAmount),
      currency: Value(currency),
      agreementType: Value(agreementType),
      agreementDate: Value(agreementDate),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory FeeAgreement.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeeAgreement(
      id: serializer.fromJson<String>(json['id']),
      clientId: serializer.fromJson<String>(json['clientId']),
      caseId: serializer.fromJson<String?>(json['caseId']),
      agreedAmount: serializer.fromJson<int>(json['agreedAmount']),
      currency: serializer.fromJson<String>(json['currency']),
      agreementType: serializer.fromJson<String>(json['agreementType']),
      agreementDate: serializer.fromJson<int>(json['agreementDate']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'clientId': serializer.toJson<String>(clientId),
      'caseId': serializer.toJson<String?>(caseId),
      'agreedAmount': serializer.toJson<int>(agreedAmount),
      'currency': serializer.toJson<String>(currency),
      'agreementType': serializer.toJson<String>(agreementType),
      'agreementDate': serializer.toJson<int>(agreementDate),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<int>(createdAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  FeeAgreement copyWith({
    String? id,
    String? clientId,
    Value<String?> caseId = const Value.absent(),
    int? agreedAmount,
    String? currency,
    String? agreementType,
    int? agreementDate,
    Value<String?> notes = const Value.absent(),
    int? createdAt,
    Value<int?> deletedAt = const Value.absent(),
  }) => FeeAgreement(
    id: id ?? this.id,
    clientId: clientId ?? this.clientId,
    caseId: caseId.present ? caseId.value : this.caseId,
    agreedAmount: agreedAmount ?? this.agreedAmount,
    currency: currency ?? this.currency,
    agreementType: agreementType ?? this.agreementType,
    agreementDate: agreementDate ?? this.agreementDate,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  FeeAgreement copyWithCompanion(FeeAgreementsCompanion data) {
    return FeeAgreement(
      id: data.id.present ? data.id.value : this.id,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      caseId: data.caseId.present ? data.caseId.value : this.caseId,
      agreedAmount: data.agreedAmount.present
          ? data.agreedAmount.value
          : this.agreedAmount,
      currency: data.currency.present ? data.currency.value : this.currency,
      agreementType: data.agreementType.present
          ? data.agreementType.value
          : this.agreementType,
      agreementDate: data.agreementDate.present
          ? data.agreementDate.value
          : this.agreementDate,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeeAgreement(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('caseId: $caseId, ')
          ..write('agreedAmount: $agreedAmount, ')
          ..write('currency: $currency, ')
          ..write('agreementType: $agreementType, ')
          ..write('agreementDate: $agreementDate, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    clientId,
    caseId,
    agreedAmount,
    currency,
    agreementType,
    agreementDate,
    notes,
    createdAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeeAgreement &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.caseId == this.caseId &&
          other.agreedAmount == this.agreedAmount &&
          other.currency == this.currency &&
          other.agreementType == this.agreementType &&
          other.agreementDate == this.agreementDate &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.deletedAt == this.deletedAt);
}

class FeeAgreementsCompanion extends UpdateCompanion<FeeAgreement> {
  final Value<String> id;
  final Value<String> clientId;
  final Value<String?> caseId;
  final Value<int> agreedAmount;
  final Value<String> currency;
  final Value<String> agreementType;
  final Value<int> agreementDate;
  final Value<String?> notes;
  final Value<int> createdAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const FeeAgreementsCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.caseId = const Value.absent(),
    this.agreedAmount = const Value.absent(),
    this.currency = const Value.absent(),
    this.agreementType = const Value.absent(),
    this.agreementDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FeeAgreementsCompanion.insert({
    required String id,
    required String clientId,
    this.caseId = const Value.absent(),
    required int agreedAmount,
    this.currency = const Value.absent(),
    required String agreementType,
    required int agreementDate,
    this.notes = const Value.absent(),
    required int createdAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       clientId = Value(clientId),
       agreedAmount = Value(agreedAmount),
       agreementType = Value(agreementType),
       agreementDate = Value(agreementDate),
       createdAt = Value(createdAt);
  static Insertable<FeeAgreement> custom({
    Expression<String>? id,
    Expression<String>? clientId,
    Expression<String>? caseId,
    Expression<int>? agreedAmount,
    Expression<String>? currency,
    Expression<String>? agreementType,
    Expression<int>? agreementDate,
    Expression<String>? notes,
    Expression<int>? createdAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (caseId != null) 'case_id': caseId,
      if (agreedAmount != null) 'agreed_amount': agreedAmount,
      if (currency != null) 'currency': currency,
      if (agreementType != null) 'agreement_type': agreementType,
      if (agreementDate != null) 'agreement_date': agreementDate,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FeeAgreementsCompanion copyWith({
    Value<String>? id,
    Value<String>? clientId,
    Value<String?>? caseId,
    Value<int>? agreedAmount,
    Value<String>? currency,
    Value<String>? agreementType,
    Value<int>? agreementDate,
    Value<String?>? notes,
    Value<int>? createdAt,
    Value<int?>? deletedAt,
    Value<int>? rowid,
  }) {
    return FeeAgreementsCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      caseId: caseId ?? this.caseId,
      agreedAmount: agreedAmount ?? this.agreedAmount,
      currency: currency ?? this.currency,
      agreementType: agreementType ?? this.agreementType,
      agreementDate: agreementDate ?? this.agreementDate,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (caseId.present) {
      map['case_id'] = Variable<String>(caseId.value);
    }
    if (agreedAmount.present) {
      map['agreed_amount'] = Variable<int>(agreedAmount.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (agreementType.present) {
      map['agreement_type'] = Variable<String>(agreementType.value);
    }
    if (agreementDate.present) {
      map['agreement_date'] = Variable<int>(agreementDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeeAgreementsCompanion(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('caseId: $caseId, ')
          ..write('agreedAmount: $agreedAmount, ')
          ..write('currency: $currency, ')
          ..write('agreementType: $agreementType, ')
          ..write('agreementDate: $agreementDate, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaymentsTable extends Payments with TableInfo<$PaymentsTable, Payment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _feeAgreementIdMeta = const VerificationMeta(
    'feeAgreementId',
  );
  @override
  late final GeneratedColumn<String> feeAgreementId = GeneratedColumn<String>(
    'fee_agreement_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES fee_agreements (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clients (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _caseIdMeta = const VerificationMeta('caseId');
  @override
  late final GeneratedColumn<String> caseId = GeneratedColumn<String>(
    'case_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cases (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('SYP'),
  );
  static const VerificationMeta _paymentDateMeta = const VerificationMeta(
    'paymentDate',
  );
  @override
  late final GeneratedColumn<int> paymentDate = GeneratedColumn<int>(
    'payment_date',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _receiptNumberMeta = const VerificationMeta(
    'receiptNumber',
  );
  @override
  late final GeneratedColumn<String> receiptNumber = GeneratedColumn<String>(
    'receipt_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    feeAgreementId,
    clientId,
    caseId,
    amount,
    currency,
    paymentDate,
    paymentMethod,
    receiptNumber,
    notes,
    createdAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payments';
  @override
  VerificationContext validateIntegrity(
    Insertable<Payment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('fee_agreement_id')) {
      context.handle(
        _feeAgreementIdMeta,
        feeAgreementId.isAcceptableOrUnknown(
          data['fee_agreement_id']!,
          _feeAgreementIdMeta,
        ),
      );
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('case_id')) {
      context.handle(
        _caseIdMeta,
        caseId.isAcceptableOrUnknown(data['case_id']!, _caseIdMeta),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('payment_date')) {
      context.handle(
        _paymentDateMeta,
        paymentDate.isAcceptableOrUnknown(
          data['payment_date']!,
          _paymentDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentDateMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentMethodMeta);
    }
    if (data.containsKey('receipt_number')) {
      context.handle(
        _receiptNumberMeta,
        receiptNumber.isAcceptableOrUnknown(
          data['receipt_number']!,
          _receiptNumberMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Payment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Payment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      feeAgreementId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fee_agreement_id'],
      ),
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_id'],
      )!,
      caseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}case_id'],
      ),
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      paymentDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}payment_date'],
      )!,
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      )!,
      receiptNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}receipt_number'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $PaymentsTable createAlias(String alias) {
    return $PaymentsTable(attachedDatabase, alias);
  }
}

class Payment extends DataClass implements Insertable<Payment> {
  final String id;
  final String? feeAgreementId;
  final String clientId;
  final String? caseId;
  final int amount;
  final String currency;
  final int paymentDate;
  final String paymentMethod;
  final String? receiptNumber;
  final String? notes;
  final int createdAt;
  final int? deletedAt;
  const Payment({
    required this.id,
    this.feeAgreementId,
    required this.clientId,
    this.caseId,
    required this.amount,
    required this.currency,
    required this.paymentDate,
    required this.paymentMethod,
    this.receiptNumber,
    this.notes,
    required this.createdAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || feeAgreementId != null) {
      map['fee_agreement_id'] = Variable<String>(feeAgreementId);
    }
    map['client_id'] = Variable<String>(clientId);
    if (!nullToAbsent || caseId != null) {
      map['case_id'] = Variable<String>(caseId);
    }
    map['amount'] = Variable<int>(amount);
    map['currency'] = Variable<String>(currency);
    map['payment_date'] = Variable<int>(paymentDate);
    map['payment_method'] = Variable<String>(paymentMethod);
    if (!nullToAbsent || receiptNumber != null) {
      map['receipt_number'] = Variable<String>(receiptNumber);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<int>(createdAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  PaymentsCompanion toCompanion(bool nullToAbsent) {
    return PaymentsCompanion(
      id: Value(id),
      feeAgreementId: feeAgreementId == null && nullToAbsent
          ? const Value.absent()
          : Value(feeAgreementId),
      clientId: Value(clientId),
      caseId: caseId == null && nullToAbsent
          ? const Value.absent()
          : Value(caseId),
      amount: Value(amount),
      currency: Value(currency),
      paymentDate: Value(paymentDate),
      paymentMethod: Value(paymentMethod),
      receiptNumber: receiptNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(receiptNumber),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Payment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Payment(
      id: serializer.fromJson<String>(json['id']),
      feeAgreementId: serializer.fromJson<String?>(json['feeAgreementId']),
      clientId: serializer.fromJson<String>(json['clientId']),
      caseId: serializer.fromJson<String?>(json['caseId']),
      amount: serializer.fromJson<int>(json['amount']),
      currency: serializer.fromJson<String>(json['currency']),
      paymentDate: serializer.fromJson<int>(json['paymentDate']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      receiptNumber: serializer.fromJson<String?>(json['receiptNumber']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'feeAgreementId': serializer.toJson<String?>(feeAgreementId),
      'clientId': serializer.toJson<String>(clientId),
      'caseId': serializer.toJson<String?>(caseId),
      'amount': serializer.toJson<int>(amount),
      'currency': serializer.toJson<String>(currency),
      'paymentDate': serializer.toJson<int>(paymentDate),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'receiptNumber': serializer.toJson<String?>(receiptNumber),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<int>(createdAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  Payment copyWith({
    String? id,
    Value<String?> feeAgreementId = const Value.absent(),
    String? clientId,
    Value<String?> caseId = const Value.absent(),
    int? amount,
    String? currency,
    int? paymentDate,
    String? paymentMethod,
    Value<String?> receiptNumber = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    int? createdAt,
    Value<int?> deletedAt = const Value.absent(),
  }) => Payment(
    id: id ?? this.id,
    feeAgreementId: feeAgreementId.present
        ? feeAgreementId.value
        : this.feeAgreementId,
    clientId: clientId ?? this.clientId,
    caseId: caseId.present ? caseId.value : this.caseId,
    amount: amount ?? this.amount,
    currency: currency ?? this.currency,
    paymentDate: paymentDate ?? this.paymentDate,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    receiptNumber: receiptNumber.present
        ? receiptNumber.value
        : this.receiptNumber,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Payment copyWithCompanion(PaymentsCompanion data) {
    return Payment(
      id: data.id.present ? data.id.value : this.id,
      feeAgreementId: data.feeAgreementId.present
          ? data.feeAgreementId.value
          : this.feeAgreementId,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      caseId: data.caseId.present ? data.caseId.value : this.caseId,
      amount: data.amount.present ? data.amount.value : this.amount,
      currency: data.currency.present ? data.currency.value : this.currency,
      paymentDate: data.paymentDate.present
          ? data.paymentDate.value
          : this.paymentDate,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      receiptNumber: data.receiptNumber.present
          ? data.receiptNumber.value
          : this.receiptNumber,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Payment(')
          ..write('id: $id, ')
          ..write('feeAgreementId: $feeAgreementId, ')
          ..write('clientId: $clientId, ')
          ..write('caseId: $caseId, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency, ')
          ..write('paymentDate: $paymentDate, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('receiptNumber: $receiptNumber, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    feeAgreementId,
    clientId,
    caseId,
    amount,
    currency,
    paymentDate,
    paymentMethod,
    receiptNumber,
    notes,
    createdAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Payment &&
          other.id == this.id &&
          other.feeAgreementId == this.feeAgreementId &&
          other.clientId == this.clientId &&
          other.caseId == this.caseId &&
          other.amount == this.amount &&
          other.currency == this.currency &&
          other.paymentDate == this.paymentDate &&
          other.paymentMethod == this.paymentMethod &&
          other.receiptNumber == this.receiptNumber &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.deletedAt == this.deletedAt);
}

class PaymentsCompanion extends UpdateCompanion<Payment> {
  final Value<String> id;
  final Value<String?> feeAgreementId;
  final Value<String> clientId;
  final Value<String?> caseId;
  final Value<int> amount;
  final Value<String> currency;
  final Value<int> paymentDate;
  final Value<String> paymentMethod;
  final Value<String?> receiptNumber;
  final Value<String?> notes;
  final Value<int> createdAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const PaymentsCompanion({
    this.id = const Value.absent(),
    this.feeAgreementId = const Value.absent(),
    this.clientId = const Value.absent(),
    this.caseId = const Value.absent(),
    this.amount = const Value.absent(),
    this.currency = const Value.absent(),
    this.paymentDate = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.receiptNumber = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PaymentsCompanion.insert({
    required String id,
    this.feeAgreementId = const Value.absent(),
    required String clientId,
    this.caseId = const Value.absent(),
    required int amount,
    this.currency = const Value.absent(),
    required int paymentDate,
    required String paymentMethod,
    this.receiptNumber = const Value.absent(),
    this.notes = const Value.absent(),
    required int createdAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       clientId = Value(clientId),
       amount = Value(amount),
       paymentDate = Value(paymentDate),
       paymentMethod = Value(paymentMethod),
       createdAt = Value(createdAt);
  static Insertable<Payment> custom({
    Expression<String>? id,
    Expression<String>? feeAgreementId,
    Expression<String>? clientId,
    Expression<String>? caseId,
    Expression<int>? amount,
    Expression<String>? currency,
    Expression<int>? paymentDate,
    Expression<String>? paymentMethod,
    Expression<String>? receiptNumber,
    Expression<String>? notes,
    Expression<int>? createdAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (feeAgreementId != null) 'fee_agreement_id': feeAgreementId,
      if (clientId != null) 'client_id': clientId,
      if (caseId != null) 'case_id': caseId,
      if (amount != null) 'amount': amount,
      if (currency != null) 'currency': currency,
      if (paymentDate != null) 'payment_date': paymentDate,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (receiptNumber != null) 'receipt_number': receiptNumber,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PaymentsCompanion copyWith({
    Value<String>? id,
    Value<String?>? feeAgreementId,
    Value<String>? clientId,
    Value<String?>? caseId,
    Value<int>? amount,
    Value<String>? currency,
    Value<int>? paymentDate,
    Value<String>? paymentMethod,
    Value<String?>? receiptNumber,
    Value<String?>? notes,
    Value<int>? createdAt,
    Value<int?>? deletedAt,
    Value<int>? rowid,
  }) {
    return PaymentsCompanion(
      id: id ?? this.id,
      feeAgreementId: feeAgreementId ?? this.feeAgreementId,
      clientId: clientId ?? this.clientId,
      caseId: caseId ?? this.caseId,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      paymentDate: paymentDate ?? this.paymentDate,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      receiptNumber: receiptNumber ?? this.receiptNumber,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (feeAgreementId.present) {
      map['fee_agreement_id'] = Variable<String>(feeAgreementId.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (caseId.present) {
      map['case_id'] = Variable<String>(caseId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (paymentDate.present) {
      map['payment_date'] = Variable<int>(paymentDate.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (receiptNumber.present) {
      map['receipt_number'] = Variable<String>(receiptNumber.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsCompanion(')
          ..write('id: $id, ')
          ..write('feeAgreementId: $feeAgreementId, ')
          ..write('clientId: $clientId, ')
          ..write('caseId: $caseId, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency, ')
          ..write('paymentDate: $paymentDate, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('receiptNumber: $receiptNumber, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTable extends Expenses with TableInfo<$ExpensesTable, Expense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caseIdMeta = const VerificationMeta('caseId');
  @override
  late final GeneratedColumn<String> caseId = GeneratedColumn<String>(
    'case_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cases (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('SYP'),
  );
  static const VerificationMeta _expenseDateMeta = const VerificationMeta(
    'expenseDate',
  );
  @override
  late final GeneratedColumn<int> expenseDate = GeneratedColumn<int>(
    'expense_date',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recipientMeta = const VerificationMeta(
    'recipient',
  );
  @override
  late final GeneratedColumn<String> recipient = GeneratedColumn<String>(
    'recipient',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _documentIdMeta = const VerificationMeta(
    'documentId',
  );
  @override
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
    'document_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES documents (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    caseId,
    category,
    amount,
    currency,
    expenseDate,
    recipient,
    documentId,
    notes,
    createdAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(
    Insertable<Expense> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('case_id')) {
      context.handle(
        _caseIdMeta,
        caseId.isAcceptableOrUnknown(data['case_id']!, _caseIdMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('expense_date')) {
      context.handle(
        _expenseDateMeta,
        expenseDate.isAcceptableOrUnknown(
          data['expense_date']!,
          _expenseDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_expenseDateMeta);
    }
    if (data.containsKey('recipient')) {
      context.handle(
        _recipientMeta,
        recipient.isAcceptableOrUnknown(data['recipient']!, _recipientMeta),
      );
    }
    if (data.containsKey('document_id')) {
      context.handle(
        _documentIdMeta,
        documentId.isAcceptableOrUnknown(data['document_id']!, _documentIdMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Expense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Expense(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      caseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}case_id'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      expenseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}expense_date'],
      )!,
      recipient: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recipient'],
      ),
      documentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_id'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }
}

class Expense extends DataClass implements Insertable<Expense> {
  final String id;
  final String? caseId;
  final String category;
  final int amount;
  final String currency;
  final int expenseDate;
  final String? recipient;
  final String? documentId;
  final String? notes;
  final int createdAt;
  final int? deletedAt;
  const Expense({
    required this.id,
    this.caseId,
    required this.category,
    required this.amount,
    required this.currency,
    required this.expenseDate,
    this.recipient,
    this.documentId,
    this.notes,
    required this.createdAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || caseId != null) {
      map['case_id'] = Variable<String>(caseId);
    }
    map['category'] = Variable<String>(category);
    map['amount'] = Variable<int>(amount);
    map['currency'] = Variable<String>(currency);
    map['expense_date'] = Variable<int>(expenseDate);
    if (!nullToAbsent || recipient != null) {
      map['recipient'] = Variable<String>(recipient);
    }
    if (!nullToAbsent || documentId != null) {
      map['document_id'] = Variable<String>(documentId);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<int>(createdAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      caseId: caseId == null && nullToAbsent
          ? const Value.absent()
          : Value(caseId),
      category: Value(category),
      amount: Value(amount),
      currency: Value(currency),
      expenseDate: Value(expenseDate),
      recipient: recipient == null && nullToAbsent
          ? const Value.absent()
          : Value(recipient),
      documentId: documentId == null && nullToAbsent
          ? const Value.absent()
          : Value(documentId),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Expense.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Expense(
      id: serializer.fromJson<String>(json['id']),
      caseId: serializer.fromJson<String?>(json['caseId']),
      category: serializer.fromJson<String>(json['category']),
      amount: serializer.fromJson<int>(json['amount']),
      currency: serializer.fromJson<String>(json['currency']),
      expenseDate: serializer.fromJson<int>(json['expenseDate']),
      recipient: serializer.fromJson<String?>(json['recipient']),
      documentId: serializer.fromJson<String?>(json['documentId']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'caseId': serializer.toJson<String?>(caseId),
      'category': serializer.toJson<String>(category),
      'amount': serializer.toJson<int>(amount),
      'currency': serializer.toJson<String>(currency),
      'expenseDate': serializer.toJson<int>(expenseDate),
      'recipient': serializer.toJson<String?>(recipient),
      'documentId': serializer.toJson<String?>(documentId),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<int>(createdAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  Expense copyWith({
    String? id,
    Value<String?> caseId = const Value.absent(),
    String? category,
    int? amount,
    String? currency,
    int? expenseDate,
    Value<String?> recipient = const Value.absent(),
    Value<String?> documentId = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    int? createdAt,
    Value<int?> deletedAt = const Value.absent(),
  }) => Expense(
    id: id ?? this.id,
    caseId: caseId.present ? caseId.value : this.caseId,
    category: category ?? this.category,
    amount: amount ?? this.amount,
    currency: currency ?? this.currency,
    expenseDate: expenseDate ?? this.expenseDate,
    recipient: recipient.present ? recipient.value : this.recipient,
    documentId: documentId.present ? documentId.value : this.documentId,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Expense copyWithCompanion(ExpensesCompanion data) {
    return Expense(
      id: data.id.present ? data.id.value : this.id,
      caseId: data.caseId.present ? data.caseId.value : this.caseId,
      category: data.category.present ? data.category.value : this.category,
      amount: data.amount.present ? data.amount.value : this.amount,
      currency: data.currency.present ? data.currency.value : this.currency,
      expenseDate: data.expenseDate.present
          ? data.expenseDate.value
          : this.expenseDate,
      recipient: data.recipient.present ? data.recipient.value : this.recipient,
      documentId: data.documentId.present
          ? data.documentId.value
          : this.documentId,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Expense(')
          ..write('id: $id, ')
          ..write('caseId: $caseId, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency, ')
          ..write('expenseDate: $expenseDate, ')
          ..write('recipient: $recipient, ')
          ..write('documentId: $documentId, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    caseId,
    category,
    amount,
    currency,
    expenseDate,
    recipient,
    documentId,
    notes,
    createdAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Expense &&
          other.id == this.id &&
          other.caseId == this.caseId &&
          other.category == this.category &&
          other.amount == this.amount &&
          other.currency == this.currency &&
          other.expenseDate == this.expenseDate &&
          other.recipient == this.recipient &&
          other.documentId == this.documentId &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.deletedAt == this.deletedAt);
}

class ExpensesCompanion extends UpdateCompanion<Expense> {
  final Value<String> id;
  final Value<String?> caseId;
  final Value<String> category;
  final Value<int> amount;
  final Value<String> currency;
  final Value<int> expenseDate;
  final Value<String?> recipient;
  final Value<String?> documentId;
  final Value<String?> notes;
  final Value<int> createdAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.caseId = const Value.absent(),
    this.category = const Value.absent(),
    this.amount = const Value.absent(),
    this.currency = const Value.absent(),
    this.expenseDate = const Value.absent(),
    this.recipient = const Value.absent(),
    this.documentId = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpensesCompanion.insert({
    required String id,
    this.caseId = const Value.absent(),
    required String category,
    required int amount,
    this.currency = const Value.absent(),
    required int expenseDate,
    this.recipient = const Value.absent(),
    this.documentId = const Value.absent(),
    this.notes = const Value.absent(),
    required int createdAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       category = Value(category),
       amount = Value(amount),
       expenseDate = Value(expenseDate),
       createdAt = Value(createdAt);
  static Insertable<Expense> custom({
    Expression<String>? id,
    Expression<String>? caseId,
    Expression<String>? category,
    Expression<int>? amount,
    Expression<String>? currency,
    Expression<int>? expenseDate,
    Expression<String>? recipient,
    Expression<String>? documentId,
    Expression<String>? notes,
    Expression<int>? createdAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (caseId != null) 'case_id': caseId,
      if (category != null) 'category': category,
      if (amount != null) 'amount': amount,
      if (currency != null) 'currency': currency,
      if (expenseDate != null) 'expense_date': expenseDate,
      if (recipient != null) 'recipient': recipient,
      if (documentId != null) 'document_id': documentId,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpensesCompanion copyWith({
    Value<String>? id,
    Value<String?>? caseId,
    Value<String>? category,
    Value<int>? amount,
    Value<String>? currency,
    Value<int>? expenseDate,
    Value<String?>? recipient,
    Value<String?>? documentId,
    Value<String?>? notes,
    Value<int>? createdAt,
    Value<int?>? deletedAt,
    Value<int>? rowid,
  }) {
    return ExpensesCompanion(
      id: id ?? this.id,
      caseId: caseId ?? this.caseId,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      expenseDate: expenseDate ?? this.expenseDate,
      recipient: recipient ?? this.recipient,
      documentId: documentId ?? this.documentId,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (caseId.present) {
      map['case_id'] = Variable<String>(caseId.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (expenseDate.present) {
      map['expense_date'] = Variable<int>(expenseDate.value);
    }
    if (recipient.present) {
      map['recipient'] = Variable<String>(recipient.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('caseId: $caseId, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency, ')
          ..write('expenseDate: $expenseDate, ')
          ..write('recipient: $recipient, ')
          ..write('documentId: $documentId, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ContractsTable extends Contracts
    with TableInfo<$ContractsTable, Contract> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContractsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clients (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _caseIdMeta = const VerificationMeta('caseId');
  @override
  late final GeneratedColumn<String> caseId = GeneratedColumn<String>(
    'case_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cases (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _documentNumberMeta = const VerificationMeta(
    'documentNumber',
  );
  @override
  late final GeneratedColumn<String> documentNumber = GeneratedColumn<String>(
    'document_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contractTypeMeta = const VerificationMeta(
    'contractType',
  );
  @override
  late final GeneratedColumn<String> contractType = GeneratedColumn<String>(
    'contract_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _issuingAuthorityMeta = const VerificationMeta(
    'issuingAuthority',
  );
  @override
  late final GeneratedColumn<String> issuingAuthority = GeneratedColumn<String>(
    'issuing_authority',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _issueDateMeta = const VerificationMeta(
    'issueDate',
  );
  @override
  late final GeneratedColumn<int> issueDate = GeneratedColumn<int>(
    'issue_date',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expiryDateMeta = const VerificationMeta(
    'expiryDate',
  );
  @override
  late final GeneratedColumn<int> expiryDate = GeneratedColumn<int>(
    'expiry_date',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('ACTIVE'),
  );
  static const VerificationMeta _documentIdMeta = const VerificationMeta(
    'documentId',
  );
  @override
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
    'document_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES documents (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clientId,
    caseId,
    documentNumber,
    contractType,
    issuingAuthority,
    issueDate,
    expiryDate,
    status,
    documentId,
    notes,
    createdAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contracts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Contract> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('case_id')) {
      context.handle(
        _caseIdMeta,
        caseId.isAcceptableOrUnknown(data['case_id']!, _caseIdMeta),
      );
    }
    if (data.containsKey('document_number')) {
      context.handle(
        _documentNumberMeta,
        documentNumber.isAcceptableOrUnknown(
          data['document_number']!,
          _documentNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_documentNumberMeta);
    }
    if (data.containsKey('contract_type')) {
      context.handle(
        _contractTypeMeta,
        contractType.isAcceptableOrUnknown(
          data['contract_type']!,
          _contractTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contractTypeMeta);
    }
    if (data.containsKey('issuing_authority')) {
      context.handle(
        _issuingAuthorityMeta,
        issuingAuthority.isAcceptableOrUnknown(
          data['issuing_authority']!,
          _issuingAuthorityMeta,
        ),
      );
    }
    if (data.containsKey('issue_date')) {
      context.handle(
        _issueDateMeta,
        issueDate.isAcceptableOrUnknown(data['issue_date']!, _issueDateMeta),
      );
    } else if (isInserting) {
      context.missing(_issueDateMeta);
    }
    if (data.containsKey('expiry_date')) {
      context.handle(
        _expiryDateMeta,
        expiryDate.isAcceptableOrUnknown(data['expiry_date']!, _expiryDateMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('document_id')) {
      context.handle(
        _documentIdMeta,
        documentId.isAcceptableOrUnknown(data['document_id']!, _documentIdMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Contract map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Contract(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_id'],
      )!,
      caseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}case_id'],
      ),
      documentNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_number'],
      )!,
      contractType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contract_type'],
      )!,
      issuingAuthority: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}issuing_authority'],
      ),
      issueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}issue_date'],
      )!,
      expiryDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}expiry_date'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      documentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_id'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $ContractsTable createAlias(String alias) {
    return $ContractsTable(attachedDatabase, alias);
  }
}

class Contract extends DataClass implements Insertable<Contract> {
  final String id;
  final String clientId;
  final String? caseId;
  final String documentNumber;
  final String contractType;
  final String? issuingAuthority;
  final int issueDate;
  final int? expiryDate;
  final String status;
  final String? documentId;
  final String? notes;
  final int createdAt;
  final int? deletedAt;
  const Contract({
    required this.id,
    required this.clientId,
    this.caseId,
    required this.documentNumber,
    required this.contractType,
    this.issuingAuthority,
    required this.issueDate,
    this.expiryDate,
    required this.status,
    this.documentId,
    this.notes,
    required this.createdAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['client_id'] = Variable<String>(clientId);
    if (!nullToAbsent || caseId != null) {
      map['case_id'] = Variable<String>(caseId);
    }
    map['document_number'] = Variable<String>(documentNumber);
    map['contract_type'] = Variable<String>(contractType);
    if (!nullToAbsent || issuingAuthority != null) {
      map['issuing_authority'] = Variable<String>(issuingAuthority);
    }
    map['issue_date'] = Variable<int>(issueDate);
    if (!nullToAbsent || expiryDate != null) {
      map['expiry_date'] = Variable<int>(expiryDate);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || documentId != null) {
      map['document_id'] = Variable<String>(documentId);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<int>(createdAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  ContractsCompanion toCompanion(bool nullToAbsent) {
    return ContractsCompanion(
      id: Value(id),
      clientId: Value(clientId),
      caseId: caseId == null && nullToAbsent
          ? const Value.absent()
          : Value(caseId),
      documentNumber: Value(documentNumber),
      contractType: Value(contractType),
      issuingAuthority: issuingAuthority == null && nullToAbsent
          ? const Value.absent()
          : Value(issuingAuthority),
      issueDate: Value(issueDate),
      expiryDate: expiryDate == null && nullToAbsent
          ? const Value.absent()
          : Value(expiryDate),
      status: Value(status),
      documentId: documentId == null && nullToAbsent
          ? const Value.absent()
          : Value(documentId),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Contract.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Contract(
      id: serializer.fromJson<String>(json['id']),
      clientId: serializer.fromJson<String>(json['clientId']),
      caseId: serializer.fromJson<String?>(json['caseId']),
      documentNumber: serializer.fromJson<String>(json['documentNumber']),
      contractType: serializer.fromJson<String>(json['contractType']),
      issuingAuthority: serializer.fromJson<String?>(json['issuingAuthority']),
      issueDate: serializer.fromJson<int>(json['issueDate']),
      expiryDate: serializer.fromJson<int?>(json['expiryDate']),
      status: serializer.fromJson<String>(json['status']),
      documentId: serializer.fromJson<String?>(json['documentId']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'clientId': serializer.toJson<String>(clientId),
      'caseId': serializer.toJson<String?>(caseId),
      'documentNumber': serializer.toJson<String>(documentNumber),
      'contractType': serializer.toJson<String>(contractType),
      'issuingAuthority': serializer.toJson<String?>(issuingAuthority),
      'issueDate': serializer.toJson<int>(issueDate),
      'expiryDate': serializer.toJson<int?>(expiryDate),
      'status': serializer.toJson<String>(status),
      'documentId': serializer.toJson<String?>(documentId),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<int>(createdAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  Contract copyWith({
    String? id,
    String? clientId,
    Value<String?> caseId = const Value.absent(),
    String? documentNumber,
    String? contractType,
    Value<String?> issuingAuthority = const Value.absent(),
    int? issueDate,
    Value<int?> expiryDate = const Value.absent(),
    String? status,
    Value<String?> documentId = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    int? createdAt,
    Value<int?> deletedAt = const Value.absent(),
  }) => Contract(
    id: id ?? this.id,
    clientId: clientId ?? this.clientId,
    caseId: caseId.present ? caseId.value : this.caseId,
    documentNumber: documentNumber ?? this.documentNumber,
    contractType: contractType ?? this.contractType,
    issuingAuthority: issuingAuthority.present
        ? issuingAuthority.value
        : this.issuingAuthority,
    issueDate: issueDate ?? this.issueDate,
    expiryDate: expiryDate.present ? expiryDate.value : this.expiryDate,
    status: status ?? this.status,
    documentId: documentId.present ? documentId.value : this.documentId,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Contract copyWithCompanion(ContractsCompanion data) {
    return Contract(
      id: data.id.present ? data.id.value : this.id,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      caseId: data.caseId.present ? data.caseId.value : this.caseId,
      documentNumber: data.documentNumber.present
          ? data.documentNumber.value
          : this.documentNumber,
      contractType: data.contractType.present
          ? data.contractType.value
          : this.contractType,
      issuingAuthority: data.issuingAuthority.present
          ? data.issuingAuthority.value
          : this.issuingAuthority,
      issueDate: data.issueDate.present ? data.issueDate.value : this.issueDate,
      expiryDate: data.expiryDate.present
          ? data.expiryDate.value
          : this.expiryDate,
      status: data.status.present ? data.status.value : this.status,
      documentId: data.documentId.present
          ? data.documentId.value
          : this.documentId,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Contract(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('caseId: $caseId, ')
          ..write('documentNumber: $documentNumber, ')
          ..write('contractType: $contractType, ')
          ..write('issuingAuthority: $issuingAuthority, ')
          ..write('issueDate: $issueDate, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('status: $status, ')
          ..write('documentId: $documentId, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    clientId,
    caseId,
    documentNumber,
    contractType,
    issuingAuthority,
    issueDate,
    expiryDate,
    status,
    documentId,
    notes,
    createdAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Contract &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.caseId == this.caseId &&
          other.documentNumber == this.documentNumber &&
          other.contractType == this.contractType &&
          other.issuingAuthority == this.issuingAuthority &&
          other.issueDate == this.issueDate &&
          other.expiryDate == this.expiryDate &&
          other.status == this.status &&
          other.documentId == this.documentId &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.deletedAt == this.deletedAt);
}

class ContractsCompanion extends UpdateCompanion<Contract> {
  final Value<String> id;
  final Value<String> clientId;
  final Value<String?> caseId;
  final Value<String> documentNumber;
  final Value<String> contractType;
  final Value<String?> issuingAuthority;
  final Value<int> issueDate;
  final Value<int?> expiryDate;
  final Value<String> status;
  final Value<String?> documentId;
  final Value<String?> notes;
  final Value<int> createdAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const ContractsCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.caseId = const Value.absent(),
    this.documentNumber = const Value.absent(),
    this.contractType = const Value.absent(),
    this.issuingAuthority = const Value.absent(),
    this.issueDate = const Value.absent(),
    this.expiryDate = const Value.absent(),
    this.status = const Value.absent(),
    this.documentId = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ContractsCompanion.insert({
    required String id,
    required String clientId,
    this.caseId = const Value.absent(),
    required String documentNumber,
    required String contractType,
    this.issuingAuthority = const Value.absent(),
    required int issueDate,
    this.expiryDate = const Value.absent(),
    this.status = const Value.absent(),
    this.documentId = const Value.absent(),
    this.notes = const Value.absent(),
    required int createdAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       clientId = Value(clientId),
       documentNumber = Value(documentNumber),
       contractType = Value(contractType),
       issueDate = Value(issueDate),
       createdAt = Value(createdAt);
  static Insertable<Contract> custom({
    Expression<String>? id,
    Expression<String>? clientId,
    Expression<String>? caseId,
    Expression<String>? documentNumber,
    Expression<String>? contractType,
    Expression<String>? issuingAuthority,
    Expression<int>? issueDate,
    Expression<int>? expiryDate,
    Expression<String>? status,
    Expression<String>? documentId,
    Expression<String>? notes,
    Expression<int>? createdAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (caseId != null) 'case_id': caseId,
      if (documentNumber != null) 'document_number': documentNumber,
      if (contractType != null) 'contract_type': contractType,
      if (issuingAuthority != null) 'issuing_authority': issuingAuthority,
      if (issueDate != null) 'issue_date': issueDate,
      if (expiryDate != null) 'expiry_date': expiryDate,
      if (status != null) 'status': status,
      if (documentId != null) 'document_id': documentId,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ContractsCompanion copyWith({
    Value<String>? id,
    Value<String>? clientId,
    Value<String?>? caseId,
    Value<String>? documentNumber,
    Value<String>? contractType,
    Value<String?>? issuingAuthority,
    Value<int>? issueDate,
    Value<int?>? expiryDate,
    Value<String>? status,
    Value<String?>? documentId,
    Value<String?>? notes,
    Value<int>? createdAt,
    Value<int?>? deletedAt,
    Value<int>? rowid,
  }) {
    return ContractsCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      caseId: caseId ?? this.caseId,
      documentNumber: documentNumber ?? this.documentNumber,
      contractType: contractType ?? this.contractType,
      issuingAuthority: issuingAuthority ?? this.issuingAuthority,
      issueDate: issueDate ?? this.issueDate,
      expiryDate: expiryDate ?? this.expiryDate,
      status: status ?? this.status,
      documentId: documentId ?? this.documentId,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (caseId.present) {
      map['case_id'] = Variable<String>(caseId.value);
    }
    if (documentNumber.present) {
      map['document_number'] = Variable<String>(documentNumber.value);
    }
    if (contractType.present) {
      map['contract_type'] = Variable<String>(contractType.value);
    }
    if (issuingAuthority.present) {
      map['issuing_authority'] = Variable<String>(issuingAuthority.value);
    }
    if (issueDate.present) {
      map['issue_date'] = Variable<int>(issueDate.value);
    }
    if (expiryDate.present) {
      map['expiry_date'] = Variable<int>(expiryDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContractsCompanion(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('caseId: $caseId, ')
          ..write('documentNumber: $documentNumber, ')
          ..write('contractType: $contractType, ')
          ..write('issuingAuthority: $issuingAuthority, ')
          ..write('issueDate: $issueDate, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('status: $status, ')
          ..write('documentId: $documentId, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CommunicationsTable extends Communications
    with TableInfo<$CommunicationsTable, Communication> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CommunicationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
    'client_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clients (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _caseIdMeta = const VerificationMeta('caseId');
  @override
  late final GeneratedColumn<String> caseId = GeneratedColumn<String>(
    'case_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cases (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _contactIdMeta = const VerificationMeta(
    'contactId',
  );
  @override
  late final GeneratedColumn<String> contactId = GeneratedColumn<String>(
    'contact_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES contacts (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _communicationTypeMeta = const VerificationMeta(
    'communicationType',
  );
  @override
  late final GeneratedColumn<String> communicationType =
      GeneratedColumn<String>(
        'communication_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _communicationDateMeta = const VerificationMeta(
    'communicationDate',
  );
  @override
  late final GeneratedColumn<int> communicationDate = GeneratedColumn<int>(
    'communication_date',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _summaryMeta = const VerificationMeta(
    'summary',
  );
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
    'summary',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _resultMeta = const VerificationMeta('result');
  @override
  late final GeneratedColumn<String> result = GeneratedColumn<String>(
    'result',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clientId,
    caseId,
    contactId,
    communicationType,
    communicationDate,
    summary,
    result,
    createdAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'communications';
  @override
  VerificationContext validateIntegrity(
    Insertable<Communication> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    }
    if (data.containsKey('case_id')) {
      context.handle(
        _caseIdMeta,
        caseId.isAcceptableOrUnknown(data['case_id']!, _caseIdMeta),
      );
    }
    if (data.containsKey('contact_id')) {
      context.handle(
        _contactIdMeta,
        contactId.isAcceptableOrUnknown(data['contact_id']!, _contactIdMeta),
      );
    }
    if (data.containsKey('communication_type')) {
      context.handle(
        _communicationTypeMeta,
        communicationType.isAcceptableOrUnknown(
          data['communication_type']!,
          _communicationTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_communicationTypeMeta);
    }
    if (data.containsKey('communication_date')) {
      context.handle(
        _communicationDateMeta,
        communicationDate.isAcceptableOrUnknown(
          data['communication_date']!,
          _communicationDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_communicationDateMeta);
    }
    if (data.containsKey('summary')) {
      context.handle(
        _summaryMeta,
        summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta),
      );
    } else if (isInserting) {
      context.missing(_summaryMeta);
    }
    if (data.containsKey('result')) {
      context.handle(
        _resultMeta,
        result.isAcceptableOrUnknown(data['result']!, _resultMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Communication map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Communication(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_id'],
      ),
      caseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}case_id'],
      ),
      contactId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_id'],
      ),
      communicationType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}communication_type'],
      )!,
      communicationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}communication_date'],
      )!,
      summary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}summary'],
      )!,
      result: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}result'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $CommunicationsTable createAlias(String alias) {
    return $CommunicationsTable(attachedDatabase, alias);
  }
}

class Communication extends DataClass implements Insertable<Communication> {
  final String id;
  final String? clientId;
  final String? caseId;
  final String? contactId;
  final String communicationType;
  final int communicationDate;
  final String summary;
  final String? result;
  final int createdAt;
  final int? deletedAt;
  const Communication({
    required this.id,
    this.clientId,
    this.caseId,
    this.contactId,
    required this.communicationType,
    required this.communicationDate,
    required this.summary,
    this.result,
    required this.createdAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || clientId != null) {
      map['client_id'] = Variable<String>(clientId);
    }
    if (!nullToAbsent || caseId != null) {
      map['case_id'] = Variable<String>(caseId);
    }
    if (!nullToAbsent || contactId != null) {
      map['contact_id'] = Variable<String>(contactId);
    }
    map['communication_type'] = Variable<String>(communicationType);
    map['communication_date'] = Variable<int>(communicationDate);
    map['summary'] = Variable<String>(summary);
    if (!nullToAbsent || result != null) {
      map['result'] = Variable<String>(result);
    }
    map['created_at'] = Variable<int>(createdAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  CommunicationsCompanion toCompanion(bool nullToAbsent) {
    return CommunicationsCompanion(
      id: Value(id),
      clientId: clientId == null && nullToAbsent
          ? const Value.absent()
          : Value(clientId),
      caseId: caseId == null && nullToAbsent
          ? const Value.absent()
          : Value(caseId),
      contactId: contactId == null && nullToAbsent
          ? const Value.absent()
          : Value(contactId),
      communicationType: Value(communicationType),
      communicationDate: Value(communicationDate),
      summary: Value(summary),
      result: result == null && nullToAbsent
          ? const Value.absent()
          : Value(result),
      createdAt: Value(createdAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Communication.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Communication(
      id: serializer.fromJson<String>(json['id']),
      clientId: serializer.fromJson<String?>(json['clientId']),
      caseId: serializer.fromJson<String?>(json['caseId']),
      contactId: serializer.fromJson<String?>(json['contactId']),
      communicationType: serializer.fromJson<String>(json['communicationType']),
      communicationDate: serializer.fromJson<int>(json['communicationDate']),
      summary: serializer.fromJson<String>(json['summary']),
      result: serializer.fromJson<String?>(json['result']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'clientId': serializer.toJson<String?>(clientId),
      'caseId': serializer.toJson<String?>(caseId),
      'contactId': serializer.toJson<String?>(contactId),
      'communicationType': serializer.toJson<String>(communicationType),
      'communicationDate': serializer.toJson<int>(communicationDate),
      'summary': serializer.toJson<String>(summary),
      'result': serializer.toJson<String?>(result),
      'createdAt': serializer.toJson<int>(createdAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  Communication copyWith({
    String? id,
    Value<String?> clientId = const Value.absent(),
    Value<String?> caseId = const Value.absent(),
    Value<String?> contactId = const Value.absent(),
    String? communicationType,
    int? communicationDate,
    String? summary,
    Value<String?> result = const Value.absent(),
    int? createdAt,
    Value<int?> deletedAt = const Value.absent(),
  }) => Communication(
    id: id ?? this.id,
    clientId: clientId.present ? clientId.value : this.clientId,
    caseId: caseId.present ? caseId.value : this.caseId,
    contactId: contactId.present ? contactId.value : this.contactId,
    communicationType: communicationType ?? this.communicationType,
    communicationDate: communicationDate ?? this.communicationDate,
    summary: summary ?? this.summary,
    result: result.present ? result.value : this.result,
    createdAt: createdAt ?? this.createdAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Communication copyWithCompanion(CommunicationsCompanion data) {
    return Communication(
      id: data.id.present ? data.id.value : this.id,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      caseId: data.caseId.present ? data.caseId.value : this.caseId,
      contactId: data.contactId.present ? data.contactId.value : this.contactId,
      communicationType: data.communicationType.present
          ? data.communicationType.value
          : this.communicationType,
      communicationDate: data.communicationDate.present
          ? data.communicationDate.value
          : this.communicationDate,
      summary: data.summary.present ? data.summary.value : this.summary,
      result: data.result.present ? data.result.value : this.result,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Communication(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('caseId: $caseId, ')
          ..write('contactId: $contactId, ')
          ..write('communicationType: $communicationType, ')
          ..write('communicationDate: $communicationDate, ')
          ..write('summary: $summary, ')
          ..write('result: $result, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    clientId,
    caseId,
    contactId,
    communicationType,
    communicationDate,
    summary,
    result,
    createdAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Communication &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.caseId == this.caseId &&
          other.contactId == this.contactId &&
          other.communicationType == this.communicationType &&
          other.communicationDate == this.communicationDate &&
          other.summary == this.summary &&
          other.result == this.result &&
          other.createdAt == this.createdAt &&
          other.deletedAt == this.deletedAt);
}

class CommunicationsCompanion extends UpdateCompanion<Communication> {
  final Value<String> id;
  final Value<String?> clientId;
  final Value<String?> caseId;
  final Value<String?> contactId;
  final Value<String> communicationType;
  final Value<int> communicationDate;
  final Value<String> summary;
  final Value<String?> result;
  final Value<int> createdAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const CommunicationsCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.caseId = const Value.absent(),
    this.contactId = const Value.absent(),
    this.communicationType = const Value.absent(),
    this.communicationDate = const Value.absent(),
    this.summary = const Value.absent(),
    this.result = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CommunicationsCompanion.insert({
    required String id,
    this.clientId = const Value.absent(),
    this.caseId = const Value.absent(),
    this.contactId = const Value.absent(),
    required String communicationType,
    required int communicationDate,
    required String summary,
    this.result = const Value.absent(),
    required int createdAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       communicationType = Value(communicationType),
       communicationDate = Value(communicationDate),
       summary = Value(summary),
       createdAt = Value(createdAt);
  static Insertable<Communication> custom({
    Expression<String>? id,
    Expression<String>? clientId,
    Expression<String>? caseId,
    Expression<String>? contactId,
    Expression<String>? communicationType,
    Expression<int>? communicationDate,
    Expression<String>? summary,
    Expression<String>? result,
    Expression<int>? createdAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (caseId != null) 'case_id': caseId,
      if (contactId != null) 'contact_id': contactId,
      if (communicationType != null) 'communication_type': communicationType,
      if (communicationDate != null) 'communication_date': communicationDate,
      if (summary != null) 'summary': summary,
      if (result != null) 'result': result,
      if (createdAt != null) 'created_at': createdAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CommunicationsCompanion copyWith({
    Value<String>? id,
    Value<String?>? clientId,
    Value<String?>? caseId,
    Value<String?>? contactId,
    Value<String>? communicationType,
    Value<int>? communicationDate,
    Value<String>? summary,
    Value<String?>? result,
    Value<int>? createdAt,
    Value<int?>? deletedAt,
    Value<int>? rowid,
  }) {
    return CommunicationsCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      caseId: caseId ?? this.caseId,
      contactId: contactId ?? this.contactId,
      communicationType: communicationType ?? this.communicationType,
      communicationDate: communicationDate ?? this.communicationDate,
      summary: summary ?? this.summary,
      result: result ?? this.result,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (caseId.present) {
      map['case_id'] = Variable<String>(caseId.value);
    }
    if (contactId.present) {
      map['contact_id'] = Variable<String>(contactId.value);
    }
    if (communicationType.present) {
      map['communication_type'] = Variable<String>(communicationType.value);
    }
    if (communicationDate.present) {
      map['communication_date'] = Variable<int>(communicationDate.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (result.present) {
      map['result'] = Variable<String>(result.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CommunicationsCompanion(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('caseId: $caseId, ')
          ..write('contactId: $contactId, ')
          ..write('communicationType: $communicationType, ')
          ..write('communicationDate: $communicationDate, ')
          ..write('summary: $summary, ')
          ..write('result: $result, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LegalReferencesTable extends LegalReferences
    with TableInfo<$LegalReferencesTable, LegalReference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LegalReferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceTypeMeta = const VerificationMeta(
    'referenceType',
  );
  @override
  late final GeneratedColumn<String> referenceType = GeneratedColumn<String>(
    'reference_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lawNumberMeta = const VerificationMeta(
    'lawNumber',
  );
  @override
  late final GeneratedColumn<String> lawNumber = GeneratedColumn<String>(
    'law_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
    'year',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _issuingAuthorityMeta = const VerificationMeta(
    'issuingAuthority',
  );
  @override
  late final GeneratedColumn<String> issuingAuthority = GeneratedColumn<String>(
    'issuing_authority',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fullTextMeta = const VerificationMeta(
    'fullText',
  );
  @override
  late final GeneratedColumn<String> fullText = GeneratedColumn<String>(
    'full_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isVerifiedMeta = const VerificationMeta(
    'isVerified',
  );
  @override
  late final GeneratedColumn<int> isVerified = GeneratedColumn<int>(
    'is_verified',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    referenceType,
    lawNumber,
    year,
    issuingAuthority,
    category,
    fullText,
    source,
    isVerified,
    createdAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'legal_references';
  @override
  VerificationContext validateIntegrity(
    Insertable<LegalReference> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('reference_type')) {
      context.handle(
        _referenceTypeMeta,
        referenceType.isAcceptableOrUnknown(
          data['reference_type']!,
          _referenceTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_referenceTypeMeta);
    }
    if (data.containsKey('law_number')) {
      context.handle(
        _lawNumberMeta,
        lawNumber.isAcceptableOrUnknown(data['law_number']!, _lawNumberMeta),
      );
    }
    if (data.containsKey('year')) {
      context.handle(
        _yearMeta,
        year.isAcceptableOrUnknown(data['year']!, _yearMeta),
      );
    }
    if (data.containsKey('issuing_authority')) {
      context.handle(
        _issuingAuthorityMeta,
        issuingAuthority.isAcceptableOrUnknown(
          data['issuing_authority']!,
          _issuingAuthorityMeta,
        ),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('full_text')) {
      context.handle(
        _fullTextMeta,
        fullText.isAcceptableOrUnknown(data['full_text']!, _fullTextMeta),
      );
    } else if (isInserting) {
      context.missing(_fullTextMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('is_verified')) {
      context.handle(
        _isVerifiedMeta,
        isVerified.isAcceptableOrUnknown(data['is_verified']!, _isVerifiedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LegalReference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LegalReference(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      referenceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_type'],
      )!,
      lawNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}law_number'],
      ),
      year: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}year'],
      ),
      issuingAuthority: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}issuing_authority'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      fullText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_text'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      ),
      isVerified: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_verified'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $LegalReferencesTable createAlias(String alias) {
    return $LegalReferencesTable(attachedDatabase, alias);
  }
}

class LegalReference extends DataClass implements Insertable<LegalReference> {
  final String id;
  final String title;
  final String referenceType;
  final String? lawNumber;
  final int? year;
  final String? issuingAuthority;
  final String category;
  final String fullText;
  final String? source;
  final int isVerified;
  final int createdAt;
  final int? deletedAt;
  const LegalReference({
    required this.id,
    required this.title,
    required this.referenceType,
    this.lawNumber,
    this.year,
    this.issuingAuthority,
    required this.category,
    required this.fullText,
    this.source,
    required this.isVerified,
    required this.createdAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['reference_type'] = Variable<String>(referenceType);
    if (!nullToAbsent || lawNumber != null) {
      map['law_number'] = Variable<String>(lawNumber);
    }
    if (!nullToAbsent || year != null) {
      map['year'] = Variable<int>(year);
    }
    if (!nullToAbsent || issuingAuthority != null) {
      map['issuing_authority'] = Variable<String>(issuingAuthority);
    }
    map['category'] = Variable<String>(category);
    map['full_text'] = Variable<String>(fullText);
    if (!nullToAbsent || source != null) {
      map['source'] = Variable<String>(source);
    }
    map['is_verified'] = Variable<int>(isVerified);
    map['created_at'] = Variable<int>(createdAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  LegalReferencesCompanion toCompanion(bool nullToAbsent) {
    return LegalReferencesCompanion(
      id: Value(id),
      title: Value(title),
      referenceType: Value(referenceType),
      lawNumber: lawNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(lawNumber),
      year: year == null && nullToAbsent ? const Value.absent() : Value(year),
      issuingAuthority: issuingAuthority == null && nullToAbsent
          ? const Value.absent()
          : Value(issuingAuthority),
      category: Value(category),
      fullText: Value(fullText),
      source: source == null && nullToAbsent
          ? const Value.absent()
          : Value(source),
      isVerified: Value(isVerified),
      createdAt: Value(createdAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory LegalReference.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LegalReference(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      referenceType: serializer.fromJson<String>(json['referenceType']),
      lawNumber: serializer.fromJson<String?>(json['lawNumber']),
      year: serializer.fromJson<int?>(json['year']),
      issuingAuthority: serializer.fromJson<String?>(json['issuingAuthority']),
      category: serializer.fromJson<String>(json['category']),
      fullText: serializer.fromJson<String>(json['fullText']),
      source: serializer.fromJson<String?>(json['source']),
      isVerified: serializer.fromJson<int>(json['isVerified']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'referenceType': serializer.toJson<String>(referenceType),
      'lawNumber': serializer.toJson<String?>(lawNumber),
      'year': serializer.toJson<int?>(year),
      'issuingAuthority': serializer.toJson<String?>(issuingAuthority),
      'category': serializer.toJson<String>(category),
      'fullText': serializer.toJson<String>(fullText),
      'source': serializer.toJson<String?>(source),
      'isVerified': serializer.toJson<int>(isVerified),
      'createdAt': serializer.toJson<int>(createdAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  LegalReference copyWith({
    String? id,
    String? title,
    String? referenceType,
    Value<String?> lawNumber = const Value.absent(),
    Value<int?> year = const Value.absent(),
    Value<String?> issuingAuthority = const Value.absent(),
    String? category,
    String? fullText,
    Value<String?> source = const Value.absent(),
    int? isVerified,
    int? createdAt,
    Value<int?> deletedAt = const Value.absent(),
  }) => LegalReference(
    id: id ?? this.id,
    title: title ?? this.title,
    referenceType: referenceType ?? this.referenceType,
    lawNumber: lawNumber.present ? lawNumber.value : this.lawNumber,
    year: year.present ? year.value : this.year,
    issuingAuthority: issuingAuthority.present
        ? issuingAuthority.value
        : this.issuingAuthority,
    category: category ?? this.category,
    fullText: fullText ?? this.fullText,
    source: source.present ? source.value : this.source,
    isVerified: isVerified ?? this.isVerified,
    createdAt: createdAt ?? this.createdAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  LegalReference copyWithCompanion(LegalReferencesCompanion data) {
    return LegalReference(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      referenceType: data.referenceType.present
          ? data.referenceType.value
          : this.referenceType,
      lawNumber: data.lawNumber.present ? data.lawNumber.value : this.lawNumber,
      year: data.year.present ? data.year.value : this.year,
      issuingAuthority: data.issuingAuthority.present
          ? data.issuingAuthority.value
          : this.issuingAuthority,
      category: data.category.present ? data.category.value : this.category,
      fullText: data.fullText.present ? data.fullText.value : this.fullText,
      source: data.source.present ? data.source.value : this.source,
      isVerified: data.isVerified.present
          ? data.isVerified.value
          : this.isVerified,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LegalReference(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('referenceType: $referenceType, ')
          ..write('lawNumber: $lawNumber, ')
          ..write('year: $year, ')
          ..write('issuingAuthority: $issuingAuthority, ')
          ..write('category: $category, ')
          ..write('fullText: $fullText, ')
          ..write('source: $source, ')
          ..write('isVerified: $isVerified, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    referenceType,
    lawNumber,
    year,
    issuingAuthority,
    category,
    fullText,
    source,
    isVerified,
    createdAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LegalReference &&
          other.id == this.id &&
          other.title == this.title &&
          other.referenceType == this.referenceType &&
          other.lawNumber == this.lawNumber &&
          other.year == this.year &&
          other.issuingAuthority == this.issuingAuthority &&
          other.category == this.category &&
          other.fullText == this.fullText &&
          other.source == this.source &&
          other.isVerified == this.isVerified &&
          other.createdAt == this.createdAt &&
          other.deletedAt == this.deletedAt);
}

class LegalReferencesCompanion extends UpdateCompanion<LegalReference> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> referenceType;
  final Value<String?> lawNumber;
  final Value<int?> year;
  final Value<String?> issuingAuthority;
  final Value<String> category;
  final Value<String> fullText;
  final Value<String?> source;
  final Value<int> isVerified;
  final Value<int> createdAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const LegalReferencesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.referenceType = const Value.absent(),
    this.lawNumber = const Value.absent(),
    this.year = const Value.absent(),
    this.issuingAuthority = const Value.absent(),
    this.category = const Value.absent(),
    this.fullText = const Value.absent(),
    this.source = const Value.absent(),
    this.isVerified = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LegalReferencesCompanion.insert({
    required String id,
    required String title,
    required String referenceType,
    this.lawNumber = const Value.absent(),
    this.year = const Value.absent(),
    this.issuingAuthority = const Value.absent(),
    required String category,
    required String fullText,
    this.source = const Value.absent(),
    this.isVerified = const Value.absent(),
    required int createdAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       referenceType = Value(referenceType),
       category = Value(category),
       fullText = Value(fullText),
       createdAt = Value(createdAt);
  static Insertable<LegalReference> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? referenceType,
    Expression<String>? lawNumber,
    Expression<int>? year,
    Expression<String>? issuingAuthority,
    Expression<String>? category,
    Expression<String>? fullText,
    Expression<String>? source,
    Expression<int>? isVerified,
    Expression<int>? createdAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (referenceType != null) 'reference_type': referenceType,
      if (lawNumber != null) 'law_number': lawNumber,
      if (year != null) 'year': year,
      if (issuingAuthority != null) 'issuing_authority': issuingAuthority,
      if (category != null) 'category': category,
      if (fullText != null) 'full_text': fullText,
      if (source != null) 'source': source,
      if (isVerified != null) 'is_verified': isVerified,
      if (createdAt != null) 'created_at': createdAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LegalReferencesCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? referenceType,
    Value<String?>? lawNumber,
    Value<int?>? year,
    Value<String?>? issuingAuthority,
    Value<String>? category,
    Value<String>? fullText,
    Value<String?>? source,
    Value<int>? isVerified,
    Value<int>? createdAt,
    Value<int?>? deletedAt,
    Value<int>? rowid,
  }) {
    return LegalReferencesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      referenceType: referenceType ?? this.referenceType,
      lawNumber: lawNumber ?? this.lawNumber,
      year: year ?? this.year,
      issuingAuthority: issuingAuthority ?? this.issuingAuthority,
      category: category ?? this.category,
      fullText: fullText ?? this.fullText,
      source: source ?? this.source,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (referenceType.present) {
      map['reference_type'] = Variable<String>(referenceType.value);
    }
    if (lawNumber.present) {
      map['law_number'] = Variable<String>(lawNumber.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (issuingAuthority.present) {
      map['issuing_authority'] = Variable<String>(issuingAuthority.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (fullText.present) {
      map['full_text'] = Variable<String>(fullText.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (isVerified.present) {
      map['is_verified'] = Variable<int>(isVerified.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LegalReferencesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('referenceType: $referenceType, ')
          ..write('lawNumber: $lawNumber, ')
          ..write('year: $year, ')
          ..write('issuingAuthority: $issuingAuthority, ')
          ..write('category: $category, ')
          ..write('fullText: $fullText, ')
          ..write('source: $source, ')
          ..write('isVerified: $isVerified, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AuditLogsTable extends AuditLogs
    with TableInfo<$AuditLogsTable, AuditLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuditLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<int> timestamp = GeneratedColumn<int>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
    'action',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _detailsMeta = const VerificationMeta(
    'details',
  );
  @override
  late final GeneratedColumn<String> details = GeneratedColumn<String>(
    'details',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ipOrDeviceMeta = const VerificationMeta(
    'ipOrDevice',
  );
  @override
  late final GeneratedColumn<String> ipOrDevice = GeneratedColumn<String>(
    'ip_or_device',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('LOCAL_DEVICE'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    timestamp,
    action,
    entityType,
    entityId,
    details,
    ipOrDevice,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audit_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<AuditLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('action')) {
      context.handle(
        _actionMeta,
        action.isAcceptableOrUnknown(data['action']!, _actionMeta),
      );
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    }
    if (data.containsKey('details')) {
      context.handle(
        _detailsMeta,
        details.isAcceptableOrUnknown(data['details']!, _detailsMeta),
      );
    } else if (isInserting) {
      context.missing(_detailsMeta);
    }
    if (data.containsKey('ip_or_device')) {
      context.handle(
        _ipOrDeviceMeta,
        ipOrDevice.isAcceptableOrUnknown(
          data['ip_or_device']!,
          _ipOrDeviceMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AuditLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuditLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timestamp'],
      )!,
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      ),
      details: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}details'],
      )!,
      ipOrDevice: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ip_or_device'],
      )!,
    );
  }

  @override
  $AuditLogsTable createAlias(String alias) {
    return $AuditLogsTable(attachedDatabase, alias);
  }
}

class AuditLog extends DataClass implements Insertable<AuditLog> {
  final String id;
  final int timestamp;
  final String action;
  final String entityType;
  final String? entityId;
  final String details;
  final String ipOrDevice;
  const AuditLog({
    required this.id,
    required this.timestamp,
    required this.action,
    required this.entityType,
    this.entityId,
    required this.details,
    required this.ipOrDevice,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['timestamp'] = Variable<int>(timestamp);
    map['action'] = Variable<String>(action);
    map['entity_type'] = Variable<String>(entityType);
    if (!nullToAbsent || entityId != null) {
      map['entity_id'] = Variable<String>(entityId);
    }
    map['details'] = Variable<String>(details);
    map['ip_or_device'] = Variable<String>(ipOrDevice);
    return map;
  }

  AuditLogsCompanion toCompanion(bool nullToAbsent) {
    return AuditLogsCompanion(
      id: Value(id),
      timestamp: Value(timestamp),
      action: Value(action),
      entityType: Value(entityType),
      entityId: entityId == null && nullToAbsent
          ? const Value.absent()
          : Value(entityId),
      details: Value(details),
      ipOrDevice: Value(ipOrDevice),
    );
  }

  factory AuditLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuditLog(
      id: serializer.fromJson<String>(json['id']),
      timestamp: serializer.fromJson<int>(json['timestamp']),
      action: serializer.fromJson<String>(json['action']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String?>(json['entityId']),
      details: serializer.fromJson<String>(json['details']),
      ipOrDevice: serializer.fromJson<String>(json['ipOrDevice']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'timestamp': serializer.toJson<int>(timestamp),
      'action': serializer.toJson<String>(action),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String?>(entityId),
      'details': serializer.toJson<String>(details),
      'ipOrDevice': serializer.toJson<String>(ipOrDevice),
    };
  }

  AuditLog copyWith({
    String? id,
    int? timestamp,
    String? action,
    String? entityType,
    Value<String?> entityId = const Value.absent(),
    String? details,
    String? ipOrDevice,
  }) => AuditLog(
    id: id ?? this.id,
    timestamp: timestamp ?? this.timestamp,
    action: action ?? this.action,
    entityType: entityType ?? this.entityType,
    entityId: entityId.present ? entityId.value : this.entityId,
    details: details ?? this.details,
    ipOrDevice: ipOrDevice ?? this.ipOrDevice,
  );
  AuditLog copyWithCompanion(AuditLogsCompanion data) {
    return AuditLog(
      id: data.id.present ? data.id.value : this.id,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      action: data.action.present ? data.action.value : this.action,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      details: data.details.present ? data.details.value : this.details,
      ipOrDevice: data.ipOrDevice.present
          ? data.ipOrDevice.value
          : this.ipOrDevice,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuditLog(')
          ..write('id: $id, ')
          ..write('timestamp: $timestamp, ')
          ..write('action: $action, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('details: $details, ')
          ..write('ipOrDevice: $ipOrDevice')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    timestamp,
    action,
    entityType,
    entityId,
    details,
    ipOrDevice,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuditLog &&
          other.id == this.id &&
          other.timestamp == this.timestamp &&
          other.action == this.action &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.details == this.details &&
          other.ipOrDevice == this.ipOrDevice);
}

class AuditLogsCompanion extends UpdateCompanion<AuditLog> {
  final Value<String> id;
  final Value<int> timestamp;
  final Value<String> action;
  final Value<String> entityType;
  final Value<String?> entityId;
  final Value<String> details;
  final Value<String> ipOrDevice;
  final Value<int> rowid;
  const AuditLogsCompanion({
    this.id = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.action = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.details = const Value.absent(),
    this.ipOrDevice = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AuditLogsCompanion.insert({
    required String id,
    required int timestamp,
    required String action,
    required String entityType,
    this.entityId = const Value.absent(),
    required String details,
    this.ipOrDevice = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       timestamp = Value(timestamp),
       action = Value(action),
       entityType = Value(entityType),
       details = Value(details);
  static Insertable<AuditLog> custom({
    Expression<String>? id,
    Expression<int>? timestamp,
    Expression<String>? action,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? details,
    Expression<String>? ipOrDevice,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (timestamp != null) 'timestamp': timestamp,
      if (action != null) 'action': action,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (details != null) 'details': details,
      if (ipOrDevice != null) 'ip_or_device': ipOrDevice,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AuditLogsCompanion copyWith({
    Value<String>? id,
    Value<int>? timestamp,
    Value<String>? action,
    Value<String>? entityType,
    Value<String?>? entityId,
    Value<String>? details,
    Value<String>? ipOrDevice,
    Value<int>? rowid,
  }) {
    return AuditLogsCompanion(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      action: action ?? this.action,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      details: details ?? this.details,
      ipOrDevice: ipOrDevice ?? this.ipOrDevice,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<int>(timestamp.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (details.present) {
      map['details'] = Variable<String>(details.value);
    }
    if (ipOrDevice.present) {
      map['ip_or_device'] = Variable<String>(ipOrDevice.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogsCompanion(')
          ..write('id: $id, ')
          ..write('timestamp: $timestamp, ')
          ..write('action: $action, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('details: $details, ')
          ..write('ipOrDevice: $ipOrDevice, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BackupHistoryTable extends BackupHistory
    with TableInfo<$BackupHistoryTable, BackupHistoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BackupHistoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _backupNameMeta = const VerificationMeta(
    'backupName',
  );
  @override
  late final GeneratedColumn<String> backupName = GeneratedColumn<String>(
    'backup_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileSizeMeta = const VerificationMeta(
    'fileSize',
  );
  @override
  late final GeneratedColumn<int> fileSize = GeneratedColumn<int>(
    'file_size',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _backupTypeMeta = const VerificationMeta(
    'backupType',
  );
  @override
  late final GeneratedColumn<String> backupType = GeneratedColumn<String>(
    'backup_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isEncryptedMeta = const VerificationMeta(
    'isEncrypted',
  );
  @override
  late final GeneratedColumn<int> isEncrypted = GeneratedColumn<int>(
    'is_encrypted',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _documentsCountMeta = const VerificationMeta(
    'documentsCount',
  );
  @override
  late final GeneratedColumn<int> documentsCount = GeneratedColumn<int>(
    'documents_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sha256ChecksumMeta = const VerificationMeta(
    'sha256Checksum',
  );
  @override
  late final GeneratedColumn<String> sha256Checksum = GeneratedColumn<String>(
    'sha256_checksum',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _uploadedToDriveMeta = const VerificationMeta(
    'uploadedToDrive',
  );
  @override
  late final GeneratedColumn<int> uploadedToDrive = GeneratedColumn<int>(
    'uploaded_to_drive',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _driveFileIdMeta = const VerificationMeta(
    'driveFileId',
  );
  @override
  late final GeneratedColumn<String> driveFileId = GeneratedColumn<String>(
    'drive_file_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    backupName,
    filePath,
    fileSize,
    backupType,
    isEncrypted,
    documentsCount,
    sha256Checksum,
    uploadedToDrive,
    driveFileId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'backup_history';
  @override
  VerificationContext validateIntegrity(
    Insertable<BackupHistoryData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('backup_name')) {
      context.handle(
        _backupNameMeta,
        backupName.isAcceptableOrUnknown(data['backup_name']!, _backupNameMeta),
      );
    } else if (isInserting) {
      context.missing(_backupNameMeta);
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('file_size')) {
      context.handle(
        _fileSizeMeta,
        fileSize.isAcceptableOrUnknown(data['file_size']!, _fileSizeMeta),
      );
    } else if (isInserting) {
      context.missing(_fileSizeMeta);
    }
    if (data.containsKey('backup_type')) {
      context.handle(
        _backupTypeMeta,
        backupType.isAcceptableOrUnknown(data['backup_type']!, _backupTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_backupTypeMeta);
    }
    if (data.containsKey('is_encrypted')) {
      context.handle(
        _isEncryptedMeta,
        isEncrypted.isAcceptableOrUnknown(
          data['is_encrypted']!,
          _isEncryptedMeta,
        ),
      );
    }
    if (data.containsKey('documents_count')) {
      context.handle(
        _documentsCountMeta,
        documentsCount.isAcceptableOrUnknown(
          data['documents_count']!,
          _documentsCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_documentsCountMeta);
    }
    if (data.containsKey('sha256_checksum')) {
      context.handle(
        _sha256ChecksumMeta,
        sha256Checksum.isAcceptableOrUnknown(
          data['sha256_checksum']!,
          _sha256ChecksumMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sha256ChecksumMeta);
    }
    if (data.containsKey('uploaded_to_drive')) {
      context.handle(
        _uploadedToDriveMeta,
        uploadedToDrive.isAcceptableOrUnknown(
          data['uploaded_to_drive']!,
          _uploadedToDriveMeta,
        ),
      );
    }
    if (data.containsKey('drive_file_id')) {
      context.handle(
        _driveFileIdMeta,
        driveFileId.isAcceptableOrUnknown(
          data['drive_file_id']!,
          _driveFileIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BackupHistoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BackupHistoryData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      backupName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}backup_name'],
      )!,
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      )!,
      fileSize: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}file_size'],
      )!,
      backupType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}backup_type'],
      )!,
      isEncrypted: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_encrypted'],
      )!,
      documentsCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}documents_count'],
      )!,
      sha256Checksum: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sha256_checksum'],
      )!,
      uploadedToDrive: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}uploaded_to_drive'],
      )!,
      driveFileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}drive_file_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $BackupHistoryTable createAlias(String alias) {
    return $BackupHistoryTable(attachedDatabase, alias);
  }
}

class BackupHistoryData extends DataClass
    implements Insertable<BackupHistoryData> {
  final String id;
  final String backupName;
  final String filePath;
  final int fileSize;
  final String backupType;
  final int isEncrypted;
  final int documentsCount;
  final String sha256Checksum;
  final int uploadedToDrive;
  final String? driveFileId;
  final int createdAt;
  const BackupHistoryData({
    required this.id,
    required this.backupName,
    required this.filePath,
    required this.fileSize,
    required this.backupType,
    required this.isEncrypted,
    required this.documentsCount,
    required this.sha256Checksum,
    required this.uploadedToDrive,
    this.driveFileId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['backup_name'] = Variable<String>(backupName);
    map['file_path'] = Variable<String>(filePath);
    map['file_size'] = Variable<int>(fileSize);
    map['backup_type'] = Variable<String>(backupType);
    map['is_encrypted'] = Variable<int>(isEncrypted);
    map['documents_count'] = Variable<int>(documentsCount);
    map['sha256_checksum'] = Variable<String>(sha256Checksum);
    map['uploaded_to_drive'] = Variable<int>(uploadedToDrive);
    if (!nullToAbsent || driveFileId != null) {
      map['drive_file_id'] = Variable<String>(driveFileId);
    }
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  BackupHistoryCompanion toCompanion(bool nullToAbsent) {
    return BackupHistoryCompanion(
      id: Value(id),
      backupName: Value(backupName),
      filePath: Value(filePath),
      fileSize: Value(fileSize),
      backupType: Value(backupType),
      isEncrypted: Value(isEncrypted),
      documentsCount: Value(documentsCount),
      sha256Checksum: Value(sha256Checksum),
      uploadedToDrive: Value(uploadedToDrive),
      driveFileId: driveFileId == null && nullToAbsent
          ? const Value.absent()
          : Value(driveFileId),
      createdAt: Value(createdAt),
    );
  }

  factory BackupHistoryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BackupHistoryData(
      id: serializer.fromJson<String>(json['id']),
      backupName: serializer.fromJson<String>(json['backupName']),
      filePath: serializer.fromJson<String>(json['filePath']),
      fileSize: serializer.fromJson<int>(json['fileSize']),
      backupType: serializer.fromJson<String>(json['backupType']),
      isEncrypted: serializer.fromJson<int>(json['isEncrypted']),
      documentsCount: serializer.fromJson<int>(json['documentsCount']),
      sha256Checksum: serializer.fromJson<String>(json['sha256Checksum']),
      uploadedToDrive: serializer.fromJson<int>(json['uploadedToDrive']),
      driveFileId: serializer.fromJson<String?>(json['driveFileId']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'backupName': serializer.toJson<String>(backupName),
      'filePath': serializer.toJson<String>(filePath),
      'fileSize': serializer.toJson<int>(fileSize),
      'backupType': serializer.toJson<String>(backupType),
      'isEncrypted': serializer.toJson<int>(isEncrypted),
      'documentsCount': serializer.toJson<int>(documentsCount),
      'sha256Checksum': serializer.toJson<String>(sha256Checksum),
      'uploadedToDrive': serializer.toJson<int>(uploadedToDrive),
      'driveFileId': serializer.toJson<String?>(driveFileId),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  BackupHistoryData copyWith({
    String? id,
    String? backupName,
    String? filePath,
    int? fileSize,
    String? backupType,
    int? isEncrypted,
    int? documentsCount,
    String? sha256Checksum,
    int? uploadedToDrive,
    Value<String?> driveFileId = const Value.absent(),
    int? createdAt,
  }) => BackupHistoryData(
    id: id ?? this.id,
    backupName: backupName ?? this.backupName,
    filePath: filePath ?? this.filePath,
    fileSize: fileSize ?? this.fileSize,
    backupType: backupType ?? this.backupType,
    isEncrypted: isEncrypted ?? this.isEncrypted,
    documentsCount: documentsCount ?? this.documentsCount,
    sha256Checksum: sha256Checksum ?? this.sha256Checksum,
    uploadedToDrive: uploadedToDrive ?? this.uploadedToDrive,
    driveFileId: driveFileId.present ? driveFileId.value : this.driveFileId,
    createdAt: createdAt ?? this.createdAt,
  );
  BackupHistoryData copyWithCompanion(BackupHistoryCompanion data) {
    return BackupHistoryData(
      id: data.id.present ? data.id.value : this.id,
      backupName: data.backupName.present
          ? data.backupName.value
          : this.backupName,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      fileSize: data.fileSize.present ? data.fileSize.value : this.fileSize,
      backupType: data.backupType.present
          ? data.backupType.value
          : this.backupType,
      isEncrypted: data.isEncrypted.present
          ? data.isEncrypted.value
          : this.isEncrypted,
      documentsCount: data.documentsCount.present
          ? data.documentsCount.value
          : this.documentsCount,
      sha256Checksum: data.sha256Checksum.present
          ? data.sha256Checksum.value
          : this.sha256Checksum,
      uploadedToDrive: data.uploadedToDrive.present
          ? data.uploadedToDrive.value
          : this.uploadedToDrive,
      driveFileId: data.driveFileId.present
          ? data.driveFileId.value
          : this.driveFileId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BackupHistoryData(')
          ..write('id: $id, ')
          ..write('backupName: $backupName, ')
          ..write('filePath: $filePath, ')
          ..write('fileSize: $fileSize, ')
          ..write('backupType: $backupType, ')
          ..write('isEncrypted: $isEncrypted, ')
          ..write('documentsCount: $documentsCount, ')
          ..write('sha256Checksum: $sha256Checksum, ')
          ..write('uploadedToDrive: $uploadedToDrive, ')
          ..write('driveFileId: $driveFileId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    backupName,
    filePath,
    fileSize,
    backupType,
    isEncrypted,
    documentsCount,
    sha256Checksum,
    uploadedToDrive,
    driveFileId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BackupHistoryData &&
          other.id == this.id &&
          other.backupName == this.backupName &&
          other.filePath == this.filePath &&
          other.fileSize == this.fileSize &&
          other.backupType == this.backupType &&
          other.isEncrypted == this.isEncrypted &&
          other.documentsCount == this.documentsCount &&
          other.sha256Checksum == this.sha256Checksum &&
          other.uploadedToDrive == this.uploadedToDrive &&
          other.driveFileId == this.driveFileId &&
          other.createdAt == this.createdAt);
}

class BackupHistoryCompanion extends UpdateCompanion<BackupHistoryData> {
  final Value<String> id;
  final Value<String> backupName;
  final Value<String> filePath;
  final Value<int> fileSize;
  final Value<String> backupType;
  final Value<int> isEncrypted;
  final Value<int> documentsCount;
  final Value<String> sha256Checksum;
  final Value<int> uploadedToDrive;
  final Value<String?> driveFileId;
  final Value<int> createdAt;
  final Value<int> rowid;
  const BackupHistoryCompanion({
    this.id = const Value.absent(),
    this.backupName = const Value.absent(),
    this.filePath = const Value.absent(),
    this.fileSize = const Value.absent(),
    this.backupType = const Value.absent(),
    this.isEncrypted = const Value.absent(),
    this.documentsCount = const Value.absent(),
    this.sha256Checksum = const Value.absent(),
    this.uploadedToDrive = const Value.absent(),
    this.driveFileId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BackupHistoryCompanion.insert({
    required String id,
    required String backupName,
    required String filePath,
    required int fileSize,
    required String backupType,
    this.isEncrypted = const Value.absent(),
    required int documentsCount,
    required String sha256Checksum,
    this.uploadedToDrive = const Value.absent(),
    this.driveFileId = const Value.absent(),
    required int createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       backupName = Value(backupName),
       filePath = Value(filePath),
       fileSize = Value(fileSize),
       backupType = Value(backupType),
       documentsCount = Value(documentsCount),
       sha256Checksum = Value(sha256Checksum),
       createdAt = Value(createdAt);
  static Insertable<BackupHistoryData> custom({
    Expression<String>? id,
    Expression<String>? backupName,
    Expression<String>? filePath,
    Expression<int>? fileSize,
    Expression<String>? backupType,
    Expression<int>? isEncrypted,
    Expression<int>? documentsCount,
    Expression<String>? sha256Checksum,
    Expression<int>? uploadedToDrive,
    Expression<String>? driveFileId,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (backupName != null) 'backup_name': backupName,
      if (filePath != null) 'file_path': filePath,
      if (fileSize != null) 'file_size': fileSize,
      if (backupType != null) 'backup_type': backupType,
      if (isEncrypted != null) 'is_encrypted': isEncrypted,
      if (documentsCount != null) 'documents_count': documentsCount,
      if (sha256Checksum != null) 'sha256_checksum': sha256Checksum,
      if (uploadedToDrive != null) 'uploaded_to_drive': uploadedToDrive,
      if (driveFileId != null) 'drive_file_id': driveFileId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BackupHistoryCompanion copyWith({
    Value<String>? id,
    Value<String>? backupName,
    Value<String>? filePath,
    Value<int>? fileSize,
    Value<String>? backupType,
    Value<int>? isEncrypted,
    Value<int>? documentsCount,
    Value<String>? sha256Checksum,
    Value<int>? uploadedToDrive,
    Value<String?>? driveFileId,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return BackupHistoryCompanion(
      id: id ?? this.id,
      backupName: backupName ?? this.backupName,
      filePath: filePath ?? this.filePath,
      fileSize: fileSize ?? this.fileSize,
      backupType: backupType ?? this.backupType,
      isEncrypted: isEncrypted ?? this.isEncrypted,
      documentsCount: documentsCount ?? this.documentsCount,
      sha256Checksum: sha256Checksum ?? this.sha256Checksum,
      uploadedToDrive: uploadedToDrive ?? this.uploadedToDrive,
      driveFileId: driveFileId ?? this.driveFileId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (backupName.present) {
      map['backup_name'] = Variable<String>(backupName.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (fileSize.present) {
      map['file_size'] = Variable<int>(fileSize.value);
    }
    if (backupType.present) {
      map['backup_type'] = Variable<String>(backupType.value);
    }
    if (isEncrypted.present) {
      map['is_encrypted'] = Variable<int>(isEncrypted.value);
    }
    if (documentsCount.present) {
      map['documents_count'] = Variable<int>(documentsCount.value);
    }
    if (sha256Checksum.present) {
      map['sha256_checksum'] = Variable<String>(sha256Checksum.value);
    }
    if (uploadedToDrive.present) {
      map['uploaded_to_drive'] = Variable<int>(uploadedToDrive.value);
    }
    if (driveFileId.present) {
      map['drive_file_id'] = Variable<String>(driveFileId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BackupHistoryCompanion(')
          ..write('id: $id, ')
          ..write('backupName: $backupName, ')
          ..write('filePath: $filePath, ')
          ..write('fileSize: $fileSize, ')
          ..write('backupType: $backupType, ')
          ..write('isEncrypted: $isEncrypted, ')
          ..write('documentsCount: $documentsCount, ')
          ..write('sha256Checksum: $sha256Checksum, ')
          ..write('uploadedToDrive: $uploadedToDrive, ')
          ..write('driveFileId: $driveFileId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ClientsTable clients = $ClientsTable(this);
  late final $CourtsTable courts = $CourtsTable(this);
  late final $ContactsTable contacts = $ContactsTable(this);
  late final $CasesTable cases = $CasesTable(this);
  late final $CaseClientsTable caseClients = $CaseClientsTable(this);
  late final $CasePartiesTable caseParties = $CasePartiesTable(this);
  late final $FolderLinksTable folderLinks = $FolderLinksTable(this);
  late final $DocumentsTable documents = $DocumentsTable(this);
  late final $CaseDocumentsTable caseDocuments = $CaseDocumentsTable(this);
  late final $DocumentTextIndexTable documentTextIndex =
      $DocumentTextIndexTable(this);
  late final $HearingsTable hearings = $HearingsTable(this);
  late final $CaseProceduresTable caseProcedures = $CaseProceduresTable(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final $FeeAgreementsTable feeAgreements = $FeeAgreementsTable(this);
  late final $PaymentsTable payments = $PaymentsTable(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  late final $ContractsTable contracts = $ContractsTable(this);
  late final $CommunicationsTable communications = $CommunicationsTable(this);
  late final $LegalReferencesTable legalReferences = $LegalReferencesTable(
    this,
  );
  late final $AuditLogsTable auditLogs = $AuditLogsTable(this);
  late final $BackupHistoryTable backupHistory = $BackupHistoryTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    clients,
    courts,
    contacts,
    cases,
    caseClients,
    caseParties,
    folderLinks,
    documents,
    caseDocuments,
    documentTextIndex,
    hearings,
    caseProcedures,
    tasks,
    feeAgreements,
    payments,
    expenses,
    contracts,
    communications,
    legalReferences,
    auditLogs,
    backupHistory,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'cases',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('case_clients', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'cases',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('case_parties', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'folder_links',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('documents', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'cases',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('case_documents', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'documents',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('case_documents', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'documents',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('document_text_index', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'cases',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('hearings', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'courts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('hearings', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'cases',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('case_procedures', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'documents',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('case_procedures', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'cases',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tasks', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'clients',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tasks', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'cases',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('fee_agreements', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'fee_agreements',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('payments', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'cases',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('payments', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'cases',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('expenses', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'documents',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('expenses', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'cases',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('contracts', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'documents',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('contracts', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'clients',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('communications', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'cases',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('communications', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'contacts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('communications', kind: UpdateKind.update)],
    ),
  ]);
}

typedef $$ClientsTableCreateCompanionBuilder =
    ClientsCompanion Function({
      required String id,
      required String clientType,
      required String fullName,
      Value<String?> nationalId,
      required String phone,
      Value<String?> phoneSecondary,
      Value<String?> email,
      Value<String?> address,
      Value<String?> occupation,
      Value<String?> companyName,
      Value<String?> commercialRecord,
      Value<String?> notes,
      required int createdAt,
      required int updatedAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });
typedef $$ClientsTableUpdateCompanionBuilder =
    ClientsCompanion Function({
      Value<String> id,
      Value<String> clientType,
      Value<String> fullName,
      Value<String?> nationalId,
      Value<String> phone,
      Value<String?> phoneSecondary,
      Value<String?> email,
      Value<String?> address,
      Value<String?> occupation,
      Value<String?> companyName,
      Value<String?> commercialRecord,
      Value<String?> notes,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });

final class $$ClientsTableReferences
    extends BaseReferences<_$AppDatabase, $ClientsTable, Client> {
  $$ClientsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CaseClientsTable, List<CaseClient>>
  _caseClientsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.caseClients,
    aliasName: 'clients__id__case_clients__client_id',
  );

  $$CaseClientsTableProcessedTableManager get caseClientsRefs {
    final manager = $$CaseClientsTableTableManager(
      $_db,
      $_db.caseClients,
    ).filter((f) => f.clientId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_caseClientsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TasksTable, List<Task>> _tasksRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.tasks,
    aliasName: 'clients__id__tasks__client_id',
  );

  $$TasksTableProcessedTableManager get tasksRefs {
    final manager = $$TasksTableTableManager(
      $_db,
      $_db.tasks,
    ).filter((f) => f.clientId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_tasksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FeeAgreementsTable, List<FeeAgreement>>
  _feeAgreementsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.feeAgreements,
    aliasName: 'clients__id__fee_agreements__client_id',
  );

  $$FeeAgreementsTableProcessedTableManager get feeAgreementsRefs {
    final manager = $$FeeAgreementsTableTableManager(
      $_db,
      $_db.feeAgreements,
    ).filter((f) => f.clientId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_feeAgreementsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PaymentsTable, List<Payment>> _paymentsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.payments,
    aliasName: 'clients__id__payments__client_id',
  );

  $$PaymentsTableProcessedTableManager get paymentsRefs {
    final manager = $$PaymentsTableTableManager(
      $_db,
      $_db.payments,
    ).filter((f) => f.clientId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ContractsTable, List<Contract>>
  _contractsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.contracts,
    aliasName: 'clients__id__contracts__client_id',
  );

  $$ContractsTableProcessedTableManager get contractsRefs {
    final manager = $$ContractsTableTableManager(
      $_db,
      $_db.contracts,
    ).filter((f) => f.clientId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_contractsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CommunicationsTable, List<Communication>>
  _communicationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.communications,
    aliasName: 'clients__id__communications__client_id',
  );

  $$CommunicationsTableProcessedTableManager get communicationsRefs {
    final manager = $$CommunicationsTableTableManager(
      $_db,
      $_db.communications,
    ).filter((f) => f.clientId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_communicationsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ClientsTableFilterComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientType => $composableBuilder(
    column: $table.clientType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nationalId => $composableBuilder(
    column: $table.nationalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneSecondary => $composableBuilder(
    column: $table.phoneSecondary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get occupation => $composableBuilder(
    column: $table.occupation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get companyName => $composableBuilder(
    column: $table.companyName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get commercialRecord => $composableBuilder(
    column: $table.commercialRecord,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> caseClientsRefs(
    Expression<bool> Function($$CaseClientsTableFilterComposer f) f,
  ) {
    final $$CaseClientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.caseClients,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CaseClientsTableFilterComposer(
            $db: $db,
            $table: $db.caseClients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> tasksRefs(
    Expression<bool> Function($$TasksTableFilterComposer f) f,
  ) {
    final $$TasksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableFilterComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> feeAgreementsRefs(
    Expression<bool> Function($$FeeAgreementsTableFilterComposer f) f,
  ) {
    final $$FeeAgreementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.feeAgreements,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeeAgreementsTableFilterComposer(
            $db: $db,
            $table: $db.feeAgreements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> paymentsRefs(
    Expression<bool> Function($$PaymentsTableFilterComposer f) f,
  ) {
    final $$PaymentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableFilterComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> contractsRefs(
    Expression<bool> Function($$ContractsTableFilterComposer f) f,
  ) {
    final $$ContractsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contracts,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContractsTableFilterComposer(
            $db: $db,
            $table: $db.contracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> communicationsRefs(
    Expression<bool> Function($$CommunicationsTableFilterComposer f) f,
  ) {
    final $$CommunicationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.communications,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CommunicationsTableFilterComposer(
            $db: $db,
            $table: $db.communications,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ClientsTableOrderingComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientType => $composableBuilder(
    column: $table.clientType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nationalId => $composableBuilder(
    column: $table.nationalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneSecondary => $composableBuilder(
    column: $table.phoneSecondary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get occupation => $composableBuilder(
    column: $table.occupation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get companyName => $composableBuilder(
    column: $table.companyName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get commercialRecord => $composableBuilder(
    column: $table.commercialRecord,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ClientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get clientType => $composableBuilder(
    column: $table.clientType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get nationalId => $composableBuilder(
    column: $table.nationalId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get phoneSecondary => $composableBuilder(
    column: $table.phoneSecondary,
    builder: (column) => column,
  );

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get occupation => $composableBuilder(
    column: $table.occupation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get companyName => $composableBuilder(
    column: $table.companyName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get commercialRecord => $composableBuilder(
    column: $table.commercialRecord,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  Expression<T> caseClientsRefs<T extends Object>(
    Expression<T> Function($$CaseClientsTableAnnotationComposer a) f,
  ) {
    final $$CaseClientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.caseClients,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CaseClientsTableAnnotationComposer(
            $db: $db,
            $table: $db.caseClients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> tasksRefs<T extends Object>(
    Expression<T> Function($$TasksTableAnnotationComposer a) f,
  ) {
    final $$TasksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableAnnotationComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> feeAgreementsRefs<T extends Object>(
    Expression<T> Function($$FeeAgreementsTableAnnotationComposer a) f,
  ) {
    final $$FeeAgreementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.feeAgreements,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeeAgreementsTableAnnotationComposer(
            $db: $db,
            $table: $db.feeAgreements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> paymentsRefs<T extends Object>(
    Expression<T> Function($$PaymentsTableAnnotationComposer a) f,
  ) {
    final $$PaymentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableAnnotationComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> contractsRefs<T extends Object>(
    Expression<T> Function($$ContractsTableAnnotationComposer a) f,
  ) {
    final $$ContractsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contracts,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContractsTableAnnotationComposer(
            $db: $db,
            $table: $db.contracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> communicationsRefs<T extends Object>(
    Expression<T> Function($$CommunicationsTableAnnotationComposer a) f,
  ) {
    final $$CommunicationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.communications,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CommunicationsTableAnnotationComposer(
            $db: $db,
            $table: $db.communications,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ClientsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClientsTable,
          Client,
          $$ClientsTableFilterComposer,
          $$ClientsTableOrderingComposer,
          $$ClientsTableAnnotationComposer,
          $$ClientsTableCreateCompanionBuilder,
          $$ClientsTableUpdateCompanionBuilder,
          (Client, $$ClientsTableReferences),
          Client,
          PrefetchHooks Function({
            bool caseClientsRefs,
            bool tasksRefs,
            bool feeAgreementsRefs,
            bool paymentsRefs,
            bool contractsRefs,
            bool communicationsRefs,
          })
        > {
  $$ClientsTableTableManager(_$AppDatabase db, $ClientsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> clientType = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<String?> nationalId = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String?> phoneSecondary = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> occupation = const Value.absent(),
                Value<String?> companyName = const Value.absent(),
                Value<String?> commercialRecord = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ClientsCompanion(
                id: id,
                clientType: clientType,
                fullName: fullName,
                nationalId: nationalId,
                phone: phone,
                phoneSecondary: phoneSecondary,
                email: email,
                address: address,
                occupation: occupation,
                companyName: companyName,
                commercialRecord: commercialRecord,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String clientType,
                required String fullName,
                Value<String?> nationalId = const Value.absent(),
                required String phone,
                Value<String?> phoneSecondary = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> occupation = const Value.absent(),
                Value<String?> companyName = const Value.absent(),
                Value<String?> commercialRecord = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ClientsCompanion.insert(
                id: id,
                clientType: clientType,
                fullName: fullName,
                nationalId: nationalId,
                phone: phone,
                phoneSecondary: phoneSecondary,
                email: email,
                address: address,
                occupation: occupation,
                companyName: companyName,
                commercialRecord: commercialRecord,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ClientsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                caseClientsRefs = false,
                tasksRefs = false,
                feeAgreementsRefs = false,
                paymentsRefs = false,
                contractsRefs = false,
                communicationsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (caseClientsRefs) db.caseClients,
                    if (tasksRefs) db.tasks,
                    if (feeAgreementsRefs) db.feeAgreements,
                    if (paymentsRefs) db.payments,
                    if (contractsRefs) db.contracts,
                    if (communicationsRefs) db.communications,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (caseClientsRefs)
                        await $_getPrefetchedData<
                          Client,
                          $ClientsTable,
                          CaseClient
                        >(
                          currentTable: table,
                          referencedTable: $$ClientsTableReferences
                              ._caseClientsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ClientsTableReferences(
                                db,
                                table,
                                p0,
                              ).caseClientsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.clientId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (tasksRefs)
                        await $_getPrefetchedData<Client, $ClientsTable, Task>(
                          currentTable: table,
                          referencedTable: $$ClientsTableReferences
                              ._tasksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ClientsTableReferences(db, table, p0).tasksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.clientId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (feeAgreementsRefs)
                        await $_getPrefetchedData<
                          Client,
                          $ClientsTable,
                          FeeAgreement
                        >(
                          currentTable: table,
                          referencedTable: $$ClientsTableReferences
                              ._feeAgreementsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ClientsTableReferences(
                                db,
                                table,
                                p0,
                              ).feeAgreementsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.clientId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (paymentsRefs)
                        await $_getPrefetchedData<
                          Client,
                          $ClientsTable,
                          Payment
                        >(
                          currentTable: table,
                          referencedTable: $$ClientsTableReferences
                              ._paymentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ClientsTableReferences(
                                db,
                                table,
                                p0,
                              ).paymentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.clientId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (contractsRefs)
                        await $_getPrefetchedData<
                          Client,
                          $ClientsTable,
                          Contract
                        >(
                          currentTable: table,
                          referencedTable: $$ClientsTableReferences
                              ._contractsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ClientsTableReferences(
                                db,
                                table,
                                p0,
                              ).contractsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.clientId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (communicationsRefs)
                        await $_getPrefetchedData<
                          Client,
                          $ClientsTable,
                          Communication
                        >(
                          currentTable: table,
                          referencedTable: $$ClientsTableReferences
                              ._communicationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ClientsTableReferences(
                                db,
                                table,
                                p0,
                              ).communicationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.clientId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ClientsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClientsTable,
      Client,
      $$ClientsTableFilterComposer,
      $$ClientsTableOrderingComposer,
      $$ClientsTableAnnotationComposer,
      $$ClientsTableCreateCompanionBuilder,
      $$ClientsTableUpdateCompanionBuilder,
      (Client, $$ClientsTableReferences),
      Client,
      PrefetchHooks Function({
        bool caseClientsRefs,
        bool tasksRefs,
        bool feeAgreementsRefs,
        bool paymentsRefs,
        bool contractsRefs,
        bool communicationsRefs,
      })
    >;
typedef $$CourtsTableCreateCompanionBuilder =
    CourtsCompanion Function({
      required String id,
      required String name,
      required String courtType,
      required String governorate,
      required String city,
      Value<String?> address,
      Value<String?> phone,
      Value<String?> notes,
      required int createdAt,
      Value<int> rowid,
    });
typedef $$CourtsTableUpdateCompanionBuilder =
    CourtsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> courtType,
      Value<String> governorate,
      Value<String> city,
      Value<String?> address,
      Value<String?> phone,
      Value<String?> notes,
      Value<int> createdAt,
      Value<int> rowid,
    });

final class $$CourtsTableReferences
    extends BaseReferences<_$AppDatabase, $CourtsTable, Court> {
  $$CourtsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CasesTable, List<Case>> _casesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.cases,
    aliasName: 'courts__id__cases__court_id',
  );

  $$CasesTableProcessedTableManager get casesRefs {
    final manager = $$CasesTableTableManager(
      $_db,
      $_db.cases,
    ).filter((f) => f.courtId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_casesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$HearingsTable, List<Hearing>> _hearingsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.hearings,
    aliasName: 'courts__id__hearings__court_id',
  );

  $$HearingsTableProcessedTableManager get hearingsRefs {
    final manager = $$HearingsTableTableManager(
      $_db,
      $_db.hearings,
    ).filter((f) => f.courtId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_hearingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CourtsTableFilterComposer
    extends Composer<_$AppDatabase, $CourtsTable> {
  $$CourtsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get courtType => $composableBuilder(
    column: $table.courtType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get governorate => $composableBuilder(
    column: $table.governorate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> casesRefs(
    Expression<bool> Function($$CasesTableFilterComposer f) f,
  ) {
    final $$CasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cases,
      getReferencedColumn: (t) => t.courtId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasesTableFilterComposer(
            $db: $db,
            $table: $db.cases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> hearingsRefs(
    Expression<bool> Function($$HearingsTableFilterComposer f) f,
  ) {
    final $$HearingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.hearings,
      getReferencedColumn: (t) => t.courtId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HearingsTableFilterComposer(
            $db: $db,
            $table: $db.hearings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CourtsTableOrderingComposer
    extends Composer<_$AppDatabase, $CourtsTable> {
  $$CourtsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get courtType => $composableBuilder(
    column: $table.courtType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get governorate => $composableBuilder(
    column: $table.governorate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CourtsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CourtsTable> {
  $$CourtsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get courtType =>
      $composableBuilder(column: $table.courtType, builder: (column) => column);

  GeneratedColumn<String> get governorate => $composableBuilder(
    column: $table.governorate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> casesRefs<T extends Object>(
    Expression<T> Function($$CasesTableAnnotationComposer a) f,
  ) {
    final $$CasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cases,
      getReferencedColumn: (t) => t.courtId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasesTableAnnotationComposer(
            $db: $db,
            $table: $db.cases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> hearingsRefs<T extends Object>(
    Expression<T> Function($$HearingsTableAnnotationComposer a) f,
  ) {
    final $$HearingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.hearings,
      getReferencedColumn: (t) => t.courtId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HearingsTableAnnotationComposer(
            $db: $db,
            $table: $db.hearings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CourtsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CourtsTable,
          Court,
          $$CourtsTableFilterComposer,
          $$CourtsTableOrderingComposer,
          $$CourtsTableAnnotationComposer,
          $$CourtsTableCreateCompanionBuilder,
          $$CourtsTableUpdateCompanionBuilder,
          (Court, $$CourtsTableReferences),
          Court,
          PrefetchHooks Function({bool casesRefs, bool hearingsRefs})
        > {
  $$CourtsTableTableManager(_$AppDatabase db, $CourtsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CourtsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CourtsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CourtsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> courtType = const Value.absent(),
                Value<String> governorate = const Value.absent(),
                Value<String> city = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CourtsCompanion(
                id: id,
                name: name,
                courtType: courtType,
                governorate: governorate,
                city: city,
                address: address,
                phone: phone,
                notes: notes,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String courtType,
                required String governorate,
                required String city,
                Value<String?> address = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required int createdAt,
                Value<int> rowid = const Value.absent(),
              }) => CourtsCompanion.insert(
                id: id,
                name: name,
                courtType: courtType,
                governorate: governorate,
                city: city,
                address: address,
                phone: phone,
                notes: notes,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$CourtsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({casesRefs = false, hearingsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (casesRefs) db.cases,
                if (hearingsRefs) db.hearings,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (casesRefs)
                    await $_getPrefetchedData<Court, $CourtsTable, Case>(
                      currentTable: table,
                      referencedTable: $$CourtsTableReferences._casesRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$CourtsTableReferences(db, table, p0).casesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.courtId == item.id),
                      typedResults: items,
                    ),
                  if (hearingsRefs)
                    await $_getPrefetchedData<Court, $CourtsTable, Hearing>(
                      currentTable: table,
                      referencedTable: $$CourtsTableReferences
                          ._hearingsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CourtsTableReferences(db, table, p0).hearingsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.courtId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CourtsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CourtsTable,
      Court,
      $$CourtsTableFilterComposer,
      $$CourtsTableOrderingComposer,
      $$CourtsTableAnnotationComposer,
      $$CourtsTableCreateCompanionBuilder,
      $$CourtsTableUpdateCompanionBuilder,
      (Court, $$CourtsTableReferences),
      Court,
      PrefetchHooks Function({bool casesRefs, bool hearingsRefs})
    >;
typedef $$ContactsTableCreateCompanionBuilder =
    ContactsCompanion Function({
      required String id,
      required String name,
      required String category,
      Value<String?> phone,
      Value<String?> phoneSecondary,
      Value<String?> email,
      Value<String?> address,
      Value<String?> organization,
      Value<String?> notes,
      required int createdAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });
typedef $$ContactsTableUpdateCompanionBuilder =
    ContactsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> category,
      Value<String?> phone,
      Value<String?> phoneSecondary,
      Value<String?> email,
      Value<String?> address,
      Value<String?> organization,
      Value<String?> notes,
      Value<int> createdAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });

final class $$ContactsTableReferences
    extends BaseReferences<_$AppDatabase, $ContactsTable, Contact> {
  $$ContactsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CommunicationsTable, List<Communication>>
  _communicationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.communications,
    aliasName: 'contacts__id__communications__contact_id',
  );

  $$CommunicationsTableProcessedTableManager get communicationsRefs {
    final manager = $$CommunicationsTableTableManager(
      $_db,
      $_db.communications,
    ).filter((f) => f.contactId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_communicationsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ContactsTableFilterComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneSecondary => $composableBuilder(
    column: $table.phoneSecondary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get organization => $composableBuilder(
    column: $table.organization,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> communicationsRefs(
    Expression<bool> Function($$CommunicationsTableFilterComposer f) f,
  ) {
    final $$CommunicationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.communications,
      getReferencedColumn: (t) => t.contactId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CommunicationsTableFilterComposer(
            $db: $db,
            $table: $db.communications,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ContactsTableOrderingComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneSecondary => $composableBuilder(
    column: $table.phoneSecondary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get organization => $composableBuilder(
    column: $table.organization,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ContactsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get phoneSecondary => $composableBuilder(
    column: $table.phoneSecondary,
    builder: (column) => column,
  );

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get organization => $composableBuilder(
    column: $table.organization,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  Expression<T> communicationsRefs<T extends Object>(
    Expression<T> Function($$CommunicationsTableAnnotationComposer a) f,
  ) {
    final $$CommunicationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.communications,
      getReferencedColumn: (t) => t.contactId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CommunicationsTableAnnotationComposer(
            $db: $db,
            $table: $db.communications,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ContactsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ContactsTable,
          Contact,
          $$ContactsTableFilterComposer,
          $$ContactsTableOrderingComposer,
          $$ContactsTableAnnotationComposer,
          $$ContactsTableCreateCompanionBuilder,
          $$ContactsTableUpdateCompanionBuilder,
          (Contact, $$ContactsTableReferences),
          Contact,
          PrefetchHooks Function({bool communicationsRefs})
        > {
  $$ContactsTableTableManager(_$AppDatabase db, $ContactsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContactsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContactsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContactsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> phoneSecondary = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> organization = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ContactsCompanion(
                id: id,
                name: name,
                category: category,
                phone: phone,
                phoneSecondary: phoneSecondary,
                email: email,
                address: address,
                organization: organization,
                notes: notes,
                createdAt: createdAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String category,
                Value<String?> phone = const Value.absent(),
                Value<String?> phoneSecondary = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> organization = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required int createdAt,
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ContactsCompanion.insert(
                id: id,
                name: name,
                category: category,
                phone: phone,
                phoneSecondary: phoneSecondary,
                email: email,
                address: address,
                organization: organization,
                notes: notes,
                createdAt: createdAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ContactsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({communicationsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (communicationsRefs) db.communications,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (communicationsRefs)
                    await $_getPrefetchedData<
                      Contact,
                      $ContactsTable,
                      Communication
                    >(
                      currentTable: table,
                      referencedTable: $$ContactsTableReferences
                          ._communicationsRefsTable(db),
                      managerFromTypedResult: (p0) => $$ContactsTableReferences(
                        db,
                        table,
                        p0,
                      ).communicationsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.contactId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ContactsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ContactsTable,
      Contact,
      $$ContactsTableFilterComposer,
      $$ContactsTableOrderingComposer,
      $$ContactsTableAnnotationComposer,
      $$ContactsTableCreateCompanionBuilder,
      $$ContactsTableUpdateCompanionBuilder,
      (Contact, $$ContactsTableReferences),
      Contact,
      PrefetchHooks Function({bool communicationsRefs})
    >;
typedef $$CasesTableCreateCompanionBuilder =
    CasesCompanion Function({
      required String id,
      required String caseNumber,
      required int caseYear,
      required String title,
      required String caseType,
      Value<String?> courtId,
      Value<String?> circuit,
      required String stage,
      Value<int?> registrationDate,
      Value<String?> subject,
      Value<int?> claimAmount,
      Value<String> currency,
      required String status,
      Value<String?> outcome,
      Value<int?> closingDate,
      Value<String?> notes,
      required int createdAt,
      required int updatedAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });
typedef $$CasesTableUpdateCompanionBuilder =
    CasesCompanion Function({
      Value<String> id,
      Value<String> caseNumber,
      Value<int> caseYear,
      Value<String> title,
      Value<String> caseType,
      Value<String?> courtId,
      Value<String?> circuit,
      Value<String> stage,
      Value<int?> registrationDate,
      Value<String?> subject,
      Value<int?> claimAmount,
      Value<String> currency,
      Value<String> status,
      Value<String?> outcome,
      Value<int?> closingDate,
      Value<String?> notes,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });

final class $$CasesTableReferences
    extends BaseReferences<_$AppDatabase, $CasesTable, Case> {
  $$CasesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CourtsTable _courtIdTable(_$AppDatabase db) =>
      db.courts.createAlias('cases__court_id__courts__id');

  $$CourtsTableProcessedTableManager? get courtId {
    final $_column = $_itemColumn<String>('court_id');
    if ($_column == null) return null;
    final manager = $$CourtsTableTableManager(
      $_db,
      $_db.courts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_courtIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$CaseClientsTable, List<CaseClient>>
  _caseClientsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.caseClients,
    aliasName: 'cases__id__case_clients__case_id',
  );

  $$CaseClientsTableProcessedTableManager get caseClientsRefs {
    final manager = $$CaseClientsTableTableManager(
      $_db,
      $_db.caseClients,
    ).filter((f) => f.caseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_caseClientsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CasePartiesTable, List<CaseParty>>
  _casePartiesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.caseParties,
    aliasName: 'cases__id__case_parties__case_id',
  );

  $$CasePartiesTableProcessedTableManager get casePartiesRefs {
    final manager = $$CasePartiesTableTableManager(
      $_db,
      $_db.caseParties,
    ).filter((f) => f.caseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_casePartiesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CaseDocumentsTable, List<CaseDocument>>
  _caseDocumentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.caseDocuments,
    aliasName: 'cases__id__case_documents__case_id',
  );

  $$CaseDocumentsTableProcessedTableManager get caseDocumentsRefs {
    final manager = $$CaseDocumentsTableTableManager(
      $_db,
      $_db.caseDocuments,
    ).filter((f) => f.caseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_caseDocumentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$HearingsTable, List<Hearing>> _hearingsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.hearings,
    aliasName: 'cases__id__hearings__case_id',
  );

  $$HearingsTableProcessedTableManager get hearingsRefs {
    final manager = $$HearingsTableTableManager(
      $_db,
      $_db.hearings,
    ).filter((f) => f.caseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_hearingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CaseProceduresTable, List<CaseProcedure>>
  _caseProceduresRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.caseProcedures,
    aliasName: 'cases__id__case_procedures__case_id',
  );

  $$CaseProceduresTableProcessedTableManager get caseProceduresRefs {
    final manager = $$CaseProceduresTableTableManager(
      $_db,
      $_db.caseProcedures,
    ).filter((f) => f.caseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_caseProceduresRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TasksTable, List<Task>> _tasksRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.tasks,
    aliasName: 'cases__id__tasks__case_id',
  );

  $$TasksTableProcessedTableManager get tasksRefs {
    final manager = $$TasksTableTableManager(
      $_db,
      $_db.tasks,
    ).filter((f) => f.caseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_tasksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FeeAgreementsTable, List<FeeAgreement>>
  _feeAgreementsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.feeAgreements,
    aliasName: 'cases__id__fee_agreements__case_id',
  );

  $$FeeAgreementsTableProcessedTableManager get feeAgreementsRefs {
    final manager = $$FeeAgreementsTableTableManager(
      $_db,
      $_db.feeAgreements,
    ).filter((f) => f.caseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_feeAgreementsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PaymentsTable, List<Payment>> _paymentsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.payments,
    aliasName: 'cases__id__payments__case_id',
  );

  $$PaymentsTableProcessedTableManager get paymentsRefs {
    final manager = $$PaymentsTableTableManager(
      $_db,
      $_db.payments,
    ).filter((f) => f.caseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ExpensesTable, List<Expense>> _expensesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.expenses,
    aliasName: 'cases__id__expenses__case_id',
  );

  $$ExpensesTableProcessedTableManager get expensesRefs {
    final manager = $$ExpensesTableTableManager(
      $_db,
      $_db.expenses,
    ).filter((f) => f.caseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_expensesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ContractsTable, List<Contract>>
  _contractsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.contracts,
    aliasName: 'cases__id__contracts__case_id',
  );

  $$ContractsTableProcessedTableManager get contractsRefs {
    final manager = $$ContractsTableTableManager(
      $_db,
      $_db.contracts,
    ).filter((f) => f.caseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_contractsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CommunicationsTable, List<Communication>>
  _communicationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.communications,
    aliasName: 'cases__id__communications__case_id',
  );

  $$CommunicationsTableProcessedTableManager get communicationsRefs {
    final manager = $$CommunicationsTableTableManager(
      $_db,
      $_db.communications,
    ).filter((f) => f.caseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_communicationsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CasesTableFilterComposer extends Composer<_$AppDatabase, $CasesTable> {
  $$CasesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get caseNumber => $composableBuilder(
    column: $table.caseNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get caseYear => $composableBuilder(
    column: $table.caseYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get caseType => $composableBuilder(
    column: $table.caseType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get circuit => $composableBuilder(
    column: $table.circuit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stage => $composableBuilder(
    column: $table.stage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get registrationDate => $composableBuilder(
    column: $table.registrationDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get claimAmount => $composableBuilder(
    column: $table.claimAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get outcome => $composableBuilder(
    column: $table.outcome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get closingDate => $composableBuilder(
    column: $table.closingDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CourtsTableFilterComposer get courtId {
    final $$CourtsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.courtId,
      referencedTable: $db.courts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CourtsTableFilterComposer(
            $db: $db,
            $table: $db.courts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> caseClientsRefs(
    Expression<bool> Function($$CaseClientsTableFilterComposer f) f,
  ) {
    final $$CaseClientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.caseClients,
      getReferencedColumn: (t) => t.caseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CaseClientsTableFilterComposer(
            $db: $db,
            $table: $db.caseClients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> casePartiesRefs(
    Expression<bool> Function($$CasePartiesTableFilterComposer f) f,
  ) {
    final $$CasePartiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.caseParties,
      getReferencedColumn: (t) => t.caseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasePartiesTableFilterComposer(
            $db: $db,
            $table: $db.caseParties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> caseDocumentsRefs(
    Expression<bool> Function($$CaseDocumentsTableFilterComposer f) f,
  ) {
    final $$CaseDocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.caseDocuments,
      getReferencedColumn: (t) => t.caseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CaseDocumentsTableFilterComposer(
            $db: $db,
            $table: $db.caseDocuments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> hearingsRefs(
    Expression<bool> Function($$HearingsTableFilterComposer f) f,
  ) {
    final $$HearingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.hearings,
      getReferencedColumn: (t) => t.caseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HearingsTableFilterComposer(
            $db: $db,
            $table: $db.hearings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> caseProceduresRefs(
    Expression<bool> Function($$CaseProceduresTableFilterComposer f) f,
  ) {
    final $$CaseProceduresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.caseProcedures,
      getReferencedColumn: (t) => t.caseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CaseProceduresTableFilterComposer(
            $db: $db,
            $table: $db.caseProcedures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> tasksRefs(
    Expression<bool> Function($$TasksTableFilterComposer f) f,
  ) {
    final $$TasksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.caseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableFilterComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> feeAgreementsRefs(
    Expression<bool> Function($$FeeAgreementsTableFilterComposer f) f,
  ) {
    final $$FeeAgreementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.feeAgreements,
      getReferencedColumn: (t) => t.caseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeeAgreementsTableFilterComposer(
            $db: $db,
            $table: $db.feeAgreements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> paymentsRefs(
    Expression<bool> Function($$PaymentsTableFilterComposer f) f,
  ) {
    final $$PaymentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.caseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableFilterComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> expensesRefs(
    Expression<bool> Function($$ExpensesTableFilterComposer f) f,
  ) {
    final $$ExpensesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expenses,
      getReferencedColumn: (t) => t.caseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableFilterComposer(
            $db: $db,
            $table: $db.expenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> contractsRefs(
    Expression<bool> Function($$ContractsTableFilterComposer f) f,
  ) {
    final $$ContractsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contracts,
      getReferencedColumn: (t) => t.caseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContractsTableFilterComposer(
            $db: $db,
            $table: $db.contracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> communicationsRefs(
    Expression<bool> Function($$CommunicationsTableFilterComposer f) f,
  ) {
    final $$CommunicationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.communications,
      getReferencedColumn: (t) => t.caseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CommunicationsTableFilterComposer(
            $db: $db,
            $table: $db.communications,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CasesTableOrderingComposer
    extends Composer<_$AppDatabase, $CasesTable> {
  $$CasesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get caseNumber => $composableBuilder(
    column: $table.caseNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get caseYear => $composableBuilder(
    column: $table.caseYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get caseType => $composableBuilder(
    column: $table.caseType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get circuit => $composableBuilder(
    column: $table.circuit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stage => $composableBuilder(
    column: $table.stage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get registrationDate => $composableBuilder(
    column: $table.registrationDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get claimAmount => $composableBuilder(
    column: $table.claimAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get outcome => $composableBuilder(
    column: $table.outcome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get closingDate => $composableBuilder(
    column: $table.closingDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CourtsTableOrderingComposer get courtId {
    final $$CourtsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.courtId,
      referencedTable: $db.courts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CourtsTableOrderingComposer(
            $db: $db,
            $table: $db.courts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CasesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CasesTable> {
  $$CasesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get caseNumber => $composableBuilder(
    column: $table.caseNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get caseYear =>
      $composableBuilder(column: $table.caseYear, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get caseType =>
      $composableBuilder(column: $table.caseType, builder: (column) => column);

  GeneratedColumn<String> get circuit =>
      $composableBuilder(column: $table.circuit, builder: (column) => column);

  GeneratedColumn<String> get stage =>
      $composableBuilder(column: $table.stage, builder: (column) => column);

  GeneratedColumn<int> get registrationDate => $composableBuilder(
    column: $table.registrationDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get subject =>
      $composableBuilder(column: $table.subject, builder: (column) => column);

  GeneratedColumn<int> get claimAmount => $composableBuilder(
    column: $table.claimAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get outcome =>
      $composableBuilder(column: $table.outcome, builder: (column) => column);

  GeneratedColumn<int> get closingDate => $composableBuilder(
    column: $table.closingDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$CourtsTableAnnotationComposer get courtId {
    final $$CourtsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.courtId,
      referencedTable: $db.courts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CourtsTableAnnotationComposer(
            $db: $db,
            $table: $db.courts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> caseClientsRefs<T extends Object>(
    Expression<T> Function($$CaseClientsTableAnnotationComposer a) f,
  ) {
    final $$CaseClientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.caseClients,
      getReferencedColumn: (t) => t.caseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CaseClientsTableAnnotationComposer(
            $db: $db,
            $table: $db.caseClients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> casePartiesRefs<T extends Object>(
    Expression<T> Function($$CasePartiesTableAnnotationComposer a) f,
  ) {
    final $$CasePartiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.caseParties,
      getReferencedColumn: (t) => t.caseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasePartiesTableAnnotationComposer(
            $db: $db,
            $table: $db.caseParties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> caseDocumentsRefs<T extends Object>(
    Expression<T> Function($$CaseDocumentsTableAnnotationComposer a) f,
  ) {
    final $$CaseDocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.caseDocuments,
      getReferencedColumn: (t) => t.caseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CaseDocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.caseDocuments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> hearingsRefs<T extends Object>(
    Expression<T> Function($$HearingsTableAnnotationComposer a) f,
  ) {
    final $$HearingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.hearings,
      getReferencedColumn: (t) => t.caseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HearingsTableAnnotationComposer(
            $db: $db,
            $table: $db.hearings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> caseProceduresRefs<T extends Object>(
    Expression<T> Function($$CaseProceduresTableAnnotationComposer a) f,
  ) {
    final $$CaseProceduresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.caseProcedures,
      getReferencedColumn: (t) => t.caseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CaseProceduresTableAnnotationComposer(
            $db: $db,
            $table: $db.caseProcedures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> tasksRefs<T extends Object>(
    Expression<T> Function($$TasksTableAnnotationComposer a) f,
  ) {
    final $$TasksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.caseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableAnnotationComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> feeAgreementsRefs<T extends Object>(
    Expression<T> Function($$FeeAgreementsTableAnnotationComposer a) f,
  ) {
    final $$FeeAgreementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.feeAgreements,
      getReferencedColumn: (t) => t.caseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeeAgreementsTableAnnotationComposer(
            $db: $db,
            $table: $db.feeAgreements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> paymentsRefs<T extends Object>(
    Expression<T> Function($$PaymentsTableAnnotationComposer a) f,
  ) {
    final $$PaymentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.caseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableAnnotationComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> expensesRefs<T extends Object>(
    Expression<T> Function($$ExpensesTableAnnotationComposer a) f,
  ) {
    final $$ExpensesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expenses,
      getReferencedColumn: (t) => t.caseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableAnnotationComposer(
            $db: $db,
            $table: $db.expenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> contractsRefs<T extends Object>(
    Expression<T> Function($$ContractsTableAnnotationComposer a) f,
  ) {
    final $$ContractsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contracts,
      getReferencedColumn: (t) => t.caseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContractsTableAnnotationComposer(
            $db: $db,
            $table: $db.contracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> communicationsRefs<T extends Object>(
    Expression<T> Function($$CommunicationsTableAnnotationComposer a) f,
  ) {
    final $$CommunicationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.communications,
      getReferencedColumn: (t) => t.caseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CommunicationsTableAnnotationComposer(
            $db: $db,
            $table: $db.communications,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CasesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CasesTable,
          Case,
          $$CasesTableFilterComposer,
          $$CasesTableOrderingComposer,
          $$CasesTableAnnotationComposer,
          $$CasesTableCreateCompanionBuilder,
          $$CasesTableUpdateCompanionBuilder,
          (Case, $$CasesTableReferences),
          Case,
          PrefetchHooks Function({
            bool courtId,
            bool caseClientsRefs,
            bool casePartiesRefs,
            bool caseDocumentsRefs,
            bool hearingsRefs,
            bool caseProceduresRefs,
            bool tasksRefs,
            bool feeAgreementsRefs,
            bool paymentsRefs,
            bool expensesRefs,
            bool contractsRefs,
            bool communicationsRefs,
          })
        > {
  $$CasesTableTableManager(_$AppDatabase db, $CasesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CasesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CasesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CasesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> caseNumber = const Value.absent(),
                Value<int> caseYear = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> caseType = const Value.absent(),
                Value<String?> courtId = const Value.absent(),
                Value<String?> circuit = const Value.absent(),
                Value<String> stage = const Value.absent(),
                Value<int?> registrationDate = const Value.absent(),
                Value<String?> subject = const Value.absent(),
                Value<int?> claimAmount = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> outcome = const Value.absent(),
                Value<int?> closingDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CasesCompanion(
                id: id,
                caseNumber: caseNumber,
                caseYear: caseYear,
                title: title,
                caseType: caseType,
                courtId: courtId,
                circuit: circuit,
                stage: stage,
                registrationDate: registrationDate,
                subject: subject,
                claimAmount: claimAmount,
                currency: currency,
                status: status,
                outcome: outcome,
                closingDate: closingDate,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String caseNumber,
                required int caseYear,
                required String title,
                required String caseType,
                Value<String?> courtId = const Value.absent(),
                Value<String?> circuit = const Value.absent(),
                required String stage,
                Value<int?> registrationDate = const Value.absent(),
                Value<String?> subject = const Value.absent(),
                Value<int?> claimAmount = const Value.absent(),
                Value<String> currency = const Value.absent(),
                required String status,
                Value<String?> outcome = const Value.absent(),
                Value<int?> closingDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CasesCompanion.insert(
                id: id,
                caseNumber: caseNumber,
                caseYear: caseYear,
                title: title,
                caseType: caseType,
                courtId: courtId,
                circuit: circuit,
                stage: stage,
                registrationDate: registrationDate,
                subject: subject,
                claimAmount: claimAmount,
                currency: currency,
                status: status,
                outcome: outcome,
                closingDate: closingDate,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$CasesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                courtId = false,
                caseClientsRefs = false,
                casePartiesRefs = false,
                caseDocumentsRefs = false,
                hearingsRefs = false,
                caseProceduresRefs = false,
                tasksRefs = false,
                feeAgreementsRefs = false,
                paymentsRefs = false,
                expensesRefs = false,
                contractsRefs = false,
                communicationsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (caseClientsRefs) db.caseClients,
                    if (casePartiesRefs) db.caseParties,
                    if (caseDocumentsRefs) db.caseDocuments,
                    if (hearingsRefs) db.hearings,
                    if (caseProceduresRefs) db.caseProcedures,
                    if (tasksRefs) db.tasks,
                    if (feeAgreementsRefs) db.feeAgreements,
                    if (paymentsRefs) db.payments,
                    if (expensesRefs) db.expenses,
                    if (contractsRefs) db.contracts,
                    if (communicationsRefs) db.communications,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (courtId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.courtId,
                                    referencedTable: $$CasesTableReferences
                                        ._courtIdTable(db),
                                    referencedColumn: $$CasesTableReferences
                                        ._courtIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (caseClientsRefs)
                        await $_getPrefetchedData<
                          Case,
                          $CasesTable,
                          CaseClient
                        >(
                          currentTable: table,
                          referencedTable: $$CasesTableReferences
                              ._caseClientsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CasesTableReferences(
                                db,
                                table,
                                p0,
                              ).caseClientsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.caseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (casePartiesRefs)
                        await $_getPrefetchedData<Case, $CasesTable, CaseParty>(
                          currentTable: table,
                          referencedTable: $$CasesTableReferences
                              ._casePartiesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CasesTableReferences(
                                db,
                                table,
                                p0,
                              ).casePartiesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.caseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (caseDocumentsRefs)
                        await $_getPrefetchedData<
                          Case,
                          $CasesTable,
                          CaseDocument
                        >(
                          currentTable: table,
                          referencedTable: $$CasesTableReferences
                              ._caseDocumentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CasesTableReferences(
                                db,
                                table,
                                p0,
                              ).caseDocumentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.caseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (hearingsRefs)
                        await $_getPrefetchedData<Case, $CasesTable, Hearing>(
                          currentTable: table,
                          referencedTable: $$CasesTableReferences
                              ._hearingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CasesTableReferences(
                                db,
                                table,
                                p0,
                              ).hearingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.caseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (caseProceduresRefs)
                        await $_getPrefetchedData<
                          Case,
                          $CasesTable,
                          CaseProcedure
                        >(
                          currentTable: table,
                          referencedTable: $$CasesTableReferences
                              ._caseProceduresRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CasesTableReferences(
                                db,
                                table,
                                p0,
                              ).caseProceduresRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.caseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (tasksRefs)
                        await $_getPrefetchedData<Case, $CasesTable, Task>(
                          currentTable: table,
                          referencedTable: $$CasesTableReferences
                              ._tasksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CasesTableReferences(db, table, p0).tasksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.caseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (feeAgreementsRefs)
                        await $_getPrefetchedData<
                          Case,
                          $CasesTable,
                          FeeAgreement
                        >(
                          currentTable: table,
                          referencedTable: $$CasesTableReferences
                              ._feeAgreementsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CasesTableReferences(
                                db,
                                table,
                                p0,
                              ).feeAgreementsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.caseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (paymentsRefs)
                        await $_getPrefetchedData<Case, $CasesTable, Payment>(
                          currentTable: table,
                          referencedTable: $$CasesTableReferences
                              ._paymentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CasesTableReferences(
                                db,
                                table,
                                p0,
                              ).paymentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.caseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (expensesRefs)
                        await $_getPrefetchedData<Case, $CasesTable, Expense>(
                          currentTable: table,
                          referencedTable: $$CasesTableReferences
                              ._expensesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CasesTableReferences(
                                db,
                                table,
                                p0,
                              ).expensesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.caseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (contractsRefs)
                        await $_getPrefetchedData<Case, $CasesTable, Contract>(
                          currentTable: table,
                          referencedTable: $$CasesTableReferences
                              ._contractsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CasesTableReferences(
                                db,
                                table,
                                p0,
                              ).contractsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.caseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (communicationsRefs)
                        await $_getPrefetchedData<
                          Case,
                          $CasesTable,
                          Communication
                        >(
                          currentTable: table,
                          referencedTable: $$CasesTableReferences
                              ._communicationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CasesTableReferences(
                                db,
                                table,
                                p0,
                              ).communicationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.caseId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CasesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CasesTable,
      Case,
      $$CasesTableFilterComposer,
      $$CasesTableOrderingComposer,
      $$CasesTableAnnotationComposer,
      $$CasesTableCreateCompanionBuilder,
      $$CasesTableUpdateCompanionBuilder,
      (Case, $$CasesTableReferences),
      Case,
      PrefetchHooks Function({
        bool courtId,
        bool caseClientsRefs,
        bool casePartiesRefs,
        bool caseDocumentsRefs,
        bool hearingsRefs,
        bool caseProceduresRefs,
        bool tasksRefs,
        bool feeAgreementsRefs,
        bool paymentsRefs,
        bool expensesRefs,
        bool contractsRefs,
        bool communicationsRefs,
      })
    >;
typedef $$CaseClientsTableCreateCompanionBuilder =
    CaseClientsCompanion Function({
      required String id,
      required String caseId,
      required String clientId,
      required String role,
      required int createdAt,
      Value<int> rowid,
    });
typedef $$CaseClientsTableUpdateCompanionBuilder =
    CaseClientsCompanion Function({
      Value<String> id,
      Value<String> caseId,
      Value<String> clientId,
      Value<String> role,
      Value<int> createdAt,
      Value<int> rowid,
    });

final class $$CaseClientsTableReferences
    extends BaseReferences<_$AppDatabase, $CaseClientsTable, CaseClient> {
  $$CaseClientsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CasesTable _caseIdTable(_$AppDatabase db) =>
      db.cases.createAlias('case_clients__case_id__cases__id');

  $$CasesTableProcessedTableManager get caseId {
    final $_column = $_itemColumn<String>('case_id')!;

    final manager = $$CasesTableTableManager(
      $_db,
      $_db.cases,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_caseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ClientsTable _clientIdTable(_$AppDatabase db) =>
      db.clients.createAlias('case_clients__client_id__clients__id');

  $$ClientsTableProcessedTableManager get clientId {
    final $_column = $_itemColumn<String>('client_id')!;

    final manager = $$ClientsTableTableManager(
      $_db,
      $_db.clients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CaseClientsTableFilterComposer
    extends Composer<_$AppDatabase, $CaseClientsTable> {
  $$CaseClientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CasesTableFilterComposer get caseId {
    final $$CasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.caseId,
      referencedTable: $db.cases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasesTableFilterComposer(
            $db: $db,
            $table: $db.cases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ClientsTableFilterComposer get clientId {
    final $$ClientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableFilterComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CaseClientsTableOrderingComposer
    extends Composer<_$AppDatabase, $CaseClientsTable> {
  $$CaseClientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CasesTableOrderingComposer get caseId {
    final $$CasesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.caseId,
      referencedTable: $db.cases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasesTableOrderingComposer(
            $db: $db,
            $table: $db.cases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ClientsTableOrderingComposer get clientId {
    final $$ClientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableOrderingComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CaseClientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CaseClientsTable> {
  $$CaseClientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CasesTableAnnotationComposer get caseId {
    final $$CasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.caseId,
      referencedTable: $db.cases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasesTableAnnotationComposer(
            $db: $db,
            $table: $db.cases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ClientsTableAnnotationComposer get clientId {
    final $$ClientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableAnnotationComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CaseClientsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CaseClientsTable,
          CaseClient,
          $$CaseClientsTableFilterComposer,
          $$CaseClientsTableOrderingComposer,
          $$CaseClientsTableAnnotationComposer,
          $$CaseClientsTableCreateCompanionBuilder,
          $$CaseClientsTableUpdateCompanionBuilder,
          (CaseClient, $$CaseClientsTableReferences),
          CaseClient,
          PrefetchHooks Function({bool caseId, bool clientId})
        > {
  $$CaseClientsTableTableManager(_$AppDatabase db, $CaseClientsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CaseClientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CaseClientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CaseClientsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> caseId = const Value.absent(),
                Value<String> clientId = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CaseClientsCompanion(
                id: id,
                caseId: caseId,
                clientId: clientId,
                role: role,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String caseId,
                required String clientId,
                required String role,
                required int createdAt,
                Value<int> rowid = const Value.absent(),
              }) => CaseClientsCompanion.insert(
                id: id,
                caseId: caseId,
                clientId: clientId,
                role: role,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CaseClientsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({caseId = false, clientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (caseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.caseId,
                                referencedTable: $$CaseClientsTableReferences
                                    ._caseIdTable(db),
                                referencedColumn: $$CaseClientsTableReferences
                                    ._caseIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (clientId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.clientId,
                                referencedTable: $$CaseClientsTableReferences
                                    ._clientIdTable(db),
                                referencedColumn: $$CaseClientsTableReferences
                                    ._clientIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CaseClientsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CaseClientsTable,
      CaseClient,
      $$CaseClientsTableFilterComposer,
      $$CaseClientsTableOrderingComposer,
      $$CaseClientsTableAnnotationComposer,
      $$CaseClientsTableCreateCompanionBuilder,
      $$CaseClientsTableUpdateCompanionBuilder,
      (CaseClient, $$CaseClientsTableReferences),
      CaseClient,
      PrefetchHooks Function({bool caseId, bool clientId})
    >;
typedef $$CasePartiesTableCreateCompanionBuilder =
    CasePartiesCompanion Function({
      required String id,
      required String caseId,
      required String name,
      required String role,
      Value<String?> lawyerName,
      Value<String?> lawyerPhone,
      Value<String?> notes,
      required int createdAt,
      Value<int> rowid,
    });
typedef $$CasePartiesTableUpdateCompanionBuilder =
    CasePartiesCompanion Function({
      Value<String> id,
      Value<String> caseId,
      Value<String> name,
      Value<String> role,
      Value<String?> lawyerName,
      Value<String?> lawyerPhone,
      Value<String?> notes,
      Value<int> createdAt,
      Value<int> rowid,
    });

final class $$CasePartiesTableReferences
    extends BaseReferences<_$AppDatabase, $CasePartiesTable, CaseParty> {
  $$CasePartiesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CasesTable _caseIdTable(_$AppDatabase db) =>
      db.cases.createAlias('case_parties__case_id__cases__id');

  $$CasesTableProcessedTableManager get caseId {
    final $_column = $_itemColumn<String>('case_id')!;

    final manager = $$CasesTableTableManager(
      $_db,
      $_db.cases,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_caseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CasePartiesTableFilterComposer
    extends Composer<_$AppDatabase, $CasePartiesTable> {
  $$CasePartiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lawyerName => $composableBuilder(
    column: $table.lawyerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lawyerPhone => $composableBuilder(
    column: $table.lawyerPhone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CasesTableFilterComposer get caseId {
    final $$CasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.caseId,
      referencedTable: $db.cases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasesTableFilterComposer(
            $db: $db,
            $table: $db.cases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CasePartiesTableOrderingComposer
    extends Composer<_$AppDatabase, $CasePartiesTable> {
  $$CasePartiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lawyerName => $composableBuilder(
    column: $table.lawyerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lawyerPhone => $composableBuilder(
    column: $table.lawyerPhone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CasesTableOrderingComposer get caseId {
    final $$CasesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.caseId,
      referencedTable: $db.cases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasesTableOrderingComposer(
            $db: $db,
            $table: $db.cases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CasePartiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CasePartiesTable> {
  $$CasePartiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get lawyerName => $composableBuilder(
    column: $table.lawyerName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lawyerPhone => $composableBuilder(
    column: $table.lawyerPhone,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CasesTableAnnotationComposer get caseId {
    final $$CasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.caseId,
      referencedTable: $db.cases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasesTableAnnotationComposer(
            $db: $db,
            $table: $db.cases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CasePartiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CasePartiesTable,
          CaseParty,
          $$CasePartiesTableFilterComposer,
          $$CasePartiesTableOrderingComposer,
          $$CasePartiesTableAnnotationComposer,
          $$CasePartiesTableCreateCompanionBuilder,
          $$CasePartiesTableUpdateCompanionBuilder,
          (CaseParty, $$CasePartiesTableReferences),
          CaseParty,
          PrefetchHooks Function({bool caseId})
        > {
  $$CasePartiesTableTableManager(_$AppDatabase db, $CasePartiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CasePartiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CasePartiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CasePartiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> caseId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String?> lawyerName = const Value.absent(),
                Value<String?> lawyerPhone = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CasePartiesCompanion(
                id: id,
                caseId: caseId,
                name: name,
                role: role,
                lawyerName: lawyerName,
                lawyerPhone: lawyerPhone,
                notes: notes,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String caseId,
                required String name,
                required String role,
                Value<String?> lawyerName = const Value.absent(),
                Value<String?> lawyerPhone = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required int createdAt,
                Value<int> rowid = const Value.absent(),
              }) => CasePartiesCompanion.insert(
                id: id,
                caseId: caseId,
                name: name,
                role: role,
                lawyerName: lawyerName,
                lawyerPhone: lawyerPhone,
                notes: notes,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CasePartiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({caseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (caseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.caseId,
                                referencedTable: $$CasePartiesTableReferences
                                    ._caseIdTable(db),
                                referencedColumn: $$CasePartiesTableReferences
                                    ._caseIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CasePartiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CasePartiesTable,
      CaseParty,
      $$CasePartiesTableFilterComposer,
      $$CasePartiesTableOrderingComposer,
      $$CasePartiesTableAnnotationComposer,
      $$CasePartiesTableCreateCompanionBuilder,
      $$CasePartiesTableUpdateCompanionBuilder,
      (CaseParty, $$CasePartiesTableReferences),
      CaseParty,
      PrefetchHooks Function({bool caseId})
    >;
typedef $$FolderLinksTableCreateCompanionBuilder =
    FolderLinksCompanion Function({
      required String id,
      required String uriString,
      required String displayName,
      Value<String?> pathHint,
      Value<int> isAccessible,
      Value<int?> lastScannedAt,
      Value<String> scanStatus,
      Value<String?> notes,
      required int createdAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });
typedef $$FolderLinksTableUpdateCompanionBuilder =
    FolderLinksCompanion Function({
      Value<String> id,
      Value<String> uriString,
      Value<String> displayName,
      Value<String?> pathHint,
      Value<int> isAccessible,
      Value<int?> lastScannedAt,
      Value<String> scanStatus,
      Value<String?> notes,
      Value<int> createdAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });

final class $$FolderLinksTableReferences
    extends BaseReferences<_$AppDatabase, $FolderLinksTable, FolderLink> {
  $$FolderLinksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DocumentsTable, List<Document>>
  _documentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.documents,
    aliasName: 'folder_links__id__documents__folder_link_id',
  );

  $$DocumentsTableProcessedTableManager get documentsRefs {
    final manager = $$DocumentsTableTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.folderLinkId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_documentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FolderLinksTableFilterComposer
    extends Composer<_$AppDatabase, $FolderLinksTable> {
  $$FolderLinksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uriString => $composableBuilder(
    column: $table.uriString,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pathHint => $composableBuilder(
    column: $table.pathHint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isAccessible => $composableBuilder(
    column: $table.isAccessible,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastScannedAt => $composableBuilder(
    column: $table.lastScannedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scanStatus => $composableBuilder(
    column: $table.scanStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> documentsRefs(
    Expression<bool> Function($$DocumentsTableFilterComposer f) f,
  ) {
    final $$DocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.folderLinkId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FolderLinksTableOrderingComposer
    extends Composer<_$AppDatabase, $FolderLinksTable> {
  $$FolderLinksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uriString => $composableBuilder(
    column: $table.uriString,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pathHint => $composableBuilder(
    column: $table.pathHint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isAccessible => $composableBuilder(
    column: $table.isAccessible,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastScannedAt => $composableBuilder(
    column: $table.lastScannedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scanStatus => $composableBuilder(
    column: $table.scanStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FolderLinksTableAnnotationComposer
    extends Composer<_$AppDatabase, $FolderLinksTable> {
  $$FolderLinksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uriString =>
      $composableBuilder(column: $table.uriString, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pathHint =>
      $composableBuilder(column: $table.pathHint, builder: (column) => column);

  GeneratedColumn<int> get isAccessible => $composableBuilder(
    column: $table.isAccessible,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastScannedAt => $composableBuilder(
    column: $table.lastScannedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get scanStatus => $composableBuilder(
    column: $table.scanStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  Expression<T> documentsRefs<T extends Object>(
    Expression<T> Function($$DocumentsTableAnnotationComposer a) f,
  ) {
    final $$DocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.folderLinkId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FolderLinksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FolderLinksTable,
          FolderLink,
          $$FolderLinksTableFilterComposer,
          $$FolderLinksTableOrderingComposer,
          $$FolderLinksTableAnnotationComposer,
          $$FolderLinksTableCreateCompanionBuilder,
          $$FolderLinksTableUpdateCompanionBuilder,
          (FolderLink, $$FolderLinksTableReferences),
          FolderLink,
          PrefetchHooks Function({bool documentsRefs})
        > {
  $$FolderLinksTableTableManager(_$AppDatabase db, $FolderLinksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FolderLinksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FolderLinksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FolderLinksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> uriString = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String?> pathHint = const Value.absent(),
                Value<int> isAccessible = const Value.absent(),
                Value<int?> lastScannedAt = const Value.absent(),
                Value<String> scanStatus = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FolderLinksCompanion(
                id: id,
                uriString: uriString,
                displayName: displayName,
                pathHint: pathHint,
                isAccessible: isAccessible,
                lastScannedAt: lastScannedAt,
                scanStatus: scanStatus,
                notes: notes,
                createdAt: createdAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String uriString,
                required String displayName,
                Value<String?> pathHint = const Value.absent(),
                Value<int> isAccessible = const Value.absent(),
                Value<int?> lastScannedAt = const Value.absent(),
                Value<String> scanStatus = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required int createdAt,
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FolderLinksCompanion.insert(
                id: id,
                uriString: uriString,
                displayName: displayName,
                pathHint: pathHint,
                isAccessible: isAccessible,
                lastScannedAt: lastScannedAt,
                scanStatus: scanStatus,
                notes: notes,
                createdAt: createdAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FolderLinksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({documentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (documentsRefs) db.documents],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (documentsRefs)
                    await $_getPrefetchedData<
                      FolderLink,
                      $FolderLinksTable,
                      Document
                    >(
                      currentTable: table,
                      referencedTable: $$FolderLinksTableReferences
                          ._documentsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$FolderLinksTableReferences(
                            db,
                            table,
                            p0,
                          ).documentsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.folderLinkId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$FolderLinksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FolderLinksTable,
      FolderLink,
      $$FolderLinksTableFilterComposer,
      $$FolderLinksTableOrderingComposer,
      $$FolderLinksTableAnnotationComposer,
      $$FolderLinksTableCreateCompanionBuilder,
      $$FolderLinksTableUpdateCompanionBuilder,
      (FolderLink, $$FolderLinksTableReferences),
      FolderLink,
      PrefetchHooks Function({bool documentsRefs})
    >;
typedef $$DocumentsTableCreateCompanionBuilder =
    DocumentsCompanion Function({
      required String id,
      Value<String?> folderLinkId,
      required String fileName,
      required String uriString,
      required String mimeType,
      required String extension,
      required int fileSize,
      required int lastModified,
      Value<String?> sha256Hash,
      required String category,
      Value<int> isAvailable,
      Value<int> hasExtractedText,
      required int createdAt,
      required int updatedAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });
typedef $$DocumentsTableUpdateCompanionBuilder =
    DocumentsCompanion Function({
      Value<String> id,
      Value<String?> folderLinkId,
      Value<String> fileName,
      Value<String> uriString,
      Value<String> mimeType,
      Value<String> extension,
      Value<int> fileSize,
      Value<int> lastModified,
      Value<String?> sha256Hash,
      Value<String> category,
      Value<int> isAvailable,
      Value<int> hasExtractedText,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });

final class $$DocumentsTableReferences
    extends BaseReferences<_$AppDatabase, $DocumentsTable, Document> {
  $$DocumentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FolderLinksTable _folderLinkIdTable(_$AppDatabase db) =>
      db.folderLinks.createAlias('documents__folder_link_id__folder_links__id');

  $$FolderLinksTableProcessedTableManager? get folderLinkId {
    final $_column = $_itemColumn<String>('folder_link_id');
    if ($_column == null) return null;
    final manager = $$FolderLinksTableTableManager(
      $_db,
      $_db.folderLinks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_folderLinkIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$CaseDocumentsTable, List<CaseDocument>>
  _caseDocumentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.caseDocuments,
    aliasName: 'documents__id__case_documents__document_id',
  );

  $$CaseDocumentsTableProcessedTableManager get caseDocumentsRefs {
    final manager = $$CaseDocumentsTableTableManager(
      $_db,
      $_db.caseDocuments,
    ).filter((f) => f.documentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_caseDocumentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $DocumentTextIndexTable,
    List<DocumentTextIndexData>
  >
  _documentTextIndexRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.documentTextIndex,
        aliasName: 'documents__id__document_text_index__document_id',
      );

  $$DocumentTextIndexTableProcessedTableManager get documentTextIndexRefs {
    final manager = $$DocumentTextIndexTableTableManager(
      $_db,
      $_db.documentTextIndex,
    ).filter((f) => f.documentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _documentTextIndexRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CaseProceduresTable, List<CaseProcedure>>
  _caseProceduresRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.caseProcedures,
    aliasName: 'documents__id__case_procedures__document_id',
  );

  $$CaseProceduresTableProcessedTableManager get caseProceduresRefs {
    final manager = $$CaseProceduresTableTableManager(
      $_db,
      $_db.caseProcedures,
    ).filter((f) => f.documentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_caseProceduresRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ExpensesTable, List<Expense>> _expensesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.expenses,
    aliasName: 'documents__id__expenses__document_id',
  );

  $$ExpensesTableProcessedTableManager get expensesRefs {
    final manager = $$ExpensesTableTableManager(
      $_db,
      $_db.expenses,
    ).filter((f) => f.documentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_expensesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ContractsTable, List<Contract>>
  _contractsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.contracts,
    aliasName: 'documents__id__contracts__document_id',
  );

  $$ContractsTableProcessedTableManager get contractsRefs {
    final manager = $$ContractsTableTableManager(
      $_db,
      $_db.contracts,
    ).filter((f) => f.documentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_contractsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DocumentsTableFilterComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uriString => $composableBuilder(
    column: $table.uriString,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get extension => $composableBuilder(
    column: $table.extension,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fileSize => $composableBuilder(
    column: $table.fileSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sha256Hash => $composableBuilder(
    column: $table.sha256Hash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isAvailable => $composableBuilder(
    column: $table.isAvailable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hasExtractedText => $composableBuilder(
    column: $table.hasExtractedText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$FolderLinksTableFilterComposer get folderLinkId {
    final $$FolderLinksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.folderLinkId,
      referencedTable: $db.folderLinks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FolderLinksTableFilterComposer(
            $db: $db,
            $table: $db.folderLinks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> caseDocumentsRefs(
    Expression<bool> Function($$CaseDocumentsTableFilterComposer f) f,
  ) {
    final $$CaseDocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.caseDocuments,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CaseDocumentsTableFilterComposer(
            $db: $db,
            $table: $db.caseDocuments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> documentTextIndexRefs(
    Expression<bool> Function($$DocumentTextIndexTableFilterComposer f) f,
  ) {
    final $$DocumentTextIndexTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documentTextIndex,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentTextIndexTableFilterComposer(
            $db: $db,
            $table: $db.documentTextIndex,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> caseProceduresRefs(
    Expression<bool> Function($$CaseProceduresTableFilterComposer f) f,
  ) {
    final $$CaseProceduresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.caseProcedures,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CaseProceduresTableFilterComposer(
            $db: $db,
            $table: $db.caseProcedures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> expensesRefs(
    Expression<bool> Function($$ExpensesTableFilterComposer f) f,
  ) {
    final $$ExpensesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expenses,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableFilterComposer(
            $db: $db,
            $table: $db.expenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> contractsRefs(
    Expression<bool> Function($$ContractsTableFilterComposer f) f,
  ) {
    final $$ContractsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contracts,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContractsTableFilterComposer(
            $db: $db,
            $table: $db.contracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DocumentsTableOrderingComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uriString => $composableBuilder(
    column: $table.uriString,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get extension => $composableBuilder(
    column: $table.extension,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fileSize => $composableBuilder(
    column: $table.fileSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sha256Hash => $composableBuilder(
    column: $table.sha256Hash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isAvailable => $composableBuilder(
    column: $table.isAvailable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hasExtractedText => $composableBuilder(
    column: $table.hasExtractedText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$FolderLinksTableOrderingComposer get folderLinkId {
    final $$FolderLinksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.folderLinkId,
      referencedTable: $db.folderLinks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FolderLinksTableOrderingComposer(
            $db: $db,
            $table: $db.folderLinks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<String> get uriString =>
      $composableBuilder(column: $table.uriString, builder: (column) => column);

  GeneratedColumn<String> get mimeType =>
      $composableBuilder(column: $table.mimeType, builder: (column) => column);

  GeneratedColumn<String> get extension =>
      $composableBuilder(column: $table.extension, builder: (column) => column);

  GeneratedColumn<int> get fileSize =>
      $composableBuilder(column: $table.fileSize, builder: (column) => column);

  GeneratedColumn<int> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sha256Hash => $composableBuilder(
    column: $table.sha256Hash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get isAvailable => $composableBuilder(
    column: $table.isAvailable,
    builder: (column) => column,
  );

  GeneratedColumn<int> get hasExtractedText => $composableBuilder(
    column: $table.hasExtractedText,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$FolderLinksTableAnnotationComposer get folderLinkId {
    final $$FolderLinksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.folderLinkId,
      referencedTable: $db.folderLinks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FolderLinksTableAnnotationComposer(
            $db: $db,
            $table: $db.folderLinks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> caseDocumentsRefs<T extends Object>(
    Expression<T> Function($$CaseDocumentsTableAnnotationComposer a) f,
  ) {
    final $$CaseDocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.caseDocuments,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CaseDocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.caseDocuments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> documentTextIndexRefs<T extends Object>(
    Expression<T> Function($$DocumentTextIndexTableAnnotationComposer a) f,
  ) {
    final $$DocumentTextIndexTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.documentTextIndex,
          getReferencedColumn: (t) => t.documentId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DocumentTextIndexTableAnnotationComposer(
                $db: $db,
                $table: $db.documentTextIndex,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> caseProceduresRefs<T extends Object>(
    Expression<T> Function($$CaseProceduresTableAnnotationComposer a) f,
  ) {
    final $$CaseProceduresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.caseProcedures,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CaseProceduresTableAnnotationComposer(
            $db: $db,
            $table: $db.caseProcedures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> expensesRefs<T extends Object>(
    Expression<T> Function($$ExpensesTableAnnotationComposer a) f,
  ) {
    final $$ExpensesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expenses,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableAnnotationComposer(
            $db: $db,
            $table: $db.expenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> contractsRefs<T extends Object>(
    Expression<T> Function($$ContractsTableAnnotationComposer a) f,
  ) {
    final $$ContractsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contracts,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContractsTableAnnotationComposer(
            $db: $db,
            $table: $db.contracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DocumentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DocumentsTable,
          Document,
          $$DocumentsTableFilterComposer,
          $$DocumentsTableOrderingComposer,
          $$DocumentsTableAnnotationComposer,
          $$DocumentsTableCreateCompanionBuilder,
          $$DocumentsTableUpdateCompanionBuilder,
          (Document, $$DocumentsTableReferences),
          Document,
          PrefetchHooks Function({
            bool folderLinkId,
            bool caseDocumentsRefs,
            bool documentTextIndexRefs,
            bool caseProceduresRefs,
            bool expensesRefs,
            bool contractsRefs,
          })
        > {
  $$DocumentsTableTableManager(_$AppDatabase db, $DocumentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DocumentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DocumentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> folderLinkId = const Value.absent(),
                Value<String> fileName = const Value.absent(),
                Value<String> uriString = const Value.absent(),
                Value<String> mimeType = const Value.absent(),
                Value<String> extension = const Value.absent(),
                Value<int> fileSize = const Value.absent(),
                Value<int> lastModified = const Value.absent(),
                Value<String?> sha256Hash = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<int> isAvailable = const Value.absent(),
                Value<int> hasExtractedText = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumentsCompanion(
                id: id,
                folderLinkId: folderLinkId,
                fileName: fileName,
                uriString: uriString,
                mimeType: mimeType,
                extension: extension,
                fileSize: fileSize,
                lastModified: lastModified,
                sha256Hash: sha256Hash,
                category: category,
                isAvailable: isAvailable,
                hasExtractedText: hasExtractedText,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> folderLinkId = const Value.absent(),
                required String fileName,
                required String uriString,
                required String mimeType,
                required String extension,
                required int fileSize,
                required int lastModified,
                Value<String?> sha256Hash = const Value.absent(),
                required String category,
                Value<int> isAvailable = const Value.absent(),
                Value<int> hasExtractedText = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumentsCompanion.insert(
                id: id,
                folderLinkId: folderLinkId,
                fileName: fileName,
                uriString: uriString,
                mimeType: mimeType,
                extension: extension,
                fileSize: fileSize,
                lastModified: lastModified,
                sha256Hash: sha256Hash,
                category: category,
                isAvailable: isAvailable,
                hasExtractedText: hasExtractedText,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DocumentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                folderLinkId = false,
                caseDocumentsRefs = false,
                documentTextIndexRefs = false,
                caseProceduresRefs = false,
                expensesRefs = false,
                contractsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (caseDocumentsRefs) db.caseDocuments,
                    if (documentTextIndexRefs) db.documentTextIndex,
                    if (caseProceduresRefs) db.caseProcedures,
                    if (expensesRefs) db.expenses,
                    if (contractsRefs) db.contracts,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (folderLinkId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.folderLinkId,
                                    referencedTable: $$DocumentsTableReferences
                                        ._folderLinkIdTable(db),
                                    referencedColumn: $$DocumentsTableReferences
                                        ._folderLinkIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (caseDocumentsRefs)
                        await $_getPrefetchedData<
                          Document,
                          $DocumentsTable,
                          CaseDocument
                        >(
                          currentTable: table,
                          referencedTable: $$DocumentsTableReferences
                              ._caseDocumentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DocumentsTableReferences(
                                db,
                                table,
                                p0,
                              ).caseDocumentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.documentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (documentTextIndexRefs)
                        await $_getPrefetchedData<
                          Document,
                          $DocumentsTable,
                          DocumentTextIndexData
                        >(
                          currentTable: table,
                          referencedTable: $$DocumentsTableReferences
                              ._documentTextIndexRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DocumentsTableReferences(
                                db,
                                table,
                                p0,
                              ).documentTextIndexRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.documentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (caseProceduresRefs)
                        await $_getPrefetchedData<
                          Document,
                          $DocumentsTable,
                          CaseProcedure
                        >(
                          currentTable: table,
                          referencedTable: $$DocumentsTableReferences
                              ._caseProceduresRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DocumentsTableReferences(
                                db,
                                table,
                                p0,
                              ).caseProceduresRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.documentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (expensesRefs)
                        await $_getPrefetchedData<
                          Document,
                          $DocumentsTable,
                          Expense
                        >(
                          currentTable: table,
                          referencedTable: $$DocumentsTableReferences
                              ._expensesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DocumentsTableReferences(
                                db,
                                table,
                                p0,
                              ).expensesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.documentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (contractsRefs)
                        await $_getPrefetchedData<
                          Document,
                          $DocumentsTable,
                          Contract
                        >(
                          currentTable: table,
                          referencedTable: $$DocumentsTableReferences
                              ._contractsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DocumentsTableReferences(
                                db,
                                table,
                                p0,
                              ).contractsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.documentId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$DocumentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DocumentsTable,
      Document,
      $$DocumentsTableFilterComposer,
      $$DocumentsTableOrderingComposer,
      $$DocumentsTableAnnotationComposer,
      $$DocumentsTableCreateCompanionBuilder,
      $$DocumentsTableUpdateCompanionBuilder,
      (Document, $$DocumentsTableReferences),
      Document,
      PrefetchHooks Function({
        bool folderLinkId,
        bool caseDocumentsRefs,
        bool documentTextIndexRefs,
        bool caseProceduresRefs,
        bool expensesRefs,
        bool contractsRefs,
      })
    >;
typedef $$CaseDocumentsTableCreateCompanionBuilder =
    CaseDocumentsCompanion Function({
      required String id,
      required String caseId,
      required String documentId,
      Value<String?> relationNote,
      required int createdAt,
      Value<int> rowid,
    });
typedef $$CaseDocumentsTableUpdateCompanionBuilder =
    CaseDocumentsCompanion Function({
      Value<String> id,
      Value<String> caseId,
      Value<String> documentId,
      Value<String?> relationNote,
      Value<int> createdAt,
      Value<int> rowid,
    });

final class $$CaseDocumentsTableReferences
    extends BaseReferences<_$AppDatabase, $CaseDocumentsTable, CaseDocument> {
  $$CaseDocumentsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CasesTable _caseIdTable(_$AppDatabase db) =>
      db.cases.createAlias('case_documents__case_id__cases__id');

  $$CasesTableProcessedTableManager get caseId {
    final $_column = $_itemColumn<String>('case_id')!;

    final manager = $$CasesTableTableManager(
      $_db,
      $_db.cases,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_caseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DocumentsTable _documentIdTable(_$AppDatabase db) =>
      db.documents.createAlias('case_documents__document_id__documents__id');

  $$DocumentsTableProcessedTableManager get documentId {
    final $_column = $_itemColumn<String>('document_id')!;

    final manager = $$DocumentsTableTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_documentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CaseDocumentsTableFilterComposer
    extends Composer<_$AppDatabase, $CaseDocumentsTable> {
  $$CaseDocumentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relationNote => $composableBuilder(
    column: $table.relationNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CasesTableFilterComposer get caseId {
    final $$CasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.caseId,
      referencedTable: $db.cases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasesTableFilterComposer(
            $db: $db,
            $table: $db.cases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableFilterComposer get documentId {
    final $$DocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CaseDocumentsTableOrderingComposer
    extends Composer<_$AppDatabase, $CaseDocumentsTable> {
  $$CaseDocumentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relationNote => $composableBuilder(
    column: $table.relationNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CasesTableOrderingComposer get caseId {
    final $$CasesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.caseId,
      referencedTable: $db.cases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasesTableOrderingComposer(
            $db: $db,
            $table: $db.cases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableOrderingComposer get documentId {
    final $$DocumentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableOrderingComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CaseDocumentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CaseDocumentsTable> {
  $$CaseDocumentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get relationNote => $composableBuilder(
    column: $table.relationNote,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CasesTableAnnotationComposer get caseId {
    final $$CasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.caseId,
      referencedTable: $db.cases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasesTableAnnotationComposer(
            $db: $db,
            $table: $db.cases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableAnnotationComposer get documentId {
    final $$DocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CaseDocumentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CaseDocumentsTable,
          CaseDocument,
          $$CaseDocumentsTableFilterComposer,
          $$CaseDocumentsTableOrderingComposer,
          $$CaseDocumentsTableAnnotationComposer,
          $$CaseDocumentsTableCreateCompanionBuilder,
          $$CaseDocumentsTableUpdateCompanionBuilder,
          (CaseDocument, $$CaseDocumentsTableReferences),
          CaseDocument,
          PrefetchHooks Function({bool caseId, bool documentId})
        > {
  $$CaseDocumentsTableTableManager(_$AppDatabase db, $CaseDocumentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CaseDocumentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CaseDocumentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CaseDocumentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> caseId = const Value.absent(),
                Value<String> documentId = const Value.absent(),
                Value<String?> relationNote = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CaseDocumentsCompanion(
                id: id,
                caseId: caseId,
                documentId: documentId,
                relationNote: relationNote,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String caseId,
                required String documentId,
                Value<String?> relationNote = const Value.absent(),
                required int createdAt,
                Value<int> rowid = const Value.absent(),
              }) => CaseDocumentsCompanion.insert(
                id: id,
                caseId: caseId,
                documentId: documentId,
                relationNote: relationNote,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CaseDocumentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({caseId = false, documentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (caseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.caseId,
                                referencedTable: $$CaseDocumentsTableReferences
                                    ._caseIdTable(db),
                                referencedColumn: $$CaseDocumentsTableReferences
                                    ._caseIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (documentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.documentId,
                                referencedTable: $$CaseDocumentsTableReferences
                                    ._documentIdTable(db),
                                referencedColumn: $$CaseDocumentsTableReferences
                                    ._documentIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CaseDocumentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CaseDocumentsTable,
      CaseDocument,
      $$CaseDocumentsTableFilterComposer,
      $$CaseDocumentsTableOrderingComposer,
      $$CaseDocumentsTableAnnotationComposer,
      $$CaseDocumentsTableCreateCompanionBuilder,
      $$CaseDocumentsTableUpdateCompanionBuilder,
      (CaseDocument, $$CaseDocumentsTableReferences),
      CaseDocument,
      PrefetchHooks Function({bool caseId, bool documentId})
    >;
typedef $$DocumentTextIndexTableCreateCompanionBuilder =
    DocumentTextIndexCompanion Function({
      required String id,
      required String documentId,
      required String extractedText,
      required String normalizedText,
      required String extractionMethod,
      required int indexedAt,
      Value<int> rowid,
    });
typedef $$DocumentTextIndexTableUpdateCompanionBuilder =
    DocumentTextIndexCompanion Function({
      Value<String> id,
      Value<String> documentId,
      Value<String> extractedText,
      Value<String> normalizedText,
      Value<String> extractionMethod,
      Value<int> indexedAt,
      Value<int> rowid,
    });

final class $$DocumentTextIndexTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $DocumentTextIndexTable,
          DocumentTextIndexData
        > {
  $$DocumentTextIndexTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DocumentsTable _documentIdTable(_$AppDatabase db) => db.documents
      .createAlias('document_text_index__document_id__documents__id');

  $$DocumentsTableProcessedTableManager get documentId {
    final $_column = $_itemColumn<String>('document_id')!;

    final manager = $$DocumentsTableTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_documentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DocumentTextIndexTableFilterComposer
    extends Composer<_$AppDatabase, $DocumentTextIndexTable> {
  $$DocumentTextIndexTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get extractedText => $composableBuilder(
    column: $table.extractedText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedText => $composableBuilder(
    column: $table.normalizedText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get extractionMethod => $composableBuilder(
    column: $table.extractionMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get indexedAt => $composableBuilder(
    column: $table.indexedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$DocumentsTableFilterComposer get documentId {
    final $$DocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumentTextIndexTableOrderingComposer
    extends Composer<_$AppDatabase, $DocumentTextIndexTable> {
  $$DocumentTextIndexTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get extractedText => $composableBuilder(
    column: $table.extractedText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedText => $composableBuilder(
    column: $table.normalizedText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get extractionMethod => $composableBuilder(
    column: $table.extractionMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get indexedAt => $composableBuilder(
    column: $table.indexedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$DocumentsTableOrderingComposer get documentId {
    final $$DocumentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableOrderingComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumentTextIndexTableAnnotationComposer
    extends Composer<_$AppDatabase, $DocumentTextIndexTable> {
  $$DocumentTextIndexTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get extractedText => $composableBuilder(
    column: $table.extractedText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get normalizedText => $composableBuilder(
    column: $table.normalizedText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get extractionMethod => $composableBuilder(
    column: $table.extractionMethod,
    builder: (column) => column,
  );

  GeneratedColumn<int> get indexedAt =>
      $composableBuilder(column: $table.indexedAt, builder: (column) => column);

  $$DocumentsTableAnnotationComposer get documentId {
    final $$DocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumentTextIndexTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DocumentTextIndexTable,
          DocumentTextIndexData,
          $$DocumentTextIndexTableFilterComposer,
          $$DocumentTextIndexTableOrderingComposer,
          $$DocumentTextIndexTableAnnotationComposer,
          $$DocumentTextIndexTableCreateCompanionBuilder,
          $$DocumentTextIndexTableUpdateCompanionBuilder,
          (DocumentTextIndexData, $$DocumentTextIndexTableReferences),
          DocumentTextIndexData,
          PrefetchHooks Function({bool documentId})
        > {
  $$DocumentTextIndexTableTableManager(
    _$AppDatabase db,
    $DocumentTextIndexTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumentTextIndexTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DocumentTextIndexTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DocumentTextIndexTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> documentId = const Value.absent(),
                Value<String> extractedText = const Value.absent(),
                Value<String> normalizedText = const Value.absent(),
                Value<String> extractionMethod = const Value.absent(),
                Value<int> indexedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumentTextIndexCompanion(
                id: id,
                documentId: documentId,
                extractedText: extractedText,
                normalizedText: normalizedText,
                extractionMethod: extractionMethod,
                indexedAt: indexedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String documentId,
                required String extractedText,
                required String normalizedText,
                required String extractionMethod,
                required int indexedAt,
                Value<int> rowid = const Value.absent(),
              }) => DocumentTextIndexCompanion.insert(
                id: id,
                documentId: documentId,
                extractedText: extractedText,
                normalizedText: normalizedText,
                extractionMethod: extractionMethod,
                indexedAt: indexedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DocumentTextIndexTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({documentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (documentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.documentId,
                                referencedTable:
                                    $$DocumentTextIndexTableReferences
                                        ._documentIdTable(db),
                                referencedColumn:
                                    $$DocumentTextIndexTableReferences
                                        ._documentIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DocumentTextIndexTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DocumentTextIndexTable,
      DocumentTextIndexData,
      $$DocumentTextIndexTableFilterComposer,
      $$DocumentTextIndexTableOrderingComposer,
      $$DocumentTextIndexTableAnnotationComposer,
      $$DocumentTextIndexTableCreateCompanionBuilder,
      $$DocumentTextIndexTableUpdateCompanionBuilder,
      (DocumentTextIndexData, $$DocumentTextIndexTableReferences),
      DocumentTextIndexData,
      PrefetchHooks Function({bool documentId})
    >;
typedef $$HearingsTableCreateCompanionBuilder =
    HearingsCompanion Function({
      required String id,
      required String caseId,
      Value<String?> courtId,
      required int hearingDate,
      required String hearingType,
      Value<String> status,
      Value<String?> decision,
      Value<String?> postponementReason,
      Value<int?> nextHearingDate,
      Value<String?> lawyerNotes,
      required int createdAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });
typedef $$HearingsTableUpdateCompanionBuilder =
    HearingsCompanion Function({
      Value<String> id,
      Value<String> caseId,
      Value<String?> courtId,
      Value<int> hearingDate,
      Value<String> hearingType,
      Value<String> status,
      Value<String?> decision,
      Value<String?> postponementReason,
      Value<int?> nextHearingDate,
      Value<String?> lawyerNotes,
      Value<int> createdAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });

final class $$HearingsTableReferences
    extends BaseReferences<_$AppDatabase, $HearingsTable, Hearing> {
  $$HearingsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CasesTable _caseIdTable(_$AppDatabase db) =>
      db.cases.createAlias('hearings__case_id__cases__id');

  $$CasesTableProcessedTableManager get caseId {
    final $_column = $_itemColumn<String>('case_id')!;

    final manager = $$CasesTableTableManager(
      $_db,
      $_db.cases,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_caseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CourtsTable _courtIdTable(_$AppDatabase db) =>
      db.courts.createAlias('hearings__court_id__courts__id');

  $$CourtsTableProcessedTableManager? get courtId {
    final $_column = $_itemColumn<String>('court_id');
    if ($_column == null) return null;
    final manager = $$CourtsTableTableManager(
      $_db,
      $_db.courts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_courtIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$HearingsTableFilterComposer
    extends Composer<_$AppDatabase, $HearingsTable> {
  $$HearingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hearingDate => $composableBuilder(
    column: $table.hearingDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hearingType => $composableBuilder(
    column: $table.hearingType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get decision => $composableBuilder(
    column: $table.decision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get postponementReason => $composableBuilder(
    column: $table.postponementReason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nextHearingDate => $composableBuilder(
    column: $table.nextHearingDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lawyerNotes => $composableBuilder(
    column: $table.lawyerNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CasesTableFilterComposer get caseId {
    final $$CasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.caseId,
      referencedTable: $db.cases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasesTableFilterComposer(
            $db: $db,
            $table: $db.cases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CourtsTableFilterComposer get courtId {
    final $$CourtsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.courtId,
      referencedTable: $db.courts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CourtsTableFilterComposer(
            $db: $db,
            $table: $db.courts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HearingsTableOrderingComposer
    extends Composer<_$AppDatabase, $HearingsTable> {
  $$HearingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hearingDate => $composableBuilder(
    column: $table.hearingDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hearingType => $composableBuilder(
    column: $table.hearingType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get decision => $composableBuilder(
    column: $table.decision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get postponementReason => $composableBuilder(
    column: $table.postponementReason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextHearingDate => $composableBuilder(
    column: $table.nextHearingDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lawyerNotes => $composableBuilder(
    column: $table.lawyerNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CasesTableOrderingComposer get caseId {
    final $$CasesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.caseId,
      referencedTable: $db.cases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasesTableOrderingComposer(
            $db: $db,
            $table: $db.cases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CourtsTableOrderingComposer get courtId {
    final $$CourtsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.courtId,
      referencedTable: $db.courts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CourtsTableOrderingComposer(
            $db: $db,
            $table: $db.courts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HearingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HearingsTable> {
  $$HearingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get hearingDate => $composableBuilder(
    column: $table.hearingDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get hearingType => $composableBuilder(
    column: $table.hearingType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get decision =>
      $composableBuilder(column: $table.decision, builder: (column) => column);

  GeneratedColumn<String> get postponementReason => $composableBuilder(
    column: $table.postponementReason,
    builder: (column) => column,
  );

  GeneratedColumn<int> get nextHearingDate => $composableBuilder(
    column: $table.nextHearingDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lawyerNotes => $composableBuilder(
    column: $table.lawyerNotes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$CasesTableAnnotationComposer get caseId {
    final $$CasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.caseId,
      referencedTable: $db.cases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasesTableAnnotationComposer(
            $db: $db,
            $table: $db.cases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CourtsTableAnnotationComposer get courtId {
    final $$CourtsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.courtId,
      referencedTable: $db.courts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CourtsTableAnnotationComposer(
            $db: $db,
            $table: $db.courts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HearingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HearingsTable,
          Hearing,
          $$HearingsTableFilterComposer,
          $$HearingsTableOrderingComposer,
          $$HearingsTableAnnotationComposer,
          $$HearingsTableCreateCompanionBuilder,
          $$HearingsTableUpdateCompanionBuilder,
          (Hearing, $$HearingsTableReferences),
          Hearing,
          PrefetchHooks Function({bool caseId, bool courtId})
        > {
  $$HearingsTableTableManager(_$AppDatabase db, $HearingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HearingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HearingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HearingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> caseId = const Value.absent(),
                Value<String?> courtId = const Value.absent(),
                Value<int> hearingDate = const Value.absent(),
                Value<String> hearingType = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> decision = const Value.absent(),
                Value<String?> postponementReason = const Value.absent(),
                Value<int?> nextHearingDate = const Value.absent(),
                Value<String?> lawyerNotes = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HearingsCompanion(
                id: id,
                caseId: caseId,
                courtId: courtId,
                hearingDate: hearingDate,
                hearingType: hearingType,
                status: status,
                decision: decision,
                postponementReason: postponementReason,
                nextHearingDate: nextHearingDate,
                lawyerNotes: lawyerNotes,
                createdAt: createdAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String caseId,
                Value<String?> courtId = const Value.absent(),
                required int hearingDate,
                required String hearingType,
                Value<String> status = const Value.absent(),
                Value<String?> decision = const Value.absent(),
                Value<String?> postponementReason = const Value.absent(),
                Value<int?> nextHearingDate = const Value.absent(),
                Value<String?> lawyerNotes = const Value.absent(),
                required int createdAt,
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HearingsCompanion.insert(
                id: id,
                caseId: caseId,
                courtId: courtId,
                hearingDate: hearingDate,
                hearingType: hearingType,
                status: status,
                decision: decision,
                postponementReason: postponementReason,
                nextHearingDate: nextHearingDate,
                lawyerNotes: lawyerNotes,
                createdAt: createdAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$HearingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({caseId = false, courtId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (caseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.caseId,
                                referencedTable: $$HearingsTableReferences
                                    ._caseIdTable(db),
                                referencedColumn: $$HearingsTableReferences
                                    ._caseIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (courtId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.courtId,
                                referencedTable: $$HearingsTableReferences
                                    ._courtIdTable(db),
                                referencedColumn: $$HearingsTableReferences
                                    ._courtIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$HearingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HearingsTable,
      Hearing,
      $$HearingsTableFilterComposer,
      $$HearingsTableOrderingComposer,
      $$HearingsTableAnnotationComposer,
      $$HearingsTableCreateCompanionBuilder,
      $$HearingsTableUpdateCompanionBuilder,
      (Hearing, $$HearingsTableReferences),
      Hearing,
      PrefetchHooks Function({bool caseId, bool courtId})
    >;
typedef $$CaseProceduresTableCreateCompanionBuilder =
    CaseProceduresCompanion Function({
      required String id,
      required String caseId,
      required int procedureDate,
      required String title,
      required String procedureType,
      Value<String?> description,
      Value<String?> result,
      Value<String?> documentId,
      required int createdAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });
typedef $$CaseProceduresTableUpdateCompanionBuilder =
    CaseProceduresCompanion Function({
      Value<String> id,
      Value<String> caseId,
      Value<int> procedureDate,
      Value<String> title,
      Value<String> procedureType,
      Value<String?> description,
      Value<String?> result,
      Value<String?> documentId,
      Value<int> createdAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });

final class $$CaseProceduresTableReferences
    extends BaseReferences<_$AppDatabase, $CaseProceduresTable, CaseProcedure> {
  $$CaseProceduresTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CasesTable _caseIdTable(_$AppDatabase db) =>
      db.cases.createAlias('case_procedures__case_id__cases__id');

  $$CasesTableProcessedTableManager get caseId {
    final $_column = $_itemColumn<String>('case_id')!;

    final manager = $$CasesTableTableManager(
      $_db,
      $_db.cases,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_caseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DocumentsTable _documentIdTable(_$AppDatabase db) =>
      db.documents.createAlias('case_procedures__document_id__documents__id');

  $$DocumentsTableProcessedTableManager? get documentId {
    final $_column = $_itemColumn<String>('document_id');
    if ($_column == null) return null;
    final manager = $$DocumentsTableTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_documentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CaseProceduresTableFilterComposer
    extends Composer<_$AppDatabase, $CaseProceduresTable> {
  $$CaseProceduresTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get procedureDate => $composableBuilder(
    column: $table.procedureDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get procedureType => $composableBuilder(
    column: $table.procedureType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get result => $composableBuilder(
    column: $table.result,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CasesTableFilterComposer get caseId {
    final $$CasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.caseId,
      referencedTable: $db.cases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasesTableFilterComposer(
            $db: $db,
            $table: $db.cases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableFilterComposer get documentId {
    final $$DocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CaseProceduresTableOrderingComposer
    extends Composer<_$AppDatabase, $CaseProceduresTable> {
  $$CaseProceduresTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get procedureDate => $composableBuilder(
    column: $table.procedureDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get procedureType => $composableBuilder(
    column: $table.procedureType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get result => $composableBuilder(
    column: $table.result,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CasesTableOrderingComposer get caseId {
    final $$CasesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.caseId,
      referencedTable: $db.cases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasesTableOrderingComposer(
            $db: $db,
            $table: $db.cases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableOrderingComposer get documentId {
    final $$DocumentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableOrderingComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CaseProceduresTableAnnotationComposer
    extends Composer<_$AppDatabase, $CaseProceduresTable> {
  $$CaseProceduresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get procedureDate => $composableBuilder(
    column: $table.procedureDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get procedureType => $composableBuilder(
    column: $table.procedureType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get result =>
      $composableBuilder(column: $table.result, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$CasesTableAnnotationComposer get caseId {
    final $$CasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.caseId,
      referencedTable: $db.cases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasesTableAnnotationComposer(
            $db: $db,
            $table: $db.cases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableAnnotationComposer get documentId {
    final $$DocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CaseProceduresTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CaseProceduresTable,
          CaseProcedure,
          $$CaseProceduresTableFilterComposer,
          $$CaseProceduresTableOrderingComposer,
          $$CaseProceduresTableAnnotationComposer,
          $$CaseProceduresTableCreateCompanionBuilder,
          $$CaseProceduresTableUpdateCompanionBuilder,
          (CaseProcedure, $$CaseProceduresTableReferences),
          CaseProcedure,
          PrefetchHooks Function({bool caseId, bool documentId})
        > {
  $$CaseProceduresTableTableManager(
    _$AppDatabase db,
    $CaseProceduresTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CaseProceduresTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CaseProceduresTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CaseProceduresTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> caseId = const Value.absent(),
                Value<int> procedureDate = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> procedureType = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> result = const Value.absent(),
                Value<String?> documentId = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CaseProceduresCompanion(
                id: id,
                caseId: caseId,
                procedureDate: procedureDate,
                title: title,
                procedureType: procedureType,
                description: description,
                result: result,
                documentId: documentId,
                createdAt: createdAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String caseId,
                required int procedureDate,
                required String title,
                required String procedureType,
                Value<String?> description = const Value.absent(),
                Value<String?> result = const Value.absent(),
                Value<String?> documentId = const Value.absent(),
                required int createdAt,
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CaseProceduresCompanion.insert(
                id: id,
                caseId: caseId,
                procedureDate: procedureDate,
                title: title,
                procedureType: procedureType,
                description: description,
                result: result,
                documentId: documentId,
                createdAt: createdAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CaseProceduresTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({caseId = false, documentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (caseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.caseId,
                                referencedTable: $$CaseProceduresTableReferences
                                    ._caseIdTable(db),
                                referencedColumn:
                                    $$CaseProceduresTableReferences
                                        ._caseIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (documentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.documentId,
                                referencedTable: $$CaseProceduresTableReferences
                                    ._documentIdTable(db),
                                referencedColumn:
                                    $$CaseProceduresTableReferences
                                        ._documentIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CaseProceduresTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CaseProceduresTable,
      CaseProcedure,
      $$CaseProceduresTableFilterComposer,
      $$CaseProceduresTableOrderingComposer,
      $$CaseProceduresTableAnnotationComposer,
      $$CaseProceduresTableCreateCompanionBuilder,
      $$CaseProceduresTableUpdateCompanionBuilder,
      (CaseProcedure, $$CaseProceduresTableReferences),
      CaseProcedure,
      PrefetchHooks Function({bool caseId, bool documentId})
    >;
typedef $$TasksTableCreateCompanionBuilder =
    TasksCompanion Function({
      required String id,
      required String title,
      Value<String?> description,
      Value<String?> caseId,
      Value<String?> clientId,
      required String priority,
      Value<String> status,
      required int dueDate,
      Value<int?> reminderTime,
      Value<int?> completedAt,
      required int createdAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });
typedef $$TasksTableUpdateCompanionBuilder =
    TasksCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String?> description,
      Value<String?> caseId,
      Value<String?> clientId,
      Value<String> priority,
      Value<String> status,
      Value<int> dueDate,
      Value<int?> reminderTime,
      Value<int?> completedAt,
      Value<int> createdAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });

final class $$TasksTableReferences
    extends BaseReferences<_$AppDatabase, $TasksTable, Task> {
  $$TasksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CasesTable _caseIdTable(_$AppDatabase db) =>
      db.cases.createAlias('tasks__case_id__cases__id');

  $$CasesTableProcessedTableManager? get caseId {
    final $_column = $_itemColumn<String>('case_id');
    if ($_column == null) return null;
    final manager = $$CasesTableTableManager(
      $_db,
      $_db.cases,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_caseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ClientsTable _clientIdTable(_$AppDatabase db) =>
      db.clients.createAlias('tasks__client_id__clients__id');

  $$ClientsTableProcessedTableManager? get clientId {
    final $_column = $_itemColumn<String>('client_id');
    if ($_column == null) return null;
    final manager = $$ClientsTableTableManager(
      $_db,
      $_db.clients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TasksTableFilterComposer extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reminderTime => $composableBuilder(
    column: $table.reminderTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CasesTableFilterComposer get caseId {
    final $$CasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.caseId,
      referencedTable: $db.cases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasesTableFilterComposer(
            $db: $db,
            $table: $db.cases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ClientsTableFilterComposer get clientId {
    final $$ClientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableFilterComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TasksTableOrderingComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reminderTime => $composableBuilder(
    column: $table.reminderTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CasesTableOrderingComposer get caseId {
    final $$CasesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.caseId,
      referencedTable: $db.cases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasesTableOrderingComposer(
            $db: $db,
            $table: $db.cases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ClientsTableOrderingComposer get clientId {
    final $$ClientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableOrderingComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<int> get reminderTime => $composableBuilder(
    column: $table.reminderTime,
    builder: (column) => column,
  );

  GeneratedColumn<int> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$CasesTableAnnotationComposer get caseId {
    final $$CasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.caseId,
      referencedTable: $db.cases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasesTableAnnotationComposer(
            $db: $db,
            $table: $db.cases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ClientsTableAnnotationComposer get clientId {
    final $$ClientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableAnnotationComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TasksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TasksTable,
          Task,
          $$TasksTableFilterComposer,
          $$TasksTableOrderingComposer,
          $$TasksTableAnnotationComposer,
          $$TasksTableCreateCompanionBuilder,
          $$TasksTableUpdateCompanionBuilder,
          (Task, $$TasksTableReferences),
          Task,
          PrefetchHooks Function({bool caseId, bool clientId})
        > {
  $$TasksTableTableManager(_$AppDatabase db, $TasksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> caseId = const Value.absent(),
                Value<String?> clientId = const Value.absent(),
                Value<String> priority = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> dueDate = const Value.absent(),
                Value<int?> reminderTime = const Value.absent(),
                Value<int?> completedAt = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TasksCompanion(
                id: id,
                title: title,
                description: description,
                caseId: caseId,
                clientId: clientId,
                priority: priority,
                status: status,
                dueDate: dueDate,
                reminderTime: reminderTime,
                completedAt: completedAt,
                createdAt: createdAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                Value<String?> description = const Value.absent(),
                Value<String?> caseId = const Value.absent(),
                Value<String?> clientId = const Value.absent(),
                required String priority,
                Value<String> status = const Value.absent(),
                required int dueDate,
                Value<int?> reminderTime = const Value.absent(),
                Value<int?> completedAt = const Value.absent(),
                required int createdAt,
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TasksCompanion.insert(
                id: id,
                title: title,
                description: description,
                caseId: caseId,
                clientId: clientId,
                priority: priority,
                status: status,
                dueDate: dueDate,
                reminderTime: reminderTime,
                completedAt: completedAt,
                createdAt: createdAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TasksTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({caseId = false, clientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (caseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.caseId,
                                referencedTable: $$TasksTableReferences
                                    ._caseIdTable(db),
                                referencedColumn: $$TasksTableReferences
                                    ._caseIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (clientId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.clientId,
                                referencedTable: $$TasksTableReferences
                                    ._clientIdTable(db),
                                referencedColumn: $$TasksTableReferences
                                    ._clientIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TasksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TasksTable,
      Task,
      $$TasksTableFilterComposer,
      $$TasksTableOrderingComposer,
      $$TasksTableAnnotationComposer,
      $$TasksTableCreateCompanionBuilder,
      $$TasksTableUpdateCompanionBuilder,
      (Task, $$TasksTableReferences),
      Task,
      PrefetchHooks Function({bool caseId, bool clientId})
    >;
typedef $$FeeAgreementsTableCreateCompanionBuilder =
    FeeAgreementsCompanion Function({
      required String id,
      required String clientId,
      Value<String?> caseId,
      required int agreedAmount,
      Value<String> currency,
      required String agreementType,
      required int agreementDate,
      Value<String?> notes,
      required int createdAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });
typedef $$FeeAgreementsTableUpdateCompanionBuilder =
    FeeAgreementsCompanion Function({
      Value<String> id,
      Value<String> clientId,
      Value<String?> caseId,
      Value<int> agreedAmount,
      Value<String> currency,
      Value<String> agreementType,
      Value<int> agreementDate,
      Value<String?> notes,
      Value<int> createdAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });

final class $$FeeAgreementsTableReferences
    extends BaseReferences<_$AppDatabase, $FeeAgreementsTable, FeeAgreement> {
  $$FeeAgreementsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ClientsTable _clientIdTable(_$AppDatabase db) =>
      db.clients.createAlias('fee_agreements__client_id__clients__id');

  $$ClientsTableProcessedTableManager get clientId {
    final $_column = $_itemColumn<String>('client_id')!;

    final manager = $$ClientsTableTableManager(
      $_db,
      $_db.clients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CasesTable _caseIdTable(_$AppDatabase db) =>
      db.cases.createAlias('fee_agreements__case_id__cases__id');

  $$CasesTableProcessedTableManager? get caseId {
    final $_column = $_itemColumn<String>('case_id');
    if ($_column == null) return null;
    final manager = $$CasesTableTableManager(
      $_db,
      $_db.cases,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_caseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PaymentsTable, List<Payment>> _paymentsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.payments,
    aliasName: 'fee_agreements__id__payments__fee_agreement_id',
  );

  $$PaymentsTableProcessedTableManager get paymentsRefs {
    final manager = $$PaymentsTableTableManager(
      $_db,
      $_db.payments,
    ).filter((f) => f.feeAgreementId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FeeAgreementsTableFilterComposer
    extends Composer<_$AppDatabase, $FeeAgreementsTable> {
  $$FeeAgreementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get agreedAmount => $composableBuilder(
    column: $table.agreedAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get agreementType => $composableBuilder(
    column: $table.agreementType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get agreementDate => $composableBuilder(
    column: $table.agreementDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ClientsTableFilterComposer get clientId {
    final $$ClientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableFilterComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CasesTableFilterComposer get caseId {
    final $$CasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.caseId,
      referencedTable: $db.cases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasesTableFilterComposer(
            $db: $db,
            $table: $db.cases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> paymentsRefs(
    Expression<bool> Function($$PaymentsTableFilterComposer f) f,
  ) {
    final $$PaymentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.feeAgreementId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableFilterComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FeeAgreementsTableOrderingComposer
    extends Composer<_$AppDatabase, $FeeAgreementsTable> {
  $$FeeAgreementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get agreedAmount => $composableBuilder(
    column: $table.agreedAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get agreementType => $composableBuilder(
    column: $table.agreementType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get agreementDate => $composableBuilder(
    column: $table.agreementDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ClientsTableOrderingComposer get clientId {
    final $$ClientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableOrderingComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CasesTableOrderingComposer get caseId {
    final $$CasesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.caseId,
      referencedTable: $db.cases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasesTableOrderingComposer(
            $db: $db,
            $table: $db.cases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FeeAgreementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FeeAgreementsTable> {
  $$FeeAgreementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get agreedAmount => $composableBuilder(
    column: $table.agreedAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get agreementType => $composableBuilder(
    column: $table.agreementType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get agreementDate => $composableBuilder(
    column: $table.agreementDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$ClientsTableAnnotationComposer get clientId {
    final $$ClientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableAnnotationComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CasesTableAnnotationComposer get caseId {
    final $$CasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.caseId,
      referencedTable: $db.cases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasesTableAnnotationComposer(
            $db: $db,
            $table: $db.cases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> paymentsRefs<T extends Object>(
    Expression<T> Function($$PaymentsTableAnnotationComposer a) f,
  ) {
    final $$PaymentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.feeAgreementId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableAnnotationComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FeeAgreementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FeeAgreementsTable,
          FeeAgreement,
          $$FeeAgreementsTableFilterComposer,
          $$FeeAgreementsTableOrderingComposer,
          $$FeeAgreementsTableAnnotationComposer,
          $$FeeAgreementsTableCreateCompanionBuilder,
          $$FeeAgreementsTableUpdateCompanionBuilder,
          (FeeAgreement, $$FeeAgreementsTableReferences),
          FeeAgreement,
          PrefetchHooks Function({
            bool clientId,
            bool caseId,
            bool paymentsRefs,
          })
        > {
  $$FeeAgreementsTableTableManager(_$AppDatabase db, $FeeAgreementsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeeAgreementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeeAgreementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeeAgreementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> clientId = const Value.absent(),
                Value<String?> caseId = const Value.absent(),
                Value<int> agreedAmount = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String> agreementType = const Value.absent(),
                Value<int> agreementDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FeeAgreementsCompanion(
                id: id,
                clientId: clientId,
                caseId: caseId,
                agreedAmount: agreedAmount,
                currency: currency,
                agreementType: agreementType,
                agreementDate: agreementDate,
                notes: notes,
                createdAt: createdAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String clientId,
                Value<String?> caseId = const Value.absent(),
                required int agreedAmount,
                Value<String> currency = const Value.absent(),
                required String agreementType,
                required int agreementDate,
                Value<String?> notes = const Value.absent(),
                required int createdAt,
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FeeAgreementsCompanion.insert(
                id: id,
                clientId: clientId,
                caseId: caseId,
                agreedAmount: agreedAmount,
                currency: currency,
                agreementType: agreementType,
                agreementDate: agreementDate,
                notes: notes,
                createdAt: createdAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FeeAgreementsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({clientId = false, caseId = false, paymentsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (paymentsRefs) db.payments],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (clientId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.clientId,
                                    referencedTable:
                                        $$FeeAgreementsTableReferences
                                            ._clientIdTable(db),
                                    referencedColumn:
                                        $$FeeAgreementsTableReferences
                                            ._clientIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (caseId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.caseId,
                                    referencedTable:
                                        $$FeeAgreementsTableReferences
                                            ._caseIdTable(db),
                                    referencedColumn:
                                        $$FeeAgreementsTableReferences
                                            ._caseIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (paymentsRefs)
                        await $_getPrefetchedData<
                          FeeAgreement,
                          $FeeAgreementsTable,
                          Payment
                        >(
                          currentTable: table,
                          referencedTable: $$FeeAgreementsTableReferences
                              ._paymentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FeeAgreementsTableReferences(
                                db,
                                table,
                                p0,
                              ).paymentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.feeAgreementId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$FeeAgreementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FeeAgreementsTable,
      FeeAgreement,
      $$FeeAgreementsTableFilterComposer,
      $$FeeAgreementsTableOrderingComposer,
      $$FeeAgreementsTableAnnotationComposer,
      $$FeeAgreementsTableCreateCompanionBuilder,
      $$FeeAgreementsTableUpdateCompanionBuilder,
      (FeeAgreement, $$FeeAgreementsTableReferences),
      FeeAgreement,
      PrefetchHooks Function({bool clientId, bool caseId, bool paymentsRefs})
    >;
typedef $$PaymentsTableCreateCompanionBuilder =
    PaymentsCompanion Function({
      required String id,
      Value<String?> feeAgreementId,
      required String clientId,
      Value<String?> caseId,
      required int amount,
      Value<String> currency,
      required int paymentDate,
      required String paymentMethod,
      Value<String?> receiptNumber,
      Value<String?> notes,
      required int createdAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });
typedef $$PaymentsTableUpdateCompanionBuilder =
    PaymentsCompanion Function({
      Value<String> id,
      Value<String?> feeAgreementId,
      Value<String> clientId,
      Value<String?> caseId,
      Value<int> amount,
      Value<String> currency,
      Value<int> paymentDate,
      Value<String> paymentMethod,
      Value<String?> receiptNumber,
      Value<String?> notes,
      Value<int> createdAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });

final class $$PaymentsTableReferences
    extends BaseReferences<_$AppDatabase, $PaymentsTable, Payment> {
  $$PaymentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FeeAgreementsTable _feeAgreementIdTable(_$AppDatabase db) => db
      .feeAgreements
      .createAlias('payments__fee_agreement_id__fee_agreements__id');

  $$FeeAgreementsTableProcessedTableManager? get feeAgreementId {
    final $_column = $_itemColumn<String>('fee_agreement_id');
    if ($_column == null) return null;
    final manager = $$FeeAgreementsTableTableManager(
      $_db,
      $_db.feeAgreements,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_feeAgreementIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ClientsTable _clientIdTable(_$AppDatabase db) =>
      db.clients.createAlias('payments__client_id__clients__id');

  $$ClientsTableProcessedTableManager get clientId {
    final $_column = $_itemColumn<String>('client_id')!;

    final manager = $$ClientsTableTableManager(
      $_db,
      $_db.clients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CasesTable _caseIdTable(_$AppDatabase db) =>
      db.cases.createAlias('payments__case_id__cases__id');

  $$CasesTableProcessedTableManager? get caseId {
    final $_column = $_itemColumn<String>('case_id');
    if ($_column == null) return null;
    final manager = $$CasesTableTableManager(
      $_db,
      $_db.cases,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_caseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get paymentDate => $composableBuilder(
    column: $table.paymentDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get receiptNumber => $composableBuilder(
    column: $table.receiptNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$FeeAgreementsTableFilterComposer get feeAgreementId {
    final $$FeeAgreementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.feeAgreementId,
      referencedTable: $db.feeAgreements,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeeAgreementsTableFilterComposer(
            $db: $db,
            $table: $db.feeAgreements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ClientsTableFilterComposer get clientId {
    final $$ClientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableFilterComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CasesTableFilterComposer get caseId {
    final $$CasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.caseId,
      referencedTable: $db.cases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasesTableFilterComposer(
            $db: $db,
            $table: $db.cases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get paymentDate => $composableBuilder(
    column: $table.paymentDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get receiptNumber => $composableBuilder(
    column: $table.receiptNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$FeeAgreementsTableOrderingComposer get feeAgreementId {
    final $$FeeAgreementsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.feeAgreementId,
      referencedTable: $db.feeAgreements,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeeAgreementsTableOrderingComposer(
            $db: $db,
            $table: $db.feeAgreements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ClientsTableOrderingComposer get clientId {
    final $$ClientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableOrderingComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CasesTableOrderingComposer get caseId {
    final $$CasesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.caseId,
      referencedTable: $db.cases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasesTableOrderingComposer(
            $db: $db,
            $table: $db.cases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<int> get paymentDate => $composableBuilder(
    column: $table.paymentDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get receiptNumber => $composableBuilder(
    column: $table.receiptNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$FeeAgreementsTableAnnotationComposer get feeAgreementId {
    final $$FeeAgreementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.feeAgreementId,
      referencedTable: $db.feeAgreements,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeeAgreementsTableAnnotationComposer(
            $db: $db,
            $table: $db.feeAgreements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ClientsTableAnnotationComposer get clientId {
    final $$ClientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableAnnotationComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CasesTableAnnotationComposer get caseId {
    final $$CasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.caseId,
      referencedTable: $db.cases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasesTableAnnotationComposer(
            $db: $db,
            $table: $db.cases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaymentsTable,
          Payment,
          $$PaymentsTableFilterComposer,
          $$PaymentsTableOrderingComposer,
          $$PaymentsTableAnnotationComposer,
          $$PaymentsTableCreateCompanionBuilder,
          $$PaymentsTableUpdateCompanionBuilder,
          (Payment, $$PaymentsTableReferences),
          Payment,
          PrefetchHooks Function({
            bool feeAgreementId,
            bool clientId,
            bool caseId,
          })
        > {
  $$PaymentsTableTableManager(_$AppDatabase db, $PaymentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> feeAgreementId = const Value.absent(),
                Value<String> clientId = const Value.absent(),
                Value<String?> caseId = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<int> paymentDate = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<String?> receiptNumber = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentsCompanion(
                id: id,
                feeAgreementId: feeAgreementId,
                clientId: clientId,
                caseId: caseId,
                amount: amount,
                currency: currency,
                paymentDate: paymentDate,
                paymentMethod: paymentMethod,
                receiptNumber: receiptNumber,
                notes: notes,
                createdAt: createdAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> feeAgreementId = const Value.absent(),
                required String clientId,
                Value<String?> caseId = const Value.absent(),
                required int amount,
                Value<String> currency = const Value.absent(),
                required int paymentDate,
                required String paymentMethod,
                Value<String?> receiptNumber = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required int createdAt,
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentsCompanion.insert(
                id: id,
                feeAgreementId: feeAgreementId,
                clientId: clientId,
                caseId: caseId,
                amount: amount,
                currency: currency,
                paymentDate: paymentDate,
                paymentMethod: paymentMethod,
                receiptNumber: receiptNumber,
                notes: notes,
                createdAt: createdAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PaymentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({feeAgreementId = false, clientId = false, caseId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (feeAgreementId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.feeAgreementId,
                                    referencedTable: $$PaymentsTableReferences
                                        ._feeAgreementIdTable(db),
                                    referencedColumn: $$PaymentsTableReferences
                                        ._feeAgreementIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (clientId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.clientId,
                                    referencedTable: $$PaymentsTableReferences
                                        ._clientIdTable(db),
                                    referencedColumn: $$PaymentsTableReferences
                                        ._clientIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (caseId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.caseId,
                                    referencedTable: $$PaymentsTableReferences
                                        ._caseIdTable(db),
                                    referencedColumn: $$PaymentsTableReferences
                                        ._caseIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$PaymentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaymentsTable,
      Payment,
      $$PaymentsTableFilterComposer,
      $$PaymentsTableOrderingComposer,
      $$PaymentsTableAnnotationComposer,
      $$PaymentsTableCreateCompanionBuilder,
      $$PaymentsTableUpdateCompanionBuilder,
      (Payment, $$PaymentsTableReferences),
      Payment,
      PrefetchHooks Function({bool feeAgreementId, bool clientId, bool caseId})
    >;
typedef $$ExpensesTableCreateCompanionBuilder =
    ExpensesCompanion Function({
      required String id,
      Value<String?> caseId,
      required String category,
      required int amount,
      Value<String> currency,
      required int expenseDate,
      Value<String?> recipient,
      Value<String?> documentId,
      Value<String?> notes,
      required int createdAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });
typedef $$ExpensesTableUpdateCompanionBuilder =
    ExpensesCompanion Function({
      Value<String> id,
      Value<String?> caseId,
      Value<String> category,
      Value<int> amount,
      Value<String> currency,
      Value<int> expenseDate,
      Value<String?> recipient,
      Value<String?> documentId,
      Value<String?> notes,
      Value<int> createdAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });

final class $$ExpensesTableReferences
    extends BaseReferences<_$AppDatabase, $ExpensesTable, Expense> {
  $$ExpensesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CasesTable _caseIdTable(_$AppDatabase db) =>
      db.cases.createAlias('expenses__case_id__cases__id');

  $$CasesTableProcessedTableManager? get caseId {
    final $_column = $_itemColumn<String>('case_id');
    if ($_column == null) return null;
    final manager = $$CasesTableTableManager(
      $_db,
      $_db.cases,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_caseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DocumentsTable _documentIdTable(_$AppDatabase db) =>
      db.documents.createAlias('expenses__document_id__documents__id');

  $$DocumentsTableProcessedTableManager? get documentId {
    final $_column = $_itemColumn<String>('document_id');
    if ($_column == null) return null;
    final manager = $$DocumentsTableTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_documentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get expenseDate => $composableBuilder(
    column: $table.expenseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recipient => $composableBuilder(
    column: $table.recipient,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CasesTableFilterComposer get caseId {
    final $$CasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.caseId,
      referencedTable: $db.cases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasesTableFilterComposer(
            $db: $db,
            $table: $db.cases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableFilterComposer get documentId {
    final $$DocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get expenseDate => $composableBuilder(
    column: $table.expenseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recipient => $composableBuilder(
    column: $table.recipient,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CasesTableOrderingComposer get caseId {
    final $$CasesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.caseId,
      referencedTable: $db.cases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasesTableOrderingComposer(
            $db: $db,
            $table: $db.cases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableOrderingComposer get documentId {
    final $$DocumentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableOrderingComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<int> get expenseDate => $composableBuilder(
    column: $table.expenseDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recipient =>
      $composableBuilder(column: $table.recipient, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$CasesTableAnnotationComposer get caseId {
    final $$CasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.caseId,
      referencedTable: $db.cases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasesTableAnnotationComposer(
            $db: $db,
            $table: $db.cases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableAnnotationComposer get documentId {
    final $$DocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpensesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpensesTable,
          Expense,
          $$ExpensesTableFilterComposer,
          $$ExpensesTableOrderingComposer,
          $$ExpensesTableAnnotationComposer,
          $$ExpensesTableCreateCompanionBuilder,
          $$ExpensesTableUpdateCompanionBuilder,
          (Expense, $$ExpensesTableReferences),
          Expense,
          PrefetchHooks Function({bool caseId, bool documentId})
        > {
  $$ExpensesTableTableManager(_$AppDatabase db, $ExpensesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> caseId = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<int> expenseDate = const Value.absent(),
                Value<String?> recipient = const Value.absent(),
                Value<String?> documentId = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExpensesCompanion(
                id: id,
                caseId: caseId,
                category: category,
                amount: amount,
                currency: currency,
                expenseDate: expenseDate,
                recipient: recipient,
                documentId: documentId,
                notes: notes,
                createdAt: createdAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> caseId = const Value.absent(),
                required String category,
                required int amount,
                Value<String> currency = const Value.absent(),
                required int expenseDate,
                Value<String?> recipient = const Value.absent(),
                Value<String?> documentId = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required int createdAt,
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExpensesCompanion.insert(
                id: id,
                caseId: caseId,
                category: category,
                amount: amount,
                currency: currency,
                expenseDate: expenseDate,
                recipient: recipient,
                documentId: documentId,
                notes: notes,
                createdAt: createdAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExpensesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({caseId = false, documentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (caseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.caseId,
                                referencedTable: $$ExpensesTableReferences
                                    ._caseIdTable(db),
                                referencedColumn: $$ExpensesTableReferences
                                    ._caseIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (documentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.documentId,
                                referencedTable: $$ExpensesTableReferences
                                    ._documentIdTable(db),
                                referencedColumn: $$ExpensesTableReferences
                                    ._documentIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ExpensesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpensesTable,
      Expense,
      $$ExpensesTableFilterComposer,
      $$ExpensesTableOrderingComposer,
      $$ExpensesTableAnnotationComposer,
      $$ExpensesTableCreateCompanionBuilder,
      $$ExpensesTableUpdateCompanionBuilder,
      (Expense, $$ExpensesTableReferences),
      Expense,
      PrefetchHooks Function({bool caseId, bool documentId})
    >;
typedef $$ContractsTableCreateCompanionBuilder =
    ContractsCompanion Function({
      required String id,
      required String clientId,
      Value<String?> caseId,
      required String documentNumber,
      required String contractType,
      Value<String?> issuingAuthority,
      required int issueDate,
      Value<int?> expiryDate,
      Value<String> status,
      Value<String?> documentId,
      Value<String?> notes,
      required int createdAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });
typedef $$ContractsTableUpdateCompanionBuilder =
    ContractsCompanion Function({
      Value<String> id,
      Value<String> clientId,
      Value<String?> caseId,
      Value<String> documentNumber,
      Value<String> contractType,
      Value<String?> issuingAuthority,
      Value<int> issueDate,
      Value<int?> expiryDate,
      Value<String> status,
      Value<String?> documentId,
      Value<String?> notes,
      Value<int> createdAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });

final class $$ContractsTableReferences
    extends BaseReferences<_$AppDatabase, $ContractsTable, Contract> {
  $$ContractsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClientsTable _clientIdTable(_$AppDatabase db) =>
      db.clients.createAlias('contracts__client_id__clients__id');

  $$ClientsTableProcessedTableManager get clientId {
    final $_column = $_itemColumn<String>('client_id')!;

    final manager = $$ClientsTableTableManager(
      $_db,
      $_db.clients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CasesTable _caseIdTable(_$AppDatabase db) =>
      db.cases.createAlias('contracts__case_id__cases__id');

  $$CasesTableProcessedTableManager? get caseId {
    final $_column = $_itemColumn<String>('case_id');
    if ($_column == null) return null;
    final manager = $$CasesTableTableManager(
      $_db,
      $_db.cases,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_caseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DocumentsTable _documentIdTable(_$AppDatabase db) =>
      db.documents.createAlias('contracts__document_id__documents__id');

  $$DocumentsTableProcessedTableManager? get documentId {
    final $_column = $_itemColumn<String>('document_id');
    if ($_column == null) return null;
    final manager = $$DocumentsTableTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_documentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ContractsTableFilterComposer
    extends Composer<_$AppDatabase, $ContractsTable> {
  $$ContractsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get documentNumber => $composableBuilder(
    column: $table.documentNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contractType => $composableBuilder(
    column: $table.contractType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get issuingAuthority => $composableBuilder(
    column: $table.issuingAuthority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get issueDate => $composableBuilder(
    column: $table.issueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ClientsTableFilterComposer get clientId {
    final $$ClientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableFilterComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CasesTableFilterComposer get caseId {
    final $$CasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.caseId,
      referencedTable: $db.cases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasesTableFilterComposer(
            $db: $db,
            $table: $db.cases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableFilterComposer get documentId {
    final $$DocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContractsTableOrderingComposer
    extends Composer<_$AppDatabase, $ContractsTable> {
  $$ContractsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get documentNumber => $composableBuilder(
    column: $table.documentNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contractType => $composableBuilder(
    column: $table.contractType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get issuingAuthority => $composableBuilder(
    column: $table.issuingAuthority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get issueDate => $composableBuilder(
    column: $table.issueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ClientsTableOrderingComposer get clientId {
    final $$ClientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableOrderingComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CasesTableOrderingComposer get caseId {
    final $$CasesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.caseId,
      referencedTable: $db.cases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasesTableOrderingComposer(
            $db: $db,
            $table: $db.cases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableOrderingComposer get documentId {
    final $$DocumentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableOrderingComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContractsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContractsTable> {
  $$ContractsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get documentNumber => $composableBuilder(
    column: $table.documentNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contractType => $composableBuilder(
    column: $table.contractType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get issuingAuthority => $composableBuilder(
    column: $table.issuingAuthority,
    builder: (column) => column,
  );

  GeneratedColumn<int> get issueDate =>
      $composableBuilder(column: $table.issueDate, builder: (column) => column);

  GeneratedColumn<int> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$ClientsTableAnnotationComposer get clientId {
    final $$ClientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableAnnotationComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CasesTableAnnotationComposer get caseId {
    final $$CasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.caseId,
      referencedTable: $db.cases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasesTableAnnotationComposer(
            $db: $db,
            $table: $db.cases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DocumentsTableAnnotationComposer get documentId {
    final $$DocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContractsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ContractsTable,
          Contract,
          $$ContractsTableFilterComposer,
          $$ContractsTableOrderingComposer,
          $$ContractsTableAnnotationComposer,
          $$ContractsTableCreateCompanionBuilder,
          $$ContractsTableUpdateCompanionBuilder,
          (Contract, $$ContractsTableReferences),
          Contract,
          PrefetchHooks Function({bool clientId, bool caseId, bool documentId})
        > {
  $$ContractsTableTableManager(_$AppDatabase db, $ContractsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContractsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContractsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContractsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> clientId = const Value.absent(),
                Value<String?> caseId = const Value.absent(),
                Value<String> documentNumber = const Value.absent(),
                Value<String> contractType = const Value.absent(),
                Value<String?> issuingAuthority = const Value.absent(),
                Value<int> issueDate = const Value.absent(),
                Value<int?> expiryDate = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> documentId = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ContractsCompanion(
                id: id,
                clientId: clientId,
                caseId: caseId,
                documentNumber: documentNumber,
                contractType: contractType,
                issuingAuthority: issuingAuthority,
                issueDate: issueDate,
                expiryDate: expiryDate,
                status: status,
                documentId: documentId,
                notes: notes,
                createdAt: createdAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String clientId,
                Value<String?> caseId = const Value.absent(),
                required String documentNumber,
                required String contractType,
                Value<String?> issuingAuthority = const Value.absent(),
                required int issueDate,
                Value<int?> expiryDate = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> documentId = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required int createdAt,
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ContractsCompanion.insert(
                id: id,
                clientId: clientId,
                caseId: caseId,
                documentNumber: documentNumber,
                contractType: contractType,
                issuingAuthority: issuingAuthority,
                issueDate: issueDate,
                expiryDate: expiryDate,
                status: status,
                documentId: documentId,
                notes: notes,
                createdAt: createdAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ContractsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({clientId = false, caseId = false, documentId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (clientId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.clientId,
                                    referencedTable: $$ContractsTableReferences
                                        ._clientIdTable(db),
                                    referencedColumn: $$ContractsTableReferences
                                        ._clientIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (caseId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.caseId,
                                    referencedTable: $$ContractsTableReferences
                                        ._caseIdTable(db),
                                    referencedColumn: $$ContractsTableReferences
                                        ._caseIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (documentId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.documentId,
                                    referencedTable: $$ContractsTableReferences
                                        ._documentIdTable(db),
                                    referencedColumn: $$ContractsTableReferences
                                        ._documentIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$ContractsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ContractsTable,
      Contract,
      $$ContractsTableFilterComposer,
      $$ContractsTableOrderingComposer,
      $$ContractsTableAnnotationComposer,
      $$ContractsTableCreateCompanionBuilder,
      $$ContractsTableUpdateCompanionBuilder,
      (Contract, $$ContractsTableReferences),
      Contract,
      PrefetchHooks Function({bool clientId, bool caseId, bool documentId})
    >;
typedef $$CommunicationsTableCreateCompanionBuilder =
    CommunicationsCompanion Function({
      required String id,
      Value<String?> clientId,
      Value<String?> caseId,
      Value<String?> contactId,
      required String communicationType,
      required int communicationDate,
      required String summary,
      Value<String?> result,
      required int createdAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });
typedef $$CommunicationsTableUpdateCompanionBuilder =
    CommunicationsCompanion Function({
      Value<String> id,
      Value<String?> clientId,
      Value<String?> caseId,
      Value<String?> contactId,
      Value<String> communicationType,
      Value<int> communicationDate,
      Value<String> summary,
      Value<String?> result,
      Value<int> createdAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });

final class $$CommunicationsTableReferences
    extends BaseReferences<_$AppDatabase, $CommunicationsTable, Communication> {
  $$CommunicationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ClientsTable _clientIdTable(_$AppDatabase db) =>
      db.clients.createAlias('communications__client_id__clients__id');

  $$ClientsTableProcessedTableManager? get clientId {
    final $_column = $_itemColumn<String>('client_id');
    if ($_column == null) return null;
    final manager = $$ClientsTableTableManager(
      $_db,
      $_db.clients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CasesTable _caseIdTable(_$AppDatabase db) =>
      db.cases.createAlias('communications__case_id__cases__id');

  $$CasesTableProcessedTableManager? get caseId {
    final $_column = $_itemColumn<String>('case_id');
    if ($_column == null) return null;
    final manager = $$CasesTableTableManager(
      $_db,
      $_db.cases,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_caseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ContactsTable _contactIdTable(_$AppDatabase db) =>
      db.contacts.createAlias('communications__contact_id__contacts__id');

  $$ContactsTableProcessedTableManager? get contactId {
    final $_column = $_itemColumn<String>('contact_id');
    if ($_column == null) return null;
    final manager = $$ContactsTableTableManager(
      $_db,
      $_db.contacts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_contactIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CommunicationsTableFilterComposer
    extends Composer<_$AppDatabase, $CommunicationsTable> {
  $$CommunicationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get communicationType => $composableBuilder(
    column: $table.communicationType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get communicationDate => $composableBuilder(
    column: $table.communicationDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get result => $composableBuilder(
    column: $table.result,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ClientsTableFilterComposer get clientId {
    final $$ClientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableFilterComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CasesTableFilterComposer get caseId {
    final $$CasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.caseId,
      referencedTable: $db.cases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasesTableFilterComposer(
            $db: $db,
            $table: $db.cases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContactsTableFilterComposer get contactId {
    final $$ContactsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contactId,
      referencedTable: $db.contacts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContactsTableFilterComposer(
            $db: $db,
            $table: $db.contacts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CommunicationsTableOrderingComposer
    extends Composer<_$AppDatabase, $CommunicationsTable> {
  $$CommunicationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get communicationType => $composableBuilder(
    column: $table.communicationType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get communicationDate => $composableBuilder(
    column: $table.communicationDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get result => $composableBuilder(
    column: $table.result,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ClientsTableOrderingComposer get clientId {
    final $$ClientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableOrderingComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CasesTableOrderingComposer get caseId {
    final $$CasesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.caseId,
      referencedTable: $db.cases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasesTableOrderingComposer(
            $db: $db,
            $table: $db.cases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContactsTableOrderingComposer get contactId {
    final $$ContactsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contactId,
      referencedTable: $db.contacts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContactsTableOrderingComposer(
            $db: $db,
            $table: $db.contacts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CommunicationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CommunicationsTable> {
  $$CommunicationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get communicationType => $composableBuilder(
    column: $table.communicationType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get communicationDate => $composableBuilder(
    column: $table.communicationDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get summary =>
      $composableBuilder(column: $table.summary, builder: (column) => column);

  GeneratedColumn<String> get result =>
      $composableBuilder(column: $table.result, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$ClientsTableAnnotationComposer get clientId {
    final $$ClientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableAnnotationComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CasesTableAnnotationComposer get caseId {
    final $$CasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.caseId,
      referencedTable: $db.cases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CasesTableAnnotationComposer(
            $db: $db,
            $table: $db.cases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContactsTableAnnotationComposer get contactId {
    final $$ContactsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contactId,
      referencedTable: $db.contacts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContactsTableAnnotationComposer(
            $db: $db,
            $table: $db.contacts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CommunicationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CommunicationsTable,
          Communication,
          $$CommunicationsTableFilterComposer,
          $$CommunicationsTableOrderingComposer,
          $$CommunicationsTableAnnotationComposer,
          $$CommunicationsTableCreateCompanionBuilder,
          $$CommunicationsTableUpdateCompanionBuilder,
          (Communication, $$CommunicationsTableReferences),
          Communication,
          PrefetchHooks Function({bool clientId, bool caseId, bool contactId})
        > {
  $$CommunicationsTableTableManager(
    _$AppDatabase db,
    $CommunicationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CommunicationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CommunicationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CommunicationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> clientId = const Value.absent(),
                Value<String?> caseId = const Value.absent(),
                Value<String?> contactId = const Value.absent(),
                Value<String> communicationType = const Value.absent(),
                Value<int> communicationDate = const Value.absent(),
                Value<String> summary = const Value.absent(),
                Value<String?> result = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CommunicationsCompanion(
                id: id,
                clientId: clientId,
                caseId: caseId,
                contactId: contactId,
                communicationType: communicationType,
                communicationDate: communicationDate,
                summary: summary,
                result: result,
                createdAt: createdAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> clientId = const Value.absent(),
                Value<String?> caseId = const Value.absent(),
                Value<String?> contactId = const Value.absent(),
                required String communicationType,
                required int communicationDate,
                required String summary,
                Value<String?> result = const Value.absent(),
                required int createdAt,
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CommunicationsCompanion.insert(
                id: id,
                clientId: clientId,
                caseId: caseId,
                contactId: contactId,
                communicationType: communicationType,
                communicationDate: communicationDate,
                summary: summary,
                result: result,
                createdAt: createdAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CommunicationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({clientId = false, caseId = false, contactId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (clientId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.clientId,
                                    referencedTable:
                                        $$CommunicationsTableReferences
                                            ._clientIdTable(db),
                                    referencedColumn:
                                        $$CommunicationsTableReferences
                                            ._clientIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (caseId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.caseId,
                                    referencedTable:
                                        $$CommunicationsTableReferences
                                            ._caseIdTable(db),
                                    referencedColumn:
                                        $$CommunicationsTableReferences
                                            ._caseIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (contactId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.contactId,
                                    referencedTable:
                                        $$CommunicationsTableReferences
                                            ._contactIdTable(db),
                                    referencedColumn:
                                        $$CommunicationsTableReferences
                                            ._contactIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$CommunicationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CommunicationsTable,
      Communication,
      $$CommunicationsTableFilterComposer,
      $$CommunicationsTableOrderingComposer,
      $$CommunicationsTableAnnotationComposer,
      $$CommunicationsTableCreateCompanionBuilder,
      $$CommunicationsTableUpdateCompanionBuilder,
      (Communication, $$CommunicationsTableReferences),
      Communication,
      PrefetchHooks Function({bool clientId, bool caseId, bool contactId})
    >;
typedef $$LegalReferencesTableCreateCompanionBuilder =
    LegalReferencesCompanion Function({
      required String id,
      required String title,
      required String referenceType,
      Value<String?> lawNumber,
      Value<int?> year,
      Value<String?> issuingAuthority,
      required String category,
      required String fullText,
      Value<String?> source,
      Value<int> isVerified,
      required int createdAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });
typedef $$LegalReferencesTableUpdateCompanionBuilder =
    LegalReferencesCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> referenceType,
      Value<String?> lawNumber,
      Value<int?> year,
      Value<String?> issuingAuthority,
      Value<String> category,
      Value<String> fullText,
      Value<String?> source,
      Value<int> isVerified,
      Value<int> createdAt,
      Value<int?> deletedAt,
      Value<int> rowid,
    });

class $$LegalReferencesTableFilterComposer
    extends Composer<_$AppDatabase, $LegalReferencesTable> {
  $$LegalReferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referenceType => $composableBuilder(
    column: $table.referenceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lawNumber => $composableBuilder(
    column: $table.lawNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get issuingAuthority => $composableBuilder(
    column: $table.issuingAuthority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullText => $composableBuilder(
    column: $table.fullText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LegalReferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $LegalReferencesTable> {
  $$LegalReferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceType => $composableBuilder(
    column: $table.referenceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lawNumber => $composableBuilder(
    column: $table.lawNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get issuingAuthority => $composableBuilder(
    column: $table.issuingAuthority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullText => $composableBuilder(
    column: $table.fullText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LegalReferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LegalReferencesTable> {
  $$LegalReferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get referenceType => $composableBuilder(
    column: $table.referenceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lawNumber =>
      $composableBuilder(column: $table.lawNumber, builder: (column) => column);

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<String> get issuingAuthority => $composableBuilder(
    column: $table.issuingAuthority,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get fullText =>
      $composableBuilder(column: $table.fullText, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<int> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$LegalReferencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LegalReferencesTable,
          LegalReference,
          $$LegalReferencesTableFilterComposer,
          $$LegalReferencesTableOrderingComposer,
          $$LegalReferencesTableAnnotationComposer,
          $$LegalReferencesTableCreateCompanionBuilder,
          $$LegalReferencesTableUpdateCompanionBuilder,
          (
            LegalReference,
            BaseReferences<
              _$AppDatabase,
              $LegalReferencesTable,
              LegalReference
            >,
          ),
          LegalReference,
          PrefetchHooks Function()
        > {
  $$LegalReferencesTableTableManager(
    _$AppDatabase db,
    $LegalReferencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LegalReferencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LegalReferencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LegalReferencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> referenceType = const Value.absent(),
                Value<String?> lawNumber = const Value.absent(),
                Value<int?> year = const Value.absent(),
                Value<String?> issuingAuthority = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> fullText = const Value.absent(),
                Value<String?> source = const Value.absent(),
                Value<int> isVerified = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LegalReferencesCompanion(
                id: id,
                title: title,
                referenceType: referenceType,
                lawNumber: lawNumber,
                year: year,
                issuingAuthority: issuingAuthority,
                category: category,
                fullText: fullText,
                source: source,
                isVerified: isVerified,
                createdAt: createdAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String referenceType,
                Value<String?> lawNumber = const Value.absent(),
                Value<int?> year = const Value.absent(),
                Value<String?> issuingAuthority = const Value.absent(),
                required String category,
                required String fullText,
                Value<String?> source = const Value.absent(),
                Value<int> isVerified = const Value.absent(),
                required int createdAt,
                Value<int?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LegalReferencesCompanion.insert(
                id: id,
                title: title,
                referenceType: referenceType,
                lawNumber: lawNumber,
                year: year,
                issuingAuthority: issuingAuthority,
                category: category,
                fullText: fullText,
                source: source,
                isVerified: isVerified,
                createdAt: createdAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LegalReferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LegalReferencesTable,
      LegalReference,
      $$LegalReferencesTableFilterComposer,
      $$LegalReferencesTableOrderingComposer,
      $$LegalReferencesTableAnnotationComposer,
      $$LegalReferencesTableCreateCompanionBuilder,
      $$LegalReferencesTableUpdateCompanionBuilder,
      (
        LegalReference,
        BaseReferences<_$AppDatabase, $LegalReferencesTable, LegalReference>,
      ),
      LegalReference,
      PrefetchHooks Function()
    >;
typedef $$AuditLogsTableCreateCompanionBuilder =
    AuditLogsCompanion Function({
      required String id,
      required int timestamp,
      required String action,
      required String entityType,
      Value<String?> entityId,
      required String details,
      Value<String> ipOrDevice,
      Value<int> rowid,
    });
typedef $$AuditLogsTableUpdateCompanionBuilder =
    AuditLogsCompanion Function({
      Value<String> id,
      Value<int> timestamp,
      Value<String> action,
      Value<String> entityType,
      Value<String?> entityId,
      Value<String> details,
      Value<String> ipOrDevice,
      Value<int> rowid,
    });

class $$AuditLogsTableFilterComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ipOrDevice => $composableBuilder(
    column: $table.ipOrDevice,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AuditLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ipOrDevice => $composableBuilder(
    column: $table.ipOrDevice,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AuditLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get details =>
      $composableBuilder(column: $table.details, builder: (column) => column);

  GeneratedColumn<String> get ipOrDevice => $composableBuilder(
    column: $table.ipOrDevice,
    builder: (column) => column,
  );
}

class $$AuditLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AuditLogsTable,
          AuditLog,
          $$AuditLogsTableFilterComposer,
          $$AuditLogsTableOrderingComposer,
          $$AuditLogsTableAnnotationComposer,
          $$AuditLogsTableCreateCompanionBuilder,
          $$AuditLogsTableUpdateCompanionBuilder,
          (AuditLog, BaseReferences<_$AppDatabase, $AuditLogsTable, AuditLog>),
          AuditLog,
          PrefetchHooks Function()
        > {
  $$AuditLogsTableTableManager(_$AppDatabase db, $AuditLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuditLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuditLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuditLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> timestamp = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String?> entityId = const Value.absent(),
                Value<String> details = const Value.absent(),
                Value<String> ipOrDevice = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AuditLogsCompanion(
                id: id,
                timestamp: timestamp,
                action: action,
                entityType: entityType,
                entityId: entityId,
                details: details,
                ipOrDevice: ipOrDevice,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int timestamp,
                required String action,
                required String entityType,
                Value<String?> entityId = const Value.absent(),
                required String details,
                Value<String> ipOrDevice = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AuditLogsCompanion.insert(
                id: id,
                timestamp: timestamp,
                action: action,
                entityType: entityType,
                entityId: entityId,
                details: details,
                ipOrDevice: ipOrDevice,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AuditLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AuditLogsTable,
      AuditLog,
      $$AuditLogsTableFilterComposer,
      $$AuditLogsTableOrderingComposer,
      $$AuditLogsTableAnnotationComposer,
      $$AuditLogsTableCreateCompanionBuilder,
      $$AuditLogsTableUpdateCompanionBuilder,
      (AuditLog, BaseReferences<_$AppDatabase, $AuditLogsTable, AuditLog>),
      AuditLog,
      PrefetchHooks Function()
    >;
typedef $$BackupHistoryTableCreateCompanionBuilder =
    BackupHistoryCompanion Function({
      required String id,
      required String backupName,
      required String filePath,
      required int fileSize,
      required String backupType,
      Value<int> isEncrypted,
      required int documentsCount,
      required String sha256Checksum,
      Value<int> uploadedToDrive,
      Value<String?> driveFileId,
      required int createdAt,
      Value<int> rowid,
    });
typedef $$BackupHistoryTableUpdateCompanionBuilder =
    BackupHistoryCompanion Function({
      Value<String> id,
      Value<String> backupName,
      Value<String> filePath,
      Value<int> fileSize,
      Value<String> backupType,
      Value<int> isEncrypted,
      Value<int> documentsCount,
      Value<String> sha256Checksum,
      Value<int> uploadedToDrive,
      Value<String?> driveFileId,
      Value<int> createdAt,
      Value<int> rowid,
    });

class $$BackupHistoryTableFilterComposer
    extends Composer<_$AppDatabase, $BackupHistoryTable> {
  $$BackupHistoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get backupName => $composableBuilder(
    column: $table.backupName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fileSize => $composableBuilder(
    column: $table.fileSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get backupType => $composableBuilder(
    column: $table.backupType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isEncrypted => $composableBuilder(
    column: $table.isEncrypted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get documentsCount => $composableBuilder(
    column: $table.documentsCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sha256Checksum => $composableBuilder(
    column: $table.sha256Checksum,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get uploadedToDrive => $composableBuilder(
    column: $table.uploadedToDrive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get driveFileId => $composableBuilder(
    column: $table.driveFileId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BackupHistoryTableOrderingComposer
    extends Composer<_$AppDatabase, $BackupHistoryTable> {
  $$BackupHistoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get backupName => $composableBuilder(
    column: $table.backupName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fileSize => $composableBuilder(
    column: $table.fileSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get backupType => $composableBuilder(
    column: $table.backupType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isEncrypted => $composableBuilder(
    column: $table.isEncrypted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get documentsCount => $composableBuilder(
    column: $table.documentsCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sha256Checksum => $composableBuilder(
    column: $table.sha256Checksum,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get uploadedToDrive => $composableBuilder(
    column: $table.uploadedToDrive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get driveFileId => $composableBuilder(
    column: $table.driveFileId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BackupHistoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $BackupHistoryTable> {
  $$BackupHistoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get backupName => $composableBuilder(
    column: $table.backupName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<int> get fileSize =>
      $composableBuilder(column: $table.fileSize, builder: (column) => column);

  GeneratedColumn<String> get backupType => $composableBuilder(
    column: $table.backupType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get isEncrypted => $composableBuilder(
    column: $table.isEncrypted,
    builder: (column) => column,
  );

  GeneratedColumn<int> get documentsCount => $composableBuilder(
    column: $table.documentsCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sha256Checksum => $composableBuilder(
    column: $table.sha256Checksum,
    builder: (column) => column,
  );

  GeneratedColumn<int> get uploadedToDrive => $composableBuilder(
    column: $table.uploadedToDrive,
    builder: (column) => column,
  );

  GeneratedColumn<String> get driveFileId => $composableBuilder(
    column: $table.driveFileId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$BackupHistoryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BackupHistoryTable,
          BackupHistoryData,
          $$BackupHistoryTableFilterComposer,
          $$BackupHistoryTableOrderingComposer,
          $$BackupHistoryTableAnnotationComposer,
          $$BackupHistoryTableCreateCompanionBuilder,
          $$BackupHistoryTableUpdateCompanionBuilder,
          (
            BackupHistoryData,
            BaseReferences<
              _$AppDatabase,
              $BackupHistoryTable,
              BackupHistoryData
            >,
          ),
          BackupHistoryData,
          PrefetchHooks Function()
        > {
  $$BackupHistoryTableTableManager(_$AppDatabase db, $BackupHistoryTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BackupHistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BackupHistoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BackupHistoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> backupName = const Value.absent(),
                Value<String> filePath = const Value.absent(),
                Value<int> fileSize = const Value.absent(),
                Value<String> backupType = const Value.absent(),
                Value<int> isEncrypted = const Value.absent(),
                Value<int> documentsCount = const Value.absent(),
                Value<String> sha256Checksum = const Value.absent(),
                Value<int> uploadedToDrive = const Value.absent(),
                Value<String?> driveFileId = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BackupHistoryCompanion(
                id: id,
                backupName: backupName,
                filePath: filePath,
                fileSize: fileSize,
                backupType: backupType,
                isEncrypted: isEncrypted,
                documentsCount: documentsCount,
                sha256Checksum: sha256Checksum,
                uploadedToDrive: uploadedToDrive,
                driveFileId: driveFileId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String backupName,
                required String filePath,
                required int fileSize,
                required String backupType,
                Value<int> isEncrypted = const Value.absent(),
                required int documentsCount,
                required String sha256Checksum,
                Value<int> uploadedToDrive = const Value.absent(),
                Value<String?> driveFileId = const Value.absent(),
                required int createdAt,
                Value<int> rowid = const Value.absent(),
              }) => BackupHistoryCompanion.insert(
                id: id,
                backupName: backupName,
                filePath: filePath,
                fileSize: fileSize,
                backupType: backupType,
                isEncrypted: isEncrypted,
                documentsCount: documentsCount,
                sha256Checksum: sha256Checksum,
                uploadedToDrive: uploadedToDrive,
                driveFileId: driveFileId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BackupHistoryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BackupHistoryTable,
      BackupHistoryData,
      $$BackupHistoryTableFilterComposer,
      $$BackupHistoryTableOrderingComposer,
      $$BackupHistoryTableAnnotationComposer,
      $$BackupHistoryTableCreateCompanionBuilder,
      $$BackupHistoryTableUpdateCompanionBuilder,
      (
        BackupHistoryData,
        BaseReferences<_$AppDatabase, $BackupHistoryTable, BackupHistoryData>,
      ),
      BackupHistoryData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ClientsTableTableManager get clients =>
      $$ClientsTableTableManager(_db, _db.clients);
  $$CourtsTableTableManager get courts =>
      $$CourtsTableTableManager(_db, _db.courts);
  $$ContactsTableTableManager get contacts =>
      $$ContactsTableTableManager(_db, _db.contacts);
  $$CasesTableTableManager get cases =>
      $$CasesTableTableManager(_db, _db.cases);
  $$CaseClientsTableTableManager get caseClients =>
      $$CaseClientsTableTableManager(_db, _db.caseClients);
  $$CasePartiesTableTableManager get caseParties =>
      $$CasePartiesTableTableManager(_db, _db.caseParties);
  $$FolderLinksTableTableManager get folderLinks =>
      $$FolderLinksTableTableManager(_db, _db.folderLinks);
  $$DocumentsTableTableManager get documents =>
      $$DocumentsTableTableManager(_db, _db.documents);
  $$CaseDocumentsTableTableManager get caseDocuments =>
      $$CaseDocumentsTableTableManager(_db, _db.caseDocuments);
  $$DocumentTextIndexTableTableManager get documentTextIndex =>
      $$DocumentTextIndexTableTableManager(_db, _db.documentTextIndex);
  $$HearingsTableTableManager get hearings =>
      $$HearingsTableTableManager(_db, _db.hearings);
  $$CaseProceduresTableTableManager get caseProcedures =>
      $$CaseProceduresTableTableManager(_db, _db.caseProcedures);
  $$TasksTableTableManager get tasks =>
      $$TasksTableTableManager(_db, _db.tasks);
  $$FeeAgreementsTableTableManager get feeAgreements =>
      $$FeeAgreementsTableTableManager(_db, _db.feeAgreements);
  $$PaymentsTableTableManager get payments =>
      $$PaymentsTableTableManager(_db, _db.payments);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
  $$ContractsTableTableManager get contracts =>
      $$ContractsTableTableManager(_db, _db.contracts);
  $$CommunicationsTableTableManager get communications =>
      $$CommunicationsTableTableManager(_db, _db.communications);
  $$LegalReferencesTableTableManager get legalReferences =>
      $$LegalReferencesTableTableManager(_db, _db.legalReferences);
  $$AuditLogsTableTableManager get auditLogs =>
      $$AuditLogsTableTableManager(_db, _db.auditLogs);
  $$BackupHistoryTableTableManager get backupHistory =>
      $$BackupHistoryTableTableManager(_db, _db.backupHistory);
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/database_provider.dart';
import '../../data/repositories/clients_repository.dart';

final clientsRepositoryProvider = Provider<ClientsRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return ClientsRepository(db);
});

final clientSearchQueryProvider = StateProvider<String>((ref) => '');

final allClientsStreamProvider = StreamProvider<List<Client>>((ref) {
  final repo = ref.watch(clientsRepositoryProvider);
  final query = ref.watch(clientSearchQueryProvider);
  return repo.watchAllClients(searchQuery: query);
});

final clientByIdProvider =
    FutureProvider.family<Client?, String>((ref, clientId) {
  final repo = ref.watch(clientsRepositoryProvider);
  return repo.getClientById(clientId);
});

final clientCasesStreamProvider =
    StreamProvider.family<List<Case>, String>((ref, clientId) {
  final repo = ref.watch(clientsRepositoryProvider);
  return repo.watchClientCases(clientId);
});

final clientPaymentsStreamProvider =
    StreamProvider.family<List<Payment>, String>((ref, clientId) {
  final repo = ref.watch(clientsRepositoryProvider);
  return repo.watchClientPayments(clientId);
});


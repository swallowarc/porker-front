import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:porker/porker.dart';

import 'domains/login_status.dart';
import 'infrastructures/env/env.dart';
import 'infrastructures/local_storage/local_storage.dart';
import 'repositories/local_storage_repository.dart';
import 'repositories/porker_service_repository.dart';
import 'services/login_service.dart';
import 'services/porker_service.dart';

/// Env
final Provider<Env> _envProvider = Provider((ref) => Env());

/// LocalStorage
final Provider<LocalStorage> localStorageProvider = Provider((ref) => LocalStorage());

/// LocalStorageRepository
final Provider<LocalStorageRepository> localStorageRepositoryProvider =
    Provider((ref) => LocalStorageRepository(ref.read(localStorageProvider)));

/// PorkerServiceRepository
final Provider<PorkerServiceRepository> porkerServiceRepositoryProvider = Provider(
  (ref) {
    final repo = PorkerServiceRepository(ref.read(_envProvider).porkerBackendURI);
    ref.onDispose(() => repo.shutdown());
    return repo;
  },
);

/// LoginService
final StateNotifierProvider<LoginService, LoginStatus> loginServiceProvider = StateNotifierProvider(
  (ref) => LoginService(ref.read(localStorageRepositoryProvider), ref.read(porkerServiceRepositoryProvider)),
);

/// PorkerService
final StateNotifierProvider<PorkerService, PokerSituation> porkerServiceProvider = StateNotifierProvider(
    (ref) => PorkerService(ref.read(localStorageRepositoryProvider), ref.read(porkerServiceRepositoryProvider)));

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
final Provider<Env> _envProvider = Provider<Env>((ref) => Env());

/// LocalStorage
final Provider<LocalStorage> localStorageProvider = Provider<LocalStorage>((ref) => LocalStorage());

/// LocalStorageRepository
final Provider<LocalStorageRepository> localStorageRepositoryProvider =
    Provider<LocalStorageRepository>((ref) => LocalStorageRepository(ref.read(localStorageProvider)));

/// PorkerServiceRepository
final Provider<PorkerServiceRepository> porkerServiceRepositoryProvider = Provider<PorkerServiceRepository>(
  (ref) {
    final repo = PorkerServiceRepository(ref.read(_envProvider).porkerBackendURI);
    ref.onDispose(() => repo.shutdown());
    return repo;
  },
);

/// LoginService
final StateNotifierProvider<LoginService, LoginStatus> loginServiceProvider = StateNotifierProvider<LoginService, LoginStatus>(
  (ref) => LoginService(ref.read(localStorageRepositoryProvider), ref.read(porkerServiceRepositoryProvider)),
);

/// PorkerService
final StateNotifierProvider<PorkerService, PokerSituation> porkerServiceProvider = StateNotifierProvider<PorkerService, PokerSituation>(
    (ref) => PorkerService(ref.read(localStorageRepositoryProvider), ref.read(porkerServiceRepositoryProvider)));

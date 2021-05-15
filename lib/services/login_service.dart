import 'package:porker_front/commons/logger/logger.dart';
import 'package:porker_front/domains/login_status.dart';
import 'package:porker_front/repositories/porker_service_repository.dart';
import 'package:porker_front/repositories/local_storage_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginService extends StateNotifier<LoginStatus> {
  final LocalStorageRepository _storageRepo;
  final PorkerServiceRepository _svcRepo;

  LoginService(LocalStorageRepository loginRepo, PorkerServiceRepository svcRepo)
      : _storageRepo = loginRepo,
        _svcRepo = svcRepo,
        super(LoginStatus());

  Future<LoginStatus> previousLogin() async {
    return await _storageRepo.getLoginStatus();
  }

  Future<String?> loginID() async {
    if (state.loginID == null) {
      final login = await _storageRepo.getLoginStatus();
      state = login;
    }
    return state.loginID;
  }

  Future<String> login(String id) async {
    final status = await _storageRepo.getLoginStatus();
    status.loginID = id;

    try {
      final newSessionID = await _svcRepo.login(status);
      status.sessionID = newSessionID;
      _storageRepo.saveLoginStatus(status);
      state = status;
    } catch (e, stack) {
      gLogger.e("failed to login", e, stack);
      return "ログインに失敗しました";
    }
    return "";
  }
}

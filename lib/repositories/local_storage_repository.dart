import 'package:porker_front/domains/login_status.dart';
import 'package:porker_front/infrastructures/local_storage/local_storage.dart';

const _storageKeyLoginStatus = "login_status";
const _storageKeyRoomID = "room_id";

class LocalStorageRepository {
  final LocalStorage _localStorage;

  LocalStorageRepository(LocalStorage localStorage) : _localStorage = localStorage;

  Future<LoginStatus> getLoginStatus() async {
    final json = await _localStorage.getMap(_storageKeyLoginStatus);
    if (json.length == 0) {
      return LoginStatus();
    }
    return LoginStatus.fromJson(json);
  }

  void saveLoginStatus(LoginStatus status) async {
    _localStorage.putMap(_storageKeyLoginStatus, status.toJson());
  }

  Future<void> deleteEnterRoomID() async {
    await _localStorage.delete(_storageKeyRoomID);
  }
}

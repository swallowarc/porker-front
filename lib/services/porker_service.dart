import 'package:grpc/grpc_web.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:porker/porker.dart';
import 'package:porker_front/commons/errors/errors.dart';
import 'package:porker_front/commons/logger/logger.dart';
import 'package:porker_front/repositories/local_storage_repository.dart';
import 'package:porker_front/repositories/porker_service_repository.dart';
import 'package:protobuf/protobuf.dart';

class PorkerService extends StateNotifier<PokerSituation> {
  final LocalStorageRepository _storageRepo;
  final PorkerServiceRepository _svcRepo;

  String? roomID;
  ResponseStream<PokerSituation>? _stream;
  bool _status = false;

  PorkerService(LocalStorageRepository storageRepo, PorkerServiceRepository svcRepo)
      : _svcRepo = svcRepo,
        _storageRepo = storageRepo,
        super(PokerSituation(state: RoomState.ROOM_STATE_TURN_DOWN));

  Future<String?> createRoom(String loginID) async {
    roomID = await _svcRepo.createRoom(loginID);
    if (roomID == null) {
      return null;
    }

    return roomID;
  }

  Future<bool> canEnterRoom(String loginID, roomID) async => await _svcRepo.canEnterRoom(loginID, roomID);

  Future<bool> enterRoom(String loginID, roomID) async {
    if (_status && this.roomID == roomID) {
      return false;
    }

    this.roomID = roomID;
    _status = true;

    gLogger.d("enter room");

    return await _enterRoom(loginID, roomID);
  }

  Future<bool> _enterRoom(String loginID, roomID) async {
    if (!_status) {
      return false;
    }

    try {
      _stream = await _svcRepo.enterRoom(loginID, roomID);
    } catch (e, stack) {
      gLogger.e("failed to enterRoom", e, stack);
      _status = false;

      return false;
    }

    _stream?.listen((roomSituation) {
      gLogger.d(roomSituation.toProto3Json());
      state = roomSituation;
    }, onError: (err) {
      if (isGRPCErrorCodeToRetry(err)) {
        gLogger.d("retry enter room");
        _enterRoom(loginID, roomID);

        return;
      }

      final newState = state.rebuild((s) {
        s.state = RoomState.ROOM_STATE_TURN_DOWN;
      });
      state = newState;
      throw err;
    });

    return true;
  }

  Future<void> voting(String loginID, roomID, Point point) async => _svcRepo.voting(loginID, roomID, point);

  Future<void> voteCounting(String loginID, roomID) async => _svcRepo.voteCounting(loginID, roomID);

  Future<void> resetRoom(String loginID, roomID) async => _svcRepo.resetRoom(loginID, roomID);

  Future<void> leaveRoom(String loginID, roomID) async {
    _status = false;
    if (_stream != null) {
      // _stream!.cancel();
    }

    _storageRepo.deleteEnterRoomID();
    _svcRepo.leaveRoom(loginID, roomID);
  }
}

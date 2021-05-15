import 'dart:async';

import 'package:grpc/grpc_web.dart';
import 'package:porker/porker.dart';
import 'package:porker_front/commons/logger/logger.dart';
import 'package:porker_front/commons/retry/retry.dart';
import 'package:porker_front/domains/login_status.dart';
import 'package:retry/retry.dart';

const _retryOpt = RetryOptions(
  maxAttempts: 8,
  maxDelay: Duration(seconds: 5),
);

class PorkerServiceRepository {
  GrpcWebClientChannel? _svcChan;
  PorkerServiceClient? _svcCli;

  PorkerServiceRepository(String serverURL) {
    _svcChan = GrpcWebClientChannel.xhr(Uri.parse(serverURL));
    _svcCli = PorkerServiceClient(_svcChan!, options: CallOptions(timeout: Duration(seconds: 600)));
  }

  Future<String> login(LoginStatus status) async {
    final req = LoginRequest(
      login: Login(
        loginId: status.loginID,
        sessionId: status.sessionID,
      ),
    );

    try {
      final res = await _svcCli!.login(req);
      return res.login.sessionId;
    } catch (error) {
      print('failed to login rpc: $error');
      return Future.error(error);
    }
  }

  Future<String> createRoom(String loginID) async {
    final res = await gRPCRetry(
      () => _svcCli!.createRoom(CreateRoomRequest(
        loginId: loginID,
      )),
    );

    return res.roomId;
  }

  Future<bool> canEnterRoom(String loginID, roomID) async {
    return gRPCRetry(
      () => _svcCli!
          .canEnterRoom(CanEnterRoomRequest(
            loginId: loginID,
            roomId: roomID,
          ))
          .then((res) => res.canEnterRoom),
    );
  }

  Future<ResponseStream<PokerSituation>> enterRoom(String loginID, roomID) async {
    return gRPCRetry(
      () => _svcCli!.enterRoom(EnterRoomRequest(
        loginId: loginID,
        roomId: roomID,
      )),
    );
  }

  Future<void> voting(String loginID, roomID, Point point) async {
    try {
      gRPCRetry(
        () => _svcCli!.voting(VotingRequest(
            roomId: roomID,
            ballot: Ballot(
              loginId: loginID,
              point: point,
            ))),
      );
    } catch (e, stack) {
      gLogger.e("failed voting", e, stack);
    }
  }

  Future<void> voteCounting(String loginID, roomID) async {
    try {
      gRPCRetry(
        () => _svcCli!.voteCounting(VoteCountingRequest(
          roomId: roomID,
          loginId: loginID,
        )),
      );
    } catch (e, stack) {
      gLogger.e("failed voteCounting", e, stack);
    }
  }

  Future<void> resetRoom(String loginID, roomID) async {
    try {
      gRPCRetry(
        () => _svcCli!.resetRoom(ResetRoomRequest(
          loginId: loginID,
          roomId: roomID,
        )),
      );
    } catch (e, stack) {
      gLogger.e("failed resetRoom", e, stack);
    }
  }

  Future<void> leaveRoom(String loginID, roomID) async {
    try {
      gRPCRetry(
        () => _svcCli!.leaveRoom(LeaveRoomRequest(
          loginId: loginID,
          roomId: roomID,
        )),
      );
    } catch (e, stack) {
      gLogger.e("failed leaveRoom", e, stack);
    }
  }

  void shutdown() {
    _svcChan!.shutdown();
  }
}

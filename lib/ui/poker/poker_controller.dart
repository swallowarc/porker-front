import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:porker/porker.dart';
import 'package:porker_front/commons/logger/logger.dart';
import 'package:porker_front/services/login_service.dart';
import 'package:porker_front/services/porker_service.dart';
import 'package:sprintf/sprintf.dart';

part 'poker_controller.freezed.dart';

@freezed
class PokerControllerState with _$PokerControllerState {
  const factory PokerControllerState({
    required String roomID,
    required String masterLoginID,
    required RoomState roomState,
    required List<Ballot> ballots,
    required String loginID,
  }) = _PokerControllerState;
}

class PokerController extends StateNotifier<PokerControllerState> {
  final PorkerService _porkerSvc;
  final LoginService _loginSvc;
  RemoveListener? _rmListener;

  PokerController(PorkerService poker, LoginService login)
      : _porkerSvc = poker,
        _loginSvc = login,
        super(
          PokerControllerState(
            roomID: "",
            masterLoginID: "",
            roomState: RoomState.ROOM_STATE_TURN_DOWN,
            ballots: [],
            loginID: "",
          ),
        );

  Future<void> subscribe(BuildContext context, String? roomID) async {
    if (_rmListener != null) {
      return;
    }

    final loginID = await _loginSvc.loginID();
    if (loginID == null) {
      Navigator.of(context).pushNamedAndRemoveUntil(sprintf("/?room_id=%s", [roomID]), (_) => false);
      return;
    }

    if (roomID == null || !await _porkerSvc.canEnterRoom(loginID, roomID)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('有効なRoomIDが指定されていません')));
      Navigator.of(context).pushNamedAndRemoveUntil("/room", (_) => false);
    }

    final isNewConnection = await _porkerSvc.enterRoom(loginID, roomID);
    if (!isNewConnection) {
      return;
    }

    _rmListener = _porkerSvc.addListener((poker) {
      state = state.copyWith(
        roomID: poker.roomId,
        masterLoginID: poker.masterLoginId,
        roomState: poker.state,
        ballots: poker.ballots,
        loginID: loginID,
      );
    });
  }

  Point selectedPoint() {
    final ballot = state.ballots.where((e) => e.loginId == state.loginID).firstOrNull;
    if (ballot == null) {
      return Point.POINT_UNKNOWN;
    }
    return ballot.point;
  }

  Future<void> voting(BuildContext context, Point point) async {
    if (state.roomState != RoomState.ROOM_STATE_TURN_DOWN) {
      return;
    }

    final loginID = await _loginSvc.loginID();
    if (loginID == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('正しくログインできていません')));
      return;
    }

    _porkerSvc.voting(loginID, state.roomID, point);
  }

  bool isVoter() {
    final myPoint = selectedPoint();
    return myPoint != Point.NOT_VOTE;
  }

  Future<void> toggleNotVote(BuildContext context) async {
    if (state.roomState != RoomState.ROOM_STATE_TURN_DOWN) {
      return;
    }

    final myPoint = selectedPoint();
    if (myPoint == Point.NOT_VOTE) {
      voting(context, Point.POINT_UNKNOWN);
      return;
    }

    voting(context, Point.NOT_VOTE);
  }

  Future<void> voteCounting(BuildContext context) async {
    if (state.roomState != RoomState.ROOM_STATE_TURN_DOWN) {
      return;
    }

    final loginID = await _loginSvc.loginID();
    if (loginID == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('正しくログインできていません')));
      return;
    }

    _porkerSvc.voteCounting(loginID, state.roomID);
  }

  Future<void> leave(BuildContext context) async {
    if (_rmListener != null) {
      _rmListener!();
    }

    final loginID = await _loginSvc.loginID();
    if (loginID == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('正しくログインできていません')));
      return;
    }

    await _porkerSvc.leaveRoom(loginID, state.roomID);
    Navigator.of(context).pushNamedAndRemoveUntil("/room", (_) => false);
  }

  Future<void> reset(BuildContext context) async {
    final loginID = await _loginSvc.loginID();
    if (loginID == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('正しくログインできていません')));
      return;
    }
    await _porkerSvc.resetRoom(loginID, state.roomID);
  }

  @override
  void dispose() {
    if (_rmListener != null) {
      _rmListener!();
    }
    gLogger.d("poker controller disposed");
    super.dispose();
  }
}

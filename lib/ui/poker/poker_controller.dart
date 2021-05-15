import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:porker/porker.dart';
import 'package:porker_front/commons/logger/logger.dart';
import 'package:porker_front/services/login_service.dart';
import 'package:porker_front/services/porker_service.dart';

part 'poker_controller.freezed.dart';

@freezed
class PokerControllerState with _$PokerControllerState {
  const factory PokerControllerState({
    required String roomID,
    required String masterLoginID,
    required RoomState roomState,
    required List<Ballot> ballots,
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
          ),
        );

  Future<void> subscribe() async {
    final loginID = await _loginSvc.loginID();
    final roomID = await _porkerSvc.reservationRoomID();

    final isNewConnection = await _porkerSvc.enterRoom(loginID!, roomID);
    if (!isNewConnection) {
      return;
    }

    _rmListener = _porkerSvc.addListener((poker) {
      state = state.copyWith(
        roomID: poker.roomId,
        masterLoginID: poker.masterLoginId,
        roomState: poker.state,
        ballots: poker.ballots,
      );
    });
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

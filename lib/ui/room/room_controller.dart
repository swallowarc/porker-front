import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:porker_front/services/login_service.dart';
import 'package:porker_front/services/porker_service.dart';
import 'package:sprintf/sprintf.dart';

part 'room_controller.freezed.dart';

@freezed
class RoomControllerState with _$RoomControllerState {
  const factory RoomControllerState(
    String? roomID,
  ) = _RoomControllerState;
}

class RoomController extends StateNotifier<RoomControllerState> {
  final PorkerService _porkerSvc;
  final LoginService _loginSvc;
  final roomIDController = TextEditingController();

  RoomController(PorkerService porker, LoginService login)
      : _porkerSvc = porker,
        _loginSvc = login,
        super(RoomControllerState(""));

  set roomID(String roomID) {
    roomIDController.value = TextEditingValue(text: roomID);
  }

  Future<void> createRoom(BuildContext context) async {
    final loginID = await _loginSvc.loginID();
    if (loginID == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('正しくログインできていません')));
      return;
    }

    final roomID = await _porkerSvc.createRoom(loginID);
    if (roomID == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('部屋の作成に失敗しました。')));
      return;
    }

    Navigator.of(context).pushNamedAndRemoveUntil(sprintf("/poker?room_id=%s", [roomID]), (_) => false);
  }

  Future<void> enterRoom(BuildContext context) async {
    final loginID = await _loginSvc.loginID();
    if (loginID == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('正しくログインできていません')));
      return;
    }

    final valid = await _porkerSvc.canEnterRoom(loginID, roomIDController.text);
    if (!valid) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('ルームIDが無効 または満室です')));
      return;
    }

    Navigator.of(context).pushNamedAndRemoveUntil(sprintf("/poker?room_id=%s", [roomIDController.text]), (_) => false);
  }

  @override
  void dispose() {
    roomIDController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:porker_front/services/login_service.dart';
import 'package:sprintf/sprintf.dart';

part 'login_controller.freezed.dart';

@freezed
class LoginControllerState with _$LoginControllerState {
  const factory LoginControllerState(
    String? roomID,
  ) = _LoginControllerState;
}

class LoginController extends StateNotifier<LoginControllerState> {
  final LoginService _login;
  final loginIDController = TextEditingController();

  LoginController(LoginService login)
      : _login = login,
        super(LoginControllerState(""));

  set roomID(String roomID) {
    state = state.copyWith(roomID: roomID);
  }

  Future<void> setPreviousLoginID() async {
    final status = await _login.previousLogin();
    loginIDController.text = status.loginID!;
  }

  Future<void> login(BuildContext context) async {
    final msg = await _login.login(loginIDController.text);
    if (msg != "") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
      return;
    }

    if (state.roomID == "") {
      Navigator.of(context).pushNamedAndRemoveUntil("/room", (_) => false);
      return;
    }
    Navigator.of(context).pushNamedAndRemoveUntil(sprintf("/poker?room_id=%s", [state.roomID]), (_) => false);
  }

  @override
  void dispose() {
    loginIDController.dispose();
    super.dispose();
  }
}

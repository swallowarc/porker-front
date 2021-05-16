import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:porker_front/providers.dart';
import 'package:porker_front/ui/room/room_controller.dart';

final StateNotifierProvider<RoomController, RoomControllerState> _controllerProvider = StateNotifierProvider(
    (ref) => RoomController(ref.read(porkerServiceProvider.notifier), ref.read(loginServiceProvider.notifier)));

class RoomView extends HookWidget {
  final _formKey = GlobalKey<FormState>();

  RoomView(BuildContext context, Map<String, String> queryParameters){
    final roomID = queryParameters["room_id"] ?? "";
    final controller = context.read(_controllerProvider.notifier);
    controller.roomID = roomID;
  }

  @override
  Widget build(BuildContext context) {
    final controller = useProvider(_controllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Room select'),
      ),
      body: Center(
        child: Container(
          width: 200,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  maxLength: 5,
                  decoration: InputDecoration(
                    hintText: 'ルームID',
                  ),
                  controller: controller.roomIDController,
                  validator: (value) {
                    if (value == null || value.length == 0) {
                      return '入力必須です';
                    }
                    const regExpString = r'^[0-9]{5}$';
                    if (!RegExp(regExpString, caseSensitive: true).hasMatch(value)) {
                      return '半角数字5桁を入力してください';
                    }
                    return null;
                  },
                  onFieldSubmitted: (id) {
                    if (id.length != 0) {
                      if (_formKey.currentState!.validate()) {
                        controller.createRoom(context);
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    child: const Text('入室'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      onPrimary: Colors.white,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        controller.enterRoom(context);
                      }
                    },
                  ),
                ),
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: Text("または"),
                ),
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    child: const Text('部屋を作成'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.redAccent,
                      onPrimary: Colors.white,
                    ),
                    onPressed: () {
                      controller.createRoom(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

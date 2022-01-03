import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:porker_front/providers.dart';
import 'package:porker_front/ui/login/login_controller.dart';

final StateNotifierProvider<LoginController, LoginControllerState> _controllerProvider =
    StateNotifierProvider<LoginController, LoginControllerState>(
        (ref) => LoginController(ref.watch(loginServiceProvider.notifier)));

class LoginView extends HookConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _queryParameters;

  LoginView(BuildContext context, Map<String, String> queryParameters) : _queryParameters = queryParameters;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(_controllerProvider.notifier);
    final roomID = _queryParameters["room_id"];
    if (roomID != null) {
      controller.roomID = roomID;
    }
    controller.setPreviousLoginID();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Container(
          width: 200,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Column(
                    children: [
                      const Text(
                        "Porker",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Image(
                        fit: BoxFit.scaleDown,
                        image: AssetImage("images/title.png"),
                      ),
                    ],
                  ),
                ),
                TextFormField(
                  maxLength: 10,
                  decoration: InputDecoration(
                    hintText: 'Guest ID',
                  ),
                  controller: controller.loginIDController,
                  validator: (value) {
                    if (value == null || value.length == 0) {
                      return '入力必須です';
                    }
                    return null;
                  },
                  onFieldSubmitted: (id) {
                    if (id.length != 0) {
                      if (_formKey.currentState!.validate()) {
                        controller.login(context);
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  child: const Text('Login'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    onPrimary: Colors.white,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      controller.login(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

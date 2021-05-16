import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:porker/porker.dart';
import 'package:porker_front/providers.dart';
import 'package:porker_front/ui/poker/poker_controller.dart';
import 'package:sprintf/sprintf.dart';

import 'card.dart';

const List<Point> _selectablePoints = [
  Point.POINT_0,
  Point.POINT_HALF,
  Point.POINT_1,
  Point.POINT_2,
  Point.POINT_3,
  Point.POINT_5,
  Point.POINT_8,
  Point.POINT_13,
  Point.POINT_21,
  Point.POINT_COFFEE,
  Point.POINT_QUESTION,
];

final StateNotifierProvider<PokerController, PokerControllerState> _controllerProvider = StateNotifierProvider(
    (ref) => PokerController(ref.read(porkerServiceProvider.notifier), ref.read(loginServiceProvider.notifier)));

class PokerView extends HookWidget {
  PokerView(BuildContext context, Map<String, String> queryParameters) {
    final controller = context.read(_controllerProvider.notifier);
    controller.subscribe(context, queryParameters["room_id"]);
  }

  @override
  Widget build(BuildContext context) {
    final controller = useProvider(_controllerProvider.notifier);
    final state = useProvider(_controllerProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Center(child: Text(sprintf("Porker [room id: %s]", [state.roomID]))),
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) {
              final List<PopupMenuEntry<int>> menuItems = [
                PopupMenuItem(
                  value: 1,
                  child: Text(
                    "退室",
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Text(
                    "リセット",
                  ),
                ),
              ];
              return menuItems;
            },
            onSelected: (int idx) {
              switch (idx) {
                case 1:
                  controller.leave(context);
                  break;
                case 2:
                  controller.reset(context);
                  break;
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: _buildView(context, state),
        ),
      ),
    );
  }

  Widget _buildView(BuildContext context, PokerControllerState state) {
    return Container(
      width: 800,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SelectableCards(),
          _FieldCards(),
          _FieldButtons(),
        ],
      ),
    );
  }
}

class _SelectableCards extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useProvider(_controllerProvider.notifier);

    var i = 0;
    final List<Widget> cards = _selectablePoints
        .map(
          (e) => Expanded(
            child: Container(
              child: PokerCard(() => controller.voting(context, e), e, true, 80 * i++),
              height: 100,
            ),
          ),
        )
        .toList();

    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 20),
      width: 900,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: cards,
        ),
      ),
    );
  }
}

class _FieldCards extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final state = useProvider(_controllerProvider);

    final List<Widget> cards = state.ballots
        .map(
          (e) => Expanded(
            child: Column(
              children: [
                Container(
                  height: 150,
                  width: 120,
                  child: PokerCard(() => {}, e.point, state.roomState == RoomState.ROOM_STATE_OPEN,
                      Random(this.hashCode).nextInt(500)),
                ),
                Text(e.loginId),
              ],
            ),
          ),
        )
        .toList();

    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 30),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: cards,
        ),
      ),
    );
  }
}

class _FieldButtons extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final state = useProvider(_controllerProvider);
    final controller = useProvider(_controllerProvider.notifier);

    final openable = state.roomState == RoomState.ROOM_STATE_TURN_DOWN &&
        state.ballots.where((e) => ![Point.POINT_UNKNOWN, Point.NOT_VOTE].contains(e.point)).length > 0;

    return Center(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 30),
        width: 330,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 150,
              height: 50,
              child: ElevatedButton.icon(
                icon: Icon(Icons.group),
                label: const Text('Open'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  onPrimary: Colors.white,
                  elevation: 3,
                ),
                onPressed: openable ? () => controller.voteCounting(context) : null,
              ),
            ),
            SizedBox(
              width: 150,
              height: 50,
              child: ElevatedButton.icon(
                icon: Icon(Icons.refresh),
                label: const Text('Reset'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlue,
                  onPrimary: Colors.white,
                  elevation: 3,
                ),
                onPressed: () {
                  controller.reset(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

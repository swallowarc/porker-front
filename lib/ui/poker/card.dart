import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:porker/porker.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sprintf/sprintf.dart';
import 'package:supercharged/supercharged.dart';

const Map<Point, String> _DisplayPoint = {
  Point.POINT_0: "0",
  Point.POINT_HALF: "1/2",
  Point.POINT_1: "1",
  Point.POINT_2: "2",
  Point.POINT_3: "3",
  Point.POINT_5: "5",
  Point.POINT_8: "8",
  Point.POINT_13: "13",
  Point.POINT_21: "21",
  Point.POINT_COFFEE: "休",
  Point.POINT_QUESTION: "?",
};

final Map<Point, Color> _displayColors = {
  Point.POINT_0: Colors.lightBlue.shade400,
  Point.POINT_HALF: Colors.lightBlue.shade300,
  Point.POINT_1: Colors.lightBlue.shade200,
  Point.POINT_2: Colors.lightBlue.shade100,
  Point.POINT_3: Colors.lightBlue.shade50,
  Point.POINT_5: Colors.red.shade50,
  Point.POINT_8: Colors.red.shade100,
  Point.POINT_13: Colors.red.shade200,
  Point.POINT_21: Colors.red.shade300,
  Point.POINT_COFFEE: Colors.lightGreenAccent.shade100,
  Point.POINT_QUESTION: Colors.yellow.shade200,
};

final List<Color> _cardColors = [
  Colors.red.shade300,
  Colors.green.shade300,
  Colors.blue.shade300,
  Colors.yellow.shade300,
  Colors.orange.shade300,
  Colors.purple.shade300,
  Colors.white70,
  Colors.indigoAccent.shade100,
  Colors.pinkAccent.shade100,
];

class PokerCard extends StatefulWidget {
  final Function() _callback;
  final Point _point;
  final bool _isOpen;
  final int _delay;
  final String _loginID;

  PokerCard(this._callback, this._point, this._isOpen, this._delay, this._loginID);

  @override
  _PokerCardState createState() => _PokerCardState();
}

class _PokerCardState extends State<PokerCard> with TickerProviderStateMixin {
  CustomAnimationControl control = CustomAnimationControl.playFromStart;
  Point latestPoint = Point.POINT_UNKNOWN;
  bool latestIsOpen = false;

  @override
  Widget build(BuildContext context) {
    if (latestPoint != widget._point || latestIsOpen != widget._isOpen) {
      control = CustomAnimationControl.playFromStart;
      latestPoint = widget._point;
      latestIsOpen = widget._isOpen;
    }

    if (widget._point == Point.POINT_UNKNOWN) {
      return Card(
        color: Colors.black.withOpacity(0.0),
      );
    }

    final int colorID = widget._loginID.hashCode % _cardColors.length;
    final card = CustomAnimation<double>(
      delay: (widget._delay).milliseconds,
      control: control,
      tween: (2.0).tweenTo(1.0),
      duration: 300.milliseconds,
      curve: Curves.easeIn,
      builder: (context, child, value) {
        if (value == 1.0) {
          control = CustomAnimationControl.stop;
        }
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: Container(
        child: Card(
          child: _cardImage(),
          color: widget._isOpen ? _displayColors[widget._point] : _cardColors[colorID],
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 1.0,
              blurRadius: 3.0,
              offset: Offset(5, 5),
            ),
          ],
        ),
      ),
    );

    return MouseRegion(
      cursor: SystemMouseCursors.grab,
      child: GestureDetector(
        child: card,
        onTap: () => widget._callback(),
      ),
    );
  }

  Widget? _cardImage() {
    if (!widget._isOpen) {
      final int imageID = widget._loginID.hashCode % 11;
      return Container(
        child: ClipRRect(
          child: Image(
            fit: BoxFit.scaleDown,
            image: AssetImage(sprintf("images/card-%02d.png", [imageID])),
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        margin: EdgeInsets.all(4.0),
      );
    }

    if (_DisplayPoint.containsKey(widget._point)) {
      return Container(
        child: Text(
          _DisplayPoint[widget._point]!,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
        ),
        alignment: Alignment.center,
      );
    }

    return null;
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:porker/porker.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sprintf/sprintf.dart';
import 'package:supercharged/supercharged.dart';

class Unanimous extends StatefulWidget {
  @override
  _UnanimousState createState() => _UnanimousState();
}

class _UnanimousState extends State<Unanimous> with TickerProviderStateMixin {
  CustomAnimationControl control = CustomAnimationControl.playFromStart;
  Point latestPoint = Point.POINT_UNKNOWN;
  bool latestIsOpen = false;

  @override
  Widget build(BuildContext context) {
    final picture = CustomAnimation<double>(
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
      child: GestureDetector(
        child: picture,
      ),
    );
  }

  Widget? _cardImage() {
    return Container(
      child: ClipRRect(
        child: Image(
          fit: BoxFit.scaleDown,
          image: AssetImage(sprintf("images/food-%02d.png", [this.hashCode % 9])),
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.all(4.0),
    );
  }
}

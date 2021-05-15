import 'package:flutter/material.dart';
import 'package:porker_front/ui/login/login_view.dart';
import 'package:porker_front/ui/poker/poker_view.dart';
import 'package:porker_front/ui/room/room_view.dart';

typedef PathWidgetBuilder = Widget Function(BuildContext, String?);

class Path {
  const Path(this.pattern, this.builder);

  final String pattern;

  final PathWidgetBuilder builder;
}

class RouteConfiguration {
  static List<Path> paths = [
    Path("/", (context, match) => LoginView()),
    Path("/room", (context, match) => RoomView()),
    Path("/poker", (context, match) => PokerView())
  ];

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    for (final path in paths) {
      final regExpPattern = RegExp(path.pattern);

      if (path.pattern == settings.name) {
        final firstMatch = regExpPattern.firstMatch(settings.name!);
        final match = (firstMatch!.groupCount == 1) ? firstMatch.group(1) : null;
        return AnimationMaterialPageRoute<void>(
          builder: (context) => path.builder(context, match),
          settings: settings,
        );
      }
    }

    // If no match was found, we let [WidgetsApp.onUnknownRoute] handle it.
    return null;
  }
}

class AnimationMaterialPageRoute<T> extends MaterialPageRoute<T> {
  AnimationMaterialPageRoute({
    required WidgetBuilder builder,
    required RouteSettings settings,
  }) : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curve = Curves.ease;
    final tween = Tween<double>(begin: 2, end: 1).chain(CurveTween(curve: curve));

    return ScaleTransition(
      // alignment: Alignment.topCenter,
      scale: animation.drive(tween),
      child: child,
    );
  }
}

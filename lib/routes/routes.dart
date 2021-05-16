import 'package:flutter/material.dart';
import 'package:porker_front/ui/login/login_view.dart';
import 'package:porker_front/ui/poker/poker_view.dart';
import 'package:porker_front/ui/room/room_view.dart';

typedef PathWidgetBuilder = Widget Function(BuildContext, Map<String, String>);

class Path {
  const Path(this.pattern, this.builder);

  final String pattern;

  final PathWidgetBuilder builder;
}

class RouteConfiguration {
  static List<Path> paths = [
    Path("/", (context, queryParameters) => LoginView(context, queryParameters)),
    Path("/room", (context, queryParameters) => RoomView(context, queryParameters)),
    Path("/poker", (context, queryParameters) => PokerView(context, queryParameters))
  ];

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final pathStrings = settings.name!.split('?');
    Map<String, String> queryParameters;
    if (pathStrings.length > 1) {
      queryParameters = Uri.splitQueryString(pathStrings[1]);
    } else {
      queryParameters = {};
    }

    for (final path in paths) {
      if (pathStrings[0] == path.pattern) {
        return AnimationMaterialPageRoute<void>(
          builder: (context) => path.builder(context, queryParameters),
          settings: settings,
        );
      }
    }

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

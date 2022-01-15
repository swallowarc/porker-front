import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:porker_front/routes/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ProviderScope(
      child: MaterialApp(
        title: "Porker",
        theme: ThemeData(
          brightness: Brightness.light,
          fontFamily: "HachiMaruPop",
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: "HachiMaruPop",
        ),
        initialRoute: '/',
        onGenerateRoute: RouteConfiguration.onGenerateRoute,
      ),
    ),
  );
}

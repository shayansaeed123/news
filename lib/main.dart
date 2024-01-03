import 'package:flutter/material.dart';
import 'package:news/utils/routes/routes.dart';
import 'package:news/utils/routes/routes_names.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(color: Colors.white,elevation: 2,),
        textTheme: TextTheme().apply(bodyColor: Colors.black),
      ),
      initialRoute: RoutesNames.splash,
      onGenerateRoute: Routes.generateRoutes,
    );
  }
}


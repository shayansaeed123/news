
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/utils/routes/routes_names.dart';
import 'package:news/view/categories_screen.dart';
import 'package:news/view/home_screen.dart';
import 'package:news/view/splash_screen.dart';

class Routes{

  static Route<dynamic> generateRoutes(RouteSettings settings){

    switch(settings.name){
      case RoutesNames.splash:
        return MaterialPageRoute(builder: (BuildContext context) => const SplashScreen());

      case RoutesNames.home:
        return MaterialPageRoute(builder: (BuildContext context) => const HomeScreen());
      case RoutesNames.categories:
        return MaterialPageRoute(builder: (BuildContext context) => const CategoriesScreen());
      default:
        return MaterialPageRoute(builder: (context) {
          return Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        },);
    }
  }
}
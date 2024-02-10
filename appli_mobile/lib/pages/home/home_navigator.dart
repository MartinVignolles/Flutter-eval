import 'package:appli_mobile/pages/home/home.dart';
import 'package:appli_mobile/pages/home/infos.dart';
import 'package:flutter/material.dart';

class HomeNavigator extends StatefulWidget {
  const HomeNavigator({super.key});

  @override
  HomeNavigatorState createState() => HomeNavigatorState();
}

class HomeNavigatorState extends State<HomeNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              switch (settings.name) {
                case '/':
                  return const HomePage();
                case '/infos':
                  final String idGamelle = settings.arguments as String;
                  return InfosPage(idGamelle: idGamelle);
                default:
                  return Container();
              }
            });
      },
    );
  }
}

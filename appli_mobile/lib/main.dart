import 'package:appli_mobile/components/my_bottom_bar.dart';
import 'package:appli_mobile/pages/home/home_navigator.dart';
import 'package:appli_mobile/pages/login/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/calendrier/Calendrier.dart';
import 'pages/historique/historique.dart';
import 'pages/settings/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'IBowl', debugShowCheckedModeBanner: true, home: LoginPage());
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainState createState() => MainState();
}

class MainState extends State<MainPage> {
  int selectedItem = 0;
  static const List<Widget> pages = <Widget>[
    HomeNavigator(),
    CalendrierPage(),
    HistoriquePage(),
    SettingsPage()
  ];

  void onItemTapped(int index) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          top: false,
          child: IndexedStack(index: selectedItem, children: pages)),
      bottomNavigationBar: AppBottomNavigationBar(
        selectedItem: selectedItem,
        onItemTapped: (index) {
          setState(() {
            selectedItem = index;
          });
        },
      ),
    );
  }

  void setItem(item) {
    selectedItem = item;
  }
}

import 'package:flutter/material.dart';

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar(
      {super.key, required this.selectedItem, required this.onItemTapped});

  final int selectedItem;
  final ValueChanged<int> onItemTapped;

  @override
  State<AppBottomNavigationBar> createState() => AppBottomNavigationBarState();
}

class AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color.fromRGBO(3, 63, 120, 0.612)),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month),
          label: 'Calendrier',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history_edu),
          label: 'Historique',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Paramètre',
        ),
      ],
      currentIndex: widget.selectedItem,
      selectedItemColor: Colors.amber[800],
      onTap: widget.onItemTapped,
    );
  }
}

import 'package:car_manager_app/screens/bottom_tab/cars_manager.dart';
import 'package:car_manager_app/screens/bottom_tab/setting.dart';
import 'package:flutter/material.dart';

class BottomTabUser extends StatefulWidget {
  const BottomTabUser({super.key});

  @override
  State<BottomTabUser> createState() => _BottomTabUserState();
}

class _BottomTabUserState extends State<BottomTabUser> {
  int _selectedScreenIndex = 0;

  static const List<Widget> _listScreen = <Widget>[
    CarsManager(),
    Setting(),
  ];

  static const List<String> _title = ["Trang chủ", "Cài đặt"];

  void _onTap(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title[_selectedScreenIndex]),
      ),
      body: _listScreen[_selectedScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedScreenIndex,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(
            label: "Trang chủ",
            icon: Icon(Icons.drive_eta_rounded),
          ),
          BottomNavigationBarItem(
            label: "Cài đặt",
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}

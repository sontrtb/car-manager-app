import 'package:car_manager_app/screens/bottom_tab/cars_manager.dart';
import 'package:car_manager_app/screens/bottom_tab/list_users.dart';
import 'package:car_manager_app/screens/bottom_tab/setting.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomTabAdmin extends StatefulWidget {
  const BottomTabAdmin({super.key});

  @override
  State<BottomTabAdmin> createState() => _BottomTabAdminState();
}

class _BottomTabAdminState extends State<BottomTabAdmin> {
  int _selectedScreenIndex = 0;
  String role = "user";

  static const List<Widget> _listScreen = <Widget>[
    CarsManager(),
    ListUser(),
    Setting(),
  ];

  static const List<String> _title = [
    "Danh sách xe",
    "Danh sách người dùng",
    "Cài đặt"
  ];

  void _onTap(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  Future<void> _loadRoleUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getString('role') ?? "user";
    });
  }

  @override
  void initState() {
    _loadRoleUser();
    super.initState();
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
            label: "Xe",
            icon: Icon(Icons.drive_eta_rounded),
          ),
          BottomNavigationBarItem(
            label: "Người dùng",
            icon: Icon(Icons.groups),
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

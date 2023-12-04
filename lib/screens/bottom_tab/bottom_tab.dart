import 'package:car_manager_app/screens/auth/login.dart';
import 'package:car_manager_app/screens/home/home_user.dart';
import 'package:car_manager_app/screens/bottom_tab/widgets/bottom_tab_admin.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomTab extends StatefulWidget {
  const BottomTab({super.key});

  @override
  State<BottomTab> createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  String? role;

  Future<void> _loadRoleUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getString('role');
    });
  }

  @override
  void initState() {
    _loadRoleUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (role == "admin") {
      return const BottomTabAdmin();
    } else if (role == "user") {
      return const HomeUser();
    }
    return const Login();
  }
}

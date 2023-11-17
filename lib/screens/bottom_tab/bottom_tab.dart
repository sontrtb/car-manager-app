import 'package:car_manager_app/screens/bottom_tab/widgets/bottom_tab_admin.dart';
import 'package:car_manager_app/screens/bottom_tab/widgets/bottom_tab_user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomTab extends StatefulWidget {
  const BottomTab({super.key});

  @override
  State<BottomTab> createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  String role = "user";

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
    if (role == "admin") {
      return const BottomTabAdmin();
    }

    return const BottomTabUser();
  }
}

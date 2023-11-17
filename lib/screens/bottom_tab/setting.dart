import 'package:car_manager_app/widgets/button.dart';
import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  void _handleLogout(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, '/login', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ElevatedButtonWidget(
            isFullWidth: true,
            text: "Đăng xuất",
            onPressed: () {
              _handleLogout(context);
            },
          ),
        ],
      ),
    );
  }
}

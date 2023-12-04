import 'package:car_manager_app/screens/bottom_tab/widgets/modal_price.dart';
import 'package:car_manager_app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  Future<void> _handleLogout(BuildContext context) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Navigator.pushNamedAndRemoveUntil(
        context, '/login', (Route<dynamic> route) => false);
  }

  void _openModalPrice(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const ModalPrice(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              _openModalPrice(context);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Giá tiền một giờ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(Icons.arrow_right)
                ],
              ),
            ),
          ),
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

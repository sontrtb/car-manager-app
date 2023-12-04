import 'package:car_manager_app/models/car.dart';
import 'package:car_manager_app/screens/home/widgets/action_home_user.dart';
import 'package:car_manager_app/screens/home/widgets/money.dart';
import 'package:car_manager_app/widgets/gradient_container.dart';
import 'package:car_manager_app/widgets/qr_scanner.dart';
import 'package:flutter/material.dart';

class HomeUser extends StatelessWidget {
  const HomeUser({super.key});

  void _handleLogout(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, '/login', (Route<dynamic> route) => false);
  }

  void _openScanerQrCode(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => QrSanner(
        onScanSuccess: (String id) {
          Navigator.pop(context);
          Navigator.pushNamed(
            context,
            '/car_detail',
            arguments: CarDetailArguments(Car(id: 1, idCar: id)),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientContainer.defaultColor(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "update_infor_user");
                  },
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Xin chao!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "Pham Hong Son",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {
                      _handleLogout(context);
                    },
                    icon: const Icon(
                      Icons.logout,
                      size: 35,
                      color: Colors.white,
                    ))
              ],
            ),
            const Money(),
            Container(
              height: 500,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 235, 235, 235),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ActionHomeUser(
                    title: "Quét mã",
                    icon: const Icon(
                      Icons.qr_code_2,
                      size: 120,
                      color: Color.fromARGB(255, 129, 145, 173),
                    ),
                    action: () {
                      _openScanerQrCode(context);
                    },
                  ),
                  ActionHomeUser(
                    title: "Danh sách xe chờ",
                    icon: const Icon(
                      Icons.map_outlined,
                      size: 120,
                      color: Color.fromARGB(255, 129, 145, 173),
                    ),
                    action: () {
                      Navigator.pushNamed(context, "/all_car");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

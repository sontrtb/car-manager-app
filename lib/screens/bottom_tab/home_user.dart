import 'package:car_manager_app/models/car.dart';
import 'package:car_manager_app/widgets/button.dart';
import 'package:car_manager_app/widgets/qr_scanner.dart';
import 'package:flutter/material.dart';

class HomeUser extends StatelessWidget {
  const HomeUser({super.key});

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
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: ElevatedButtonWidget(
            text: "Mở Qr scan",
            onPressed: () {
              _openScanerQrCode(context);
            },
          ),
        ),
      ),
    );
  }
}

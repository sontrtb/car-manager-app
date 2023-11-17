import 'package:car_manager_app/widgets/button.dart';
import 'package:car_manager_app/widgets/qr_scanner.dart';
import 'package:flutter/material.dart';
import 'widgets/list_cars.dart';

class CarsManager extends StatefulWidget {
  const CarsManager({super.key});

  @override
  State<CarsManager> createState() => _CarsManagerState();
}

class _CarsManagerState extends State<CarsManager> {
  late String _idCarAdd;

  void _handleRegisterCar() {
    print("Call api...$_idCarAdd");
    Navigator.pop(context);
  }

  void _openAddCar() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => QrSanner(
        onScanSuccess: (String id) {
          setState(() {
            _idCarAdd = id;
          });
          Navigator.pop(context);
          _openConfirmAddCar();
        },
      ),
    );
  }

  void _openConfirmAddCar() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: 200,
          child: Column(
            children: [
              const Text(
                "Xác nhận đăng kí xe",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              RichText(
                text: TextSpan(
                  text: "ID xe: ",
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                  children: [
                    TextSpan(
                      text: _idCarAdd,
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButtonWidget(
                      text: "Huỷ",
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  const SizedBox(
                    width: 30,
                  ),
                  ElevatedButtonWidget(
                    text: "Xác nhận",
                    onPressed: _handleRegisterCar,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          const Expanded(
            child: ListCars(),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButtonWidget(
              text: "Thêm xe",
              onPressed: _openAddCar,
              isFullWidth: true,
            ),
          )
        ],
      ),
    );
  }
}

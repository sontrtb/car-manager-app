import 'package:car_manager_app/models/car.dart';
import 'package:car_manager_app/services/car.dart';
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
  List<Car> _cars = [];

  Future<void> _handleRegisterCar() async {
    setState(() {
      _cars.insert(
          0,
          Car(
            id: 4,
            idCar: "jhhjhhj787yuy8y",
          ));
    });
    // final response = await CarApi().createCar(_idCarAdd);
    // if (response.errorCode == 0) {
    //   setState(() {
    //     _cars.insert(
    //         0,
    //         Car(
    //           id: response.data["id"],
    //           idCar: response.data["idCar"],
    //         ));
    //   });
    //   if (context.mounted) {
    //     Navigator.pop(context);
    //   }
    // }
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

  Future<void> _loadData() async {
    final res = await CarApi().listCar();
    final List<dynamic> initCars = res.data;
    final List<Car> loadedCars = initCars
        .map((e) => Car(
              id: e["id"],
              idCar: e["idCar"],
              lat: e["lat"],
              lon: e["lon"],
              userId: e["userId"],
              statusLock: e["statusLock"],
              startUseTime: e["startUseTime"],
              endUseTime: e["endUseTime"],
            ))
        .toList();

    if (!mounted) return;
    setState(() {
      _cars = loadedCars;
    });
  }

  @override
  void initState() {
    super.initState();
    // _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Expanded(
            child: ListCars(cars: _cars),
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

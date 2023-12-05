import 'package:car_manager_app/models/car.dart';
import 'package:car_manager_app/services/car.dart';
import 'package:car_manager_app/services/user.dart';
import 'package:car_manager_app/utils/format.dart';
import 'package:car_manager_app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final f = NumberFormat("###,###.###", "tr_TR");

class Pay extends StatefulWidget {
  const Pay({super.key, required this.car});

  static String routeName = "pay";

  final Car car;

  @override
  State<Pay> createState() => _PayState();
}

class _PayState extends State<Pay> {
  bool _isSending = false;

  double _hourBetween = 0;

  Future<void> _handlePay() async {
    setState(() {
      _isSending = true;
    });

    await UserApi().pay((_hourBetween * 40000).toInt());
    await CarApi().updateCar(widget.car.idCar, null);

    setState(() {
      _isSending = false;
    });

    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/bottom_tab',
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  void initState() {
    _hourBetween = FormatDateIso()
        .hourBetween(widget.car.startUseTime, widget.car.endUseTime);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thanh toán"),
      ),
      body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    "Mã xe: ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    widget.car.idCar,
                    style: const TextStyle(fontSize: 18),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const Text(
                    "Thời gian bắt đầu: ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    FormatDateIso()
                        .formatToString(widget.car.startUseTime ?? ""),
                    style: const TextStyle(fontSize: 18),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const Text(
                    "Thời gian kết thúc: ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    FormatDateIso().formatToString(widget.car.endUseTime ?? ""),
                    style: const TextStyle(fontSize: 18),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const Text(
                    "Thời gian sử dụng: ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    "$_hourBetween giờ",
                    style: const TextStyle(
                        fontSize: 20, color: Color.fromARGB(255, 42, 248, 149)),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                color: const Color.fromARGB(255, 222, 216, 249),
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    const Text(
                      "Tổng tiền: ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.blue),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      f.format(_hourBetween * 40000),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButtonWidget(
                text: "Thanh toán",
                onPressed: () {
                  _handlePay();
                },
                isFullWidth: true,
                isLoading: _isSending,
              ),
            ],
          )),
    );
  }
}

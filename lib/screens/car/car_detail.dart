import 'dart:async';
import 'dart:convert';
import 'package:car_manager_app/models/car.dart';
import 'package:car_manager_app/services/car.dart';
import 'package:car_manager_app/utils/format.dart';
import 'package:car_manager_app/widgets/button.dart';
import 'package:car_manager_app/widgets/mqtt_handler.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final formatter = DateFormat('hh:mm dd-MM-yyyy');

class CarDetail extends StatefulWidget {
  const CarDetail({super.key, required this.initCar});

  final Car initCar;

  static String routeName = "/car_detail";

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(20.9805459, 105.7853237),
    zoom: 14.4746,
  );

  @override
  State<CarDetail> createState() => _CarDetailState();
}

class _CarDetailState extends State<CarDetail> {
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  late Car? car;
  String? role;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Future<void> _handleMessageMqtt(String mess) async {
    if (car == null || car?.idCar == null || !mounted) return;

    Map<String, dynamic>? response = jsonDecode(mess);

    if (response?["idCar"] != car?.idCar) return;

    final marker = Marker(
      markerId: MarkerId(car!.idCar),
      position: LatLng(response?['lat'] ?? 0, response?['lon'] ?? 0),
      icon: await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(
            size: Size(15, 15),
          ),
          "assets/images/icon_car.png"),
    );

    setState(() {
      if (response?['statusLock'] != null) {
        car?.statusLock = response?['statusLock'].toString() == "true";
      }
      if (response?['lat'] != null && response?['lon'] != null) {
        markers[MarkerId(car!.idCar)] = marker;
      }
    });
  }

  Future<void> _loadData() async {
    setState(() {
      car = widget.initCar;
    });
  }

  Future<void> _loadRoleUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getString('role');
    });
  }

  void _handleLock() {
    CarApi().lockCar(car!.idCar);
  }

  Future<void> _handleEnd() async {
    final newCarRes = await CarApi().updateCar(car!.idCar, null);
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        'pay',
        (Route<dynamic> route) => false,
        arguments: CarDetailArguments(Car.fromJson(newCarRes.data)),
      );
    }
  }

  @override
  void initState() {
    _loadRoleUser();
    MqttHandler mqttHandler =
        MqttHandler(topic: "MQTT_ESP32/LED1", onMessage: _handleMessageMqtt);
    _loadData();

    mqttHandler.connect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Chi tiết xe"),
          automaticallyImplyLeading: role == "admin",
        ),
        body: Column(
          children: [
            SizedBox(
              height: height - 550,
              child: GoogleMap(
                markers: markers.values.toSet(),
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                initialCameraPosition: CarDetail._kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Thông tin xe",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Mã xe: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                              car?.idCar ?? "",
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
                              "Trạng thái: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                              car?.statusLock == true
                                  ? "Khoá xe"
                                  : "Đang hoạt động",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: car?.statusLock == true
                                      ? Colors.redAccent
                                      : Colors.greenAccent),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        car?.startUseTime != null
                            ? Row(
                                children: [
                                  const Text(
                                    "Giờ bắt đầu: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    FormatDateIso()
                                        .formatToString(car!.startUseTime!),
                                    style: const TextStyle(fontSize: 18),
                                  )
                                ],
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 10,
                        ),
                        car?.userId != null
                            ? Row(
                                children: [
                                  const Text(
                                    "Người sử dụng: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    (car?.userData != null &&
                                            car?.userData?.name != null)
                                        ? car!.userData!.name!
                                        : "---",
                                    style: const TextStyle(fontSize: 18),
                                  )
                                ],
                              )
                            : const SizedBox()
                      ],
                    ),
                    Column(
                      children: [
                        OutlinedButtonWidget(
                          isFullWidth: true,
                          text: car?.statusLock == true ? "Mở khoá" : "Khoá xe",
                          onPressed: _handleLock,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        role == "user"
                            ? ElevatedButtonWidget(
                                isFullWidth: true,
                                text: "Kết thúc chuyến đi",
                                onPressed: () {
                                  _handleEnd();
                                })
                            : const SizedBox()
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

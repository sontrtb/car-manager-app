import 'dart:async';
import 'dart:convert';
import 'package:car_manager_app/models/car.dart';
import 'package:car_manager_app/widgets/mqtt_handler.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CarDetail extends StatefulWidget {
  const CarDetail({super.key});

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(20.9805459, 105.7853237),
    zoom: 14.4746,
  );

  @override
  State<CarDetail> createState() => _CarDetailState();
}

class _CarDetailState extends State<CarDetail> {
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  late MqttHandler mqttHandler;

  Future<void> _handleMessageMqtt(String mess) async {
    Map<String, dynamic> response = jsonDecode(mess);
    final carUpdate = Car.fromJson(response);
    final marker = Marker(
      markerId: MarkerId(carUpdate.idCar),
      position: LatLng(carUpdate.lat!, carUpdate.lon!),
      icon: await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(
            size: Size(15, 15),
          ),
          "assets/images/icon_car.png"),
      infoWindow: InfoWindow(
        title: 'Mã xe: ${carUpdate.idCar}',
        snippet: "Trạng thái: ${carUpdate.statusLock.toString()}",
      ),
    );
    setState(() {
      markers[MarkerId(carUpdate.idCar)] = marker;
    });
  }

  Future<void> _loadData() async {}

  @override
  void initState() {
    mqttHandler = MqttHandler(topic: "sontrtb", onMessage: _handleMessageMqtt);
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
        ),
        body: Column(
          children: [
            SizedBox(
              height: height - 400,
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
          ],
        ));
  }
}

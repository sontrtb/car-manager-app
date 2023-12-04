import 'dart:async';
import 'dart:convert';

import 'package:car_manager_app/widgets/mqtt_handler.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapAllCar extends StatefulWidget {
  const MapAllCar({super.key});

  @override
  State<MapAllCar> createState() => _MapAllCarState();
}

class _MapAllCarState extends State<MapAllCar> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(20.9805459, 105.7853237),
    zoom: 14.4746,
  );

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  Future<void> _handleMessageMqtt(String mess) async {
    if (!mounted) return;

    Map<String, dynamic> response = jsonDecode(mess);

    final marker = Marker(
      markerId: MarkerId(response["idCar"]),
      position: LatLng(response['lat'], response['lon']),
      icon: await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(
            size: Size(15, 15),
          ),
          "assets/images/icon_car.png"),
    );

    setState(() {
      if (response['lat'] != null &&
          response['lon'] != null &&
          response["idCar"] != null) {
        markers[MarkerId(response["idCar"])] = marker;
      }
    });
  }

  @override
  void initState() {
    MqttHandler mqttHandler =
        MqttHandler(topic: "MQTT_ESP32/LED1", onMessage: _handleMessageMqtt);
    mqttHandler.connect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách xe"),
      ),
      body: GoogleMap(
        markers: markers.values.toSet(),
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}

import 'dart:async';

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

  void _loadData() async {
    final marker = Marker(
        markerId: MarkerId("ssdsd"),
        position: LatLng(20.9800909, 105.7853924),
        icon: await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(
              size: Size(15, 15),
            ),
            "assets/images/icon_car.png"),
        infoWindow: InfoWindow(
          title: "Mã xe: ssas8sa8s8",
          snippet: "Trạng thái: Rảnh",
        ));
    setState(() {
      markers = {MarkerId("ssdsd"): marker};
    });
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Các xe chờ"),
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

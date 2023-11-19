import 'dart:convert';

class Car {
  Car({
    required this.id,
    required this.idCar,
    this.lat,
    this.lon,
    this.endUseTime,
    this.startUseTime,
    this.statusLock,
    this.userId,
  });

  final int id;
  final String idCar;
  late String? lat;
  late String? lon;
  late int? userId;
  late bool? statusLock;
  late DateTime? startUseTime;
  late DateTime? endUseTime;
}

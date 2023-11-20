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

  late int id;
  late String idCar;
  late double? lat;
  late double? lon;
  late int? userId;
  late bool? statusLock;
  late DateTime? startUseTime;
  late DateTime? endUseTime;

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      lat: json['lat'],
      lon: json['lon'],
      idCar: json['idCar'],
      statusLock: json['statusLock'],
    );
  }
}

import 'package:car_manager_app/models/user.dart';

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
    this.userData,
  });

  late int id;
  late String idCar;
  late double? lat;
  late double? lon;
  late int? userId;
  late bool? statusLock;
  late DateTime? startUseTime;
  late DateTime? endUseTime;
  late User? userData;

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      lat: json['lat'],
      lon: json['lon'],
      idCar: json['idCar'],
      statusLock: json['statusLock'],
      userId: json['userId'],
      userData: json['userData'] == null
          ? null
          : User(
              id: json['userData']["id"],
              role:
                  json['userData']["role"] == "admin" ? Role.admin : Role.user,
              name: json['userData']["name"],
              userName: json['userData']["userName"],
              amountOfMoney: json['userData']["amountOfMoney"],
            ),
    );
  }
}

class CarDetailArguments {
  final Car car;

  CarDetailArguments(this.car);
}

import 'package:car_manager_app/models/car.dart';
import 'package:flutter/material.dart';

import 'list_cars_item.dart';

class ListCars extends StatefulWidget {
  const ListCars({super.key});

  @override
  State<ListCars> createState() => _ListCarsState();
}

class _ListCarsState extends State<ListCars> {
  List<Car> cars = [
    Car(id: 1, idCar: "sdssd8s7d8sdys8dy"),
    Car(id: 1, idCar: "sdssd8s7d8sdys8dy"),
    Car(id: 1, idCar: "sdssd8s7d8sdys8dy"),
    Car(id: 1, idCar: "sdssd8s7d8sdys8dy"),
    Car(id: 1, idCar: "sdssd8s7d8sdys8dy"),
    Car(id: 1, idCar: "sdssd8s7d8sdys8dy"),
    Car(id: 1, idCar: "sdssd8s7d8sdys8dy"),
    Car(id: 1, idCar: "sdssd8s7d8sdys8dy"),
    Car(id: 1, idCar: "sdssd8s7d8sdys8dy"),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cars.length,
      itemBuilder: (ctx, index) => ListCarsItem(
        car: cars[index],
      ),
    );
  }
}

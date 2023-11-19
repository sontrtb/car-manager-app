import 'package:car_manager_app/models/car.dart';
import 'package:flutter/material.dart';
import 'list_cars_item.dart';

class ListCars extends StatefulWidget {
  const ListCars({super.key, required this.cars});

  final List<Car> cars;

  @override
  State<ListCars> createState() => _ListCarsState();
}

class _ListCarsState extends State<ListCars> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.cars.length,
      itemBuilder: (ctx, index) => ListCarsItem(
        car: widget.cars[index],
      ),
    );
  }
}

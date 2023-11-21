import 'package:car_manager_app/models/car.dart';
import 'package:flutter/material.dart';

class ListCarsItem extends StatelessWidget {
  const ListCarsItem({super.key, required this.car});

  final Car car;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/car_detail',
            arguments: CarDetailArguments(car),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ID: ${car.idCar}",
              ),
              const Row(
                children: [
                  Icon(Icons.lock),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Bị khoá"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

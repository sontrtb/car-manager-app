import 'package:flutter/material.dart';

const startAlignment = Alignment.topLeft;
const endAlignment = Alignment.bottomRight;

class GradientContainer extends StatelessWidget {
  const GradientContainer(
      {super.key, required this.colors, required this.child});
  GradientContainer.defaultColor({super.key, required this.child})
      : colors = [
          const Color.fromRGBO(121, 122, 236, 1),
          Color.fromARGB(255, 24, 139, 255)
        ];

  final List<Color> colors;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: colors, begin: startAlignment, end: endAlignment),
      ),
      child: child,
    );
  }
}

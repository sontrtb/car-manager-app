import 'package:flutter/material.dart';

class ActionHomeUser extends StatelessWidget {
  const ActionHomeUser(
      {super.key,
      required this.title,
      required this.icon,
      required this.action});

  final void Function() action;
  final String title;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.all(25),
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        child: Row(
          children: [
            icon,
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 129, 145, 173),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

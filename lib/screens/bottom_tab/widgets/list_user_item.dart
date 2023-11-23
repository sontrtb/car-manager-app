import 'package:flutter/material.dart';

class ListUserItem extends StatelessWidget {
  const ListUserItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text("sds ds d "),
        ),
      ),
    );
  }
}

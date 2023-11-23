import 'package:car_manager_app/screens/bottom_tab/widgets/list_user_item.dart';
import 'package:flutter/material.dart';

class ListUser extends StatefulWidget {
  const ListUser({super.key});

  @override
  State<ListUser> createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (ctx, index) => const ListUserItem(),
      ),
    );
  }
}

import 'package:car_manager_app/models/user.dart';
import 'package:car_manager_app/screens/bottom_tab/widgets/list_user_item.dart';
import 'package:car_manager_app/services/user.dart';
import 'package:flutter/material.dart';

class ListUser extends StatefulWidget {
  const ListUser({super.key});

  @override
  State<ListUser> createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  List<User> _users = [];
  bool _loading = false;

  Future<void> _loadData() async {
    setState(() {
      _loading = true;
    });
    final res = await UserApi().getList();
    final List<dynamic> listUserRes = res.data ?? [];
    final List<User> loadedUsers =
        listUserRes.map((e) => User.fromJson(e)).toList();

    if (!mounted) return;
    setState(() {
      _users = loadedUsers;
      _loading = false;
    });
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(
          child: SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(),
      ));
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (ctx, index) => ListUserItem(
          user: _users[index],
        ),
      ),
    );
  }
}

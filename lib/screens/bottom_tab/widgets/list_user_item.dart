import 'package:car_manager_app/models/user.dart';
import 'package:car_manager_app/user/user_detail.dart';
import 'package:flutter/material.dart';

class ListUserItem extends StatelessWidget {
  const ListUserItem({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            UserDetail.routeName,
            arguments: UserDetailArguments(user),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Tài khoản: ',
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                        text: user.userName,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                  text: 'Họ và tên: ',
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                        text: user.name ?? "Chưa cập nhật",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

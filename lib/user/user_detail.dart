import 'package:car_manager_app/models/user.dart';
import 'package:car_manager_app/services/user.dart';
import 'package:car_manager_app/widgets/button.dart';
import 'package:flutter/material.dart';

class UserDetail extends StatefulWidget {
  const UserDetail({super.key, required this.user});

  static String routeName = "/user_detail";

  final User user;

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  bool _isSending = false;
  final moneyController = TextEditingController();
  final amountOfMoneyController = TextEditingController();

  void _handleRecharge() {
    setState(() {
      _isSending = true;
    });

    UserApi().recharge(widget.user.id, int.parse(moneyController.text)).then(
      (value) {
        int newMoney = value.data["amountOfMoney"];
        amountOfMoneyController.text = newMoney.toString();
        setState(() {
          _isSending = false;
        });
        Navigator.pop(context);
      },
    );
  }

  void _handleOpenRecharge() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Nhập số tiền",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: moneyController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Nạp tiền"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButtonWidget(
              isFullWidth: true,
              isLoading: _isSending,
              text: "Xác nhận",
              onPressed: _handleRecharge,
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    setState(() {
      amountOfMoneyController.text = widget.user.amountOfMoney.toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chi tiết người dùng"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              readOnly: true,
              initialValue: widget.user.userName,
              decoration: const InputDecoration(
                label: Text("Tên tài khoản"),
              ),
            ),
            TextFormField(
              readOnly: true,
              initialValue: widget.user.name ?? "Chưa cập nhật",
              decoration: const InputDecoration(
                label: Text("Tên"),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              readOnly: true,
              initialValue: widget.user.phoneNumber ?? "Chưa cập nhật",
              decoration: const InputDecoration(
                label: Text("Số điện thoại"),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              readOnly: true,
              initialValue: widget.user.address ?? "Chưa cập nhật",
              decoration: const InputDecoration(
                label: Text("Địa chỉ"),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              readOnly: true,
              controller: amountOfMoneyController,
              decoration: const InputDecoration(
                label: Text(
                  "Số dư tài khoản",
                ),
              ),
            ),
            const Spacer(),
            ElevatedButtonWidget(
              isFullWidth: true,
              isLoading: _isSending,
              onPressed: _handleOpenRecharge,
              text: 'Nạp tiền',
            ),
          ],
        ),
      ),
    );
  }
}

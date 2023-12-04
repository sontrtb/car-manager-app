import 'package:car_manager_app/screens/bottom_tab/bottom_tab.dart';
import 'package:car_manager_app/services/user.dart';
import 'package:car_manager_app/widgets/button.dart';
import 'package:flutter/material.dart';

class UpdateInforUser extends StatefulWidget {
  const UpdateInforUser({super.key});

  @override
  State<UpdateInforUser> createState() => _UpdateInforUserState();
}

class _UpdateInforUserState extends State<UpdateInforUser> {
  final _formKey = GlobalKey<FormState>();
  bool _isSending = false;
  late String? name;
  late String? phoneNumber;
  late String? address;

  Future<void> _handleUpdateInfor(context) async {
    _formKey.currentState!.save();

    setState(() {
      _isSending = true;
    });

    UserApi()
        .update(
          UpdateUserLogin(
              name: name, phoneNumber: phoneNumber, address: address),
        )
        .then(
          (value) => {
            setState(() {
              _isSending = false;
            }),
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => const BottomTab(),
              ),
            )
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const Text(
                  "Thông tin cá nhân",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 10),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          label: Text("Tên"),
                        ),
                        onSaved: (newValue) => {
                          name = newValue,
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: const InputDecoration(
                          label: Text("Số điện thoại"),
                        ),
                        onSaved: (newValue) => {
                          phoneNumber = newValue,
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: const InputDecoration(
                          label: Text("Địa chỉ"),
                        ),
                        onSaved: (newValue) => {
                          address = newValue,
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ElevatedButtonWidget(
              isLoading: _isSending,
              isFullWidth: true,
              onPressed: () {
                _handleUpdateInfor(context);
              },
              text: "Cập nhật thông tin",
            ),
          ],
        ),
      ),
    );
  }
}

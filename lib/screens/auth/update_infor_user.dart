import 'package:car_manager_app/screens/bottom_tab/bottom_tab.dart';
import 'package:flutter/material.dart';

class UpdateInforUser extends StatefulWidget {
  const UpdateInforUser({super.key});

  @override
  State<UpdateInforUser> createState() => _UpdateInforUserState();
}

class _UpdateInforUserState extends State<UpdateInforUser> {
  final _formKey = GlobalKey<FormState>();

  late String userName;

  late String password;

  void _handleUpdateInfor(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => const BottomTab(),
      ),
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
                          label: Text("Tên tài khoản"),
                        ),
                        onSaved: (newValue) => {
                          userName = newValue!,
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          label: Text("Mật khẩu"),
                        ),
                        onSaved: (newValue) => {
                          password = newValue!,
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _handleUpdateInfor(context);
                },
                child: const Text("Cập nhật thông tin"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

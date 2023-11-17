import 'package:car_manager_app/screens/auth/login.dart';
import 'package:car_manager_app/screens/auth/update_infor_user.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  late String userName;
  late String password;

  void _goToLogin(context) {
    Navigator.push(context, MaterialPageRoute(builder: (ctx) => const Login()));
  }

  void _handleRegister(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (ctx) => const UpdateInforUser()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Đăng ký",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text("Đã có tài khoản ? "),
                        TextButton(
                          onPressed: () {
                            _goToLogin(context);
                          },
                          child: const Text("Đăng nhập"),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _handleRegister(context);
                        },
                        child: const Text("Đăng ký"),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:car_manager_app/screens/auth/login.dart';
import 'package:car_manager_app/screens/auth/update_infor_user.dart';
import 'package:car_manager_app/services/auth.dart';
import 'package:car_manager_app/widgets/button.dart';
import 'package:car_manager_app/widgets/gradient_container.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  late String userName = "";
  late String password = "";
  bool _isSending = false;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void _goToLogin(context) {
    Navigator.push(context, MaterialPageRoute(builder: (ctx) => const Login()));
  }

  Future<void> _handleRegister(context) async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() {
      _isSending = true;
    });

    final responseRegister = await AuthApi().register(
      BodyLogin(
        password: password,
        userName: userName,
      ),
    );

    setState(() {
      _isSending = false;
    });

    if (responseRegister.data != null) {
      final SharedPreferences prefs = await _prefs;
      prefs.setString('role', "user");
      prefs.setString('token', responseRegister.data["token"]);

      if (context.mounted) {
        Navigator.push(context,
            MaterialPageRoute(builder: (ctx) => const UpdateInforUser()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientContainer.defaultColor(
        child: Center(
          child: Container(
            height: 420,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Đăng ký",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Tên tài khoản không được để trống";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          label: Text("Tên tài khoản"),
                        ),
                        onSaved: (newValue) => {
                          userName = newValue!,
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Mật khẩu không được để trống";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: const InputDecoration(
                          label: Text("Mật khẩu"),
                        ),
                        onSaved: (newValue) => {
                          password = newValue!,
                        },
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        validator: (value) {
                          if (value != password) {
                            return "Mật khẩu nhập lại không khớp";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: const InputDecoration(
                          label: Text("Nhập lại mật khẩu"),
                        ),
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
                      ElevatedButtonWidget(
                        isFullWidth: true,
                        isLoading: _isSending,
                        onPressed: () {
                          _handleRegister(context);
                        },
                        text: 'Đăng ký',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

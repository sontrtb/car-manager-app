import 'dart:convert';
import 'package:car_manager_app/config/config.dart';
import 'package:car_manager_app/screens/auth/register.dart';
import 'package:car_manager_app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  late String userName;
  late String password;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _isSending = false;

  Future<void> _handleLogin(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() {
      _isSending = true;
    });
    final urlLogin = Uri.https(Config().apiUrl, '/api/v1/auth/login');
    final response = await http.post(
      urlLogin,
      body: jsonEncode(
        {
          'userName': userName,
          'password': password,
        },
      ),
    );
    setState(() {
      _isSending = false;
    });

    // final Map<String, dynamic> dataLogin = jsonDecode(response.body);
    // print('Response status: ${dataLogin}');

    // if (!context.mounted) return;
    final SharedPreferences prefs = await _prefs;
    prefs.setString('role', "admin");
    prefs.setString('token', "sd7sds8dsd7s8dsddsds9dsdsd");

    Navigator.pushNamedAndRemoveUntil(
        context, '/bottom_tab', (Route<dynamic> route) => false);
  }

  void _goToRegister(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (ctx) => const Register()));
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
                "Đăng nhập",
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Tên tài khoản không được để trống";
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Mật khẩu không được để trống";
                        }
                        return null;
                      },
                      onSaved: (newValue) => {
                        password = newValue!,
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text("Chưa có tài khoản ? "),
                        TextButton(
                          onPressed: () {
                            _goToRegister(context);
                          },
                          child: const Text("Đăng ký"),
                        ),
                      ],
                    ),
                    ElevatedButtonWidget(
                      text: "Đăng nhập",
                      onPressed: () {
                        _handleLogin(context);
                      },
                      isFullWidth: true,
                    ),
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

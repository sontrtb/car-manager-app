import 'package:car_manager_app/models/user.dart';
import 'package:car_manager_app/screens/auth/register.dart';
import 'package:car_manager_app/services/auth.dart';
import 'package:car_manager_app/widgets/button.dart';
import 'package:car_manager_app/widgets/gradient_container.dart';
import 'package:flutter/material.dart';
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

    final responseLogin = await AuthApi().login(
      BodyLogin(
        password: password,
        userName: userName,
      ),
    );

    setState(() {
      _isSending = false;
    });

    if (responseLogin.data != null) {
      UserLogin userLogin = UserLogin.fromJson(responseLogin.data);
      final SharedPreferences prefs = await _prefs;
      prefs.setString('role', userLogin.user.role.name);
      prefs.setString('token', userLogin.token);

      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/bottom_tab', (Route<dynamic> route) => false);
      }
    }
  }

  void _goToRegister(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (ctx) => const Register()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientContainer.defaultColor(
        child: Center(
          child: Container(
            height: 350,
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
                  "Đăng nhập",
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
                        // obscureText: true,
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
                        isLoading: _isSending,
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

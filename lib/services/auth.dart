import 'package:car_manager_app/models/api.dart';
import 'package:car_manager_app/services/root_api.dart';

class BodyLogin {
  const BodyLogin({required this.password, required this.userName});
  final String userName;
  final String password;

  Map<String, dynamic> toMap() => {
        "userName": userName,
        "password": password,
      };
}

class AuthApi {
  Future<ResponseApi> login(BodyLogin body) async {
    ResponseApi response = await RootApi().post(
      "/auth/login",
      body.toMap(),
    );

    return response;
  }
}

import 'package:car_manager_app/models/api.dart';
import 'package:car_manager_app/services/root_api.dart';

class UpdateUserLogin {
  const UpdateUserLogin({this.name, this.address, this.phoneNumber});
  final String? name;
  final String? address;
  final String? phoneNumber;

  Map<String, dynamic> toMap() => {
        "name": name,
        "address": address,
        "phoneNumber": phoneNumber,
      };
}

class UserApi {
  Future<ResponseApi> update(UpdateUserLogin body) async {
    ResponseApi response = await RootApi().patch("/user/update", body.toMap());
    return response;
  }

  Future<ResponseApi> getList() async {
    ResponseApi response = await RootApi().get("/user/list_user");
    return response;
  }
}

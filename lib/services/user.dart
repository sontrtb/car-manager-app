import 'package:car_manager_app/models/api.dart';
import 'package:car_manager_app/services/root_api.dart';

class UpdateUserLogin {
  const UpdateUserLogin(
      {this.name, this.address, this.phoneNumber, this.amountOfMoney});
  final String? name;
  final String? address;
  final String? phoneNumber;
  final int? amountOfMoney;

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

  Future<ResponseApi> recharge(int id, int money) async {
    ResponseApi response =
        await RootApi().patch("/user/recharge/$id", {"money": money});
    return response;
  }

  Future<ResponseApi> pay(int money) async {
    ResponseApi response = await RootApi().patch("/user/pay", {"money": money});
    return response;
  }

  Future<ResponseApi> get() async {
    ResponseApi response = await RootApi().get("/user");
    return response;
  }

  Future<ResponseApi> getList() async {
    ResponseApi response = await RootApi().get("/user/list_user");
    return response;
  }
}

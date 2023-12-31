import 'package:car_manager_app/models/api.dart';
import 'package:car_manager_app/services/root_api.dart';

class CarApi {
  Future<ResponseApi> listCar() async {
    ResponseApi response = await RootApi().get(
      "/car/list_car",
    );
    return response;
  }

  Future<ResponseApi> carDetail(int id) async {
    ResponseApi response = await RootApi().get(
      "/car/$id",
    );
    return response;
  }

  Future<ResponseApi> updateCar(String idCar, int? userId) async {
    ResponseApi response =
        await RootApi().patch("/car/update/$idCar", {"userId": userId});
    return response;
  }

  Future<ResponseApi> lockCar(String idCar) async {
    ResponseApi response = await RootApi().patch("/car/lockCar/$idCar", {});
    return response;
  }

  Future<ResponseApi> createCar(String idCar) async {
    ResponseApi response = await RootApi().post(
      "/car/create",
      {"idCar": idCar},
    );
    return response;
  }
}

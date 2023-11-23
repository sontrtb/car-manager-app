import 'dart:convert';
import 'package:car_manager_app/config/config.dart';
import 'package:car_manager_app/models/api.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RootApi {
  var client = http.Client();
  Map<String, String> _header(String? token) => {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

  void _handleError(String mess) {
    Fluttertoast.showToast(
      msg: mess,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  // get
  Future<dynamic> get(String api) async {
    try {
      final url = Uri.parse(Config().apiUrl + api);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      var response = await client
          .get(
            url,
            headers: _header(token),
          )
          .timeout(const Duration(seconds: 5));

      final ResponseApi responseApi = ResponseApi.fromJson(response.body);
      if (responseApi.errorCode == 1) {
        _handleError(responseApi.mess);
      }
      return responseApi;
    } catch (e) {
      const responseError = ResponseApi(
        errorCode: 1,
        mess: 'Có lỗi xảy xa',
      );
      _handleError(responseError.mess);
      return responseError;
    }
  }

  // post
  Future<ResponseApi> post(String api, Map<String, dynamic> body) async {
    final url = Uri.parse(Config().apiUrl + api);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    var response = await client.post(
      url,
      headers: _header(token),
      body: jsonEncode(body),
    );

    final ResponseApi responseApi = ResponseApi.fromJson(response.body);
    if (responseApi.errorCode == 1) {
      _handleError(responseApi.mess);
    }

    return responseApi;
  }
}

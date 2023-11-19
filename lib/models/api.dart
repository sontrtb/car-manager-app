import 'dart:convert';

class ResponseApi {
  const ResponseApi({
    this.data,
    required this.errorCode,
    required this.mess,
  });

  final int errorCode;
  final String mess;
  final dynamic data;

  factory ResponseApi.fromJson(String json) {
    try {
      Map<String, dynamic> res = jsonDecode(json);
      return ResponseApi(
        errorCode: res["errorCode"],
        mess: res["mess"],
        data: res["data"],
      );
    } catch (e) {
      return const ResponseApi(
        errorCode: 1,
        mess: "Dữ liệu không đúng định dạng",
      );
    }
  }
}

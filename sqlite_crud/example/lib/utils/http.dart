import 'dart:async';

import 'package:dio/dio.dart';

typedef Success = void Function(dynamic json);
typedef Fail = void Function(String message, int code);

class Http {
  static Dio? _dio;
  static Http https = Http();

  Http() {
    if (_dio != null) return;
    _dio = createDio();
  }

  Future<dynamic> post(String url, Object? data) async {
    Response res = await _dio!.post(url, data: data);
    print(res);
    print(data);
    return Future.value(res.data);
  }

  Dio createDio() {
    return Dio(
      BaseOptions(
        queryParameters: {},
        responseType: ResponseType.json,
        contentType: "application/json",
      ),
    );
  }
}

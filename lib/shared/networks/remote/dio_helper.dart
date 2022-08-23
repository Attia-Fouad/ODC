import 'package:dio/dio.dart';
class DioHelper {
  static late Dio dio;
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://lavie.orangedigitalcenteregypt.com',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required String url,
    token,
    query,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    query,
    token,
    required data,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer $token",

    };
    return dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    query,
    token,
    required data,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer $token",

    };
    return dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> patchData({
    required String url,
    token,
    query,
    required data,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };
    return dio.patch(
      url,
      queryParameters: query,
      data: data,
    );
  }



}
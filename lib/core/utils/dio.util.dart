import 'package:dio/dio.dart';

class DioUtil {
  DioUtil._internal();

  static final DioUtil _instance = DioUtil._internal();

  factory DioUtil() => _instance;

  static final Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  Future<Response> get(String url) async {
    Response response = await dio.get(url);

    return response;
  }
}

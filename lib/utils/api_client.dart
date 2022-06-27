import 'package:dio/dio.dart';

class ApiClient {
  const ApiClient._();

  static Dio get dio => _dio;

  static const _baseUrl = 'https://www.thecocktaildb.com/api/json/v1/1/';

  static final _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      // connectTimeout: 12500,
    ),
  );
}

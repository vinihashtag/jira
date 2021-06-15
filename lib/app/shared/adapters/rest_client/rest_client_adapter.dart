import 'package:dio/dio.dart';
import 'package:jira_matic/app/shared/utils/constants.dart';

import 'rest_client_exception.dart';
import 'rest_client_response.dart';

abstract class RestClientAdapter {
  Future<RestClientResponse> request({
    required String url,
    required String method,
    Map<String, dynamic>? data,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  });

  RestClientAdapter get instance;
  RestClientAdapter get instanceAuth;
  RestClientAdapter get instanceCache;
  RestClientAdapter get instanceAuthCache;
}

class RestClientAdapterImpl implements RestClientAdapter {
  late Dio _dio;
  static RestClientAdapter? _instance;
  static RestClientAdapter? _instanceAuth;
  static RestClientAdapter? _instanceCache;
  static RestClientAdapter? _instanceAuthCache;

  RestClientAdapterImpl() {
    _dio = Dio();
  }

  RestClientAdapterImpl._simple() {
    _dio = Dio(_getOptions());
    // _dio.interceptors.add(InterceptorLogWrapper());
  }

  RestClientAdapterImpl._cache() {
    _dio = Dio(_getOptions(withCache: true));
    // _dio.interceptors.add(InterceptorLogWrapper());
    // _dio.interceptors.add(CacheInterceptorWrapper());
  }

  RestClientAdapterImpl._auth() {
    _dio = Dio(_getOptions());
    // _dio.interceptors.add(AuthInterceptorWrapper());
  }

  RestClientAdapterImpl._authCache() {
    _dio = Dio(_getOptions(withCache: true));
    // _dio.interceptors.add(AuthInterceptorWrapper());
    // _dio.interceptors.add(CacheInterceptorWrapper());
  }

  BaseOptions _getOptions({bool withCache = false}) {
    return BaseOptions(
        connectTimeout: 60000,
        receiveTimeout: 60000,
        baseUrl: const String.fromEnvironment('BASE_URL',
            defaultValue: Constants.baseUrlDev),
        extra: withCache ? {'cache': true} : null,
        headers: {
          'Authorization':
              'Basic ${const String.fromEnvironment('TOKEN', defaultValue: Constants.tokenDev)}'
        });
  }

  @override
  RestClientAdapter get instance {
    _instance ??= RestClientAdapterImpl._simple();
    return _instance!;
  }

  @override
  RestClientAdapter get instanceAuth {
    _instanceAuth ??= RestClientAdapterImpl._auth();
    return _instanceAuth!;
  }

  @override
  RestClientAdapter get instanceCache {
    _instanceCache ??= RestClientAdapterImpl._cache();
    return _instanceCache!;
  }

  @override
  RestClientAdapter get instanceAuthCache {
    _instanceAuthCache ??= RestClientAdapterImpl._authCache();
    return _instanceAuthCache!;
  }

  @override
  Future<RestClientResponse> request({
    required String url,
    required String method,
    Map<String, dynamic>? data,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    final defaultHeaders = headers ?? {};

    Response? response;

    try {
      switch (method) {
        case 'GET':
          response = await _dio.get(
            url,
            options: Options(
              headers: defaultHeaders,
            ),
            queryParameters: queryParameters,
          );
          break;
        case 'POST':
          response = await _dio.post(
            url,
            options: Options(headers: defaultHeaders),
            queryParameters: queryParameters,
            data: data,
          );

          break;
        case 'PUT':
          response = await _dio.put(
            url,
            options: Options(headers: defaultHeaders),
            queryParameters: queryParameters,
            data: data!,
          );
          break;
        case 'PATCH':
          response = await _dio.patch(
            url,
            options: Options(headers: defaultHeaders),
            queryParameters: queryParameters,
            data: data!,
          );
          break;
        case 'DELETE':
          response = await _dio.delete(
            url,
            options: Options(headers: defaultHeaders),
            queryParameters: queryParameters,
            data: data!,
          );
          break;
        default:
      }

      if (response == null) {
        throw Exception('Method not defined.');
      }

      return RestClientResponse(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    } on DioError catch (e) {
      throw RestClientException(
        statusCode: e.response?.statusCode,
        message: (e.response?.statusMessage) ?? e.message,
        error: e.error,
      );
    } catch (e) {
      print('Erro : $e');

      throw RestClientException(
        statusCode: 500,
        message: 'Erro inesperado na requisição',
        error: 'Erro inesperado na requisição $method da url: $url',
      );
    }
  }
}

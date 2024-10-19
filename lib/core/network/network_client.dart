import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:fh_movie_app/core/utils/endpoints.dart';
import 'package:flutter/foundation.dart';

import '../error/exceptions.dart';
import '../utils/Globals.dart';
import 'network_response.dart';

abstract class INetworkClient {
  Future<NetworkResposne> get(
      String url, {
        Map<String, dynamic>? headers,
        String? data,
      });
  Future<NetworkResposne> post(String url,
      {Map<String, dynamic>? headers,
        dynamic data,
        Map<String, dynamic> queryParam});
  Future<NetworkResposne> put(
      String url, {
        Map<String, dynamic>? headers,
        dynamic data,
      });
  Future<NetworkResposne> delete(
      String url, {
        Map<String, dynamic>? headers,
        dynamic data,
      });
  Future<Uint8List?> downloadDocument(String url);
}

//class NetworkClient  implements INetworkClient{
class NetworkClient implements INetworkClient {
  final Dio dio = Dio();

  NetworkClient() {
    BaseOptions options = BaseOptions(
      baseUrl: EndPoints.baseUrl,
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
    );
    dio.options = options;
    if (kDebugMode) {
      (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        // SecurityContext context = SecurityContext(withTrustedRoots: true);

        // context.setTrustedCertificatesBytes(
        //rootCACertificate.buffer.asUint8List());

        //context
        //  .useCertificateChainBytes(clientCertificate.buffer.asUint8List());

        //context.usePrivateKeyBytes(privateKey.buffer.asUint8List());
        // HttpClient httpClient = HttpClient(context: context);
        //return httpClient;
        return client;
      };
    }
  }
  NetworkResposne getNetworkResponse(Response response) {
    return NetworkResposne(
      data: response.data,
      statusCode: response.statusCode,
    );
  }

  @override
  Future<NetworkResposne> get(
      String url, {
        Map<String, dynamic>? headers,
        String? data,
      }) async {
    try {
      Response response =
      await dio.get(url, options: Options(headers: headers));
      //  await dio.get(url, options: Options(headers: headers));
      if (kDebugMode) {
        print("res:$response");
      }
      return getNetworkResponse(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        return getNetworkResponse(e.response!);
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.unknown) {
        throw NetworkException();
      }

      throw const ServerException("");
    }
  }

  @override
  Future<NetworkResposne> post(String url,
      {Map<String, dynamic>? headers,
        dynamic data,
        Map<String, dynamic>? queryParam}) async {
    try {
      dio.options.headers.addAll(headers!);
      final response = await dio.post(
        url,
        options: Options(
          headers: headers,
        ),
        //queryParameters: queryParam,
        data: data,
      );

      return getNetworkResponse(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        return getNetworkResponse(e.response!);
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.unknown) {
        throw NetworkException();
      }

      throw const ServerException("");
    }
  }

  @override
  Future<NetworkResposne> put(String url,
      {Map<String, dynamic>? headers, dynamic data}) async {
    try {
      final response = await dio.put(
        url,
        options: Options(
          headers: headers,
        ),
        data: data,
      );
      return getNetworkResponse(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        return getNetworkResponse(e.response!);
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.unknown) {
        throw NetworkException();
      }

      throw const ServerException("");
    }
  }

  @override
  Future<Uint8List?> downloadDocument(String url) async {
    var res = await dio.get(
      url,
      options: Options(responseType: ResponseType.bytes),
    );
    if (res.statusCode == 200) {
      return res.data;
    } else {
      return null;
    }
  }

  @override
  Future<NetworkResposne> delete(String url, {Map<String, dynamic>? headers, data}) async {
    try {
      final response = await dio.delete(
        url,
        options: Options(
          headers: headers,
        ),
        data: data,
      );
      return getNetworkResponse(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        return getNetworkResponse(e.response!);
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.unknown) {
        throw NetworkException();
      }

      throw const ServerException("");
    }
  }
}
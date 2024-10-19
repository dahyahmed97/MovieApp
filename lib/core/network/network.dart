import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../error/exceptions.dart';
import '../preferences/preferences_manager.dart';
import '../services/service_locator.dart';
import '../utils/Globals.dart';
import '../utils/enums.dart';
import 'network_client.dart';
import 'network_response.dart';

abstract class INetwork {
  Future<Map<String, dynamic>> get(
      String url, {
        bool auth = true,
        bool visitor = false,
      });

  Future<Map<String, dynamic>> post(String url,
      {dynamic data,
        bool auth = true,
        bool visitor = false,
        bool isExternal = false,
        Map<String, String>? headers});

  Future<Map<String, dynamic>> put(String url,
      {dynamic data, bool auth = true, bool visitor = false});

  Future<Map<String, dynamic>> delete(String url,
      {dynamic data,
        bool auth = true,
        bool visitor = false,
        bool isExternal = false,
        Map<String, String>? headers});


  Future<Map<String, dynamic>> getAccessToken(String refreshToken);
}

class Network implements INetwork {
  INetworkClient networkClient;
  String? refreshToken;

  RetrialRequest? oldRequest;

  Network({required this.networkClient});

  void saveGetRequest(String url) {
    oldRequest = null;
    oldRequest ??= RetrialRequest(method: RequestType.get, url: url);
    if (kDebugMode) {}
  }

  void savePostRequest(String url, dynamic data) {
    oldRequest = null;
    oldRequest ??=
        RetrialRequest(method: RequestType.post, url: url, data: data);

    if (oldRequest!.counter > 1) {
      oldRequest = null;
    }
  }

  void savePutRequest(String url, dynamic data) {
    oldRequest = null;
    oldRequest ??=
        RetrialRequest(method: RequestType.put, url: url, data: data);

    // if (RetrialRequest.counter > 1) {
    //   oldRequest = null;
    // }
  }

  void saveDeleteRequest(String url, dynamic data) {
    oldRequest = null;
    oldRequest ??=
        RetrialRequest(method: RequestType.delete, url: url, data: data);

    // if (RetrialRequest.counter > 1) {
    //   oldRequest = null;
    // }
  }

  void disposeOldRequest() {
    oldRequest = null;
  }

  Future<Map<String, dynamic>> retryRequest() async {
    if (kDebugMode) {}

    if (oldRequest != null) {
      if (oldRequest!.method == RequestType.post) {
        return post(oldRequest!.url, data: oldRequest!.data);
      } else {
        return get(oldRequest!.url);
      }
    }
    disposeOldRequest();
    throw UnAuthorizedException();
  }

  @override
  Future<Map<String, dynamic>> get(
      String url, {
        bool auth = true,
        bool visitor = false,
      }) async {
    if (kDebugMode) {
      print(url);
    }
    saveGetRequest(url);

    final response = await networkClient.get(url,
        headers: await getHeaders(auth, visitor, null));

    return getResponse(response);
  }

  @override
  Future<Map<String, dynamic>> post(String url,
      {dynamic data,
        bool auth = true,
        bool visitor = false,
        bool isExternal = false,
        Map<String, String>? headers}) async {
    savePostRequest(url, data);
    final response = await networkClient.post(
      url,
      data: data,
      headers: await getHeaders(auth, visitor, headers),
    );
    return getResponse(response);
  }

  @override
  Future<Map<String, dynamic>> put(String url,
      {dynamic data, bool auth = true, bool visitor = false}) async {
    savePutRequest(url, data);
    final response = await networkClient.put(
       url,
      data: data,
      headers: await getHeaders(auth, visitor, null),
    );
    return getResponse(response);
  }

  Future<Map<String, dynamic>> getResponse(NetworkResposne response) async {
    if (response.statusCode == 200) {
      disposeOldRequest();
      return response.data;
    } else if (response.statusCode == 401) {
      if (kDebugMode) {}
      if (refreshToken == null || refreshToken == "") {
        if (response.data == "TOKEN_IS_REQUIRED" ||
            response.data == "INVALID_TOKEN") {
          throw UnAuthorizedException();
        }
        throw ServerException(response.data["message"]);
      }
      return retryRequest();
    } else if (response.statusCode == 500) {
      return response.data;
    } else {
      if (kDebugMode) {}
      throw const ServerException("something went wrong");
    }
  }

  Future<Map<String, dynamic>> getHeaders(
      bool auth, bool visitor, Map<String, String>? otherHeaders) async {
    Map<String, dynamic> headers = {};
    headers.addAll({
      "Content-Type": "application/json; charset=Utf-8",
      "accept": "*/*",
      "accept-Encoding": "application/json; charset=Utf-8",
    });
    if (otherHeaders != null) {
      headers.addAll(otherHeaders);
    }

    if (visitor) {
      //  headers.addAll({"Authorization": await getVisitorToken()});
    } else if (auth) {
      String? token =await sl<PreferenceManager>().getAccessToken();
      if (token != null) {
        headers.addAll({HttpHeaders.authorizationHeader: "Bearer $token"});
      }
    }

    return headers;
  }

  @override
  Future<Map<String, dynamic>> getAccessToken(String refreshToken) {
    // TODO: implement getAccessToken
    throw UnimplementedError();
  }

  Future<Uint8List?> downloadDocument(String s) async {
    var res = await networkClient.downloadDocument(s);
    if (res != null) {
      return res;
    } else {
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>> delete(String url, {data, bool auth = true, bool visitor = false, bool isExternal = false, Map<String, String>? headers}) async {
    final response = await networkClient.delete(
      url,
      data: data,
      headers: await getHeaders(auth, visitor, headers),
    );
    return getResponse(response);
  }


}

class RetrialRequest extends Equatable {
  int counter = 0;
  RequestType method;
  String url;
  dynamic data;
  RetrialRequest({
    required this.method,
    required this.url,
    this.data,
  }) {
    counter++;
  }

  @override
  List<Object?> get props => [counter, method, url, data];
}

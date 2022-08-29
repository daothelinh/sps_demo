import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sps_demo/core/common/common_request_options.dart';
import 'package:sps_demo/core/common/common_response.dart';
import 'package:sps_demo/core/services/local_storage_service.dart';
import 'package:sps_demo/resful/resful_module.dart';

import '../core/services/logger_service.dart';

class RestfulModuleImpl implements RestfulModule {
  final GetConnect getConnect =
      GetConnect(timeout: const Duration(seconds: 120));

  final LocalStorageService localStorageService = LocalStorageService();

  Future<Map<String, String>> _getHeaders(Map<String, String>? headers) async {
    var finalHeaders = <String, String>{};

    if (headers != null) finalHeaders = headers;

    if (!(finalHeaders.containsKey('authorization'))) {
      var token = await authToken;
      if (token != null) {
        if (kDebugMode) logger.d('Token: $token');
        finalHeaders['authorization'] = 'Bearer ' + token;
      }
    }
    return finalHeaders;
  }

  @override
  Future<CommonResponse<T>> get<T>(String uri,
      {Map<String, dynamic>? query, CommonRequestOptions? options}) async {
    var result = await getConnect.get<T>(
      uri,
      query: query,
      headers: (await _getHeaders(options?.headers)),
      contentType: options?.contentType,
    );
    _logger(result, query: query);
    return CommonResponse(
      body: result.body,
      headers: result.headers,
      statusCode: result.statusCode,
      statusMessage: result.statusText,
    );
  }

  @override
  Future<CommonResponse<T>> post<T>(String uri, data,
      {Map<String, dynamic>? query, CommonRequestOptions? options}) async {
    var result = await getConnect.post<T>(
      uri,
      data,
      query: query,
      headers: (await _getHeaders(options?.headers)),
      contentType: options?.contentType,
    );
    _logger(result, query: data);
    return CommonResponse(
      body: result.body,
      headers: result.headers,
      statusCode: result.statusCode,
      statusMessage: result.statusText,
    );
  }

  @override
  Future<CommonResponse<T>> patch<T>(String uri, data,
      {Map<String, dynamic>? query, CommonRequestOptions? options}) async {
    var result = await getConnect.patch<T>(
      uri,
      data,
      query: query,
      headers: (await _getHeaders(options?.headers)),
      contentType: options?.contentType,
    );
    _logger(result, query: data);
    return CommonResponse(
      body: result.body,
      headers: result.headers,
      statusCode: result.statusCode,
      statusMessage: result.statusText,
    );
  }

  @override
  Future<CommonResponse<T>> put<T>(String uri,
      {data,
      Map<String, dynamic>? query,
      CommonRequestOptions? options}) async {
    var result = await getConnect.put<T>(
      uri,
      data,
      query: query,
      headers: (await _getHeaders(options?.headers)),
      contentType: options?.contentType,
    );
    _logger(result, query: data);

    return CommonResponse(
      body: result.body,
      headers: result.headers,
      statusCode: result.statusCode,
      statusMessage: result.statusText,
    );
  }

  @override
  Future<CommonResponse<T>> delete<T>(String uri,
      {data,
      Map<String, dynamic>? query,
      CommonRequestOptions? options}) async {
    var result = await getConnect.delete<T>(
      uri,
      query: query,
      headers: (await _getHeaders(options?.headers)),
      contentType: options?.contentType,
    );
    _logger(result, query: data);

    return CommonResponse(
      body: result.body,
      headers: result.headers,
      statusCode: result.statusCode,
      statusMessage: result.statusText,
    );
  }

  void _logger(Response result, {dynamic query}) {
    if (kDebugMode) {
      logger.d('Path: ${result.request?.url.path}');
      logger.d('Request query/body: $query');
      logger.d('Status code:' + result.statusCode.toString());
      logger.d('Response Body: ' + result.body.toString());
    }
  }

  @override
  Future<String?> get authToken async {
    return localStorageService.authToken;
  }

  @override
  Future<void> removeAuthToken() async {
    await localStorageService.removeAuthToken();
  }

  @override
  Future<void> saveAuthToken(String authToken) async {
    await localStorageService.saveAuthToken(authToken);
  }
}

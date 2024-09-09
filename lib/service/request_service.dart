import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:lin_chuck/constant/environment.dart';
import 'package:lin_chuck/utils/alert.dart';

enum HttpMethod {
  get,
  post,
  delete,
}

class RequestService {
  late Dio _dio;

  RequestService({bool showAlertIfError = true}) {
    _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 40),
      ),
    );

    _dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final HttpClient client = HttpClient();
        client.badCertificateCallback = (cert, host, port) => true;

        return client;
      },
    );

    initializeInterceptors(showAlertIfError);
  }

  dynamic initializeInterceptors(bool showAlertIfError) {
    _dio.interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) async {
        return handler.next(options);
      }, onResponse: (response, handler) {
        return handler.next(response);
      }, onError: (DioException error, handler) {
        String title = 'ระบบขัดข้อง';
        int errorCode = error.response?.statusCode ?? 0;
        String errorMessage = error.response?.statusMessage ?? '';
        String? remark = '$errorCode: $errorMessage';

        if (errorCode == 400) {
          title = 'ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง';
          remark = null;
        } else if (error.type == DioExceptionType.unknown) {
          remark = 'Unknown exception';
        }

        if (showAlertIfError) {
          showAlert(
            title,
            content: 'กรุณาลองใหม่',
            remark: remark,
          );
        } else {
          log('$title: $remark');
        }

        return handler.next(error);
      }),
    );
  }

  Future<dynamic> request(
    String url, {
    HttpMethod method = HttpMethod.post,
    dynamic data,
    Options? options,
  }) async {
    Response? response;
    String baseURL = getBaseURL();
    String path = baseURL + url;

    switch (method) {
      case HttpMethod.post:
        response = await _dio.post(
          path,
          data: data,
          options: options,
        );
        break;

      case HttpMethod.delete:
        response = await _dio.delete(
          path,
          data: data,
          options: options,
        );
        break;

      default:
        response = await _dio.get(
          path,
          queryParameters: data,
          options: options,
        );
    }

    return response;
  }

  Future<bool> checkInternetConnection() async {
    bool result = false;

    try {
      final lookup = await InternetAddress.lookup('google.com');

      if (lookup.isNotEmpty && lookup[0].rawAddress.isNotEmpty) {
        result = true;
      }
    } catch (e) {
      log(e.toString());
    }

    return result;
  }

  Future<String> checkConnectivity() async {
    List<ConnectivityResult> result = await Connectivity().checkConnectivity();

    if (result.contains(ConnectivityResult.wifi)) {
      return 'network';
    }

    return 'gps';
  }
}
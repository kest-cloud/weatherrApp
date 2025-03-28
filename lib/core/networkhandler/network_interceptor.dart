import 'dart:io';
import 'package:dio/dio.dart';
import 'package:weatherapp/core/utils/string.dart';
import 'package:equatable/equatable.dart';

class NewInterceptor extends Interceptor {
  NewInterceptor();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String os = "";
    if (Platform.isAndroid) {
      os = "android";
    } else if (Platform.isIOS) {
      os = "ios";
    }

    options.headers.addAll({"device_os": os});
    options.headers.addAll({"version": "2.2.3"});
    return handler.next(options);
    // }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Logger('requesterror ${err.response!.data}');
    return handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Logger('responsed ${response.data}    ${response.statusMessage}');
    return handler.next(response);
  }
}

class Failure extends Equatable {
  final String? message;
  final dynamic data;

  const Failure({this.message, this.data});

  @override
  List<Object?> get props => [message, data];
}

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weatherapp/core/networkhandler/network_requester.dart';
import 'package:weatherapp/core/utils/env.dart';
import 'package:weatherapp/core/utils/string.dart';

abstract class WeatherRemoteDatasource {
  Future<Response<Map<String, dynamic>>> getWeather(String lat, String lang);
}

class WeatherRemoteDatasourceImpl extends WeatherRemoteDatasource {
  WeatherRemoteDatasourceImpl({
    required this.networkRequester,
  });

  final NetworkRequester networkRequester;

  final baseUrl = Env.baseUrl;

  @override
  Future<Response<Map<String, dynamic>>> getWeather(
      String lat, String lang) async {
    final id = dotenv.env['APIKEY'];
    var response = await networkRequester.post(
      "?lat=$lat&lon=$lang&appid=$id",
      isProtected: false,
      contentType: 'application/json',
      data: {},
    );

    Logger("api request $response");
    return response;
  }
}

import 'package:dartz/dartz.dart';
import 'package:weatherapp/core/networkhandler/network_interceptor.dart';

abstract class WeatherRepository {
  Future<Either<Failure, dynamic>> getWeather(String lat, String lang);
}

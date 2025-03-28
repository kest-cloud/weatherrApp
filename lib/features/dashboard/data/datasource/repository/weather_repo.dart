import 'package:dartz/dartz.dart';
import 'package:weatherapp/core/networkhandler/network_interceptor.dart';
import 'package:weatherapp/features/dashboard/data/datasource/weather_remote_datasource.dart';
import 'package:weatherapp/features/dashboard/data/domain/entity/weather_model.dart';
import 'package:weatherapp/features/dashboard/data/domain/repository/repo.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRepositoryImpl({required this.remoteDatasource});

  final WeatherRemoteDatasource remoteDatasource;

  @override
  Future<Either<Failure, dynamic>> getWeather(String lat, String lang) async {
    try {
      var response = await remoteDatasource.getWeather(lat, lang);

      if (response.statusCode == 200) {
        return Right(WeatherResponse.fromJson(response.data!));
      } else {
        return Left(
          Failure(
            message: response.statusMessage.toString(),
            data: response.statusMessage.toString(),
          ),
        );
      }
    } catch (e) {
      return Left(
        Failure(
          message: "Failed to fetch weather data",
          data: e,
        ),
      );
    }
  }
}

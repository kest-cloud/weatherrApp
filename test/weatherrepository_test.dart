import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weatherapp/core/networkhandler/network_interceptor.dart';
import 'package:weatherapp/features/dashboard/data/datasource/repository/weather_repo.dart';
import 'package:weatherapp/features/dashboard/data/datasource/weather_remote_datasource.dart';
import 'package:weatherapp/features/dashboard/data/domain/entity/weather_model.dart';
import 'package:weatherapp/features/dashboard/data/domain/repository/repo.dart';

class MockWeatherDatasource extends Mock implements WeatherRemoteDatasource {}

void main() {
  late WeatherRepository repository;
  late MockWeatherDatasource mockDatasource;
  const lat = "51.5149";
  const lang = "-0.1236";

  setUp(() {
    mockDatasource = MockWeatherDatasource();
    repository = WeatherRepositoryImpl(remoteDatasource: mockDatasource);
  });

  test('returns Right(data) when the call is successful', () async {
    when(() => mockDatasource.getWeather(lat, lang)).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(),
        data: {
          "coord": {"lon": 0.1236, "lat": 51.5149},
          "weather": [
            {
              "id": 800,
              "main": "Clear",
              "description": "clear sky",
              "icon": "01d"
            }
          ],
          "main": {
            "temp": 25,
            "feels_like": 287.42,
            "temp_min": 288.26,
            "temp_max": 288.26,
            "pressure": 1018,
            "humidity": 61
          },
          "name": "gb",
        },
        statusCode: 200,
      ),
    );

    final result = await mockDatasource.getWeather(lat, lang);

    // Assuming your repository handles JSON deserialization
    final weatherResponse = WeatherResponse.fromJson(result.data!);

    expect(weatherResponse.main?.temp, 25);
    expect(weatherResponse.name, "gb");
  });

  test('returns Left(Failure) when the call fails', () async {
    // Simulate failure response
    final response = Response<Map<String, dynamic>>(
      requestOptions: RequestOptions(path: ''),
      statusCode: 500,
      statusMessage: "Failed to fetch weather data",
      data: {},
    );

    // Mock the failure scenario
    when(() => mockDatasource.getWeather(any(), any()))
        .thenAnswer((_) async => response);

    // Call the repository method
    final result = await repository.getWeather(lat, lang);

    // Check that a Left<Failure> is returned
    expect(result, isA<Left>());
    expect(result.isLeft(), true);

    result.fold(
      (failure) => expect(failure.message ?? "Failed to fetch weather data",
          equals("Failed to fetch weather data")),
      (_) => fail("Expected a failure, but got a success response"),
    );
  });
}

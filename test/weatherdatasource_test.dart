import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weatherapp/core/networkhandler/network_requester.dart';
import 'package:weatherapp/features/dashboard/data/datasource/weather_remote_datasource.dart';

class MockNetworkRequester extends Mock implements NetworkRequester {}

void main() {
  late WeatherRemoteDatasource datasource;
  late MockNetworkRequester mockNetworkRequester;

  setUpAll(() async {
    await dotenv.load(fileName: ".env");
  });

  setUp(() {
    mockNetworkRequester = MockNetworkRequester();
    datasource =
        WeatherRemoteDatasourceImpl(networkRequester: mockNetworkRequester);
  });
  test('calls the correct endpoint and returns response', () async {
    final response = Response<Map<String, dynamic>>(
      requestOptions: RequestOptions(path: ""),
      statusCode: 200,
      data: {"temperature": 25.0},
    );

    when(() => mockNetworkRequester.post(
          any(),
          isProtected: any(named: "isProtected"),
          contentType: any(named: "contentType"),
          data: any(named: "data"),
        )).thenAnswer((_) async => response);

    final result = await datasource.getWeather("51.5149", "-0.1236");

    expect(result, response);

    verify(() => mockNetworkRequester.post(
          "?lat=51.5149&lon=-0.1236&appid=${dotenv.env['APIKEY']}",
          isProtected: false,
          contentType: 'application/json',
          data: {},
        )).called(1);
  });
}

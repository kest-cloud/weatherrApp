// Mock Classes
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weatherapp/core/networkhandler/network_interceptor.dart';
import 'package:weatherapp/features/dashboard/data/domain/entity/weather_model.dart';
import 'package:weatherapp/features/dashboard/data/domain/repository/repo.dart';
import 'package:weatherapp/features/dashboard/presentation/notifier/weather_event.dart';
import 'package:weatherapp/features/dashboard/presentation/notifier/weather_state.dart';
import 'package:weatherapp/features/dashboard/presentation/notifier/weatherbloc_bloc.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

class MockWeatherEvent extends Mock implements FetchWeatherEvent {}

void main() {
  late WeatherBlocNotifier weatherBloc;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    weatherBloc = WeatherBlocNotifier(weatherRepository: mockWeatherRepository);
  });

  tearDown(() {
    weatherBloc.close();
  });
  final mockWeatherResponse = WeatherResponse(main: MainWeather(temp: 25));
  blocTest<WeatherBlocNotifier, WeatherState>(
    'emits [loading, loaded] when data is fetched successfully',
    build: () {
      when(() => mockWeatherRepository.getWeather(any(), any()))
          .thenAnswer((_) async => Right(mockWeatherResponse));
      return weatherBloc;
    },
    act: (bloc) => bloc.add(FetchWeatherEvent()),
    expect: () => [
      WeatherState(status: WeatherStatus.loading),
      WeatherState(
          status: WeatherStatus.loaded, weatherData: mockWeatherResponse),
    ],
  );
  blocTest<WeatherBlocNotifier, WeatherState>(
    'emits [loading, error] when data fetch fails with dynamic message',
    build: () {
      when(() => mockWeatherRepository.getWeather(any(), any()))
          .thenAnswer((_) async => Left(Failure(message: "Timeout Error")));
      return weatherBloc;
    },
    act: (bloc) => bloc.add(FetchWeatherEvent()),
    verify: (bloc) {
      final errorState = bloc.state;
      expect(errorState.status, WeatherStatus.error);
      expect(
          errorState.errorMessage, isNotNull); // ✅ Using expect inside verify
    },
  );
}

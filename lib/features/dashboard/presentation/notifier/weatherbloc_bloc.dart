import 'package:bloc/bloc.dart';
import 'package:weatherapp/core/utils/string.dart';
import 'package:weatherapp/features/dashboard/data/domain/repository/repo.dart';
import 'package:weatherapp/features/dashboard/presentation/notifier/weather_event.dart';
import 'package:weatherapp/features/dashboard/presentation/notifier/weather_state.dart';

class WeatherBlocNotifier extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBlocNotifier({
    required this.weatherRepository,
  }) : super(WeatherState()) {
    // Event handlers
    on<FetchWeatherEvent>(onFetchWeather);
    on<ToggleTemperatureUnitEvent>(_onToggleTemperatureUnit);
  }

  // Fetch Weather Method
  Future<void> onFetchWeather(
      FetchWeatherEvent event, Emitter<WeatherState> emit) async {
    // Emit loading state
    emit(state.copyWith(status: WeatherStatus.loading));
    final lat = "51.51494225418024";
    final long = "-0.12363193061883422";
    try {
      // Fetch weather data from repository
      final weatherData = await weatherRepository.getWeather(lat, long);

      weatherData.fold((failure) async {
        Logger(failure);
        emit(state.copyWith(
            status: WeatherStatus.error,
            errorMessage: failure.data.toString()));
      }, (right) async {
        Logger(right);
        // when the data comes back with a value
        emit(state.copyWith(status: WeatherStatus.loaded, weatherData: right));
      });
    } catch (error) {
      // Emit error state with error message
      emit(state.copyWith(
          status: WeatherStatus.error, errorMessage: error.toString()));
    }
  }

// Toggle Temperature Unit Method
  void _onToggleTemperatureUnit(
      ToggleTemperatureUnitEvent event, Emitter<WeatherState> emit) {
    // Toggle unit and update temperature accordingly
    bool newIsCelsius = !state.isCelsius!;
    double newTemperature = newIsCelsius
        ? (state.weatherData!.main!.temp! - num.parse("32")) *
            5 /
            9 // Convert to Celsius
        : (state.weatherData!.main!.temp! * 9 / 5) +
            32; // Convert to Fahrenheit

    emit(state.copyWith(
      isCelsius: newIsCelsius,
      temp: newTemperature.toString(),
    ));
  }
}

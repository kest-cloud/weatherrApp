// lib/features/weather/presentation/notifier/weather_state.dart

import 'package:equatable/equatable.dart';
import 'package:weatherapp/features/dashboard/data/domain/entity/weather_model.dart';

enum WeatherStatus {
  initial, // Initial state before any action
  loading, // When data is being fetched
  loaded, // When data is successfully loaded
  error // When there's an error fetching data
}

// Immutable state class for Weather
class WeatherState extends Equatable {
  // Weather data entity
  final WeatherResponse? weatherData;

  // Current status of weather data
  final WeatherStatus status;

  // Current status of weather data F
  final String? temp;

  // Temperature unit preference
  bool? isCelsius;

  // Error message if something goes wrong
  final String? errorMessage;

  // Constructor with default values
  WeatherState({
    this.weatherData,
    this.status = WeatherStatus.initial,
    this.isCelsius = true,
    this.errorMessage,
    this.temp,
  });

  // Method to create a new state with updated values
  WeatherState copyWith({
    WeatherResponse? weatherData,
    WeatherStatus? status,
    bool? isCelsius,
    String? errorMessage,
    String? temp,
  }) {
    return WeatherState(
      weatherData: weatherData ?? this.weatherData,
      status: status ?? this.status,
      isCelsius: isCelsius ?? this.isCelsius,
      errorMessage: errorMessage ?? this.errorMessage,
      temp: temp ?? this.temp,
    );
  }

  // Equatable props for comparison
  @override
  List<Object?> get props => [
        weatherData,
        status,
        isCelsius,
        errorMessage,
        temp,
      ];
}

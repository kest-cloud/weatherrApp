import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

// Event for fetching weather for a specific location
class FetchWeatherEvent extends WeatherEvent {
  const FetchWeatherEvent();

  @override
  List<Object> get props => [];
}

// Event for toggling temperature unit
class ToggleTemperatureUnitEvent extends WeatherEvent {
  const ToggleTemperatureUnitEvent();

  @override
  List<Object> get props => [];
}

// Additional events can be added as needed
class RefreshWeatherEvent extends WeatherEvent {
  final String location;

  const RefreshWeatherEvent(this.location);

  @override
  List<Object> get props => [location];
}

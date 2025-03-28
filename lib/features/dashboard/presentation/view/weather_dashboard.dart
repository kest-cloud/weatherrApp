import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/core/utils/string.dart';
import 'package:weatherapp/features/dashboard/presentation/notifier/weather_event.dart';
import 'package:weatherapp/features/dashboard/presentation/notifier/weather_state.dart';
import 'package:weatherapp/features/dashboard/presentation/notifier/weatherbloc_bloc.dart';
import 'package:weatherapp/features/dashboard/presentation/widgets/responsive.dart';

class WeatherDashboardPage extends StatefulWidget {
  const WeatherDashboardPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WeatherDashboardPageState createState() => _WeatherDashboardPageState();
}

class _WeatherDashboardPageState extends State<WeatherDashboardPage> {
  void _refreshWeather() async {
    context.read<WeatherBlocNotifier>().add(FetchWeatherEvent());
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherBlocNotifier>().add(FetchWeatherEvent());
    });
    super.initState();
  }

  bool isCelsius = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBlocNotifier, WeatherState>(
        builder: (context, state) {
      return RefreshIndicator(
        onRefresh: () async {
          _refreshWeather();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: state.status == WeatherStatus.loading
                ? const CircularProgressIndicator()
                : state.status == WeatherStatus.error
                    ? _buildErrorWidget()
                    : Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: _buildWeatherContent(context, state),
                      ),
          ),
        ),
      );
    });
  }

  Widget _buildErrorWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error_outline, color: Colors.red, size: 60),
        Text('Failed to fetch weather data'),
        SizedBox(height: 10),
        InkWell(
            onTap: () async {
              _refreshWeather();
            },
            child: Text(
              "Retry",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w300),
            ))
      ],
    );
  }

  Column _buildWeatherContent(BuildContext context, WeatherState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            //TODO 3 IMAGE (Please make the image at the top 4:3 aspect ration under 300px wide and 16:9 over 300px wide.)

            SizedBox(height: 70),
            ResponsiveImage(width: 350),
            // You can adjust the width to show the difference in aspect ratio for the image.
            // as instruted.
            SizedBox(height: 25),
            // Title
            const Text(
              'THIS IS MY WEATHER APP',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'FuturaCondensedExtraBold',
                fontWeight: FontWeight.bold,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Temperature',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "CircularStd",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    state.isCelsius!
                        ? '${state.weatherData?.main?.temp ?? ""}°'
                        : "${state.temp}°" ?? "",
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: "CircularStd",
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Location Section
                  Text(
                    'Location',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "CircularStd",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    state.weatherData?.sys?.country ?? "",
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: "CircularStd",
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      Row(
                        children: [
                          const Text(
                            'Celsius/Fahrenheit',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "CircularStd",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Switch(
                            activeColor: Colors.white,
                            activeTrackColor: Colors.blueGrey,
                            inactiveThumbColor: Colors.grey,
                            inactiveTrackColor: Colors.blueGrey,
                            value: state.isCelsius!,
                            onChanged: (bool value) {
                              Logger(value);
                              context
                                  .read<WeatherBlocNotifier>()
                                  .add(ToggleTemperatureUnitEvent());
                              state.isCelsius = !state.isCelsius!;
                              setState(() {});
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          children: [
            InkWell(
              onTap: () async {
                _refreshWeather();
              },
              child: Container(
                height: 48,
                width: 320,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xffFF5700)),
                child: Center(
                    child: Text(
                  "Refresh",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                )),
              ),
            ),
            const SizedBox(height: 30)
          ],
        ),
      ],
    );
  }
}

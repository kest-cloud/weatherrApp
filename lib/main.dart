import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weatherapp/core/di-manual/di_manual.dart';
import 'package:weatherapp/core/utils/string.dart';
import 'package:weatherapp/features/dashboard/data/domain/repository/repo.dart';
import 'package:weatherapp/features/dashboard/presentation/notifier/weather_event.dart';
import 'package:weatherapp/features/dashboard/presentation/notifier/weatherbloc_bloc.dart';
import 'package:weatherapp/features/dashboard/presentation/view/weather_dashboard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:async';

void main() {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    await dotenv.load(fileName: '.env');
    await setUp();
    runApp(MultiRepositoryProvider(providers: [
      RepositoryProvider<WeatherRepository>(
        create: (context) => getIt(),
      ),
    ], child: const MyApp()));
  }, (error, stack) async {
    Logger(error);
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: WeatherBlocNotifier(
        weatherRepository: getIt(), // Ensure this has access
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather app',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const WeatherDashboardPage(),
      ),
    );
  }
  //TODO 1 make sure you use the clean code architecture.
  //TODO 2 make sure you use the bloc state management.
}

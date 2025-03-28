import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/core/networkhandler/network_interceptor.dart';
import 'package:weatherapp/core/networkhandler/network_requester.dart';
import 'package:weatherapp/core/utils/env.dart';
import 'package:weatherapp/features/dashboard/data/datasource/repository/weather_repo.dart';
import 'package:weatherapp/features/dashboard/data/datasource/weather_remote_datasource.dart';
import 'package:weatherapp/features/dashboard/data/domain/repository/repo.dart';
import 'package:weatherapp/features/dashboard/presentation/notifier/weatherbloc_bloc.dart';

GetIt getIt = GetIt.instance;

Future<void> setUp() async {
  ///network
  BaseOptions options = BaseOptions(
    baseUrl: Env.baseUrl,
    receiveDataWhenStatusError: true,
    sendTimeout: const Duration(seconds: 30),
    connectTimeout: const Duration(seconds: 40),
    receiveTimeout: const Duration(seconds: 60), // 60 seconds
  );

  //module
  var interceptor = NewInterceptor();
  getIt.registerLazySingleton<NewInterceptor>(() => interceptor);
  var dio = Dio(options);

  getIt.registerLazySingleton<Dio>(() => dio);
  dio.interceptors.add(interceptor);
  dio.interceptors.add(
    PrettyDioLogger(
        requestBody: true,
        //true
        requestHeader: true,
        //true
        responseBody: true,
        //true
        responseHeader: true,
        //false
        compact: true,
        //false
        error: true,
        //true
        maxWidth: 90),
  );

  var fluttersecuredstorage = const FlutterSecureStorage();
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => fluttersecuredstorage,
  );

  //storage
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingletonAsync<SharedPreferences>(() async {
    return sharedPreferences;
  });

  // datasource
  // datasource
  getIt.registerLazySingleton<WeatherRemoteDatasource>(
      () => WeatherRemoteDatasourceImpl(
            networkRequester: getIt(),
          ));

  getIt.registerLazySingleton<NetworkRequester>(
    () => NetworkRequester(
      dio: getIt(),
    ),
  );

// repo
// repo
  getIt.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      remoteDatasource: getIt(),
    ),
  );

  // Notifier
  // Notifier
  getIt.registerLazySingleton<WeatherBlocNotifier>(
    () => WeatherBlocNotifier(weatherRepository: getIt()),
  );
}

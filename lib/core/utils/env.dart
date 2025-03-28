abstract class Env {
  static const String baseUrl =
      String.fromEnvironment('BASEURL', defaultValue: '');

  static const String apikey =
      String.fromEnvironment('APIKEY', defaultValue: '');
}

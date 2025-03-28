// ignore: file_names
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weatherapp/core/utils/string.dart';

class NetworkRequester {
  NetworkRequester({
    required this.dio,
  });
  final Dio dio;

  Future<Response<Map<String, dynamic>>> post(String endpoint,
      {required dynamic data,
      bool isProtected = false,
      bool isFormData = false,
      String? path,
      String? contentType,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters}) async {
    final url = dotenv.env['BASEURL']; //
    Logger('${path ?? url}$endpoint');
    Logger('$data');

    try {
      Response<Map<String, dynamic>> response =
          await dio.post<Map<String, dynamic>>(
        '${path ?? url}$endpoint',
        queryParameters: queryParameters ?? {},
        data: data,
        options: Options(
          method: 'POST',
          headers: headers,
          extra: <String, dynamic>{},
          contentType: isFormData ? 'multipart/form-data' : contentType,
        ),
      );

      return response;
    } on DioException catch (e) {
      Logger(e);
      throw e.toString();
    } catch (e) {
      throw e.toString();
    }
  }
}

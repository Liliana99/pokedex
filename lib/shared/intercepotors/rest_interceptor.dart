import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class CustomInterceptor extends Interceptor {
  final bool responseHeader;
  var logger = Logger();

  CustomInterceptor({this.responseHeader = true});

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Aquí puedes manipular los encabezados de la respuesta si es necesario
    if (!responseHeader) {
      // Supongamos que quieres eliminar los encabezados de la respuesta
      response.headers.clear();
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    logger.d(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');

    handler.reject(err);
  }
}

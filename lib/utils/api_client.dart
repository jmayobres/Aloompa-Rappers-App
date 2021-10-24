import 'package:dio/dio.dart';

class ApiClient {
  Dio dio;
  ApiClient() {
    setupDio();
  }

  setupDio() async {
    BaseOptions options = BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 5000,
      baseUrl: 'http://assets.aloompa.com.s3.amazonaws.com',
    );
    dio = Dio(options);
    // dio = addInterceptors(dio);
    // dio.interceptors.add(LoggingInterceptors());
  }

  // Dio addInterceptors(Dio dio) {
  //   return dio
  //     ..interceptors.add(InterceptorsWrapper(
  //       onRequest: (RequestOptions options, handler) {
  //       //  requestInterceptor(options, handler);
  //       },
  //       onError: (DioError dioError, handler) => errorInterceptor(dioError),
  //       onResponse: (response, handler) {
  //         return handler.next(response); // continue
  //       },
  //     ));
  // }

  // dynamic errorInterceptor(DioError dioError) {
  //   switch (dioError.response.statusCode) {
  //     case 400:
  //       throw HttpException(dioError.response);
  //     case 401:
  //       throw HttpException(dioError.response);
  //     case 403:
  //       throw HttpException(dioError.response);
  //     case 422:
  //       throw HttpException(dioError.response);
  //     case 500:
  //       throw HttpException(dioError.response);
  //     case 502:
  //       throw HttpException(dioError.response);
  //     case 504:
  //       throw HttpException(dioError.response);
  //     default:
  //       throw Exception(
  //           'Error occured while Communication with Server with StatusCode : ${dioError.response.statusCode}');
  //   }
  // }

  Future<dynamic> getDio(String url, {Map<String, dynamic> parameters}) async {
    dynamic response = await dio.get(
      url,
      queryParameters: parameters,
    );
    return response;
  }
}

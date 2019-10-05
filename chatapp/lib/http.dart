import 'package:dio/dio.dart';

final String basePath = "192.168.8.102:3000";

final String baseUrl = "http://" + basePath + "/api/";

var http = new Dio();

InterceptorsWrapper basePathInterceptor;

initHttp() {
  addBasePathInterceptor();
}

addBasePathInterceptor() {
  basePathInterceptor =
      InterceptorsWrapper(onRequest: (RequestOptions options) {
    options.baseUrl = baseUrl;
  });

  http.interceptors.add(basePathInterceptor);
}

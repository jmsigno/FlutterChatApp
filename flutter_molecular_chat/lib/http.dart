import 'package:dio/dio.dart';

// this is the place where the back end api is running on.Should changed into your locall machine IP
//final String basePath = "10.1.1.226:3000"; //laptop
final String basePath = "118.211.141.238:3000"; //desktop


// basic url where the endpoins are running on
final String baseUrl = "http://" + basePath + "/api/";

//DIo is a flutter library to use for network calls.here create an object of DIO
var http = new Dio();

InterceptorsWrapper basePathInterceptor;

//This method is called from the main.dart to initialyze the addBasePathInterceptor method
initHttp() {
  addBasePathInterceptor();
}

/**
 *  When we use a InterceptorsWrapper no need of typing all the path to endpoint.we can just use the 
last part of the endpoint.othe part is automatically intercepted
 */
addBasePathInterceptor() {
  basePathInterceptor =
      InterceptorsWrapper(onRequest: (RequestOptions options) {
    options.baseUrl = baseUrl;
  });

  http.interceptors.add(basePathInterceptor);
}


import 'package:dio/dio.dart';
import 'package:dio_methods_curd/main.dart';
import 'package:dio_methods_curd/ui/auth/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DioClient{

  Dio? _dio;

  DioClient(){

    /// make a dio instance
    /// and initialize the baseurl and time out conditions and headers
    _dio = Dio(
      BaseOptions(
        baseUrl: "http://192.168.1.113:3000",
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
        contentType: 'application/json',
        headers: {'Content-Type': 'application/json'},
      ),
    );

    // add logger
    _dio!.interceptors.add(
      LogInterceptor(request: true,requestBody: true,responseBody: true)
    );

    // this will add the interceptors in dio
    _dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (option,handler){

          return handler.next(option);

        },
        onResponse: (response,handler){


          return handler.next(response);

        },
        onError:
            (
            DioException dioException,
            ErrorInterceptorHandler errorInterceptorHandler,
            ) async{

          if(dioException.response!=null && dioException.response!.statusCode==401){
            navigatorKey.currentState!.pushReplacement(
              MaterialPageRoute(builder: (context){
                return LoginScreen();
              })
            );

          }

          if (dioException.type == DioExceptionType.connectionTimeout ||
              dioException.type == DioExceptionType.receiveTimeout) {
            print("Connection Time Out");
          } else if (dioException.type == DioExceptionType.cancel) {
            print("Request Cancel");
          } else if (dioException.type == DioExceptionType.badResponse) {
            print("bad Resonse");
          }
          return errorInterceptorHandler.next(dioException);
        },
      ),
    );
  }

  Dio getDio(){
    return _dio!;
  }

}
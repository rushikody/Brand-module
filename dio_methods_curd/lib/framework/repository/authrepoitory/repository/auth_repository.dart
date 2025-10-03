


import 'package:dio/dio.dart';
import 'package:dio_methods_curd/framework/repository/authrepoitory/contract/auth_contract.dart';
import 'package:dio_methods_curd/framework/repository/authrepoitory/model/register.dart';

import '../../../utils/dio_init.dart';

class AuthRepository extends AuthContract{

  final Dio dio = DioClient().getDio();

  @override
  Future<Response> loginUser(String userName, String password) async{
    try{
      Response response = await dio.post(
          "/api/auth/login",
          data: {
              "identifier": userName,
              "password": password
            }
      );
      print(" ----------- /// ---------  ${response}");
      print(" ----------- /// ---------  ${response.data}");
      return response;
    }on DioException catch (e){
      print(e);
      throw Exception(e.response!.data['message']);
    }
  }

  @override
  Future<Response> forgotPassword(String userName) async{
    try{
      Response response = await dio.post(
          "/api/auth/forgot-password",
          data: {
            "email": userName,
          }
      );
      print(" ----------- /// ---------  ${response}");
      print(" ----------- /// ---------  ${response.data}");
      return response;
    }on DioException catch (e){
      print(e);
      throw Exception(e.response!.data['message']);
    }
  }

  @override
  Future<Response> registerUser(Register register)async {
    try{
      Response response = await dio.post(
          "/api/auth/register",
          data: register.toJson()
      );
      print(" ----------- /// ---------  ${response}");
      print(" ----------- /// ---------  ${response.data}");
      return response;
    }on DioException catch (e){
      print(e);
      throw Exception( (e.response==null)? "Server Not Working" :  e.response!.data['message']);
    }

  }
}
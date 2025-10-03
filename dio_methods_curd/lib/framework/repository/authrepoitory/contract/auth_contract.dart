

import 'package:dio/dio.dart';
import 'package:dio_methods_curd/framework/repository/authrepoitory/model/register.dart';

abstract class AuthContract{

  // user Login Method
  Future<Response> loginUser(String userName,String password);

  //
  Future<Response> forgotPassword(String userName);

  Future<Response> registerUser(Register register);

}
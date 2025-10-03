


import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_methods_curd/framework/repository/authrepoitory/model/register.dart';
import 'package:dio_methods_curd/framework/repository/authrepoitory/repository/auth_repository.dart';

import 'package:dio_methods_curd/framework/utils/hive_init.dart';
import 'package:dio_methods_curd/framework/utils/ui_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../repository/authrepoitory/model/login_user_model.dart';

final authController = ChangeNotifierProvider((ref){
  return AuthOperation();
});


class AuthOperation extends ChangeNotifier{

  UiState authState = UiState<LoginUser>();

  void addLoader(bool val){
    authState.isLoading = val;
    notifyListeners();
  }

  Future<void> loginUser(String userName,String password)async{
    addLoader(true);
    try{
      Response response = await AuthRepository().loginUser(userName, password);
      authState.success =  loginUserFromJson(json.encode(response.data));

    }catch(e){
      authState.success = LoginUser(
        message:e.toString()
      );
    }finally{
      addLoader(false);
      notifyListeners();
    }
  }

  Future<LoginUser> forgotPassword(String userName)async{
    addLoader(true);
    try{
      Response response = await AuthRepository().forgotPassword(userName);
      return LoginUser(
        success: true,
          message:response.data['message']
      );
    }catch(e){
      return LoginUser(
        success: false,
          message:e.toString()
      );
    }finally{
      addLoader(false);
      notifyListeners();
    }
  }

  Future<void> registerUser(Register register)async{
    addLoader(true);
    try{
      Response response = await AuthRepository().registerUser(register);
      authState.success =  loginUserFromJson(json.encode(response.data));
    }catch(e){
      authState.success = LoginUser(
          message:e.toString()
      );
    }finally{
      addLoader(false);
      notifyListeners();
    }
  }

}
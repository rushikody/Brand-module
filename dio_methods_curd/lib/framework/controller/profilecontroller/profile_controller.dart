
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_methods_curd/framework/repository/profilerepository/model/profile_model.dart';
import 'package:dio_methods_curd/framework/repository/profilerepository/repository/profile_repository.dart';
import 'package:dio_methods_curd/framework/utils/hive_init.dart';
import 'package:dio_methods_curd/framework/utils/ui_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileController = ChangeNotifierProvider((ref){

  return ProfileOperation();

});



class ProfileOperation extends ChangeNotifier{

  UiState profileState = UiState<Userprofile>();

  void setLoader(bool val){
    profileState.isLoading = val;
    notifyListeners();
  }

  void setUpdateLoader(bool val){
    profileState.isUpdate = val;
    notifyListeners();
  }

  void setLogoutLoader(bool val){
    profileState.isLogOut = val;
    notifyListeners();
  }

  Future<void> getUserInfo()async {
    profileState.error=null;
    String token = await HiveInit().getAccessToken();
    try{
    Response response = await ProfileRepository().getUser(token);
    profileState.success = userprofileFromJson(json.encode(response.data));
  }catch(e){
      profileState.error = e.toString();
      profileState.success = Userprofile(
    message:e.toString()
    );
    }finally{
      setLoader(false);
    notifyListeners();
    }
  }

  Future<bool> UpdateUserInfo(User userInfo)async {
    setUpdateLoader(true);
    String token = await HiveInit().getAccessToken();
    try{
      Response response = await ProfileRepository().updateUser(userInfo, token);
      return true;
    }catch(e){
      return false;
    }finally{
      setUpdateLoader(false);
      setLoader(false);
      notifyListeners();
    }
  }


  Future<bool> logoutUser()async {
    setLogoutLoader(true);
    String accessToken = await HiveInit().getAccessToken();
    String refreshToken = await HiveInit().getRefreshToken();
    try{
      Response response = await ProfileRepository().logOutUser(accessToken, refreshToken);
      if(response.statusCode==200){
        await HiveInit().clearBox();
        return true;
      }else{
        return false;
      }
    }catch(e){
      return false;
    }finally{
      setUpdateLoader(false);
      setLoader(false);
      setLogoutLoader(false);
      notifyListeners();
    }
  }

  Future<bool> changeImage(PlatformFile file)async {
    setUpdateLoader(true);
    String accessToken = await HiveInit().getAccessToken();
    try{
      Response response = await ProfileRepository().imageChange(file,accessToken);
      if(response.statusCode==200){
        return true;
      }else{
        return false;
      }
    }catch(e){
      return false;
    }finally{
      setUpdateLoader(false);
      setLoader(false);
      setLogoutLoader(false);
      notifyListeners();
    }
  }
}
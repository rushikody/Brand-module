

import 'dart:io';

import 'package:dio/dio.dart';

import 'package:dio_methods_curd/framework/repository/profilerepository/model/profile_model.dart';
import 'package:file_picker/file_picker.dart';

abstract class ProfileApi{

  Future<Response> getUser(String token);

  Future<Response> updateUser(User user, String token);

  Future<Response> logOutUser(String accessToken, String refreshToken);

  Future<Response> imageChange(PlatformFile file,String accessToken);

}
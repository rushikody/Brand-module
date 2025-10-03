

import 'dart:io';

import 'package:file_picker/file_picker.dart';

import 'package:dio/dio.dart';
import 'package:dio_methods_curd/framework/repository/profilerepository/contract/profile_contract.dart';

import '../../../utils/dio_init.dart';
import 'package:dio_methods_curd/framework/repository/profilerepository/model/profile_model.dart';

class ProfileRepository extends ProfileApi{

  final Dio dio = DioClient().getDio();

  @override
  Future<Response> getUser(String token) async{
    try{
      Response response = await dio.get(
          "/api/users/profile",
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            }
          )
      );
      print(response.data);
      return response;
    }on DioException catch (e){
      throw Exception( (e.response==null)? "Server Not Working" :  e.response!.data['message']);
    }




  }


  @override
  Future<Response> updateUser(User user, String token) async {
    try {
      Response response = await dio.put(
          "/api/users/profile",
          data: {
            "first_name": user.firstName,
            "last_name": user.lastName,
            "phone": user.phone,
            "date_of_birth": user.dateOfBirth
          },
          options: Options(
              headers: {
                'Authorization': 'Bearer $token',
              }
          )
      );
      print(response.data);
      return response;
    } on DioException catch (e) {
      throw Exception((e.response == null) ? "Server Not Working" : e.response!
          .data['message']);
    }
  }

  @override
  Future<Response> logOutUser(String accessToken, String refreshToken) async {
    try {
      Response response = await dio.post(
          "/api/auth/logout",
          data:{
            "refresh_token": refreshToken,
          },
          options: Options(
              headers: {
                'Authorization': 'Bearer $accessToken',
              }
          )
      );
      print(response.data);
      return response;
    } on DioException catch (e) {
      throw Exception((e.response == null) ? "Server Not Working" : e.response!
          .data['message']);
    }
  }


  @override
  Future<Response> imageChange(PlatformFile file,String accessToken) async {
    try {

      FormData formData = FormData.fromMap(
          {
            "profile_image":MultipartFile.fromBytes(
              await File(file.path!).readAsBytes(),
              filename: file.name,
            ),

          }
      );

      Response response = await dio.post(
          "/api/users/profile/upload-image",
          data:formData,
          options: Options(
              headers: {
                'Authorization': 'Bearer $accessToken',
              }
          )
      );
      print(response.data);
      return response;
    } on DioException catch (e) {
      throw Exception((e.response == null) ? "Server Not Working" : e.response!
          .data['message']);
    }
  }

}
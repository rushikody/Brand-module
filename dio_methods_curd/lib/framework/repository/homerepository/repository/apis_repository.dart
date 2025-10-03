import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_methods_curd/framework/controller/homecontroller/home_controller.dart';
import 'package:dio_methods_curd/framework/utils/dio_init.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../contract/apis_contract.dart';
import '../module/fetchdata_model.dart';

/// here implements all method declare inside the api
class ApiImplements extends Api {


  final Dio dio = DioClient().getDio();

  // it fetch the data from get api
  @override
  Future<Response> getAllBrand(int page,int limit) async {
    try{
      Response response = await dio.get("/api/brands?page=$page&limit=$limit");
      return response;
    }on DioException catch (e){
      print(e);
      throw Exception(e);
    }
  }

  // it fetch the specific module base on id
  @override
  Future<Response> getBrandById(int id) async{
    try{
      Response response = await dio.get("/api/brands/$id");
      return response;
    }on DioException catch (e){
      throw Exception(e);
    }
  }

  // it send the data on the server
  @override
  Future<Response> postData(Datum data) async {
    try{
      print(data.name);
      print(data.description);
      Response response = await dio.post(
        "/api/brands",
        data:{
          "name": data.name,
          "description": data.description,
          "website": "https://apple.com",
          "is_active": true
        }
      );
      print(response);
      return response;

    }on DioException catch (e){
      print(e);
      throw Exception(e);
    }
  }

  // update the data base on module id
  @override
  Future<Response> patchData(int id ,Datum data) async{

    try{
      print(data.name);
      print(data.description);
      Response response = await dio.put(
          "/api/brands/$id",
          data:{
            "name": data.name,
            "description": data.description,
            "website": "https://apple.com",
            "is_active": true
          }
      );
      print(response);
      return response;

    }on DioException catch (e){
      print(e);
      throw Exception(e);
    }


  }

  // delete the data present in server base on id
  @override
  Future<Response> deleteData(int id) async{
    try{
      Response response = await dio.delete("/api/brands/$id");
      return response;
    }on DioException catch (e){
      throw Exception(e);
    }
  }

  // it change the image specific brand base on id
  @override
  Future<Response> imageChange(int id,PlatformFile file,WidgetRef ref) async{

    try{

      String fileName = file.name;
      print(fileName);


      FormData formData = FormData.fromMap(
          {
            "logo":MultipartFile.fromBytes(
              await File(file.path!).readAsBytes(),
              filename: fileName,
            ),
          }
      );

      Response response = await dio.post(
          "/api/brands/$id/upload-logo",
        data:formData,
        onSendProgress: (int sent, int total) {
            ref.read(imageLoadProvider.notifier).state = sent / total;
          print('Upload progress: ${(sent / total * 100).toStringAsFixed(0)}%');
        },
      );
      return response;
    }on DioException catch (e){
      print(e);
      throw Exception(e);
    }
  }
}

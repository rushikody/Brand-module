
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../module/fetchdata_model.dart';

abstract class Api{


  //  make these method to call get all data api
  Future<Response> getAllBrand(int page,int limit);

  // get brand by id
  Future<Response> getBrandById(int id);

  // make these Method for add data on server
  Future<Response> postData(Datum data);

  // make these method for change the single entity
  Future<Response> patchData(int id ,Datum data);

  // make these for delete the data base on id
  Future<Response> deleteData(int id);

  // change Image
  Future<Response> imageChange(int id,PlatformFile file,WidgetRef ref);

}
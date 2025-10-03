
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// these class initialize the  all controller use in home
class HomeController{

  static TextEditingController searchController = TextEditingController();
  static TextEditingController deleteController = TextEditingController();

  // this method pic the image form the gallery of the local device
  Future<PlatformFile?> getFileFromGallery()async{

    FilePickerResult? filePickerResult =   await FilePicker.platform.pickFiles();

    if(filePickerResult!=null){
      return filePickerResult.files.first;
    }

    return null;
  }
}

final imageLoadProvider = StateProvider<double>((ref){
  return 0.0;
});



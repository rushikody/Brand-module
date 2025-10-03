


import 'dart:io';

import 'package:dio_methods_curd/framework/controller/profilecontroller/profile_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../framework/controller/homecontroller/home_controller.dart';
import '../theme/app_color.dart';
import 'custom_snackbar.dart';
import 'custom_text_widget.dart';

class ChangeProfileImage extends StatefulWidget {
  const ChangeProfileImage({super.key});

  @override
  State<ChangeProfileImage> createState() => _ChangeProfileImageState();
}

class _ChangeProfileImageState extends State<ChangeProfileImage> {
  PlatformFile? file;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 10,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.close),
              ),
              SizedBox(height: 10),
            ],
          ),

          Center(
            child: Column(
              spacing: 9,
              children: [
                GestureDetector(
                  onTap: () async {
                    print("Function Call");
                    file = await HomeController().getFileFromGallery();
                    setState(() {});
                  },
                  child: Container(
                    height: 130,
                    width: 130,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.textColor.withOpacity(0.2),
                    ),
                    child: (file != null)
                        ? Image.file(File(file!.path!), fit: BoxFit.cover)
                        : Icon(Icons.person, color: AppColor.textColor),
                  ),
                ),
                if (file == null)
                  CustomTextWidget(text: "Select Profile Image"),
              ],
            ),
          ),

          Consumer(
            builder: (context,ref,child) {
              final image = ref.watch(profileController);
              return ElevatedButton(
                onPressed: () async {
                  if (file != null) {
                    print("image Path : ${file!.path}");
                    bool result =  await ref.read(profileController.notifier).changeImage(file!);

                    if(result){
                      await ref.read(profileController.notifier).getUserInfo();
                      CustomSnackBar.showMySnackBar(
                        context,
                        "Image Updated Successfully",
                        AppColor.success,
                      );
                    }else{
                      CustomSnackBar.showMySnackBar(
                        context,
                        "Something Went Wrong",
                        AppColor.error,
                      );
                    }

                    Navigator.pop(context);
                  }
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: file == null
                      ? AppColor.textColor.withOpacity(0.02)
                      : AppColor.success,
                ),
                child:(image.profileState.isUpdate)? Center(child: CircularProgressIndicator(),) :  CustomTextWidget(text: "Submit", color: AppColor.white),
              );
            }
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}

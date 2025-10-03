import 'dart:io';

import 'package:dio_methods_curd/framework/controller/homecontroller/home_controller.dart';
import 'package:dio_methods_curd/framework/controller/homecontroller/home_controller_provider.dart';
import 'package:dio_methods_curd/framework/repository/homerepository/module/fetchdata_model.dart';
import 'package:dio_methods_curd/ui/utils/widgets/custom_snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:typed_data';
import '../../utils/widgets/custom_text_widget.dart';
import '../theme/app_color.dart';

///  these help to change the profile of the user
///  in profile screen
class ChangeImage extends ConsumerStatefulWidget {
  final int id;

  const ChangeImage({super.key, required this.id});

  @override
  ConsumerState<ChangeImage> createState() => _ChangeChangeImage();
}

class _ChangeChangeImage extends ConsumerState<ChangeImage> {
  PlatformFile? file;


  @override
  Widget build(BuildContext context) {
    // var userInfo = ref.watch(getUserData(widget.id));
    final val = ref.read(imageLoadProvider);
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

          if (val > 0 && val <= 1) // Show only during upload
            LinearProgressIndicator(value: val, color: AppColor.success),

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

          ElevatedButton(
            onPressed: () async {
              if (file != null) {
                FetchData fetchdata = await ref
                    .read(apisOperationProvider.notifier)
                    .postImageOnServer(widget.id, file!, ref);

                await ref
                    .read(apisOperationProvider.notifier)
                    .getAllResponseApi(true);

                CustomSnackBar.showMySnackBar(
                  context,
                  "Image Updated : ${fetchdata.message}",
                  AppColor.success,
                );

                await Future.delayed(Duration(seconds: 1));

                Navigator.pop(context);
              }
            },

            style: ElevatedButton.styleFrom(
              backgroundColor: file == null
                  ? AppColor.textColor.withOpacity(0.02)
                  : AppColor.success,
            ),
            child: CustomTextWidget(text: "Submit", color: AppColor.white),
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}

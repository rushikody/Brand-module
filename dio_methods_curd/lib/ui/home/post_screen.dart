import 'package:dio_methods_curd/ui/utils/widgets/take_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../framework/controller/homecontroller/home_controller_provider.dart';
import '../../framework/repository/homerepository/module/fetchdata_model.dart';
import '../utils/theme/app_color.dart';
import '../utils/widgets/change_image.dart';
import '../utils/widgets/custom_snackbar.dart';
import '../utils/widgets/custom_text_field.dart';
import '../utils/widgets/custom_text_widget.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController productName = TextEditingController();
  final TextEditingController dis = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer(
        builder: (context, ref, child) {
          return Column(
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: CustomTextWidget(
                  text: "Post The Data",
                  color: AppColor.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),

              TakeInput(
                iconData: Icons.currency_rupee,
                text: "Enter Brand name",
                controller: productName,
              ),
              TakeInput(
                iconData: Icons.chat,
                text: "Enter description",
                controller: dis,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      print(productName.text);
                      print(dis.text);

                      if (productName.text.isNotEmpty && dis.text.isNotEmpty) {
                        Datum data = Datum(
                          name: productName.text,
                          description: dis.text,
                          website: "https://apple.com",
                        );

                        FetchData? feData = await ref
                            .read(apisOperationProvider.notifier)
                            .postUserOnServer(data);

                        ref
                            .read(apisOperationProvider.notifier)
                            .getAllResponseApi(true);

                        CustomSnackBar.showMySnackBar(
                          context,
                          "Data Post : ${feData.message}",
                          AppColor.success,
                        );

                        Navigator.pop(context);
                      } else {
                        print("Filled all field");
                        CustomSnackBar.showMySnackBar(
                          context,
                          "Filled all field",
                          AppColor.error,
                        );
                      }
                    },
                    child: CustomTextWidget(
                      text: "Post Data",
                      color: AppColor.black,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.success,
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.error,
                    ),
                    child: CustomTextWidget(
                      text: "Cancel",
                      color: AppColor.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }
}

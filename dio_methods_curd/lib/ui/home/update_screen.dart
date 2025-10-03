import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../framework/controller/homecontroller/home_controller_provider.dart';
import '../../framework/repository/homerepository/module/fetchdata_model.dart';
import '../utils/theme/app_color.dart';
import '../utils/widgets/custom_snackbar.dart';
import '../utils/widgets/custom_text_widget.dart';
import '../utils/widgets/take_input.dart';

class UpdateScreen extends StatefulWidget {
  final int id;
  final Datum data;
  const UpdateScreen({super.key, required this.id, required this.data});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final TextEditingController productName = TextEditingController();
  final TextEditingController dis = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    productName.text = widget.data.name!;
    dis.text = widget.data.description!;
  }

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
                  text: "Update The Data",
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
                            .updateData(widget.id, data);

                        ref
                            .read(apisOperationProvider.notifier)
                            .getAllResponseApi(true);

                        CustomSnackBar.showMySnackBar(
                          context,
                          "Data Updated : ${feData.message}",
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

                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.success,
                    ),
                    child: CustomTextWidget(
                      text: "Update Data",
                      color: AppColor.black,
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

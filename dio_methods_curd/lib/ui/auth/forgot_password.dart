

import 'package:dio_methods_curd/framework/controller/authcontroller/auth_controller.dart';
import 'package:dio_methods_curd/framework/repository/authrepoitory/model/login_user_model.dart';
import 'package:dio_methods_curd/ui/utils/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/theme/app_color.dart';
import '../utils/widgets/custom_snackbar.dart';
import '../utils/widgets/custom_text_field.dart';
import '../utils/widgets/custom_text_widget.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final TextEditingController _emailController  = TextEditingController();
  final forgotPassword = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back)),
              Form(
                key: forgotPassword,
                child: CustomTextField(
                  controller: _emailController,
                  iconData: Icons.email,
                  text: "Enter Email",
                  validate: (v) {
                    if (v == null || v.isEmpty) {
                      return 'Please enter an email address';
                    }
                    final emailRegex = RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    );
                    if (!emailRegex.hasMatch(v)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
              ),

              Consumer(
                builder: (context,ref,child) {

                  final forgot = ref.watch(authController);

                  return CustomButtonWidget(

                    onPressed: ()async{

                      if(forgotPassword.currentState!.validate()) {
                        LoginUser loginUser =  await ref.read(authController.notifier).forgotPassword(
                            _emailController.text.trim().toString());
                        if(loginUser.success!){
                          CustomSnackBar.showMySnackBar(context, loginUser.message?? "Link Send Successfully", AppColor.success);
                          Navigator.pop(context);
                        }else{
                          CustomSnackBar.showMySnackBar(context, loginUser.message?? "Link Not Send", AppColor.error);
                        }

                      }else{
                        CustomSnackBar.showMySnackBar(context, "No Valid Data", AppColor.error);
                      }

                    },
                    buttonWidth: MediaQuery.sizeOf(context).width,
                    buttonShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    buttonHeight: 50,
                    buttonColor: Colors.blue,
                    childWidget: (forgot.authState.isLoading) ? Center(child: CircularProgressIndicator(),):  CustomTextWidget(
                      text: "Send Link",
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: AppColor.textColor,
                    ),
                  );
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}

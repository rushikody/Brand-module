import 'package:dio/dio.dart';
import 'package:dio_methods_curd/framework/controller/authcontroller/auth_controller.dart';
import 'package:dio_methods_curd/framework/controller/authcontroller/login_controller.dart';
import 'package:dio_methods_curd/framework/controller/authcontroller/validation_controller.dart';
import 'package:dio_methods_curd/framework/repository/authrepoitory/contract/auth_contract.dart';
import 'package:dio_methods_curd/framework/repository/authrepoitory/model/login_user_model.dart';
import 'package:dio_methods_curd/framework/utils/hive_init.dart';
import 'package:dio_methods_curd/gen/assets.gen.dart';
import 'package:dio_methods_curd/ui/auth/forgot_password.dart';
import 'package:dio_methods_curd/ui/auth/register_screen.dart';
import 'package:dio_methods_curd/ui/utils/theme/app_color.dart';
import 'package:dio_methods_curd/ui/utils/widgets/custom_button_widget.dart';
import 'package:dio_methods_curd/ui/utils/widgets/custom_snackbar.dart';
import 'package:dio_methods_curd/ui/utils/widgets/custom_text_field.dart';
import 'package:dio_methods_curd/ui/utils/widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../main.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailController= TextEditingController();
  final TextEditingController _passwordController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Center(
              child: Assets.images.login.image(
                height: 250,
                width: 250,
              ),
              // child: Image.asset(
              //   "assets/Images/login.jpg",
              //   height: 250,
              //   width: 250,
              // ),
            ),
            CustomTextWidget(
              text: "Login",
              fontSize: 21,
              fontWeight: FontWeight.w600,
            ),

            Form(
              key: LoginController.loginScreenKey,
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomTextField(
                    controller: _emailController,
                      iconData: Icons.person,
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

                  CustomTextField(
                      iconData: Icons.lock,
                      controller: _passwordController,
                      text: "Enter Password",
                    validate:(v) {

                      if (v == null || v.isEmpty) {
                        return 'Please enter the password';
                      }

                      if(v.length<=8){
                        return "password length grater then 8";
                      }

                      // Check for at least one lowercase letter
                      if (!v.contains(RegExp(r'[a-z]'))) {
                        return 'Password must contain at least one lowercase letter.';
                      }

                      // Check for at least one uppercase letter
                      if (!v.contains(RegExp(r'[A-Z]'))) {
                        return 'Password must contain at least one uppercase letter.';
                      }

                      // Check for at least one digit
                      if (!v.contains(RegExp(r'[0-9]'))) {
                        return 'Password must contain at least one number.';
                      }

                      // Check for at least one special character (adjust as needed)
                      if (!v.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                        return 'Password must contain at least one special character.';
                      }

                      return null;
                    },
                  ),
                  
                  GestureDetector(
                      onTap: (){
                        print("Forget Password");
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context){
                          return ForgotPassword();
                        })
                        );
                      },
                      child: CustomTextWidget(text: "Forgot Password",fontSize: 15,fontWeight: FontWeight.w600,color: AppColor.blue,))
                ],
              ),
            ),

            Consumer(
              builder: (context,ref,child) {

                final login =  ref.watch(authController);

                return  CustomButtonWidget(
                  onPressed: ()async{
                    if(LoginController.loginScreenKey.currentState!.validate()){


                      await ref.read(authController.notifier).loginUser(_emailController.text.trim().toString(), _passwordController.text.trim().toString());
                      LoginUser loginUser  = login.authState.success;
                      if(login.authState.success.message=="Success"){
                        selectedIndex = 0;
                        CustomSnackBar.showMySnackBar(context, "Login successfully", AppColor.success);

                        await HiveInit().setUserLogin(true);
                        await HiveInit().addAccessToken(loginUser.data!.tokens!.accessToken!);
                        await HiveInit().addRefreshToken(loginUser.data!.tokens!.refreshToken!);

                        print("access Token : ${await HiveInit().getAccessToken()} Refresh Token : ${await HiveInit().getRefreshToken()}");

                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                          return HomeScreen();
                        }));

                      }else{
                        CustomSnackBar.showMySnackBar(context, "${login.authState.success.message}", AppColor.error);
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
                  childWidget:(login.authState.isLoading)? Center(child: CircularProgressIndicator(color: AppColor.black)) : CustomTextWidget(
                    text: "Login",
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: AppColor.textColor,
                  ),
                );
              }
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                CustomTextWidget(text: "You Don't Have An Account",fontSize: 15,),
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return RegisterScreen();
                      }));
                    },
                    child: CustomTextWidget(text: "Register",fontSize: 16,fontWeight: FontWeight.w600,color: AppColor.blue,)),
              ],
            ),

          ],
        ),
      ),
    );
  }
}

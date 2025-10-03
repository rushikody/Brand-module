import 'package:dio_methods_curd/framework/controller/authcontroller/login_controller.dart';
import 'package:dio_methods_curd/framework/repository/authrepoitory/model/login_user_model.dart';
import 'package:dio_methods_curd/ui/home/home_screen.dart';
import 'package:dio_methods_curd/ui/utils/widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../framework/controller/authcontroller/auth_controller.dart';
import '../../framework/repository/authrepoitory/model/register.dart';
import '../../framework/utils/hive_init.dart';
import '../../main.dart';
import '../utils/theme/app_color.dart';
import '../utils/widgets/custom_button_widget.dart';
import '../utils/widgets/custom_snackbar.dart';
import '../utils/widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  DateTime? _selectedDate;
  String? phoneNumber;
  String? date;
  final TextEditingController _dobController = TextEditingController();

  void showMyDatePicker()async{

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dobController.text = DateFormat('yyyy-MM-dd').format(_selectedDate!);
        date = _dobController.text;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
              Center(
                child: CustomTextWidget(
                  text: "Register User",
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(
                height: 20
                ,
              ),

              Form(
                key: LoginController.registerScreenKey,
                child: Column(
                  spacing: 10,

                  children: [
                    CustomTextField(
                      iconData: Icons.person,
                      controller: _userNameController,
                      text: "Enter UserName",
                      validate: (v) {
                        if (v != null && v.isEmpty) {
                          return "Enter the UserName";
                        }
                        if (v!.length <= 3) {
                          return "Username must grater than 3 characters long";
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      controller: _emailController,
                      iconData: Icons.email,
                      text: "Enter Email",
                      validate: (v) {
                        final RegExp regex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
                        if (v == null || v.isEmpty) {
                          return 'Please enter an email address';
                        }
                        if (!regex.hasMatch(v)) {
                          return 'Only @gmail.com emails are allowed';
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
                      controller: _passwordController,
                      iconData: Icons.lock,
                      text: "Enter Password",
                      validate: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Please enter the password';
                        }

                        if (v.length <= 8) {
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
                    CustomTextField(
                      controller: _confirmPasswordController,
                      iconData: Icons.lock,
                      text: "Enter confirm password",
                      validate: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Please enter the password';
                        }

                        if (_passwordController.text != v) {
                          return 'Confirm Password Not Match With Password';
                        }

                        return null;
                      },
                    ),
                    CustomTextField(
                      controller: _firstNameController,
                      iconData: Icons.person,
                      text: "Enter First Name",
                      validate: (v) {
                        if (v != null && v.isEmpty) {
                          return "Enter the First Name";
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      controller: _lastNameController,
                      iconData: Icons.person,
                      text: "Enter lastName",
                      validate: (v) {
                        if (v != null && v.isEmpty) {
                          return "Enter the LastName";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _dobController,
                      onTap: (){
                        showMyDatePicker();
                      },
                      validator: (v){
                        return null;
                      },
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: "Enter Dob",
                        prefixIcon: Icon(Icons.calendar_month,color: AppColor.blue,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    IntlPhoneField(
                      initialCountryCode: "IN",
                      onChanged: (v) {
                        _phoneController.text = v.completeNumber;
                        phoneNumber = v.completeNumber;
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Consumer(
                builder: (context,ref,child) {

                  final register = ref.watch(authController);

                  return CustomButtonWidget(
                    onPressed: () async{
                      if (LoginController.registerScreenKey.currentState!
                          .validate()) {

                        Register user = Register(
                          username: _userNameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                          confirmPassword: _confirmPasswordController.text,
                          firstName: _firstNameController.text,
                          lastName: _lastNameController.text,
                          phone: phoneNumber ?? "+1234567890",
                          dateOfBirth: date ?? "2025-09-23T06:48:45.899Z",
                        );

                        await ref.read(authController.notifier).registerUser(user);
                        LoginUser loginUser  = register.authState.success;
                        if(register.authState.success.message.contains("Resource created successfully")){
                          CustomSnackBar.showMySnackBar(context, "User Created Successfully", AppColor.success);
                          selectedIndex = 0;
                          await HiveInit().setUserLogin(true);
                          await HiveInit().addAccessToken(loginUser.data!.tokens!.accessToken!);
                          await HiveInit().addRefreshToken(loginUser.data!.tokens!.refreshToken!);

                          print("access Token : ${await HiveInit().getAccessToken()} Refresh Token : ${await HiveInit().getRefreshToken()}");

                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                            return HomeScreen();
                          }));

                      }else{
                      CustomSnackBar.showMySnackBar(context, "${register.authState.success.message}", AppColor.error);
                      }
                      } else {
                        CustomSnackBar.showMySnackBar(
                          context,
                          "No Valid Data",
                          AppColor.error,
                        );
                      }
                    },
                    buttonWidth: MediaQuery.sizeOf(context).width,
                    buttonShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    buttonHeight: 50,
                    buttonColor: Colors.blue,
                    childWidget:(register.authState.isLoading)? Center(child: CircularProgressIndicator(color: AppColor.black,),): CustomTextWidget(
                      text: "Register",
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: AppColor.textColor,
                    ),
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}

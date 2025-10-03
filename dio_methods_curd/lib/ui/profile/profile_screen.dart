
import 'package:dio_methods_curd/framework/controller/profilecontroller/profile_controller.dart';
import 'package:dio_methods_curd/ui/auth/login_screen.dart';
import 'package:dio_methods_curd/ui/utils/theme/app_color.dart';
import 'package:dio_methods_curd/ui/utils/widgets/chnage_Profile_Image.dart';
import 'package:dio_methods_curd/ui/utils/widgets/custom_button_widget.dart';
import 'package:dio_methods_curd/ui/utils/widgets/custom_snackbar.dart';
import 'package:dio_methods_curd/ui/utils/widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../framework/controller/authcontroller/login_controller.dart';
import '../../framework/repository/profilerepository/model/profile_model.dart';
import '../utils/widgets/custom_navigation_widget.dart';
import '../utils/widgets/custom_text_field.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  String? image;
  DateTime? _selectedDate;

  @override
  void initState() {

    final profile = ref.read(profileController.notifier).profileState;
    Userprofile userprofile = profile.success;
    if(userprofile.data!=null) {
      _userNameController.text = userprofile.data!.user!.username!;
      _emailController.text = userprofile.data!.user!.email!;
      _phoneController.text = userprofile.data!.user!.phone!;
      _firstNameController.text = userprofile.data!.user!.firstName!;
      _lastNameController.text = userprofile.data!.user!.lastName!;
      _dobController.text = userprofile.data!.user!.dateOfBirth!;
      image = userprofile.data!.user!.profileImage;
      convertDateTime(_dobController.text);
      if (image != null) {
        image = image!.replaceAll("localhost:3000", "192.168.1.113:3000");
      }
    }
    print("image-- $image");
    super.initState();
  }

  void convertDateTime(String date){
    String selectDate =  DateFormat('dd/MM/yyyy').format(DateTime.parse(date));

    print("Date : $selectDate");

    _dobController.text = selectDate;

  }

  void showMyDatePicker()async{

      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate ?? DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );

    if(picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dobController.text = DateFormat('yyyy-MM-dd').format(_selectedDate!);
      });
    }
  }

  void showBottomSheetForImage() async {
    final result = await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: ChangeProfileImage(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTextWidget(text: "Profile Screen"),
      ),
      body: Consumer(
        builder: (context,ref,child) {

          final profile = ref.watch(profileController);
          Userprofile userprofile = profile.profileState.success;
          if(profile.profileState.error!= null){
            return Center(child: CustomTextWidget(text: "Server Not Working"),);
          }

          return Padding(
            padding: const EdgeInsets.all(10),
            child: (profile.profileState.isLoading)? Center(child: CircularProgressIndicator(),) :  SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Center(
                    child: Column(
                      spacing: 10,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(width: 0.1),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child:(image==null) ? Icon(Icons.person,size: 41,) : Image.network(userprofile.data!.user!.profileImage),
                            ),

                            Positioned(
                                bottom: 0,
                                right: 10,
                                child: GestureDetector(
                                  onTap: (){
                                    showBottomSheetForImage();
                                  },
                                  child: Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColor.blue
                                      ),
                                      child: Icon(Icons.edit,size: 20,)),
                                ))
                          ],

                        ),

                        CustomTextWidget(text: _userNameController.text,fontWeight: FontWeight.w500,fontSize: 14),
                        CustomTextWidget(text: _emailController.text,fontWeight: FontWeight.w600,fontSize: 20)
                      ],
                    ),
                  ),

                  Form(
                    key: LoginController.profileKey,
                    child: Column(
                      spacing: 10,
                      children: [
                        CustomTextField(
                          controller: _firstNameController,
                          iconData: Icons.person,
                          text: "Enter First Name",
                          validate: (v) {
                            if (v != null && v.isEmpty) {
                              return "Enter the UserName";
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
                              return "Enter the UserName";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            hintText: "Enter Phone Number",
                            prefixIcon: Icon(Icons.call,color: AppColor.blue,),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: _dobController,
                          onTap: (){
                            showMyDatePicker();
                          },
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "Enter Dob",
                            prefixIcon: Icon(Icons.calendar_month,color: AppColor.blue,),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  // Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButtonWidget(buttonWidth: MediaQuery.sizeOf(context).width/3, buttonHeight:50,buttonColor: AppColor.blue,
                        onPressed: ()async{
                        if(LoginController.profileKey.currentState!.validate()){
                          User user = User();
                          user.firstName = _firstNameController.text;
                          user.lastName = _lastNameController.text;
                          user.phone = _phoneController.text;
                          user.dateOfBirth = _dobController.text;
                          bool update =  await ref.read(profileController.notifier).UpdateUserInfo(user);
                          if(update){
                            CustomSnackBar.showMySnackBar(context, "Update Successfully", AppColor.success);
                          }else{
                            CustomSnackBar.showMySnackBar(context, "something Wrong", AppColor.error);
                          }
                        }

                        },
                        childWidget:(profile.profileState.isUpdate) ? Center(child: CircularProgressIndicator(),) : CustomTextWidget(
                          text: "Update",
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: AppColor.textColor,
                        ),
                      ),
                      CustomButtonWidget(buttonWidth: MediaQuery.sizeOf(context).width/3, buttonHeight:50,buttonColor: AppColor.blue,
                        onPressed: ()async{
                           bool result = await ref.read(profileController.notifier).logoutUser();
                           if(result){
                             CustomSnackBar.showMySnackBar(context, "Log Out Successfully", AppColor.success);
                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                               return LoginScreen();
                             }));
                           }else{
                             CustomSnackBar.showMySnackBar(context, "Something Wrong Happen", AppColor.error);
                           }
                        },
                        childWidget: (profile.profileState.isLogOut) ? Padding(
                          padding: const EdgeInsets.all(4),
                          child: Center(child: CircularProgressIndicator(),),
                        ):  CustomTextWidget(
                        text: "Log Out",
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: AppColor.textColor,
                      ),
                      )
                    ],
                  ),
                ],
              ),

            ),
          );
        }
      ),
        bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}


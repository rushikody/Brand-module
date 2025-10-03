
import 'package:dio_methods_curd/framework/utils/hive_init.dart';
import 'package:dio_methods_curd/ui/auth/login_screen.dart';
import 'package:flutter/material.dart';
import '../../../ui/home/home_screen.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../repository/homerepository/repository/apis_repository.dart';
import '../homecontroller/home_controller_provider.dart';

class SplashScreenController{

  // context required for navigation
  BuildContext context;

  SplashScreenController({required this.context});

  /// here navigate from splash screen to homeScreen
  void navigationToHomeScreenAfterDelay(WidgetRef ref){

    Future.delayed(Duration(seconds: 1),()async{


      // fetch all data first time when go home screen
      ref.read(apisOperationProvider.notifier).getAllResponseApi(false);

      if(context.mounted){// it check the mounted or not

        if(!await HiveInit().getUserLogin()){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
            return LoginScreen();
          }));
        }else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
            return HomeScreen();
          }));
        }


      }
    });

  }

}
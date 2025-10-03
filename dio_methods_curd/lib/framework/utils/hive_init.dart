

import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class HiveInit{

    Future<void> initHive()async{
      await  Hive.initFlutter();
      Box box =await  Hive.openBox("Token");
    }

    Future<void> clearBox()async{
      Box box =await  Hive.openBox("Token");
      await box.clear();
    }

    Future<void> setUserLogin(bool login)async{
      Box box =await  Hive.openBox("Token");
      await box.put("isLogin",login);
    }

    Future<bool> getUserLogin()async{

      Box box =await  Hive.openBox("Token");
      if(box.containsKey("isLogin")){
        print("Get Login");
        return await box.get("isLogin");
      }else{
        print("Not Get Login");
        return false;
      }

    }


    Future<void> addAccessToken(String accessToken)async{
      Box box =await  Hive.openBox("Token");
      await box.put("accessToken", accessToken);
    }

    Future<void> addRefreshToken(String refreshToken)async{
      Box box =await  Hive.openBox("Token");
      await box.put("refreshToken", refreshToken);
    }

    Future<String> getAccessToken()async{
      Box box =await  Hive.openBox("Token");
      return  await box.get("accessToken");
    }

    Future<String> getRefreshToken()async{
      Box box =await  Hive.openBox("Token");
      return await box.get("refreshToken");
    }

}
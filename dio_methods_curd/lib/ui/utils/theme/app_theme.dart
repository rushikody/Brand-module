import 'package:flutter/material.dart';

import 'app_color.dart';
class AppTheme{

  ThemeData themeDataLight(){

    return ThemeData(

      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColor.scaFoldBackgroundColor,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColor.blue
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColor.blue
      ),
      textTheme: TextTheme(
        bodySmall: TextStyle(
          color: AppColor.textColor
        ),
          bodyMedium: TextStyle(
              color: AppColor.textColor
          ),
          bodyLarge: TextStyle(
              color: AppColor.textColor
          )
      )

    );

  }

}

import 'package:dio_methods_curd/framework/repository/homerepository/repository/apis_repository.dart';
import 'package:dio_methods_curd/framework/utils/hive_init.dart';
import 'package:dio_methods_curd/ui/auth/login_screen.dart';
import 'package:dio_methods_curd/ui/auth/register_screen.dart';
import 'package:dio_methods_curd/ui/auth/splash_screen.dart';
import 'package:dio_methods_curd/ui/profile/profile_screen.dart';
import 'package:dio_methods_curd/ui/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

int selectedIndex = 0;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main()async{
  await HiveInit().initHive();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: AppTheme().themeDataLight(),
        home: SplashScreen(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../framework/controller/authcontroller/splash_screen_controller.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Navigation to HomeScreen Method
    SplashScreenController(context: context).navigationToHomeScreenAfterDelay(ref);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset("assets/Images/image.jpg",height: 300,width: 300,fit: BoxFit.cover,)),
    );
  }
}

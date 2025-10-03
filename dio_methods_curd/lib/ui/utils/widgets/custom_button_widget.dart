
import 'package:dio_methods_curd/ui/utils/theme/app_color.dart';
import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {


  final VoidCallback? onPressed;
  final Widget? childWidget;
  final Color? buttonColor;
  final double buttonWidth;
  final double buttonHeight;
  final OutlinedBorder? buttonShape;

  const CustomButtonWidget({super.key,this.buttonShape,required this.buttonWidth,required this.buttonHeight,this.onPressed, this.childWidget,this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.blue,
          fixedSize: Size(buttonWidth, buttonHeight),
          shape: buttonShape
        ),
        onPressed: onPressed,
        child:childWidget
    );
  }
}

import 'package:flutter/material.dart';

import 'custom_text_widget.dart';

// show the snack bar to user
class CustomSnackBar {
  static void showMySnackBar(BuildContext context, String text, Color? color) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,

        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: CustomTextWidget(text: text,fontSize: 14,)),
            IconButton(onPressed: (){
              ScaffoldMessenger.of(context).clearSnackBars();
            }, icon: Icon(Icons.close,color: Colors.white
              ,))
          ],
        ),
        backgroundColor: color,
      ),
    );
  }
}

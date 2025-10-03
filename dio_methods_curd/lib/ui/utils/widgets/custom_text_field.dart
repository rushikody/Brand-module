import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../theme/app_color.dart';

class CustomTextField extends ConsumerStatefulWidget {
  final String text;
  final TextEditingController? controller;
  final Function(String)? callback;
  final IconData iconData;
  final IconData? suffixIcon;
  final String? Function(String?)? validate;
  final TextInputType? keyBordType;
  final List<TextInputFormatter>? inputFormatters;



  const CustomTextField({
    super.key,
    required this.iconData,
    this.suffixIcon,
    this.validate,
    required this.text,
    this.callback,
    this.controller,
     this.keyBordType,
     this.inputFormatters
  });

  @override
  ConsumerState<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends ConsumerState<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onFieldSubmitted: widget.callback,
      validator:widget.validate,

      keyboardType: widget.keyBordType,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.iconData,color: AppColor.blue,),
        hintText: widget.text,
        suffixIcon: Icon(widget.suffixIcon,color: AppColor.blue,),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.black),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.black),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}

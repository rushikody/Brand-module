import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../theme/app_color.dart';

class TakeInput extends ConsumerStatefulWidget {
  final String text;
  final TextEditingController? controller;
  final Function(String)? callback;
  final IconData iconData;

  const TakeInput({
    super.key,
    required this.iconData,
    required this.text,
    this.callback,
    this.controller,
  });

  @override
  ConsumerState<TakeInput> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends ConsumerState<TakeInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onFieldSubmitted: widget.callback,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.iconData),
        hintText: widget.text,
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

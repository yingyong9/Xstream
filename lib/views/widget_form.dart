// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_tiktok/style/style.dart';

class WidgetForm extends StatelessWidget {
  const WidgetForm({
    Key? key,
    this.textEditingController,
    this.hint,
    this.textInputType,
  }) : super(key: key);

  final TextEditingController? textEditingController;
  final String? hint;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(keyboardType: textInputType ?? TextInputType.text,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: StandardTextStyle.normalWithOpacity,
        filled: true,
        border: InputBorder.none,
      ),
      controller: textEditingController,
    );
  }
}

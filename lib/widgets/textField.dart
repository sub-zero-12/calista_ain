import 'package:flutter/material.dart';

Widget customFormField(
    TextEditingController controller,
    String labelText,
    IconData iconData,
    TextInputType textInputType,
    int? maxLine,
    validator, {
      bool readOnly = false,
      bool visible = false,
      Widget suffixIcon = const SizedBox.shrink(),
    }) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: TextFormField(
      controller: controller,
      keyboardType: textInputType,
      obscureText: visible,
      decoration: InputDecoration(
        label: Text(labelText),
        //border: const OutlineInputBorder(),
        prefixIcon: Icon(iconData),
        suffixIcon: suffixIcon,
      ),
      readOnly: readOnly,
      validator: validator,
      maxLines: maxLine,
    ),
  );
}



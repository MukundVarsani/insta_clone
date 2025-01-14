import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget{

  final TextEditingController textEditingController;
  final bool isPassword;
  final String hintText;
  final TextInputType textInputType;
  late IconButton? icon;

   TextFieldInput({super.key,
    required this.textEditingController,
    this.isPassword = false,
    required this.hintText,
    required this.textInputType,
     this.icon});


  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
   return TextField(
     controller: textEditingController,
     decoration: InputDecoration(
       hintText: hintText,
       border: inputBorder,
       focusedBorder: inputBorder,
       enabledBorder : inputBorder,
       filled: true,
       contentPadding: const EdgeInsets.all(8),
       suffixIcon: icon
     ),
     keyboardType: textInputType,
     obscureText: isPassword,
   );
  }

}
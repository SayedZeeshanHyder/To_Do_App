import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget{

  final controller;
  final hinttext;
  final keytype;
  final prefixicon;
  final validatormsg;
  final obscuretext;
  final suffixicon;

  MyTextField({
    required this.controller,
    required this.hinttext,
    required this.keytype,
    this.prefixicon,
    this.validatormsg,
    this.obscuretext=false,
    this.suffixicon=null
      }
    );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscuretext,
      validator : (value){
        if(value==null || value.isEmpty){
          return validatormsg;
        }
        return null;
      },
      controller: controller,
      keyboardType: keytype,
      decoration: InputDecoration(
        prefixIcon: prefixicon,
        suffixIcon: suffixicon,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(15),
        ),
        hintText: hinttext,
      ),
    );
  }

}
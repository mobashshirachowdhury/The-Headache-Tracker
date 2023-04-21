import 'package:flutter/material.dart';
import 'helptofill.dart';

class text_field extends StatelessWidget {
  TextEditingController controller;
  String hintName;
  IconData icon;
  bool isObscureText;
  TextInputType inputType;
  bool readonly;

  text_field(
      { this.controller,
        this.hintName,
        this.icon,
        this.isObscureText = false,
        this.inputType = TextInputType.text,
        this.readonly = false
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: text_field(
        controller: controller,
        obscureText: isObscureText,
        //enabled: isEnable,
        keyboardType: TextInputType.text,
        validator: (value) {
           if (value == null || value.isEmpty) {
             return 'Please enter $hintName';
           }
           if (hintName == "Email" && !validateEmail(value)) {
             return 'Please Enter Valid Email';
           }
             return null;
        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.blue),
          ),
        prefixIcon: Icon(icon),
        hintText: hintName,
        labelText: hintName,
        fillColor: Colors.grey[200],
        filled: true
        ),
      ),
    );
  }
}
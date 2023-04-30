import 'package:flutter/material.dart';

Widget textField(BuildContext context, String label, TextEditingController tc) {
  return TextField(
    controller: tc,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xfff66BBE0),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xfff66BBE0),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xfff66BBE0),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        hintStyle: TextStyle(color: Color(0xfff0000000)),
        hintText: label),
  );
}

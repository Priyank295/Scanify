import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

bool validateEmail(BuildContext context, String email) {
  if (EmailValidator.validate(email)) {
    return true;
  } else {
    var snack = SnackBar(content: Text("Please enter valid email"));
    ScaffoldMessenger.of(context).showSnackBar(snack);
    return false;
  }
}

bool validatePass(BuildContext context, String pass) {
  if (pass.length < 8) {
    var snack =
        SnackBar(content: Text("Password should be greater then 8 characters"));
    ScaffoldMessenger.of(context).showSnackBar(snack);
    return false;
  } else {
    return true;
  }
}

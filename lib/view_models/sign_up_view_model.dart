import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wit_test_app/services/firebase/auth.dart';
import 'package:wit_test_app/util/snackbar/custom_snack.dart';
import 'package:wit_test_app/view/home_screen.dart';

class SignupProvider with ChangeNotifier {
  bool isLoading = false;
  final formkeysignUp = GlobalKey<FormState>();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController confirmcontroller = TextEditingController();
  
  //===============confirm==password==========//
  String? confirmValidate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'confirmpassword required';
    } else if (value != passwordcontroller.text) {
      return "password not matching";
    }
    return null;
  }

  void validate(BuildContext context) async {
    if (formkeysignUp.currentState!.validate()) {
       tosignup(context);
    } else {
      return;
    }
  }



  tosignup(BuildContext context) {
    FirebaseAuthMethodes(FirebaseAuth.instance)
        .signupUsingEmail(
            email: emailcontroller.text, password: passwordcontroller.text)!
        .then((value) {
      if (value == "success") {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>const Homescreen()));
      } else {
        Showsnackbar.showsnack(context, value);
      }
    });
  }
}

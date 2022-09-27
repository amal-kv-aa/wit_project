import 'package:flutter/cupertino.dart';

class SignupProvider with ChangeNotifier{
   bool isLoading = false;
  final formkeysignUp = GlobalKey<FormState>();
  final TextEditingController phonenumbercontroller = TextEditingController();
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
   
  void validate(){
  if ( formkeysignUp.currentState!.validate()) 
  {
      
  }
  else
  {

    return;
  }
  }
}
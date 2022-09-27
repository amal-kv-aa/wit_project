import 'package:flutter/cupertino.dart';

class HomeProvider with ChangeNotifier {
  bool isLoading = false;
  final formkey = GlobalKey<FormState>();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController phonenumbercontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
 bool visibility = true;


//===============email validation===========//
  String? emailValidate(String value) {
    if (value.isEmpty) {
      return 'email required';
    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return 'email formate invalid';
    }
    return null;
  }
//================password==validate===============//
  String? passwordValidate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'password required';
    } else if (value.trim().length < 8) {
      return 'Password must be at least 8 characters in length';
    }
    return null;
  }
  //================phone number==============//
  String? phoneValidate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'phonenumber required';
    } else if (value.trim().length < 10) {
      return 'enter valid phonenumber';
    }
    return null;
  }
 visibleupdate() {
    visibility = !visibility;
    notifyListeners();
  }
  void validate(){
  if (formkey.currentState!.validate()) 
  {
      
  }
  else
  {

    return;
  }
  }
}

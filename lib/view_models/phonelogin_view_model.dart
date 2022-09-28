import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:wit_test_app/services/firebase/auth.dart';

class PhoneLoginProvider with ChangeNotifier{
  final formkeyPhonlogin = GlobalKey<FormState>();
  final TextEditingController phonenumbercontroller = TextEditingController();

  
  validate(BuildContext context){
    if (formkeyPhonlogin.currentState!.validate()) {
      toPhoneverification(context);
    } else {
      return;
    }
  }
   toPhoneverification(BuildContext context) {
    FirebaseAuthMethodes(FirebaseAuth.instance)
        .loginWithPhone(phoneNumber: "+91${phonenumbercontroller.text}",context: context);
  }
}
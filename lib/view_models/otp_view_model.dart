import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:wit_test_app/services/firebase/auth.dart';
import 'package:wit_test_app/util/snackbar/custom_snack.dart';
import 'package:wit_test_app/view_models/sign_up_view_model.dart';

class OtpProvider with ChangeNotifier {
  late AnimationController animationController;
  late AnimationController bganimcontroller;
  final TextEditingController otpController = TextEditingController();
String verificationID ='';

   updateId(String newid){
    verificationID = newid;
    notifyListeners();
   }

  toOtpverify(BuildContext context) {
    FirebaseAuthMethodes(FirebaseAuth.instance)
        .verifyOTP(otp: otpController.text.trim(),verificationID: verificationID)!
        .then((value) {
        
        if (value == "success") {
          showanimation(context);
          context.read<SignupProvider>().tosignup(context);
        } else {
          Showsnackbar.showsnack(context, value);
        }
        });
  }

  showanimation(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Lottie.asset(
              'assets/animations/91842-success.json',
              height: 150.h,
              controller: animationController,
              onLoaded: (composition) {
                animationController.forward();
                animationController.duration = composition.duration;
              },
            ),
          );
        });
  }

  showLoding({required BuildContext context}) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: [
                const Text(
                  "checking OTP pleas wait",
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: 25.h,
                ),
                const CircularProgressIndicator()
              ],
            ),
          );
        });
  }
}

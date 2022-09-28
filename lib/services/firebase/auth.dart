import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wit_test_app/util/snackbar/custom_snack.dart';
import 'package:wit_test_app/view/otp_screen.dart';
import 'package:wit_test_app/view_models/otp_view_model.dart';

class FirebaseAuthMethodes {
  final FirebaseAuth _auth;
  FirebaseAuthMethodes(this._auth);


//===============================Email Sign app=============================//

  Future<String>? signupUsingEmail({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "success";
    } on FirebaseException catch (e) {
      log(e.message.toString());

      return e.message!.toString();
    }
  }

  //===============Email Login===============//

  Future<String>? loginWithEmail(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (!_auth.currentUser!.emailVerified) {
        return "success";
      } else {
        return "";
      }
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

//============phoneverify==============//

   loginWithPhone({required String phoneNumber,required BuildContext context}) async {
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) {
          
        });
      },
      verificationFailed: (FirebaseAuthException e) {
         Showsnackbar.showsnack(context,e.message.toString());
      },
      codeSent: (String verificationId, int? resendToken) {
           Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>const OtpScreen()));
        log("sended...");
        context.read<OtpProvider>().updateId(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
         Showsnackbar.showsnack(context,'time out');
        log(verificationId.toString());
      },
    
    );
  }
  //=================otp===================//  
  Future<String>? verifyOTP({required String otp,required String verificationID}) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otp);

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
        return "success";
    }on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  
  }
}

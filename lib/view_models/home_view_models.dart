import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wit_test_app/main.dart';
import 'package:wit_test_app/services/firebase/auth.dart';
import 'package:wit_test_app/util/snackbar/custom_snack.dart';
import 'package:wit_test_app/view/home_screen.dart';
import 'package:wit_test_app/view/login.dart';

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

  //============obscure=================//
  visibleupdate() {
    visibility = !visibility;
    notifyListeners();
  }

  //=================validations==form==field==============//
  void validate(BuildContext context) async {
    if (formkey.currentState!.validate()) {
      await FirebaseAuthMethodes(FirebaseAuth.instance)
          .loginWithEmail(
              email: emailcontroller.text, password: passwordcontroller.text)!
          .then((value) {
        if (value == "success") {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (ctx) => const Homescreen()));
        } else {
          Showsnackbar.showsnack(context, value);
        }
      });
    } else {
      return;
    }
  }

  displayDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const CircleAvatar(
            radius: 60,
          ),
          title: Text(
            FirebaseAuth.instance.currentUser!.email!.toString(),
            style: const TextStyle(
                fontFamily: "cursive", fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('logout'),
              onPressed: () {
               FirebaseAuth.instance.signOut().then((vatlue) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>const Login()));
               });

              },
            )
          ],
        );
      },
    );
  }
}

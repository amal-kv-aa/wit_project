import 'package:flutter/material.dart';
import 'package:wit_test_app/view/login.dart';

class SplashProvider with ChangeNotifier {
  Future gotoHome(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const Login()));
    });
  }
}

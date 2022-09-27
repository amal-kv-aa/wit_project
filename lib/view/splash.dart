import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wit_test_app/view_models/splash_view_model.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<SplashProvider>().gotoHome(context);
    return
    Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.cyanAccent,
    );
  }
}
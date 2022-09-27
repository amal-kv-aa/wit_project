import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wit_test_app/view/splash.dart';
import 'package:wit_test_app/view_models/home_view_models.dart';
import 'package:wit_test_app/view_models/sign_up_view_model.dart';
import 'package:wit_test_app/view_models/splash_view_model.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => SplashProvider()),
      ChangeNotifierProvider(create: (_) => HomeProvider()),
      ChangeNotifierProvider(create: (_)=> SignupProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
              primary: Colors.tealAccent
            )),
            primarySwatch: Colors.cyan,
          ),
          home: const SplashScreen(),
        );
      },
      designSize: const Size(375, 812),
    );
  }
}

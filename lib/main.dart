import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wit_test_app/view/home_screen.dart';
import 'package:wit_test_app/view/login.dart';
import 'package:wit_test_app/view_models/home_view_models.dart';
import 'package:wit_test_app/view_models/otp_view_model.dart';
import 'package:wit_test_app/view_models/phonelogin_view_model.dart';
import 'package:wit_test_app/view_models/sign_up_view_model.dart';
import 'package:wit_test_app/view_models/splash_view_model.dart';
import 'package:wit_test_app/view_models/todo_viewmodel.dart';

import 'firebase_options.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => SplashProvider()),
      ChangeNotifierProvider(create: (_) => HomeProvider()),
      ChangeNotifierProvider(create: (_)=> SignupProvider()),
      ChangeNotifierProvider(create: (_)=>OtpProvider()),
      ChangeNotifierProvider(create: (_)=>TodoProvider()),
      ChangeNotifierProvider(create: (_)=>PhoneLoginProvider())
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
          home: const MainPage(),
        );
      },
      designSize: const Size(375, 812),
    );
  }
}


class MainPage extends StatelessWidget{
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)=>
  StreamBuilder<User?>(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context, snapshot) {
     if (snapshot.hasData) {
       return const Homescreen();
     }
     else
     {
      return const Login();
     }
  },);
}

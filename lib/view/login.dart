import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wit_test_app/util/Textfield/custom_textfield.dart';
import 'package:wit_test_app/view/sign_up.dart';
import 'package:wit_test_app/view_models/home_view_models.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final watch =context.watch<HomeProvider>();
    final read = context.read<HomeProvider>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.teal,
          child: Form(
            key: watch.formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40.h,
                  child: Text("App name",style: TextStyle(fontFamily: 'cursive',fontSize: 30.h,color: Colors.white),),
                ),
                SizedBox(
                  height: 70,
                  width: 280,
                  child: ModelTextfield(
                    hint: 'email',
                    controller: read.emailcontroller,
                    validator: (value) =>
                        read.emailValidate(value!),
                  ),
                ),
                SizedBox(
                  height: 70,
                  width: 280,
                  child: ModelTextfield(
                    hint: 'password',
                    visibility:watch.visibility,
                    iconButton: IconButton(
                        onPressed: () {
                          read.visibleupdate();
                        },
                        icon: Icon(
                          watch.visibility
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        )),
                    controller: watch.passwordcontroller,
                    validator: (value) =>
                        read.passwordValidate(value!),
                  ),
                ),
               SizedBox(height:20.h ),
                ElevatedButton(onPressed: (){
                  read.validate();
                }, child: const Text("Login")),
                SizedBox(height: 30.h),
                 RichText(
                text: TextSpan(
              children: [
                const TextSpan(
                    text: "Don't have an account?",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w200)),
                TextSpan(
                    text: "  Sign-up",
                    style: TextStyle(
                        color: Colors.white54,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.h),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>const SignUp()));
                      }),
              ],
            ))
              ],
            ),
          )),
    );
  }
}

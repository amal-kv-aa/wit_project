import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wit_test_app/util/Textfield/custom_textfield.dart';
import 'package:wit_test_app/view_models/home_view_models.dart';
import 'package:wit_test_app/view_models/sign_up_view_model.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final watch =context.watch<SignupProvider>();
    final read = context.read<SignupProvider>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
                  "Create new Account",style: TextStyle(color: Colors.white,fontSize: 24,fontFamily: "cursive"),
                ),centerTitle: true,),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.teal,
          child: Form(
            key: watch.formkeysignUp,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 70,
                  width: 280,
                  child: ModelTextfield(
                    hint: 'email',
                    controller: read.emailcontroller,
                    validator: (value) =>
                        context.read<HomeProvider>().emailValidate(value!),
                  ),
                ),
                  SizedBox(
                  height: 70.h,
                  width: 280.h,
                  child: ModelTextfield(
                    hint: 'phone number',
                    controller:read.emailcontroller,
                    validator: (value) =>
                        context.read<HomeProvider>().phoneValidate(value!),
                  ),
                ),
                   SizedBox(
                  height: 70,
                  width: 280,
                  child: ModelTextfield(
                    hint: 'password',
                    visibility:context.watch<HomeProvider>().visibility,
                    iconButton: IconButton(
                        onPressed: () {
                          context.read<HomeProvider>().visibleupdate();
                        },
                        icon: Icon(
                          context.watch<HomeProvider>().visibility
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        )),
                    controller: watch.passwordcontroller,
                    validator: (value) =>
                        context.read<HomeProvider>().passwordValidate(value!),
                  ),
                ),
                  SizedBox(
                  height: 70,
                  width: 280,
                  child: ModelTextfield(
                    hint: 'confirm password',
                    visibility:context.watch<HomeProvider>().visibility,
                    iconButton: IconButton(
                        onPressed: () {
                          context.read<HomeProvider>().visibleupdate();
                        },
                        icon: Icon(
                          context.watch<HomeProvider>().visibility
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        )),
                    controller: watch.confirmcontroller,
                    validator: (value) =>
                        context.read<SignupProvider>().confirmValidate(value!),
                  ),
                ),
               SizedBox(height:20.h ),
                ElevatedButton(onPressed: (){
                  context.read<SignupProvider>().validate();
                }, child: const Text("Login")),
                SizedBox(height: 30.h),
                 RichText(
                text: TextSpan(
              children: [
                const TextSpan(
                    text: "already have a account signin",
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
                      }),
              ],
            ))
              ],
            ),
          )),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wit_test_app/view_models/home_view_models.dart';
import 'package:wit_test_app/view_models/phonelogin_view_model.dart';

import '../util/Textfield/custom_textfield.dart';

class PhoneLogin extends StatelessWidget {
  const PhoneLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Form(
          key: context.watch<PhoneLoginProvider>().formkeyPhonlogin,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Phonenumber login",style: TextStyle(fontFamily: "cursive",color: Colors.white,fontSize: 20),),
              SizedBox(height: 30.h,),
              SizedBox(
                width: 250.w,
                child: ModelTextfield(
                  hint: 'phone number',
                  controller: context.read<PhoneLoginProvider>().phonenumbercontroller,
                  validator: (value) =>
                      context.read<HomeProvider>().phoneValidate(value!),
                ),
              ),
              SizedBox(height: 20.h,),
              ElevatedButton(onPressed: (){
                context.read<PhoneLoginProvider>().validate(context);
              }, child: const Text("submit"))
            ],
          ),
        ),
      ),
    );
  }
}

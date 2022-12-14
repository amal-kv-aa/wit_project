
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:wit_test_app/view/home_screen.dart';
import 'package:wit_test_app/view_models/otp_view_model.dart';
import 'package:wit_test_app/view_models/phonelogin_view_model.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key }) : super(key: key);
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    context.read<OtpProvider>().animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    context.read<OtpProvider>().bganimcontroller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    context
        .read<OtpProvider>()
        .animationController
        .addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (ctx) => const Homescreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
     final read = context.read<OtpProvider>();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Consumer<OtpProvider>(
                builder: (context, value, child) {
                  return Lottie.asset(
                      'assets/animations/105173-verification-code-otp.json',
                      controller: value.bganimcontroller,
                      onLoaded: (compossition) {
                    value.bganimcontroller.forward();
                  });
                },
              ),
              const Text(
                'enter OTP',
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                width: 240.w,
                child: PinCodeTextField(
                  appContext: context,
                  pastedTextStyle: TextStyle(
                    color: Colors.green.shade600,
                    fontWeight: FontWeight.bold,
                  ),
                  length: 6,
                  obscureText: true,
                  obscuringCharacter: '*',
                  obscuringWidget: const Icon(
                    Icons.https_outlined,
                    color: Colors.white,
                  ),
                  blinkWhenObscuring: true,
                  animationType: AnimationType.fade,
                  validator: (v) {
                    return null;
                  },
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.teal,
                      inactiveColor: Colors.black,
                      errorBorderColor: Colors.red,
                      activeColor: Colors.black,
                      inactiveFillColor: Colors.white,
                      selectedFillColor: Colors.teal,
                      selectedColor: Colors.white),
                  cursorColor: Colors.black,
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  keyboardType: TextInputType.number,
                  controller: context.watch<OtpProvider>().otpController,
                  boxShadows: const [
                    BoxShadow(
                      offset: Offset(3, 1),
                      color: Colors.black12,
                      blurRadius: 10,
                    )
                  ],
                  onCompleted: (v) {
                    debugPrint("Completed");
                  },
                  onTap: () {

                  },
                  onChanged: (value) {
                    debugPrint(value);
                  },
                  beforeTextPaste: (text) {
                    debugPrint('');
                    return true;
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(
                        text: 'resend OTP',
                        style: const TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          context.read<PhoneLoginProvider>().toPhoneverification(context);
                        }),
                  ),
                  SizedBox(
                    width: 30.w,
                  )
                ],
              ),
              SizedBox(
                height: 20.w,
              ),
              ElevatedButton(
                  onPressed: () {
                    read.toOtpverify(context);
                    read.showLoding(context: context);
                  },
                  child: const Text('submit'))
            ],
          ),
        ),
      ),
    );
  }
}

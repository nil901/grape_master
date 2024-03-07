import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:grape_master/util/prefs/app_preference.dart';
import '../../util/color.dart';
import '../../util/constants.dart';
import '../../util/image_assets.dart';
import '../../util/large_button.dart';
import 'LocalString.dart';
import 'login_cnt.dart';

class OtPScreen extends StatefulWidget {
  const OtPScreen({super.key});

  @override
  State<OtPScreen> createState() => _OtPScreenState();
}

class _OtPScreenState extends State<OtPScreen> {


   int _secondsRemaining = 60;
  late Timer _timer;

  @override
  void initState() {
    AppPreference().initialAppPreference();
    super.initState();
    startTimer();
  } 

   void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer.cancel(); // Stop the timer when it reaches 0
        }
      });
    });
  }

    @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final cnt = Get.put(LoginCnt());
    
    return WillPopScope(
       onWillPop: () => _oneButtonPressed(context),
      child: Material(
        color: Color.fromARGB(255, 108, 105, 105),
        child: SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 720,
                  ),
                  Image.asset(ImageAssets.ic_logo),
                  h70,
                  Center(
                      child: Text(
                    txt_confirm_otp.tr,
                    style: TextStyle(
                        fontWeight: FontWeight.w400, color: kblack, fontSize: 15.1),
                  )),
                  // Center(
                  //     child: Text(
                  //   "number.",
                  //   style: TextStyle(
                  //       fontWeight: FontWeight.w400, color: kblack, fontSize: 15.1),
                  // )),
                  h30,
                  Center(
                      child: Text(
                    "+91 ${cnt.mobilecnt.text}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: kblack, fontSize: 19),
                  )),
                  h20,
                  OtpTextField(
                    textStyle: TextStyle(
                        color: klime, fontSize: 18, fontWeight: FontWeight.w600),
                    numberOfFields: 4,
                    focusedBorderColor: klime,
                    cursorColor: klime,
                    borderRadius: BorderRadius.circular(8),
                    borderColor: klime,
                    fillColor: klime,
                    disabledBorderColor: klime,
                    showFieldAsBox: true,
                    onCodeChanged: (String code) {
                      //  print(code);
                    },
                    onSubmit: (String verificationCode) {
                      cnt.otpMatch = verificationCode;
                    }, 
                  ),
                  h30,
                _secondsRemaining == 0 ? Center(child: InkWell(
                  onTap: (){
                    cnt.Login(context);
                  },
                  child: Text(resend_otp.tr, style: TextStyle(
                          fontWeight: FontWeight.bold, color: klime, fontSize: 19),),
                ),):  Center(
                      child: Text(
                    '00 : $_secondsRemaining',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: kgreen, fontSize: 19),
                  )),
                  h20,
                  LargeButton(
                    onPress: () {
                      cnt.userRegistercent(context);
                    },
                    text: Text(
                      verify_otp.tr,
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500, color: kwhite),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
   Future<bool> _oneButtonPressed(BuildContext context) async {
    DateTime backPressedTime = DateTime.now();
    final differene = DateTime.now().difference(backPressedTime);
    backPressedTime = DateTime.now();

    if (differene >= const Duration(seconds: 2)) {
      Fluttertoast.showToast(
        msg: "Click Again To Close The App",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: kblack,
        textColor: kwhite,
        fontSize: 13.0,
      );
      return false;
    } else {
      SystemNavigator.pop(animated: true);
      return true;
    }
  }
}

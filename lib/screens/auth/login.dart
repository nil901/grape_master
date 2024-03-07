import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/Home/terms_and_condition.dart';
import 'package:grape_master/screens/auth/langvange_screen.dart';
import 'package:grape_master/screens/auth/login_cnt.dart';
import '../../util/color.dart';
import '../../util/comman_text_fileds.dart';
import '../../util/constants.dart';
import '../../util/image_assets.dart';
import '../../util/large_button.dart';
import '../../util/util.dart';
import 'LocalString.dart';
import 'demo.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cnt = Get.put(LoginCnt());
    return WillPopScope(
      onWillPop: () => _oneButtonPressed(context),
      child: Material(
        color: Color.fromARGB(255, 108, 105, 105),
        child: SafeArea(
          child: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 720,
                      ),
                      Image.asset(
                        ImageAssets.ic_logo,
                        height: 300,
                      ),
                      CommanTextFileds(
                        inputType: TextInputType.phone,
                        imageicon: ImageAssets.ic_phone,
                        controller: cnt.referralmobilecnt,
                        hinttext: txt_referral_mobile_no.tr,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CommanTextFileds(
                        inputType: TextInputType.name,
                        maxLength: 50,
                        imageicon: ImageAssets.ic_man,
                        controller: cnt.fullname,
                        hinttext: txt_fullname.tr,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CommanTextFileds(
                        inputType: TextInputType.phone,
                        maxLength: 10,
                        imageicon: ImageAssets.ic_phone,
                        controller: cnt.mobilecnt,
                        hinttext: txt_mobile.tr,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                          child: LargeButton(
                        onPress: () {
                          //        Navigator.push(
                          //   context,
                          //   PageTransition(
                          //     type: PageTransitionType.fade, // Choose your desired animation type
                          //     child: OtPScreen(),
                          //   ),
                          // );
                          if (cnt.fullname.text.isEmpty) {
                            Utils().validationTostmassage(txt_fullname.tr);
                          } else if (!RegExp(r'^[a-zA-Z ]+$')
                              .hasMatch(cnt.fullname.text)) {
                            Utils().validationTostmassage(fullnamealfa.tr);
                          } else if (cnt.mobilecnt.text.isEmpty) {
                            Utils().validationTostmassage(
                                txt_enter_your_mobile_number.tr);
                          } else if (!RegExp(r'^[0-9]{10}$')
                              .hasMatch(cnt.mobilecnt.text)) {
                            Utils().validationTostmassage(
                                txt_enter_validmobile.tr);
                          } else if (cnt.mobilecnt.text.length < 10) {
                            Utils().validationTostmassage(
                                txt_enter_validmobile.tr);
                          } else {
                            cnt.Login(context);
                          }
                        },
                        text: Text(
                          send_otp.tr,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: kwhite),
                        ),
                      )),
                      SizedBox(
                        height: 12,
                      ),
                      Center(
                          child: Text(
                        txtotpmsgg.tr,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, color: grey800),
                      )),
                      h2,
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TermsAndCondition()));
                        },
                        child: RichText(
                          text: TextSpan(
                            // style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                text: "${txt_youare.tr}  ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: grey800,
                                    fontSize: 13),
                              ),
                              TextSpan(
                                text: terms.tr,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kgreen,
                                  fontSize: 15,
                                  decoration: TextDecoration.underline,
                                  // Add any other styles you want for highlighting.
                                ),
                              ),
                              TextSpan(
                                text: "  ${agree.tr}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: grey800,
                                    fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ),
                      h10
                    ],
                  ),
                ),
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

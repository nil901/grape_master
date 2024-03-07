import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/registerplot/register_the_plot.dart';
import 'package:grape_master/util/color.dart';
import 'package:grape_master/util/constants.dart';
import 'package:grape_master/util/image_assets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../screens/auth/LocalString.dart';
import '../screens/post/post_controller.dart';
import '../screens/registerplot/plot_controller.dart';
import '../screens/registerplot/plot_wegits/aks_question_form.dart';
import 'large_button.dart';
import 'package:http/http.dart' as http;

class Utils {
    void launchPhoneCall(String phoneNumber) async {
  String url = 'tel:$phoneNumber';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
    Tostmassage(){
      Fluttertoast.showToast(
        msg: "Success",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: kblack,
        textColor: Colors.white,
        fontSize: 16.0
    );
    } 
      validationTostmassage(msg){
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM_RIGHT,
        timeInSecForIosWeb: 1,
        backgroundColor: kblack,
        textColor: Colors.white,
        fontSize: 16.0
    );
    } 

      static String stripHtmlIfNeeded(String text) {
    return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '');
  }
  static Future<bool> validateImage(String imageUrl) async {
    http.Response res;
    try {
      res = await http.get(Uri.parse(imageUrl));
    } catch (e) {
      return false;
    }

    if (res.statusCode != 200) return false;
    Map<String, dynamic> data = res.headers;
    return checkIfImage(data['content-type']);
  }

  static bool checkIfImage(String param) {
    if (param == 'image/jpeg' || param == 'image/png' || param == 'image/gif') {
      return true;
    }
    return false;
  }  

 
  showCustomDialog(BuildContext context) { 
 

   
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(10),
          contentPadding: EdgeInsets.zero,
          content: SingleChildScrollView(
            child: Container(
              // margin: MediaQuery.of(context).viewInsets,
              // height: 200,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      height: 65,
                      color: kgreen,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          Text(txt_ask_question.tr,
                              style: TextStyle(
                                  color: kwhite,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700)),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(Icons.close,
                                  color: Colors.white, size: 26))
                        ],
                      )),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            
                            int id = 1;
                             Navigator.pop(context);
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType
                                    .fade, // Choose your desired animation type
                                child: AskQutionsForm(
                                  id: id,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(100),
                                child: CircleAvatar(
                                  radius: 35,
                                  backgroundColor: kwhite,
                                  child: Image.asset(
                                    ImageAssets.ic_pen,
                                    height: 40,
                                    color: klime,
                                  ),
                                ),
                              ),
                              h10,
                              Text(txt_rbQues.tr,
                                  style: TextStyle(
                                      color: kblack,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                           // Navigator.pop(context); 
                            Utils().validationTostmassage("Coming Soon");
                            // Navigator.push(
                            //   context,
                            //   PageTransition(
                            //     type: PageTransitionType
                            //         .fade, // Choose your desired animation type
                            //     child: AskQutionsForm(
                            //       id: 2,
                            //     ),
                            //   ),
                            // );
                          },
                          child: Column(
                            children: [
                              Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(100),
                                child: CircleAvatar(
                                  radius: 35,
                                  backgroundColor: kwhite,
                                  child: Image.asset(
                                    ImageAssets.ic_mic,
                                    height: 40,
                                    color: klime,
                                  ),
                                ),
                              ),
                              h10,
                              Text(txt_rbRecord.tr,
                                  style: TextStyle(
                                      color: kblack,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  cameraopengalaryopen(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(10),
          contentPadding: EdgeInsets.zero,
          content: SingleChildScrollView(
            child: Container(
              // margin: MediaQuery.of(context).viewInsets,
              // height: 200,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      height: 65,
                      color: kgreen,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          Text('Give Feedback',
                              style: TextStyle(
                                  color: kwhite,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700)),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(Icons.close,
                                  color: Colors.white, size: 26))
                        ],
                      )),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            int id = 1;
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType
                                    .fade, // Choose your desired animation type
                                child: AskQutionsForm(
                                  id: id,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(100),
                                child: CircleAvatar(
                                  radius: 35,
                                  backgroundColor: kwhite,
                                  child: Image.asset(
                                    ImageAssets.ic_pen,
                                    height: 40,
                                    color: klime,
                                  ),
                                ),
                              ),
                              h10,
                              Text('Enter Question',
                                  style: TextStyle(
                                      color: kblack,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType
                                    .fade, // Choose your desired animation type
                                child: AskQutionsForm(
                                  id: 2,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(100),
                                child: CircleAvatar(
                                  radius: 35,
                                  backgroundColor: kwhite,
                                  child: Image.asset(
                                    ImageAssets.ic_mic,
                                    height: 40,
                                    color: klime,
                                  ),
                                ),
                              ),
                              h10,
                              Text('Voice Record',
                                  style: TextStyle(
                                      color: kblack,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

   static popmsggape(context) {
    showDialog(
        context: context,
        builder: (context) {
          return Padding(
              padding: const EdgeInsets.all(20.0),
              child: AlertDialog(
                insetPadding: EdgeInsets.all(12),
                contentPadding: EdgeInsets.zero,
                content: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Your header and close button code here
                        h10,

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                ImageAssets.ic_logo,
                                height: 50,
                              ),
                              Text(
                                'Grape Master',
                                style: TextStyle(
                                    color: kblack, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              txt_no_plot_dialog_msg.tr,
                              style: TextStyle(
                                  color: kblack, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        h20,
                        h20,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28),
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        // AppPreference().setBool(
                                        //     PreferencesKey.setpopmassage
                                        //         .toString(),
                                        //     true);
                                      },
                                      child: Text(
                                        txt_skip.tr,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      )),
                                  w10,
                                   w10,
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType
                                                .fade, // Choose your desired animation type
                                            child: RegisterThePlot(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        txt_create_plot.tr,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      )),
                                ],
                              )),
                        ),
                        h20,
                      ],
                    ),
                  ),
                ),
              ));
        });
  } 

  static UserRestrict(context) {
    showDialog(
        context: context,
        builder: (context) {
          return Padding(
              padding: const EdgeInsets.all(20.0),
              child: AlertDialog(
                insetPadding: EdgeInsets.all(12),
                contentPadding: EdgeInsets.zero,
                content: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Your header and close button code here
                        h10,

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                ImageAssets.ic_logo,
                                height: 50,
                              ),
                              Text(
                                'Grape Master',
                                style: TextStyle(
                                    color: kblack, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              deactivated.tr,
                              style: TextStyle(
                                  color: kblack, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        h20,
                        h20,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28),
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        // AppPreference().setBool(
                                        //     PreferencesKey.setpopmassage
                                        //         .toString(),
                                        //     true);
                                      },
                                      child: Text(
                                      "",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      )),
                                  w10,
                                   w10,
                                  InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                     Utils().launchPhoneCall("9607087801");
                                      },
                                      child: Text(
                                        txt_okk.tr,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      )),
                                ],
                              )),
                        ),
                        h20,
                      ],
                    ),
                  ),
                ),
              ));
        });
  }
}



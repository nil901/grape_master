import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/auth/login.dart';
import 'package:grape_master/util/color.dart';
import 'package:grape_master/util/constants.dart';
import 'package:grape_master/util/dialog_helper.dart';

import '../../util/image_assets.dart';
import '../../util/prefs/PreferencesKey.dart';
import '../../util/prefs/app_preference.dart';
import '../../util/util.dart';
import 'LocalString.dart';

class Updatelang extends StatefulWidget {
  const Updatelang({super.key});

  @override
  State<Updatelang> createState() => _UpdatelangState();
}

class _UpdatelangState extends State<Updatelang> {
  bool marathi = false;

  bool hindi = false;
  bool english = false;
  bool kanada = false;
  // final String? title;
  // final bool? flag;
  //  final selectLanguage;
  final List locale = [
    {'name': 'ENGLISH', 'locale': Locale('kn', 'IN')},
    {'name': 'मराठी ', 'locale': Locale('mr', 'IN')},
    {'name': 'हिंदी', 'locale': Locale('hi', 'IN')},
  ];

  // LanguageButton(this.title, this.flag, this.selectLanguage);
  updateLanguage(Locale locale) async {
  
    AppPreference().setString(PreferencesKey.languagecode ,locale.languageCode);
     AppPreference().setString(PreferencesKey.countrycode ,locale.countryCode ?? '');

    log("  code fjf ${locale.languageCode}");
    // Get.back();
    Get.updateLocale(locale);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //  statusBarColor: Util.colorPrimary,
    ));
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //     statusBarColor: Colors.transparent,
  //   ));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(
            //       height: MediaQuery.of(context).size.height - 720,
            //     ),
            Center(
              child: Image.asset(
                ImageAssets.ic_logo,
                height: 220,
              ),
            ),
            Text(
             txxtselect_app_language.tr,
              style: TextStyle(color: kblack, fontSize: 25),
            ),
            h40,

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: ()async {
                       
                         updateLanguage(locale[1]['locale']);
                         await AppPreference().setString(PreferencesKey.languageid,'1').then((value) => {
                          print(value),
                         Navigator.pop(context)
                           //DialogHelper.hideLoading()
                         });
                          
                        setState(() {});
                        marathi = true;
                        hindi = false;
                        english = false;
                        kanada = false;
                      },
                      child: Container(
                       
                        decoration: BoxDecoration(
                          color: marathi == true ? kgreen:  klang,
                          border: Border.all(width: 0.75, color: grey800),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              h10,
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        radius: 22.7,
                                        backgroundColor:marathi == true ?  kwhite :klangbig,
                                        child: CircleAvatar(
                                          radius: 22,
                                          backgroundColor: marathi == true ?  kgreen :klangbig,
                                          child: Text(
                                            "म",
                                            style: TextStyle(
                                                color:  marathi == true ? kwhite: Color.fromARGB(
                                                    255, 133, 131, 131),
                                                fontSize: 30),
                                          ),
                                        ),
                                      ),
                                      CircleAvatar(
                                        radius: 12,
                                        backgroundColor: marathi == true ? kwhite :klangbig,
                                        child: Image.asset(
                                          ImageAssets.ic_tick,
                                          height: 15,
                                          color:marathi == true ? kgreen : kwhite,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              h10,
                              Text(
                                " मराठी",
                                style: TextStyle(color:  marathi == true ? kwhite :grey800, fontSize: 18),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  w10,
                  Expanded(
                    child: InkWell( 
                      onTap: (){
                        Utils().validationTostmassage("Coming Soon");
                        //  updateLanguage(locale[2]['locale']);
                        //   AppPreference().setInt(PreferencesKey.languageid ,2);
                          // Get.to(LoginScreen());
                             setState(() {});
                        marathi = false;
                        hindi = true;
                        english = false;
                        kanada = false; 


                      
                      },
                      child: Container(
                      
                        decoration: BoxDecoration(
                          color: hindi == true ? kgreen:  klang,
                          border: Border.all(width: 0.75, color: grey800),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              h10,
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        radius: 22.7,
                                         backgroundColor: hindi == true ?  kwhite :klangbig,
                                        child: CircleAvatar(
                                          radius: 21,
                                         backgroundColor: hindi == true ?  kgreen :klangbig,
                                          child: Text(
                                            "ह",
                                            style: TextStyle(
                                                  color:  hindi == true ? kwhite: Color.fromARGB(
                                                    255, 133, 131, 131),
                                                fontSize: 30),
                                          ),
                                        ),
                                      ),
                                      CircleAvatar(
                                        radius: 12,
                                         backgroundColor: hindi == true ? kwhite :klangbig,
                                        child: Image.asset(
                                          ImageAssets.ic_tick,
                                          height: 15,
                                          color:hindi == true ? kgreen : kwhite,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              h10,
                              Text(
                                " हिंदी ",
                                style: TextStyle(color:  hindi == true ? kwhite :grey800, fontSize: 18),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            h20,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        Utils().validationTostmassage("Coming Soon");
                          // AppPreference().setInt(PreferencesKey.languageid ,2);
                             setState(() {});
                        marathi = false;
                        hindi = false;
                        english = true;
                        kanada = false;
                      
                      },
                      child: Container(
                      
                        decoration: BoxDecoration(
                        color: english == true ? kgreen:  klang,
                          border: Border.all(width: 0.75, color: grey800),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              h10,
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        radius: 22.7,
                                         backgroundColor: english == true ?  kwhite :klangbig,
                                        child: CircleAvatar(
                                          radius: 21,
                                         backgroundColor: english == true ?  kgreen :klangbig,
                                          child: Text(
                                            "E",
                                            style: TextStyle(
                                                color:  english == true ? kwhite: Color.fromARGB(
                                                    255, 133, 131, 131),
                                                fontSize: 30),
                                          ),
                                        ),
                                      ),
                                      CircleAvatar(
                                        radius: 12,
                                         backgroundColor: english == true ? kwhite :klangbig,
                                        child: Image.asset(
                                          ImageAssets.ic_tick,
                                          height: 15,
                                         color:english == true ? kgreen : kwhite,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              h10,
                              Text(
                                " English",
                                style: TextStyle(color: english == true ?  kwhite :grey800,fontSize: 18),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  w10,
                  Expanded(
                    child: InkWell(
                      onTap: (){
                         updateLanguage(locale[0]['locale']);
                            AppPreference().setString(PreferencesKey.languageid ,'4');
                           Navigator.pop(context);
                            setState(() {});
                        marathi = false;
                        hindi = false;
                        english = false;
                        kanada = true;
                      },
                      child: Container(
                      
                        decoration: BoxDecoration(
                         color: kanada == true ? kgreen:  klang,
                          border: Border.all(width: 0.75, color: grey800),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              h10,
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        radius: 22.7,
                                         backgroundColor: kanada == true ?  kwhite :klangbig,
                                        child: CircleAvatar(
                                          radius: 21,
                                          backgroundColor: kanada == true ?  kgreen :klangbig,
                                          child: Text(
                                            "ಕ",
                                            style: TextStyle(
                                                 color:  kanada == true ? kwhite: Color.fromARGB(
                                                    255, 133, 131, 131),
                                                fontSize: 30),
                                          ),
                                        ),
                                      ),
                                      CircleAvatar(
                                        radius: 12,
                                        backgroundColor: kanada == true ? kwhite :klangbig,
                                        child: Image.asset(
                                          ImageAssets.ic_tick,
                                          height: 15,
                                          color:kanada == true ? kgreen : kwhite,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              h10,
                              Text(
                                "ಕನ್ನಡ",
                                style: TextStyle(  color: kanada == true ?  kwhite :grey800, fontSize: 18),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

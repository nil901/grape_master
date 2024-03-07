import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LocalString.dart';


class SelectLanguageScreen extends StatefulWidget {
  static final routeName = '/select-language-screen';

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  final List locale = [
    {'name': 'ENGLISH', 'locale': Locale('kn', 'IN')},
    {'name': 'मराठी ', 'locale': Locale('mr', 'IN')},
    {'name': 'हिंदी', 'locale': Locale('hi', 'IN')},
  ];

  String _selectedLanguage = 'No language selected';

  void _selectLanguage(String title) {
    setState(() {
      _selectedLanguage = title;
    });
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration( 
        
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            // Container(
            //   height: 200,
            //   width: 200,
            //   child: Image.asset('assets/images/anand_crop_guru_logo.png'),
            // ),
            SizedBox(
              height: 20,
            ),
            Text(txt_record_header.tr,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              height: 25,
            ),
            LanguageButton('मराठी', _selectedLanguage == 'मराठी' ? true : false,
                _selectLanguage),
            LanguageButton('हिन्दी',
                _selectedLanguage == 'हिन्दी' ? true : false, _selectLanguage),
            LanguageButton('ENGLISH',
                _selectedLanguage == 'ENGLISH' ? true : false, _selectLanguage),
            LanguageButton('ગુજરાતી',
                _selectedLanguage == 'ગુજરાતી' ? true : false, _selectLanguage),
            SizedBox(
              height: 35,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white, width: 1.3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3,
                    offset: Offset(0.0, 1.0),
                  ),
                ],
              
              ),
              child: SizedBox(
                height: 37,
               
                child: ElevatedButton(
                  onPressed: () {
                    //Navigator.popAndPushNamed(context, RoutesName.login);
                  },
                  child: Text(txt_rbRecord.tr,
                  
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      )),
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.black54,
                    splashFactory: NoSplash.splashFactory,
                    backgroundColor:Colors.orange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageButton extends StatelessWidget {
  final String title;
  final bool flag;
  final selectLanguage;
  final List locale = [
    {'name': 'ENGLISH', 'locale': Locale('kn', 'IN')},
    {'name': 'मराठी ', 'locale': Locale('mr', 'IN')},
    {'name': 'हिंदी', 'locale': Locale('hi', 'IN')},
  ];

  LanguageButton(this.title, this.flag, this.selectLanguage);
  updateLanguage(Locale locale) async {
  
    // AppPreference().setString(PreferencesKey.languagecode ,locale.languageCode);
    //  AppPreference().setString(PreferencesKey.countrycode ,locale.countryCode ?? '');

    log("  code fjf ${locale.languageCode}");
    // Get.back();
    Get.updateLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      
        if (title == "मराठी") {
         
          updateLanguage(locale[1]['locale']);
            print(" marhti langavmnage :-  ${locale[1]['locale']}");
           // AppPreference().setInt(PreferencesKey.languageid ,3);
        } else if (title == "हिन्दी") {

          updateLanguage(locale[2]['locale']);
                  //   AppPreference().setInt(PreferencesKey.languageid ,2);
        } else if (title == "ENGLISH") {
         
          updateLanguage(locale[0]['locale']);
            //AppPreference().setInt(PreferencesKey.languageid ,1);
        } else {
          print('not found language');
        }
        print("djdk");
        selectLanguage(title);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 7),
        height: 50,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
          border: Border.all(
            width: 1.7,
            color:  Colors.pink ,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 2.0,
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color:  Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

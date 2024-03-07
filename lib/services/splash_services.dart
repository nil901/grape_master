import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/address/address_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../screens/auth/langvange_screen.dart';
import '../screens/auth/login.dart';
import '../screens/home_Screen.dart';
import '../util/prefs/PreferencesKey.dart';
import '../util/prefs/app_preference.dart';

class SplashServices {
  void checkAuthentication(BuildContext context) async {
    Future.delayed(const Duration(seconds: 1), () {
      if (AppPreference().getInt(PreferencesKey.uId) == 0 ||
          AppPreference().getInt(PreferencesKey.uId) == "") {
        Get.to(LangvangeSelection());
      }else if( AppPreference().getInt(PreferencesKey.stateId)  == "null"|| AppPreference().getInt(PreferencesKey.stateId)  == 0 ){
         Get.to(AddressScreen());
      }
      else{
           Get.to(MyHomePage());
      }

      // Navigator.popAndPushNamed(context, RoutesName.loginscreen);
    });
  }
}




// {
//   "PLOT_ID": "34861",
//   "USER_ID": "19",
//   "CROP_ID": "27",
//   "CROPVARIETY_ID": "159",
//   "CHATANI_ID": "104",
//   "ST_ID": "2",
//   "WATER_SOURCE": "null",
//   "PLOT_SRUCTURE": "null",
//   "CULTIVATION_TYPE": "null",
//   "METHOD_OF_WATER": "null",
//   "CROP_DISTANCE": "1 X 1 X ",
//   "EXPORT_LOCAL": "Local",
//   "PLOT_AREA": "1.0",
//   "LATITUDE_1": "",
//   "LONGITUDE_1": "",
//   "LATITUDE_2": "",
//   "LONGTUDE_2": "",
//   "PREVIOUS_YEAR_PROBLEM": "null",
//   "SOWING_DATE": "02\/29\/2024",
//   "TASK": "EDIT",
//   "EXTRA1": "",
//   "EXTRA2": "",
//   "EXTRA3": "",
//   "LANG_ID": "1"
// } 


//deler response 

// {
//   "SHOP_ID": "41",
//   "SHOP_NAME": "Aprozer Agri Services 125775",
//   "DEALER_NAME": "Ajinkya Aprozers nashik",
//   "SHOP_ADDRESS": "Satpur MIDC near satpur police station nashik",
//   "STATE_ID": "27",
//   "CITY_ID": "27",
//   "TALUKA_ID": "172",
//   "VILLAGE": "wrqd",
//   "PINCODE": "422047",
//   "WHATSUP_MOBILE_NO": "9868585888",
//   "EMAIL": "demo@gmail.com",
//   "FETLIZER_LIC_NO": "ffh57577575",
//   "PESTISIDE_LIC_NO": "p58575757f",
//   "SEED_LIC_NO": "8586585",
//   "VALID_UPTO": "",
//   "PAN_NUMBER": "gjgjgj55575758",
//   "GST_NUMBER": "gdhf75577575",
//   "TASK": "EDIT",
//   "EXTRA1": "",
//   "EXTRA2": "",
//   "EXTRA3": "",
//   "LANG_ID": "",
//   "USER_ID": "19",
//   "LATITUDE": "20.0086648",
//   "LONGITUDE": "73.7638967",
//   "SHOP_PHOTO": "",
//   "SHOP_OWNER_PHOTO": ""
// }
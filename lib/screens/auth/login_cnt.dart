import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:page_transition/page_transition.dart';
import '../../network/api_constants.dart';
import '../../services/api_service.dart';
import '../../util/dialog_helper.dart';
import '../../util/prefs/PreferencesKey.dart';
import '../../util/prefs/app_preference.dart';
import '../../util/util.dart';
import '../address/address_screen.dart';
import '../home_Screen.dart';
import 'LocalString.dart';
import 'otp_screen.dart';

class LoginCnt extends GetxController {
  RxBool isLoding = false.obs;
  RxBool value = false.obs;
  RxBool isLogin = true.obs;
  String? otpMatch;
  String? masterOtp;
  String? userOtp;

  TextEditingController referralmobilecnt = TextEditingController(text: "");
  TextEditingController fullname = TextEditingController(text: "");
  TextEditingController mobilecnt = TextEditingController(text: "");

  Future Login(BuildContext context) async {
    try {
      await UserLogin(context);
    } catch (e, stackTrace) {
      log(stackTrace.toString());
      log('$e  rfgrtgytt');
      DialogHelper.hideLoading();
    }
  }

  Future userRegistercent(BuildContext context) async {
    try {
      if (masterOtp == otpMatch || userOtp == otpMatch) {
        print("match");
        await UserRegistration(context);
      } else {
       Utils().validationTostmassage(txt_valid_enter_otp.tr);
      }
      ;
    } catch (e, stackTrace) {
      log(stackTrace.toString());
      log('$e  error');
      DialogHelper.hideLoading();
    }
  } 


  

  Future UserLogin(context) async {
    DialogHelper.showLoading("Loading");
    try {
      await ApiService.instance
          .postHTTP(
              url: ApiRoutes.getotp,
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: json.encode({"MOBILE_NO": mobilecnt.text}))
          .then((value) async {
        log(value.data.toString());
        if (value.data['ResponseCode'] == '0') {
          DialogHelper.hideLoading();
         
          Navigator.push(
            context,
            PageTransition(
              type:
                  PageTransitionType.fade, // Choose your desired animation type
              child: OtPScreen(),
            ),
          );
          masterOtp = value.data['DATA'][0]['Master_Otp'].toString();
          userOtp = value.data['DATA'][0]['User_Otp'].toString();
          print(" hhkhb ${value.data['DATA'][0]['User_Otp'].toString()}");
        } else {
          DialogHelper.hideLoading();
          log("Error: ${value.data['ResponseCode']}");
        }
      });
    } on Exception catch (e) {
      print("No Internet");
    }
  }

  Future UserRegistration(context) async {
    DialogHelper.showLoading("Loading");
    await ApiService.instance
        .postHTTP(
            url: ApiRoutes.useregistration,
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
              "USER_ID": "",
              "FULL_NAME": fullname.text,
              "MOBILE_NUMBER": mobilecnt.text,
              "EMAIL": "",
              "DATE_OF_BIRTH": "",
              "ADDRESS": "",
              "ADHARCARD_NUMBER": "",
              "TOKEN": "",
              "STATE_ID": "",
              "CITY_ID": "",
              "TALUKA_ID": "",
              "AREA_ID": "",
              "MAC_ADDRESS": "",
              "PROFILE_PHOTO": "",
              "TASK": "ADD",
              "EXTRA1": "",
              "EXTRA2": "",
              "EXTRA3": "",
              "LANG_ID":AppPreference().getString(PreferencesKey.languageid)

            }))
        .then((value) async {
      //  log(value.data.toString());
      if (value.data['ResponseCode'] == '0') {
        DialogHelper.hideLoading(); 
        if(value.data["DATA1"][0]["STATUS"].toString() == "Active"){
          if(value.data["DATA1"][0]["STATE_NAME"].toString() == "null"){
          //  Navigator.push(
          //   context,
          //   PageTransition(
          //     type:
          //         PageTransitionType.fade, // Choose your desired animation type
          //     child: AddressScreen(name: fullname.text,),
          //   ),
          // );
          Get.to(AddressScreen(name: fullname.text,));
        }  else {
          Navigator.push(
            context,
            PageTransition(
              type:
                  PageTransitionType.fade, // Choose your desired animation type
              child: MyHomePage(),
            ),
          );
        } 
        }else{
          Utils.UserRestrict(context);
        }
        


      //  log(value.data["DATA1"][0]["STATE_ID"].toString());
        //  if( value.data["DATA1"][0]["MOBILE_NUMBER"])
      
         
          
        

        //  Get.offAll(() => OTPScreen());
        await AppPreference()
            .setString('uMobile', value.data['DATA1'][0]['MOBILE_NUMBER'].toString());
        await AppPreference().setString(
            PreferencesKey.uName, value.data['DATA1'][0]['FULL_NAME'].toString());
        await AppPreference()
            .setInt(PreferencesKey.uId, value.data['DATA1'][0]['USER_ID']);
        // await AppPreference()
        //     .setString(PreferencesKey.token, value.data['DATA1'][0]['TOKEN']);
        await AppPreference().setString(
            PreferencesKey.profilePic, value.data['DATA1'][0]['PROFILE_PHOTO']);
         await AppPreference().setInt(
            PreferencesKey.stateId, value.data['DATA1'][0]['STATE_ID']);
        await AppPreference()
            .setInt(PreferencesKey.cityid, value.data['DATA1'][0]['CITY_ID']);
        await AppPreference().setInt(
            PreferencesKey.talukaid, value.data['DATA1'][0]['TALUKA_ID']);
        // await AppPreference().setString(
        //     PreferencesKey.address, value.data['DATA1'][0]['ADDRESS']);
        await AppPreference().setString(
            PreferencesKey.statename, value.data['DATA1'][0]['STATE_NAME'].toString());
        await AppPreference().setString(
            PreferencesKey.cityname, value.data['DATA1'][0]['CITY_NAME']);
        await AppPreference().setString(
            PreferencesKey.talukaname, value.data['DATA1'][0]['TALUKA_NAME']);
        await AppPreference().setString(
            PreferencesKey.areaname, value.data['DATA1'][0]['AREA_NAME']);
        // await AppPreference()
        //     .setString(PreferencesKey.stutas, value.data['DATA1'][0]['STATE_NAME']);

        // // print("${value.data['DATA'][0]['UserID']}");
         fullname.clear();
           mobilecnt.clear();
      } else {
        DialogHelper.hideLoading();
        log("Error: ${value.data['ResponseCode']}");
      }
    });
  }
  String _validateName(String value) {
    String pattern = r'^[a-zA-Z]+$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Please enter only alphabetic characters';
    }
    return "";
  }



}



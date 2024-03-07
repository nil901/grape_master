import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:grape_master/model/home_model/product_list_api.dart';
import 'package:grape_master/screens/auth/LocalString.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/adreesmodel/city_list_by_state_model.dart';
import '../../model/adreesmodel/delear_list_api.dart';
import '../../model/adreesmodel/my_leed_model.dart';
import '../../model/adreesmodel/state_list_model.dart';
import '../../model/adreesmodel/taluka_list_by_city_model.dart';
import '../../network/api_constants.dart';
import '../../services/api_service.dart';
import '../../util/dialog_helper.dart';
import '../../util/prefs/PreferencesKey.dart';
import '../../util/prefs/app_preference.dart';
import '../../util/util.dart';
import '../home_Screen.dart';
import '../register_as_deler/dashboard_deler_profile.dart';

class AddressController extends ChangeNotifier {
  bool _isLoading = false;
  bool get value => _isLoading;
  bool connections = false;
  void _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }
    List<bool> isOpenList = [];

  String? selectedState;
  String? selectedStateId;

  String? selectedCity;
  String? cityid;
  String? selectedtaluka;
  String? talukaId;

  bool get connection => connections;

  TextEditingController fullNamecontroller = TextEditingController(text: "");
  TextEditingController mobileNumbercontroller =
      TextEditingController(text: "");
  TextEditingController statecontroller = TextEditingController(text: "");
  TextEditingController districtController = TextEditingController(text: "");
  TextEditingController talukaController = TextEditingController(text: "");
  TextEditingController vilageNameController = TextEditingController(text: "");
  TextEditingController updatestatecontroller = TextEditingController(text: "");
  TextEditingController updatedistrictController =
      TextEditingController(text: "");
  TextEditingController updatetalukaController =
      TextEditingController(text: "");
  TextEditingController updatevilageNameController =
      TextEditingController(text: "");

  //delar
  TextEditingController shopNameController = TextEditingController(text: "");
  TextEditingController dealerNameController = TextEditingController(text: "");
  TextEditingController AddressofShopController =
      TextEditingController(text: "");
  TextEditingController stateController = TextEditingController(text: "");
  TextEditingController districtShopController =
      TextEditingController(text: "");
  TextEditingController detalukaController = TextEditingController(text: "");
  TextEditingController pinCodeController = TextEditingController(text: "");

  TextEditingController whatsappMobileNumberController =
      TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController fertillizerController = TextEditingController(text: "");
  TextEditingController pestrcidelicNoController =
      TextEditingController(text: "");
  TextEditingController seedLicNumberController =
      TextEditingController(text: "");
  TextEditingController validUptoController = TextEditingController(text: "");
  TextEditingController panNoController = TextEditingController(text: "");
  TextEditingController gstNumberController = TextEditingController(text: "");
  TextEditingController shopvillagenamecontroller =
      TextEditingController(text: "");

  //product text fileds
  TextEditingController productnameController = TextEditingController(text: "");
  TextEditingController productDecriptionController =
      TextEditingController(text: "");
  TextEditingController mesasureofuseandstageController =
      TextEditingController(text: "");
       TextEditingController updatemesasureofuseandstageController =
      TextEditingController(text: "");
  TextEditingController priceController = TextEditingController(text: "");
  TextEditingController companyNameController = TextEditingController(text: "");
  TextEditingController companysalePersonController =
      TextEditingController(text: "");
  TextEditingController companyareasalePersonmobilenumberController =
      TextEditingController(text: "");

  String _selectedState = '';

  void cleardata() {
    print('hello');
    productnameController.clear();
    productDecriptionController.clear();

    mesasureofuseandstageController.clear();

    imageData1 = '';
    imageData3 = '';

    priceController.clear();

    companyNameController.clear();

    companysalePersonController..clear();
  }

  void addProductValidation(context) {
    print('hello');
    if (productnameController.text.isEmpty) {
      Utils().validationTostmassage("Enter Product Name");
    } else if (productDecriptionController.text.isEmpty) {
      Utils().validationTostmassage("Enter Product Description");
    } else if (updatemesasureofuseandstageController.text.isEmpty) {
      Utils().validationTostmassage("Enter measure and stage");
    } else if (imageData1 == "") {
      Utils().validationTostmassage("Upload Product photo");
    } else if (priceController.text.isEmpty) {
      Utils().validationTostmassage("Enter Your Price");
    } else if (companyNameController.text.isEmpty) {
      Utils().validationTostmassage("Enter Brand Name");
    } else if (companysalePersonController.text.isEmpty) {
      Utils().validationTostmassage("Enter Company person name");
    } else {
      productAddPostApi(context);
    }
  }

  void editProductValidation(context, spid) {
    print('hello');
    if (productnameController.text.isEmpty) {
      Utils().validationTostmassage("Enter Product Name");
    } else if (productDecriptionController.text.isEmpty) {
      Utils().validationTostmassage("Enter Product Description");
    } else if (mesasureofuseandstageController.text.isEmpty) {
      Utils().validationTostmassage("Enter measure and stage");
    } else if (imageData1 == "") {
      Utils().validationTostmassage("Upload Product photo");
    } else if (priceController.text.isEmpty) {
      Utils().validationTostmassage("Enter Your Price");
    } else if (companyNameController.text.isEmpty) {
      Utils().validationTostmassage("Enter Brand Name");
    } else if (companysalePersonController.text.isEmpty) {
      Utils().validationTostmassage("Enter Company person name");
    } else {
      editproductAddPostApi(context, spid);
    }
  }

//  String mobile=  AppPreference().getString( PreferencesKey.umobile, );

  Future addressApi(BuildContext context) async {
    try {
      if (fullNamecontroller.text.isEmpty) {
        Utils().validationTostmassage(txt_fullname.tr);
      } else if (mobileNumbercontroller.text.isEmpty) {
        Utils().validationTostmassage(txt_mobile.tr);
      } else if (selectedState == null) {
        Utils().validationTostmassage(txt_select_state.tr);
      } else if (selectedCity == null) {
        Utils().validationTostmassage(txt_select_district.tr);
      } else if (selectedtaluka == null) {
        Utils().validationTostmassage(txt_select_Taluka.tr);
      } else if (vilageNameController.text.isEmpty) {
        Utils().validationTostmassage(txt_Village.tr);
      } else {
        await userRegistration(context);
      }
    } catch (e, stackTrace) {
      log(stackTrace.toString());
      log('$e  rfgrtgytt');
      DialogHelper.hideLoading();
    }
  }

  StateLIstModel? stateModel;
  Future stateListApi() async {
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: ApiRoutes.getdata,
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": 0,
                "END": 10000,
                "WORD": "NONE",
                "GET_DATA": "Get_AllStates",
                "ID1": "",
                "ID2": "",
                "ID3": "",
                "STATUS": "",
                "START_DATE": "",
                "END_DATE": "",
                "EXTRA1": "",
                "EXTRA2": "",
                "EXTRA3": "",
                "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
              }))
          .then((value) {
        stateModel = StateLIstModel.fromJson(value.data);
        _setLoading(false);

        //  log('dssssssssff---${bannar.length}');
      });
      return stateModel;
    } on DioError catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
    }
  }

  CityByStateListModel? citymodel;

  Future cityListApi() async {
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: 'http://newgrapemastersnskapi.cropmaster.in/api/Get_Data',
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": 0,
                "END": 10000,
                "WORD": "NONE",
                "GET_DATA": "Get_CityListByState",
                "ID1": selectedState,
                "ID2": "",
                "ID3": "",
                "STATUS": "",
                "START_DATE": "",
                "END_DATE": "",
                "EXTRA1": "",
                "EXTRA2": "",
                "EXTRA3": "",
                "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
              }))
          .then((value) {
        citymodel = CityByStateListModel.fromJson(value.data);
        _setLoading(false);

        log('dssssssssff---${value.data}');
      });
      return stateModel;
    } on Exception catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

  TalukaListByModel? talukamodel;

  Future talukaListApi() async {
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: 'http://newgrapemastersnskapi.cropmaster.in/api/Get_Data',
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": 0,
                "END": 10000,
                "WORD": "NONE",
                "GET_DATA": "Get_TalukaListByCity",
                "ID1": selectedCity,
                "ID2": "",
                "ID3": "",
                "STATUS": "",
                "START_DATE": "",
                "END_DATE": "",
                "EXTRA1": "",
                "EXTRA2": "",
                "EXTRA3": "",
                "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
              }))
          .then((value) {
        talukamodel = TalukaListByModel.fromJson(value.data);
        _setLoading(false);

        log('dssssssssff---${value.data}');
      });
      return TalukaListByModel;
    } on Exception catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

  int id = AppPreference().getInt(PreferencesKey.uId);
  Future userRegistration(context) async {
    print("user id ${selectedStateId}");

    DialogHelper.showLoading("Loading");
    // Your data
    Map<String, dynamic> userData = {
      "USER_ID":AppPreference().getInt(PreferencesKey.uId),
      "FULL_NAME": fullNamecontroller.text,
      "MOBILE_NUMBER": mobileNumbercontroller.text,
      "EMAIL": "",
      "DATE_OF_BIRTH": "",
      "ADDRESS": "",
      "ADHARCARD_NUMBER": "",
      "TOKEN": "",
      "STATE_ID": selectedState.toString(),
      "CITY_ID": selectedCity.toString(),
      "TALUKA_ID": selectedtaluka.toString(),
      "AREA_ID": vilageNameController.text,
      "MAC_ADDRESS": "",
      "TASK": "UPDATE",
      "EXTRA1": "",
      "EXTRA2": "",
      "EXTRA3": "",
      "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
      "PROFILE_PHOTO": ""
    };
    await ApiService.instance
        .postHTTP(
            url: ApiRoutes.useregistration,
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode(userData))
        .then((value) async {
     log("${userData}");
      if (value.data['ResponseCode'] == '0') {
         log(value.data.toString());
        await AppPreference().setString(
            'uMobile', value.data['DATA1'][0]['MOBILE_NUMBER'].toString());
        await AppPreference().setString(PreferencesKey.uName,
            value.data['DATA1'][0]['FULL_NAME'].toString());
        // await AppPreference()
        //     .setInt(PreferencesKey.uId, value.data['DATA1'][0]['USER_ID']);
        // await AppPreference()
        //     .setString(PreferencesKey.token, value.data['DATA1'][0]['TOKEN']);
        await AppPreference().setString(
            PreferencesKey.profilePic, value.data['DATA1'][0]['PROFILE_PHOTO']);
        await AppPreference()
            .setInt(PreferencesKey.stateId, value.data['DATA1'][0]['STATE_ID']);
        await AppPreference()
            .setInt(PreferencesKey.cityid, value.data['DATA1'][0]['CITY_ID']);
        await AppPreference().setInt(
            PreferencesKey.talukaid, value.data['DATA1'][0]['TALUKA_ID']);
        // await AppPreference().setString(
        //     PreferencesKey.address, value.data['DATA1'][0]['ADDRESS']);
        await AppPreference().setString(PreferencesKey.statename,
            value.data['DATA1'][0]['STATE_NAME'].toString());
        await AppPreference().setString(
            PreferencesKey.cityname, value.data['DATA1'][0]['CITY_NAME']);
        await AppPreference().setString(
            PreferencesKey.talukaname, value.data['DATA1'][0]['TALUKA_NAME']);
        await AppPreference().setString(
            PreferencesKey.areaname, value.data['DATA1'][0]['AREA_NAME']);
        print(userData);
        AppPreference().initialAppPreference();
        DialogHelper.hideLoading();
           await AppPreference().initialAppPreference();
        reloadSharedPreferences();
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade, // Choose your desired animation type
            child: MyHomePage(),
          ),
        );
      } else {
        DialogHelper.hideLoading();
        log("Error: ${value.data['ResponseCode']}");
      }
    });
  }

  String? ShopId;
  Future productAddPostApi(context) async {
    print("user id ${selectedStateId}");
 var data = { 
         "SHOP_ID": ShopId,
              "SP_ID": "",
              "PRODUCT_NAME": productnameController.text,
              "PRODUCT_DESCRIPTION": productDecriptionController.text,
              "BRAND_NAME": companyNameController.text,
              "TASK": "ADD",
              "EXTRA1": "",
              "EXTRA2": "",
              "EXTRA3": "",
              "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
              "MEASURE_OF_USE":"4444",
              "PRICE": priceController.text,
              "EMPLOYEE_NAME": companysalePersonController.text,
              "EMPLOYEE_MOBILE_NO":
                  companyareasalePersonmobilenumberController.text,
              "PRODUCT_PHOTO": imageData1,
              "EMPLOYEE_PHOTO": imageData
 };
 log("${data}");
    DialogHelper.showLoading("Loading");
    await ApiService.instance
        .postHTTP(
            url: ApiRoutes.productadd,
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
              "SHOP_ID": ShopId,
              "SP_ID": "",
              "PRODUCT_NAME": productnameController.text,
              "PRODUCT_DESCRIPTION": productDecriptionController.text,
              "BRAND_NAME": companyNameController.text,
              "TASK": "ADD",
              "EXTRA1": "",
              "EXTRA2": "",
              "EXTRA3": "",
              "LANG_ID": "1",
              "MEASURE_OF_USE": updatemesasureofuseandstageController.text,
              "PRICE": priceController.text,
              "EMPLOYEE_NAME": companysalePersonController.text,
              "EMPLOYEE_MOBILE_NO":
                  companyareasalePersonmobilenumberController.text,
              "PRODUCT_PHOTO": imageData1,
              "EMPLOYEE_PHOTO": imageData
            }))
        .then((value) async {
      log(value.data.toString());
      if (value.data['ResponseCode'] == '0') {
        DialogHelper.hideLoading();
         productlistApi(ShopId);
        Navigator.pop(context);
       productlistApi(ShopId);
       
        imageData1 = '';
        imageData3 = "";
        cleardata();
      } else {
        DialogHelper.hideLoading();
        log("Error: ${value.data['ResponseCode']}");
      }
    });
  }

  Future editproductAddPostApi(context, spid) async {
    print("user id ${selectedStateId}");

    DialogHelper.showLoading("Loading");
    await ApiService.instance
        .postHTTP(
            url: ApiRoutes.productadd,
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
              "SHOP_ID": ShopId,
              "SP_ID": spid,
              "PRODUCT_NAME": productnameController.text,
              "PRODUCT_DESCRIPTION": productDecriptionController.text,
              "BRAND_NAME": companyNameController.text,
              "TASK": "EDIT",
              "EXTRA1": "",
              "EXTRA2": "",
              "EXTRA3": "",
              "LANG_ID": "1",
              "MEASURE_OF_USE": mesasureofuseandstageController.text,
              "PRICE": priceController.text,
              "EMPLOYEE_NAME": companysalePersonController.text,
              "EMPLOYEE_MOBILE_NO":
                  companyareasalePersonmobilenumberController.text,
              "PRODUCT_PHOTO": imageData1,
              "EMPLOYEE_PHOTO": imageData
            }))
        .then((value) async {
      log(value.data.toString());
      if (value.data['ResponseCode'] == '0') {
        DialogHelper.hideLoading();
        Navigator.pop(context);
        productlistApi(ShopId);
        imageData1 = '';
        cleardata();
      } else {
        DialogHelper.hideLoading();
        log("Error: ${value.data['ResponseCode']}");
      }
    });
  }

  Future productAvalibaleOrNot(
      context, productyesno, spid, productname, description, barandname) async {
    print("user id ${selectedStateId}");

    DialogHelper.showLoading("Loading");
    await ApiService.instance
        .postHTTP(
            url: 'http://newgrapemastersnskapi.cropmaster.in/api/ShopProduct/1',
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
              "SHOP_ID": ShopId,
              "SP_ID": spid,
              "PRODUCT_NAME": productname,
              "PRODUCT_DESCRIPTION": description,
              "BRAND_NAME": barandname,
              "TASK": "IS_AVAILABLE",
              "EXTRA1": productyesno,
              "EXTRA2": "",
              "EXTRA3": "",
              "LANG_ID": "",
              "PRODUCT_PHOTO": "",
              "MEASURE_OF_USE": "",
              "PRICE": "",
              "EMPLOYEE_NAME": "",
              "EMPLOYEE_MOBILE_NO": "",
              "EMPLOYEE_PHOTO": ""
            }))
        .then((value) async {
      log(value.data.toString());
      if (value.data['ResponseCode'] == '0') {
        DialogHelper.hideLoading();
        Navigator.pop(context);
        productlistApi(ShopId);
        Utils().validationTostmassage("Success");
        imageData1 = '';
        cleardata();
      } else {
        DialogHelper.hideLoading();
        log("Error: ${value.data['ResponseCode']}");
      }
    });
  }

  Future<void> reloadSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.reload(); // Call reload method
  }

  Future update(context, imagedata) async {
    DialogHelper.showLoading("Loading");

    await ApiService.instance
        .postHTTP(
            url: ApiRoutes.useregistration,
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
              "USER_ID": id,
              "FULL_NAME": fullNamecontroller.text,
              "MOBILE_NUMBER": mobileNumbercontroller.text,
              "EMAIL": "",
              "DATE_OF_BIRTH": "",
              "ADDRESS": "",
              "ADHARCARD_NUMBER": "",
              "TOKEN": "",
              "STATE_ID": selectedState,
              "CITY_ID": selectedCity,
              "TALUKA_ID": selectedtaluka,
              "AREA_ID": updatevilageNameController.text,
              "MAC_ADDRESS": "",
              "TASK": "UPDATE",
              "EXTRA1": "",
              "EXTRA2": "",
              "EXTRA3": "",
              "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
              "PROFILE_PHOTO":imagedata.toString()
            }))
        .then((value) async {
      log(value.data.toString());
      if (value.data['ResponseCode'] == '0') {
        DialogHelper.hideLoading();
Utils().validationTostmassage(profileupadet.tr);
Navigator.pop(context);


        await AppPreference().setString(
            PreferencesKey.uName, value.data['DATA1'][0]['FULL_NAME']);

        await AppPreference().setString(PreferencesKey.umobile,
            value.data['DATA1'][0]['MOBILE_NUMBER'].toString());

        await AppPreference().setString(PreferencesKey.areaname,
            value.data['DATA1'][0]['AREA_NAME'].toString());

        await AppPreference()
            .setInt(PreferencesKey.stateId, value.data['DATA1'][0]['STATE_ID']);

        // await AppPreference().setInt(PreferencesKey.areaname,
        // value.data['DATA1'][0]['STATE_ID']);

        await AppPreference()
            .setInt(PreferencesKey.cityid, value.data['DATA1'][0]['CITY_ID']);

        await AppPreference().setInt(
            PreferencesKey.talukaid, value.data['DATA1'][0]['TALUKA_ID']);
        await AppPreference().setString(
            PreferencesKey.profilePic, value.data['DATA1'][0]['PROFILE_PHOTO'].toString());
        await AppPreference().setString(
            PreferencesKey.areaname, value.data['DATA1'][0]['AREA_NAME']);
// Navigator.pop(context);
        await AppPreference().initialAppPreference();
        reloadSharedPreferences();
    
      } else {
        DialogHelper.hideLoading();
        log("Error: ${value.data['ResponseCode']}");
      }
    });
  }

  bool isEmailValid = false;
  bool isMobileValid = false;
  bool PanValid = false;
  bool GstValid = false;
  dynamic imageData = "";
    dynamic   imageData3 = "";

  File? image;
  File? image2;
  File? image1;
    File? uploadimageowner;
  File? image3;
    File? image5;
  dynamic imageData1 = "";

  void registerShopValidation(context) {
    if (shopNameController.text.isEmpty) {
      Utils().validationTostmassage("Please Enter Shop Name");
    } else if (dealerNameController.text.isEmpty) {
      Utils().validationTostmassage("Please Enter Dealer Name");
    } else if (AddressofShopController.text.isEmpty) {
      Utils().validationTostmassage("Please Enter Address ");
    } else if (selectedState == null) {
      Utils().validationTostmassage("Please Select State ");
    } else if (selectedCity == null) {
      Utils().validationTostmassage("Please Select District ");
    } else if (selectedtaluka == null) {
      Utils().validationTostmassage("Please Select Taluka ");
    } else if (pinCodeController.text.isEmpty) {
      Utils().validationTostmassage("Please Enter Pin Code ");
    } else if (shopvillagenamecontroller.text.isEmpty) {
      Utils().validationTostmassage("Please Enter Village Name");
    } else if (fertillizerController.text.isEmpty) {
      Utils().validationTostmassage("Please Enter Fertillizer LIC No.");
    } else if (pestrcidelicNoController.text.isEmpty) {
      Utils().validationTostmassage("Please Enter Pestrcidelic LIC No.");
    } else if (seedLicNumberController.text.isEmpty) {
      Utils().validationTostmassage("Please Enter Seed LIC No.");
    } else if (validUptoController.text.isEmpty) {
      Utils().validationTostmassage("Please Enter Vaild Upto Date ");
    } else if (panNoController.text.isEmpty) {
      Utils().validationTostmassage("Please Enter PAN No.");
    } else if (PanValid == false) {
      Utils().validationTostmassage("Please Enter Valid PAN No.");
    } else if (emailController.text.isEmpty) {
      Utils().validationTostmassage("Please Enter Email Address");
    } else if (whatsappMobileNumberController.text.isEmpty) {
      Utils().validationTostmassage("Please Enter Whastsapp Mobile Number");
    } else if (isEmailValid == false) {
      Utils().validationTostmassage("Please Enter Valid Email Address");
    } else if (image == null) {
      Utils().validationTostmassage("Please Select Shop Owner Photo");
      //  shpregster(context);
    } else {
      shpregster(context);
    }
  }

  Future shpregster(context) async {
    print("user id ${selectedStateId}");
    var jason = {
      "SHOP_ID": "",
      "SHOP_NAME": shopNameController.text,
      "DEALER_NAME": dealerNameController.text,
      "SHOP_ADDRESS": AddressofShopController.text,
      "STATE_ID": selectedStateId,
      "CITY_ID": cityid,
      "TALUKA_ID": talukaId.toString(),
      "VILLAGE": shopvillagenamecontroller.text,
      "PINCODE": pinCodeController.text,
      "WHATSUP_MOBILE_NO": whatsappMobileNumberController.text,
      "EMAIL": emailController.text,
      "FETLIZER_LIC_NO": fertillizerController.text,
      "PESTISIDE_LIC_NO": pestrcidelicNoController.text,
      "SEED_LIC_NO": seedLicNumberController.text,
      "VALID_UPTO": validUptoController.text,
      "PAN_NUMBER": panNoController.text,
      "GST_NUMBER": gstNumberController.text,
      "TASK": "ADD",
      "EXTRA1": "",
      "EXTRA2": "",
      "EXTRA3": "",
      "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
      "USER_ID": AppPreference().getInt(PreferencesKey.uId),
      "LATITUDE": "",
      "LONGITUDE": "",
      "SHOP_OWNER_PHOTO": imageData.toString(),
      "SHOP_PHOTO": imageData1.toString()
    };

    DialogHelper.showLoading("Loading");
    await ApiService.instance
        .postHTTP(
            url: ApiRoutes.shopregister,
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
              "SHOP_ID": "",
              "SHOP_NAME": shopNameController.text,
              "DEALER_NAME": dealerNameController.text,
              "SHOP_ADDRESS": AddressofShopController.text,
              "STATE_ID": selectedState,
              "CITY_ID": selectedCity,
              "TALUKA_ID": selectedtaluka,
              "VILLAGE": shopvillagenamecontroller.text,
              "PINCODE": pinCodeController.text,
              "WHATSUP_MOBILE_NO": whatsappMobileNumberController.text,
              "EMAIL": emailController.text,
              "FETLIZER_LIC_NO": fertillizerController.text,
              "PESTISIDE_LIC_NO": pestrcidelicNoController.text,
              "SEED_LIC_NO": seedLicNumberController.text,
              "VALID_UPTO": validUptoController.text,
              "PAN_NUMBER": panNoController.text,
              "GST_NUMBER": gstNumberController.text,
              "TASK": "ADD",
              "EXTRA1": "",
              "EXTRA2": "",
              "EXTRA3": "",
              "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
              "USER_ID": AppPreference().getInt(PreferencesKey.uId),
              "LATITUDE": "",
              "LONGITUDE": "",
              "SHOP_OWNER_PHOTO": imageData.toString(),
              "SHOP_PHOTO": imageData1.toString()
            }))
        .then((value) async {
      log("${jason}");
      log(value.data.toString());
      if (value.data['ResponseCode'] == '0') {
        Utils().validationTostmassage("Sucsuess");
        DialogHelper.hideLoading();
        log(" shop name ${value.data['DATA1'][0]['SHOP_NAME'].toString()}");

        await AppPreference().setString(PreferencesKey.shopname,
            value.data['DATA1'][0]['SHOP_NAME'].toString());
        await AppPreference().setString(PreferencesKey.delearname,
            value.data['DATA1'][0]['DEALER_NAME'].toString());
        await AppPreference().setString(PreferencesKey.shopaddress,
            value.data['DATA1'][0]['ADDRESS'].toString());
        await AppPreference().setString(PreferencesKey.shopid,
            value.data['DATA1'][0]['STATE_ID'].toString());
        await AppPreference().setString(PreferencesKey.shopdistrictid,
            value.data['DATA1'][0]['CITY_ID'].toString());
        await AppPreference().setString(PreferencesKey.shoptalukaid,
            value.data['DATA1'][0]['TALUKA_ID'].toString());
        await AppPreference().setString(
            PreferencesKey.date, value.data['DATA1'][0]['REG_DATE'].toString());
        await AppPreference().setString(
            PreferencesKey.date, value.data['DATA1'][0]['REG_DATE'].toString());
        await AppPreference().setString(PreferencesKey.pinlcode,
            value.data['DATA1'][0]['PINCODE'].toString());
        await AppPreference().setString(PreferencesKey.shopvillage,
            value.data['DATA1'][0]['VILLAGE'].toString());
        await AppPreference().setString(PreferencesKey.contactmobilenumber,
            value.data['DATA1'][0]['CONTACT_NUMBER'].toString());
        await AppPreference().setString(PreferencesKey.shopemail,
            value.data['DATA1'][0]['EMAIL'].toString());
        await AppPreference().setString(PreferencesKey.fertillizerlicno,
            value.data['DATA1'][0]['FETLIZER_LIC_NO'].toString());
        await AppPreference().setString(PreferencesKey.PESTISIDE_LIC_NO,
            value.data['DATA1'][0]['PESTISIDE_LIC_NO'].toString());
        await AppPreference().setString(PreferencesKey.SEED_LIC_NO,
            value.data['DATA1'][0]['SEED_LIC_NO'].toString());
        await AppPreference().setString(PreferencesKey.VALID_UPTO,
            value.data['DATA1'][0]['VALID_UPTO'].toString());
        await AppPreference().setString(PreferencesKey.PAN_NUMBER,
            value.data['DATA1'][0]['PAN_NUMBER'].toString());
        await AppPreference().setString(PreferencesKey.GST_NUMBER,
            value.data['DATA1'][0]['GST_NUMBER'].toString());
        await AppPreference().setString(PreferencesKey.SHOP_OWNER_PHOTO,
            value.data['DATA1'][0]['SHOP_OWNER_PHOTO'].toString());
        await AppPreference().setString(PreferencesKey.SHOP_IMAGE,
            value.data['DATA1'][0]['SHOP_OWNER_PHOTO'].toString());

        await AppPreference().initialAppPreference();
        Navigator.pop(context);
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade, // Choose your desired animation type
            child: DealerDashboardScreen(),
          ),
        );
      } else {
        DialogHelper.hideLoading();
        log("Error: ${value.data['ResponseCode']}");
      }
    });
  }

  Future EditShopApi(context, shopid) async {
    print("user id ${selectedStateId}");

    DialogHelper.showLoading("Loading");
    await ApiService.instance
        .postHTTP(
            url: ApiRoutes.shopregister,
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
              "SHOP_ID": shopid,
              "SHOP_NAME": shopNameController.text,
              "DEALER_NAME": dealerNameController.text,
              "SHOP_ADDRESS": AddressofShopController.text,
              "STATE_ID": selectedState,
              "CITY_ID": selectedCity,
              "TALUKA_ID": selectedtaluka,
              "VILLAGE": shopvillagenamecontroller.text,
              "PINCODE": pinCodeController.text,
              "WHATSUP_MOBILE_NO": "9834705267",
              "EMAIL": emailController.text,
              "FETLIZER_LIC_NO": fertillizerController.text,
              "PESTISIDE_LIC_NO": pestrcidelicNoController.text,
              "SEED_LIC_NO": seedLicNumberController.text,
              "VALID_UPTO": validUptoController.text,
              "PAN_NUMBER": panNoController.text,
              "GST_NUMBER": gstNumberController.text,
              "TASK": "EDIT",
              "EXTRA1": "",
              "EXTRA2": "",
              "EXTRA3": "",
              "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
              "USER_ID": AppPreference().getInt(PreferencesKey.uId),
              "LATITUDE": "20.0086648",
              "LONGITUDE": "73.7638967",
              "SHOP_PHOTO": imageData.toString(),
              "SHOP_OWNER_PHOTO": imageData1.toString()
            }))
        .then((value) async {
      log(value.data.toString());
      if (value.data['ResponseCode'] == '0') {
        Utils().validationTostmassage("Sucsuess");
        DialogHelper.hideLoading();

        Navigator.pop(context);
      
      } else {
        DialogHelper.hideLoading();
        log("Error: ${value.data['ResponseCode']}");
      }
    });
  }

  Future updateLocation(context) async {
    print("user id ${selectedStateId}");

    DialogHelper.showLoading("Loading");
    await ApiService.instance
        .postHTTP(
            url: ApiRoutes.updateShop,
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
              "SHOP_ID": "",
              "LATITUDE": "20.0086789",
              "LONGITUDE": "73.7638929",
              "TASK": "EDIT",
              "EXTRA1": "",
              "EXTRA2": "",
              "EXTRA3": "",
              "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
            }))
        .then((value) async {
      log(value.data.toString());
      if (value.data['ResponseCode'] == '0') {
        Utils().validationTostmassage("Success");
        DialogHelper.hideLoading();
      } else {
        DialogHelper.hideLoading();
        log("Error: ${value.data['ResponseCode']}");
      }
    });
  }

  DelearListEmployee? delearListEmployeeModel;
  Future delerlistinformationApi() async {
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: ApiRoutes.shoplist,
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": 0,
                "END": 10000,
                "WORD": "",
                "EXTRA1": "Shop_Profile",
                "EXTRA2": "",
                "EXTRA3": "",
                "LANG_ID":AppPreference().getString(PreferencesKey.languageid),
                "USER_ID": AppPreference().getInt(PreferencesKey.uId),
                "LATITUDE": "",
                "LONGITUDE": ""
              }))
          .then((value) {
        delearListEmployeeModel = DelearListEmployee.fromJson(value.data);
        _setLoading(false);
        // delerlistinformationApi();

        log('dssssssssff---${value.data}');
      });
      return delearListEmployeeModel;
    } on DioError catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
    }
  }

  ProductLiastModel? productLiastModel;
  Future productlistApi(shopid) async {
    print('$ShopId');
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: 'http://newgrapemastersnskapi.cropmaster.in/api/ShopProduct',
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": 0,
                "END": 10000,
                "WORD": "",
                "EXTRA1": "",
                "EXTRA2": "",
                "EXTRA3": "",
                "SHOP_ID": shopid,
                "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
              }))
          .then((value) {
        productLiastModel = ProductLiastModel.fromJson(value.data);
        _setLoading(false);
        // delerlistinformationApi();
        //ShopId = productLiastModel?.DATA?[0]?.SP_ID;
        log('dssssssssff---${value.data}'); 
         if (productLiastModel?.DATA != null) {

    isOpenList = List.filled(productLiastModel!.DATA!.length, false);

} else {

      isOpenList = List.filled(productLiastModel!.DATA!.length, true);
 
  // Handle the case where DATA is null or empty
    // pve?.isOpenList = [];
    // print(pve?.isOpenList);
}
      });
      return productLiastModel;
    } on DioError catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
    }
  }

  MyLeadsModel? myLeadsModel;
  Future myleadModelApi(shopid) async {
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: ApiRoutes.productenquery,
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": 0,
                "END": 10000,
                "WORD": "",
                "EXTRA1": "",
                "EXTRA2": "",
                "EXTRA3": "",
                "SHOP_ID": shopid,
                "LANG_ID":AppPreference().getString(PreferencesKey.languageid),
              }))
          .then((value) {
        myLeadsModel = MyLeadsModel.fromJson(value.data);
        _setLoading(false);
        // delerlistinformationApi();

        //  log('dssssssssff---${bannar.length}');
      });
      return myLeadsModel;
    } on DioError catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
    }
  }
}

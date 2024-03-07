import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grape_master/model/quzie_result_model.dart';
import 'package:grape_master/screens/auth/login.dart';
import 'package:grape_master/util/color.dart';
import 'package:grape_master/util/constants.dart';
import 'package:grape_master/util/image_assets.dart';
import 'package:grape_master/util/util.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/home_model/blog_model.dart';
import '../../model/home_model/near_by_shop.model.dart';
import '../../model/home_model/notification_model.dart';
import '../../model/home_model/plot_model.dart';
import '../../model/home_model/product_list_model.dart';
import '../../model/home_model/quize_model_list.dart';
import '../../model/home_model/version_code_model.dart';
import '../../model/home_model/wether_model.dart';
import '../../network/api_constants.dart';
import '../../services/api_service.dart';
import '../../util/dialog_helper.dart';
import '../../util/prefs/PreferencesKey.dart';
import '../../util/prefs/app_preference.dart';
import '../auth/LocalString.dart';
import '../registerplot/register_the_plot.dart';

class HomeController extends ChangeNotifier {
  bool _isLoading = false;
  bool get value => _isLoading;
  bool connections = false;
  void _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  int? shopId;

  List<Map<String, String>> items = [
    {
      'id': "1",
      'name': "Blogs",
      'image': ImageAssets.ic_blogs,
    },
    {
      'id': "2",
      'name': "Nere by shop",
      'image': "assets/images/beerbottal.png",
    },
  ];

  List<Map<String, String>> data = [
    {
      'id': "1",
      'name': "Call",
      'image': ImageAssets.ic_phone1,
    },
    {
      'id': "2",
      'name': "Whatsapp",
      'image': ImageAssets.ic_whatsapp,
    },
    {
      'id': "3",
      'name': "Map",
      'image': ImageAssets.ic_google_icon,
    },
  ];

  void openMap(lat, long) async {
    // Replace the latitude and longitude with the desired location

    // Create a map link using the appropriate scheme
    String mapUrl = 'https://www.google.com/maps?q=$lat,$long';

    // Check if the map link can be launched
    if (await canLaunch(mapUrl)) {
      await launch(mapUrl);
    } else {
      throw 'Could not launch map';
    }
  }

  callNumber(moblenumber) async {
    //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(moblenumber);
  }

  void openWhatsApp(number) async {
    final message = ''; // Replace with your message

    final whatsappUrl = "https://wa.me/$number/?text=${Uri.parse(message)}";

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      // Handle error, e.g., show an error message.
      print('Error launching WhatsApp.');
    }
  }

  MaywetherforcastingModel? watherModel;
  Future wetherforcasting() async {
   // log('${ApiRoutes.quizelist}');
    _setLoading(true);
    try {
      await ApiService.instance.get(
          "http://api.weatherapi.com/v1/forecast.json?",
          queryParameters: {
            "key": "581836bdc25a4f3b846104040221807",
            "q": "Nasik",
            "days": "8",
            "aqi": "no",
            "alerts": "no"
          }).then((value) {
            print(value.data);
        watherModel = MaywetherforcastingModel.fromJson(value.data);
 // int temperatureInCelsius = watherModel!.current.tempC.toInt();
       print("--------------------------wether${watherModel!.current?.feelslike_c.toString()}----------------------------");
        _setLoading(false);
      });
      return watherModel;
    } on Exception catch (e) {
      print("object ${e.toString()}");

      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

  BlogListModel? blogmodel;

  Future blogapi() async {
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: ApiRoutes.blog,
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": 0,
                "END": 10000,
                "WORD": "",
                "EXTRA1": "",
                "EXTRA2": "",
                "EXTRA3": "",
                "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
                "USER_ID": AppPreference().getInt(PreferencesKey.uId),
              }))
          .then((value) {
        blogmodel = BlogListModel.fromJson(value.data);
        _setLoading(false);

        //log('dssssssssff---${value.data}');
      });
      return blogmodel;
    } on Exception catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

  PlotRagisterModel? plotmodel;

  Future plotapi(context) async {
    log('${ApiRoutes.plot}');
    log('${AppPreference().getInt(PreferencesKey.uId)}');
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: ApiRoutes.plot,
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": 0,
                "END": "1000",
                "WORD": "",
                "EXTRA1": "",
                "EXTRA2": "",
                "EXTRA3": "",
                "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
                "USER_ID": AppPreference().getInt(PreferencesKey.uId),
              }))
          .then((value) {
          plotmodel?.DATA?.clear();
        plotmodel = PlotRagisterModel.fromJson(value.data);
        if (plotmodel?.DATA!.length == 0) {
      
          Utils.popmsggape(context);
        }

        _setLoading(false);
          

     //   log('dssssssssff---${value.data}');
      });
      return plotmodel;
    } on Exception catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

  NotificationModel? notificationModel;
  String? countnotification;
  Future notification(context) async {
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: ApiRoutes.notification,
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": 0,
                "END": 100,
                "WORD": "",
                "EXTRA1": "",
                "EXTRA2": "",
                "EXTRA3": "",
                "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
                "USER_ID": AppPreference().getInt(PreferencesKey.uId),
                "TOKEN": ""
              }))
          .then((value) {
        notificationModel = NotificationModel.fromJson(value.data);
        //     if(plotmodel?.DATA!.length == 0 ){
        //  popmsggape(context);
        //     }

        countnotification = notificationModel?.data[0].unseenCount.toString();
       // log("${value}");

        _setLoading(false);

        //log('dssssssssff---${value.data}');
      });
      return notificationModel;
    } on Exception catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

  Future deleteNotification(context, notificationid) async {
    await ApiService.instance
        .postHTTP(
            url:
                'http://newgrapemastersnskapi.cropmaster.in/api/Notification/1',
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
              "USER_ID": AppPreference().getInt(PreferencesKey.uId),
              "NOTIFICATION_ID": notificationid.toString(),
              "TASK": "NOTE_DELETE",
              "EXTRA1": "",
              "EXTRA2": "",
              "EXTRA3": "",
              "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
            }))
        .then((value) async {
      log(value.data.toString());
      if (value.data['ResponseCode'] == '0') {
        Navigator.pop(context);

        //  Utils().validationTostmassage("Successfully Sending Enquiry");
        notification(context);
      } else {
        log("Error: ${value.data['ResponseCode']}");
      }
    });
  }

  Future postLikeUnlike(
    context,
    postid
  ) async {
    await ApiService.instance
        .postHTTP(
            url:
                'http://newgrapemastersnskapi.cropmaster.in/api/PostCommentLike',
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
              "USER_ID": AppPreference().getInt(PreferencesKey.uId),
              "POST_ID":postid,
              "TASK": "ADD",
              "REMARK": "",
              "EXTRA1": "",
              "EXTRA2": "",
              "EXTRA3": "",
              "LANG_ID":AppPreference().getString(PreferencesKey.languageid),
              "TYPE": "Like"
            }))
        .then((value) async {
      log(value.data.toString());
      if (value.data['ResponseCode'] == '0') {
       blogapi();

        //  Utils().validationTostmassage("Successfully Sending Enquiry");
        //notification(context);
      } else {
        log("Error: ${value.data['ResponseCode']}");
         blogapi();
      }
    });
  }

  Future noteViewApi(context, notificationid) async {
    await ApiService.instance
        .postHTTP(
            url:
                'http://newgrapemastersnskapi.cropmaster.in/api/Notification/1',
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
              "USER_ID": AppPreference().getInt(PreferencesKey.uId),
              "NOTIFICATION_ID": notificationid.toString(),
              "TASK": "NOTE_VIEW",
              "EXTRA1": "",
              "EXTRA2": "",
              "EXTRA3": "",
              "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
            }))
        .then((value) async {
      log(value.data.toString());
      if (value.data['ResponseCode'] == '0') {
        //  Utils().validationTostmassage("Successfully Sending Enquiry");
        notification(context);
      } else {
        log("Error: ${value.data['ResponseCode']}");
      }
    });
  }

  Future likeunlikenotification(context, notificationid) async {
    await ApiService.instance
        .postHTTP(
            url:
                'http://newgrapemastersnskapi.cropmaster.in/api/Notification/1',
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
              "USER_ID": AppPreference().getInt(PreferencesKey.uId),
              "NOTIFICATION_ID": notificationid.toString(),
              "TASK": "NOTE_LIKE",
              "EXTRA1": "",
              "EXTRA2": "",
              "EXTRA3": "",
              "LANG_ID": AppPreference().getInt(PreferencesKey.uId),
            }))
        .then((value) async {
      log(value.data.toString());
      if (value.data['ResponseCode'] == '0') {
        // Navigator.pop(context);

        //  Utils().validationTostmassage("Successfully Sending Enquiry");
        notification(context);
      } else {
        log("Error: ${value.data['ResponseCode']}");
      }
    });
  }

  NearByShopModel? shopnearbyyou;

  Future shopnearapi() async {
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: ApiRoutes.shop,
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": 0,
                "END": 10000,
                "WORD": "",
                "EXTRA1": "Dealer",
                "EXTRA2": "",
                "EXTRA3": "",
                "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
                "USER_ID": AppPreference().getInt(PreferencesKey.uId),
                "LATITUDE": "20.0086703",
                "LONGITUDE": "73.7639098",
              }))
          .then((value) {
        shopnearbyyou = NearByShopModel.fromJson(value.data);
        _setLoading(false);

        log('dssssssssff---${value.data}');
      });
      return shopnearbyyou;
    } on Exception catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

  ProductListModel? productListmodel;

  Future ProductListApi() async {
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: ApiRoutes.shoproduct,
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": 0,
                "END": 10000,
                "WORD": "",
                "EXTRA1": "",
                "EXTRA2": "",
                "EXTRA3": "",
                "SHOP_ID": shopId,
                "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
              }))
          .then((value) {
        productListmodel = ProductListModel.fromJson(value.data);
        _setLoading(false);

        log('dssssssssff---${shopId}');
      });
      return productListmodel;
    } on Exception catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

  String? delerStutus;

  VersionCodeModel? versionCodeModel;
  Future versionCodeApi() async {
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: ApiRoutes.getdata,
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": "",
                "END": "",
                "WORD": "",
                "GET_DATA": "Get_Version",
                "ID1": AppPreference().getInt(PreferencesKey.uId),
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
        versionCodeModel = VersionCodeModel.fromJson(value.data);
        _setLoading(false);

        delerStutus = versionCodeModel?.data[0].dealerStatus;
        log('dssssssssff---${delerStutus}');
      });
      return versionCodeModel;
    } on Exception catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

  QuizeModelLIstMode? quizeModelLIst;
  Future quizeapi() async {
    log(' dddd${ApiRoutes.quizelist}');
    _setLoading(true);
    try {
      var data = { 
        "START": 0,
                "END": 10000,
                "WORD": "",
                "EXTRA1": "",
                "EXTRA2": "",
                "EXTRA3": "",
                "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
                "USER_ID": AppPreference().getInt(PreferencesKey.uId),
      };
      log("$data");
      
            await ApiService.instance 

          .postHTTP(
              url: ApiRoutes.quizelist,
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": 0,
                "END": 10000,
                "WORD": "",
                "EXTRA1": "",
                "EXTRA2": "",
                "EXTRA3": "",
                "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
                "USER_ID": AppPreference().getInt(PreferencesKey.uId),
              }))
          .then((value) {
            quizeModelLIst?.DATA?.clear();
        quizeModelLIst = QuizeModelLIstMode.fromJson(value.data);
      //  log("${value.data}");
        _setLoading(false);
      });
      return quizeModelLIst;
    } on Exception catch (e) {
      print("object ${e.toString()}");

      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

  // Future enquirey(BuildContext context) async {

  //   try {
  //     await EnquireyApi(context);
  //   } catch (e, stackTrace) {
  //     log(stackTrace.toString());
  //     log('$e  rfgrtgytt');
  //     DialogHelper.hideLoading();
  //   }
  // }

  QuizeResultModel? resultModel;
  Future resultquizeapi() async {
    log('${ApiRoutes.quizelist}');
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: 'http://newgrapemastersnskapi.cropmaster.in/api/QuizResult',
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": 0,
                "END": 10000,
                "WORD": "",
                "EXTRA1": "",
                "EXTRA2": "",
                "EXTRA3": "",
                "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
                "USER_ID": AppPreference().getInt(PreferencesKey.uId),
              }))
          .then((value) {
          resultModel?.DATA?.clear();
        resultModel = QuizeResultModel.fromJson(value.data);
        log("${value.data}");
        _setLoading(false);
      });
      return resultModel;
    } on Exception catch (e) {
      print("object ${e.toString()}");

      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

  Future wether() async {
    log('${ApiRoutes.quizelist}');
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: 'http://newgrapemastersnskapi.cropmaster.in/api/QuizResult',
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": 0,
                "END": 10000,
                "WORD": "",
                "EXTRA1": "",
                "EXTRA2": "",
                "EXTRA3": "",
                "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
                "USER_ID": AppPreference().getInt(PreferencesKey.uId),
              }))
          .then((value) {
        resultModel = QuizeResultModel.fromJson(value.data);
        log("${value.data}");
        _setLoading(false);
      });
      return resultModel;
    } on Exception catch (e) {
      print("object ${e.toString()}");

      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

  Future postquize(
    context,
    fo_id,
    foodid,
  ) async {
    print(foodid);
    //DialogHelper.showLoading("Loading");

    await ApiService.instance
        .postHTTP(
            url:
                'http://newgrapemastersnskapi.cropmaster.in/api/FarmerOpeniun/1',
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
              "EXTRA1": "16",
              "EXTRA2": "",
              "EXTRA3": "",
              "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
              "USER_ID": AppPreference().getInt(PreferencesKey.uId),
              "TASK": "ADD",
              "FOO_ID": foodid.toString(),
              "WORD": "",
              "FO_ID": fo_id
            }))
        .then((value) async {
      log(value.data.toString());
      if (value.data['ResponseCode'] == '0') {
       // DialogHelper.hideLoading();

        // Utils().validationTostmassage("Successfully Sending Enquiry");
        quizeapi();
      } else {
        DialogHelper.hideLoading();
        log("Error: ${value.data['ResponseCode']}");
      }
    });
  }

  Future EnquireyApi(
    context,
    productId,
    shopid,
  ) async {
    DialogHelper.showLoading("Loading");
    log(" product id ${shopid.toString()}");
    await ApiService.instance
        .postHTTP(
            url: ApiRoutes.productenquiry,
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
              "SHOP_ID": shopid,
              "PRODUCT_ID": productId,
              "USER_ID": AppPreference().getInt(PreferencesKey.uId),
              "REMARK": "",
              "TASK": " ",
              "EXTRA1": "",
              "EXTRA2": "",
              "EXTRA3": "",
              "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
            }))
        .then((value) async {
      log(value.data.toString());
      if (value.data['ResponseCode'] == '0') {
        DialogHelper.hideLoading();
        Navigator.pop(context);
        Utils().validationTostmassage("Successfully Sending Enquiry");
        // Navigator.push(
        //   context,
        //   PageTransition(
        //     type: PageTransitionType.fade, // Choose your desired animation type
        //     child: OtPScreen(),
        //   ),
        // );
      } else {
        DialogHelper.hideLoading();
        log("Error: ${value.data['ResponseCode']}");
      }
    });
  }
}

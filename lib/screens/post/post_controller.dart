import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/auth/LocalString.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';

import '../../model/post_models/add_post_model.dart';
import '../../model/post_models/comment_list_post.dart';
import '../../model/post_models/my_post_model.dart';
import '../../model/post_models/post_model.dart';
import '../../network/api_constants.dart';
import '../../services/api_service.dart';
import '../../util/dialog_helper.dart';
import '../../util/prefs/PreferencesKey.dart';
import '../../util/prefs/app_preference.dart';
import '../../util/util.dart';
import '../auth/otp_screen.dart';

class postCnt extends ChangeNotifier {
  bool _isLoading = false;
  bool get value => _isLoading;
  bool connections = false;
  void _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  String? PostId;
  TextEditingController commentController = TextEditingController(text: "");
  TextEditingController cropController = TextEditingController(text: "");
  TextEditingController discriptionController = TextEditingController(text: "");

  List<Map<String, String>> items = [
    {
      'id': "1",
      'name': "Tamoto",
      'image':
          "https://images.pexels.com/photos/400958/pexels-photo-400958.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    },
    {
      'id': "2",
      'name': " Green Peas",
      'image':
          "https://images.pexels.com/photos/255469/pexels-photo-255469.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    },
    {
      'id': "3",
      'name': "Orange Carrots",
      'image':
          "https://images.pexels.com/photos/1306559/pexels-photo-1306559.jpeg",
    },
    {
      'id': "4",
      'name': "fingers Lot",
      'image':
          "https://images.pexels.com/photos/2583187/pexels-photo-2583187.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    },
    {
      'id': "5",
      'name': "fingers Lot",
      'image':
          "https://images.pexels.com/photos/2583187/pexels-photo-2583187.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    },
    {
      'id': "5",
      'name': "fingers Lot",
      'image':
          "https://images.pexels.com/photos/2583187/pexels-photo-2583187.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    },
    {
      'id': "6",
      'name': "fingers Lot",
      'image':
          "https://images.pexels.com/photos/2583187/pexels-photo-2583187.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    },
    {
      'id': "7",
      'name': "Kothimbir ",
      'image':
          "https://images.pexels.com/photos/60560/parsley-seasoning-greens-salad-60560.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    },
  ];

  List<Map<String, String>> videositems = [
    {
      'id': "1",
      'name': "द्राक्ष बाग जास्त सेटिंग / लोड नियोजन ||",
      'image':
          "https://dm0qx8t0i9gc9.cloudfront.net/thumbnails/video/TOEwt0C/videoblocks-rural-australia-crop-farming-agricultural-landscape-aerial-drone-shot_ra9uykryx_thumbnail-1080_01.png",
    },
    {
      'id': "2",
      'name': "यावर्षी द्राक्ष बागेत शेंड्य समस्या येत आहे ...!",
      'image':
          "https://2.bp.blogspot.com/-pLLWS1j5PCQ/VqyQUTUqtdI/AAAAAAABE64/QYlUh6421co/s1600/2de5113b6a62d0360130b90442106237_large.jpeg",
    },
    {
      'id': "3",
      'name': "यावर्षी द्राक्षबागेत शेंड्याची समस्या येत आहे ||",
      'image':
          "https://th.bing.com/th/id/OIP.Ng2p2KtYu4j9ufKjkjstywHaEQ?rs=1&pid=ImgDetMain",
    },
    {
      'id': "4",
      'name': "यावर्षी टायलिसी समस्या ये शकते...!",
      'image':
          "https://e1.pxfuel.com/desktop-wallpaper/175/288/desktop-wallpaper-best-4-agriculture-backgrounds-on-hip-agriculture.jpg",
    },
  ];

  PostModel? postmodel;
  late int pageNumber;
  late bool error;
  late bool loading;
  final int numberOfPostsPerRequest = 10;
  late List<PostModel> posts;
  late bool isLastPage;
  final int nextPageTrigger = 3;
  File? image1;
  int? cropID;
  dynamic imageData = "";
  Future PickImageImag(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      imageData = base64Encode(imageTemporary.readAsBytesSync());

      image1 = imageTemporary;
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  }

  Future postlistApi() async {
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: "http://newgrapemastersnskapi.cropmaster.in/api/FarmerPost",
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
                "CROP_ID": ""
              }))
          .then((value) {
        postmodel = PostModel.fromJson(value.data);
        _setLoading(false);

        log('dssssssssff---${value.data}');
      });
      return postmodel;
    } on Exception catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

 

   Future addlikepost(context, postid) async {
    log("${imageData}");

    log(" distance print ");
    //DialogHelper.showLoading("Loading");
    await ApiService.instance
        .postHTTP(
            url: ApiRoutes.likepost,
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
               "USER_ID": AppPreference().getInt(PreferencesKey.uId),
                "POST_ID": postid,
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
        DialogHelper.hideLoading();
        //cropController.clear();
        //discriptionController.clear();
      Utils().validationTostmassage("Like");
        // Navigator.push(
        //   context,
        //   PageTransition(
        //     type: PageTransitionType.fade, // Choose your desired animation type
        //     child: MyHomePage(),
        //   ),
        // );
        // Navigator.of(conte
        // xt).pop();
        myPostPostcropApi();
        postlistApi();
          myPostPostcropApi();
        // myPostPostcropApi();
        
      } else {
           postlistApi();
             myPostPostcropApi();
        //DialogHelper.hideLoading();
        log("Error: ${value.data['ResponseCode']}");
      }
    });
  } 

  Future unlikeaddlikepost(context, postid) async {
    log("${imageData}");

    log(" distance print ");
    //DialogHelper.showLoading("Loading");
    await ApiService.instance
        .postHTTP(
            url: ApiRoutes.likepost,
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
               "USER_ID": AppPreference().getInt(PreferencesKey.uId),
                "POST_ID": postid,
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
        DialogHelper.hideLoading();
        //cropController.clear();
        //discriptionController.clear();
      Utils().validationTostmassage("Like");
         postlistApi();
            myPostPostcropApi();
        // Navigator.push(
        //   context,
        //   PageTransition(
        //     type: PageTransitionType.fade, // Choose your desired animation type
        //     child: MyHomePage(),
        //   ),
        // );
        //+ Navigator.of(context).pop();
     
        // myPostPostcropApi();
        
      } else if(value.data['ResponseCode'] == '0') {
        postlistApi();
           myPostPostcropApi();
        //DialogHelper.hideLoading();
        log("hello: ${value.data['ResponseCode']}");
          
      }
    });
  }

  CommentListModel? commentlist;

  Future commentlistApi(posid) async {
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: ApiRoutes.comment,
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": 0,
                "END": 100000,
                "WORD": "",
                "EXTRA1": "",
                "EXTRA2": "",
                "EXTRA3": "",
                "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
                "POST_ID": posid
              }))
          .then((value) {
        commentlist = CommentListModel.fromJson(value.data);
        _setLoading(false);

        log('dssssssssff---${value.data}');
      });
      return commentlist;
    } on Exception catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

  Future postcomment(context) async {
    log("${PostId}");
    DialogHelper.showLoading("Loading");
    await ApiService.instance
        .postHTTP(
            url: ApiRoutes.postcomment,
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
              "USER_ID": AppPreference().getInt(PreferencesKey.uId),
              "POST_ID": PostId.toString(),
              "REMARK": commentController.text,
              "TASK": "ADD",
              "EXTRA1": "",
              "EXTRA2": "",
              "EXTRA3": "",
              "LANG_ID": "",
              "TYPE": "COMMENT"
            }))
        .then((value) async {
      log(value.data.toString());
      if (value.data['ResponseCode'] == '0') {
        DialogHelper.hideLoading();
        commentlistApi(PostId);
        commentController.clear();

        postlistApi();
      } else {
        DialogHelper.hideLoading();
        log("Error: ${value.data['ResponseCode']}");
      }
    });
  }

  AddPostCropModel? addPostCropModel;
  String? cropSelected;
  Future addPostcropApi() async {
    log("${ApiRoutes.getdata}");
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
                "GET_DATA": "Get_Crop",
                "ID1": "",
                "ID2": "",
                "ID3": "",
                "STATUS": "",
                "START_DATE": "",
                "END_DATE": "",
                "EXTRA1": "",
                "EXTRA2": "",
                "EXTRA3": "",
                "LANG_ID": AppPreference().getString(PreferencesKey.languageid)
              }))
          .then((value) {
        addPostCropModel = AddPostCropModel.fromJson(value.data);
        _setLoading(false);

        log('dssssssssff---${value.data}');
      });
      return addPostCropModel;
    } on Exception catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

  Future rigstar(BuildContext context) async {
    try {
      if (cropSelected == null) {
        //Utils.showFlushbar("Cropid", context);
      } else if (discriptionController.text.isEmpty) {
        Utils().validationTostmassage(
          description.tr,
        );
      } else if (imageData == "") {
        Utils().validationTostmassage(txt_photo.tr);
      } else {
        await plotRagister(context);
      }
    } catch (e, stackTrace) {
      log(stackTrace.toString());
      log('$e  rfgrtgytt');
      DialogHelper.hideLoading();
    }
  }

  Future plotRagister(context) async {
    log("${imageData}");

    log(" distance print ");
    DialogHelper.showLoading("Loading");
    await ApiService.instance
        .postHTTP(
            url: ApiRoutes.addpostfarmer,
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
              "USER_ID": AppPreference().getInt(PreferencesKey.uId),
              "CROP_ID": cropSelected,
              "POST_TITLE": "",
              "POST_DESCRIPTION": discriptionController.text,
              "TASK": "ADD",
              "EXTRA1": "",
              "EXTRA2": "",
              "EXTRA3": "",
              "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
              "POST_IMAGE": imageData.toString()
            }))
        .then((value) async {
      log(value.data.toString());
      if (value.data['ResponseCode'] == '0') {
        DialogHelper.hideLoading();
        cropController.clear();
        discriptionController.clear();

        // Navigator.push(
        //   context,
        //   PageTransition(
        //     type: PageTransitionType.fade, // Choose your desired animation type
        //     child: MyHomePage(),
        //   ),
        // );
        Navigator.of(context).pop();
        postlistApi();
      } else {
        DialogHelper.hideLoading();
        log("Error: ${value.data['ResponseCode']}");
      }
    });
  }

  Future editpost(context, postid) async {
    log("${imageData}");

    log(" distance print ");
    DialogHelper.showLoading("Loading");
    await ApiService.instance
        .postHTTP(
            url: "http://newgrapemastersnskapi.cropmaster.in/api/FarmerPost/1",
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
              "USER_ID": AppPreference().getInt(PreferencesKey.uId),
              "CROP_ID": cropSelected,
              "POST_TITLE": "",
              "POST_DESCRIPTION": discriptionController.text,
              "TASK": "EDIT",
              "EXTRA1": postid,
              "EXTRA2": "",
              "EXTRA3": "",
              "LANG_ID": "1",
              "POST_IMAGE": imageData.toString()
            }))
        .then((value) async {
      log(value.data.toString());
      if (value.data['ResponseCode'] == '0') {
        DialogHelper.hideLoading();
        cropController.clear();
        discriptionController.clear();
        await addPostcropApi();
        Utils().validationTostmassage(successfullyupdatedpost.tr);

        // Navigator.push(
        //   context,
        //   PageTransition(
        //     type: PageTransitionType.fade, // Choose your desired animation type
        //     child: MyHomePage(),
        //   ),
        // );
        Navigator.of(context).pop();
        postlistApi();
      } else {
        DialogHelper.hideLoading();
        log("Error: ${value.data['ResponseCode']}");
      }
    });
  }

  Future delatePost(context, cropid) async {
    log("${PostId}");

    log(" distance print ");
    DialogHelper.showLoading("Loading");
    await ApiService.instance
        .postHTTP(
            url: ApiRoutes.addpostfarmer,
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
              "USER_ID": AppPreference().getInt(PreferencesKey.uId),
              "CROP_ID": cropid,
              "POST_TITLE": "",
              "POST_DESCRIPTION": discriptionController.text,
              "TASK": "DELETE",
              "EXTRA1": PostId.toString(),
              "EXTRA2": "",
              "EXTRA3": "",
              "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
              "POST_IMAGE": imageData.toString()
            }))
        .then((value) async {
      log(value.data.toString());
      if (value.data['ResponseCode'] == '0') {
        Navigator.pop(context);
        DialogHelper.hideLoading();
        myPostPostcropApi();
        // Navigator.push(
        //   context,
        //   PageTransition(
        //     type: PageTransitionType.fade, // Choose your desired animation type
        //     child: MyHomePage(),
        //   ),
        // );
        // Navigator.of(context).pop();
        myPostPostcropApi();
        postlistApi();
      } else {
        DialogHelper.hideLoading();
        log("Error: ${value.data['ResponseCode']}");
      }
    });
  }

  PostModel? mypost;

  Future myPostPostcropApi() async {
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: "http://newgrapemastersnskapi.cropmaster.in/api/FarmerPost",
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": 0,
                "END": 10000,
                "WORD": "",
                "EXTRA1": AppPreference().getInt(PreferencesKey.uId),
                "EXTRA2": "",
                "EXTRA3": "",
                "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
                "USER_ID": AppPreference().getInt(PreferencesKey.uId),
                "CROP_ID": ""
              }))
          .then((value) {
        mypost = PostModel.fromJson(value.data);
        _setLoading(false);

        log('dssssssssff---${value.data}');
      });
      return mypost;
    } on Exception catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }
}

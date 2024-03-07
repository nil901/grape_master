import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grape_master/util/prefs/PreferencesKey.dart';
import 'package:grape_master/util/prefs/app_preference.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/video_models/sesstion_model.dart';
import '../../model/video_models/video_caogry_model.dart';
import '../../network/api_constants.dart';
import '../../services/api_service.dart';
import '../../model/video_models/video_llink_list.dart';

class Videocnt extends ChangeNotifier {
  bool _isLoading = false;
  bool get value => _isLoading;
  bool connections = false;
  void _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  void openurl(url) async {
    // Replace the latitude and longitude with the desired location

    // Create a map link using the appropriate scheme
    String mapUrl = url;

    // Check if the map link can be launched
    if (await canLaunch(mapUrl)) {
      await launch(mapUrl);
    } else {
      throw 'Could not launch map';
    }
  }

  SesstionModel? sesstionModel;

  Future sesstionApi() async {
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: ApiRoutes.videobannar,
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": 0,
                "END": 10000,
                "WORD": "",
                "EXTRA1": "",
                "EXTRA2": "",
                "EXTRA3": "",
                "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
                "USER_ID": "",
                "CROP_ID": "",
                "TASK": "Live",
                "TYPE": "Live"
              }))
          .then((value) {
        sesstionModel = SesstionModel.fromJson(value.data);
        _setLoading(false);

        log('dssssssssff---${value.data}');
      });
      return sesstionModel;
    } on Exception catch (e) {
      print("object ${e.toString()}");

      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

  VideoCategoreyModel? videoCategoreyModel;

  Future videoCateogeyApi() async {
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: ApiRoutes.getdata,
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": 0,
                "END": 1000,
                "WORD": "",
                "GET_DATA": "Video_Category",
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
        videoCategoreyModel = VideoCategoreyModel.fromJson(value.data);
        _setLoading(false);
      video(videoCategoreyModel?.data[0].vcId);
        log('dssssssssff---${value.data}');
      });
      return videoCategoreyModel;
    } on Exception catch (e) {
      print("object ${e.toString()}");
      rethrow;
    } on Exception {
      _setLoading(false);
      rethrow;
      _setLoading(false);
    }
  }

  VideoListLinkModel? videoListLinkModel;

  Future video(cropid) async {
    _setLoading(true);
    try {
      await ApiService.instance
          .postHTTP(
              url: 'http://newgrapemastersnskapi.cropmaster.in/api/VideoAudio',
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: json.encode({
                "START": 0,
                "END": "10000",
                "WORD": "",
                "EXTRA1":cropid,
                "EXTRA2": "",
                "EXTRA3": "",
                "LANG_ID": AppPreference().getString(PreferencesKey.languageid),
                "USER_ID": "",
                "CROP_ID":cropid,
                "TASK": "Old",
                "TYPE": "Video"
              }))
          .then((value) {
        videoListLinkModel = VideoListLinkModel.fromJson(value.data);
        _setLoading(false);

        log('dssssssssff---${value.data}');
      });
      return videoListLinkModel;
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

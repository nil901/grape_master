import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/auth/LocalString.dart';

import 'color.dart';
import 'constants.dart';
import 'image_assets.dart';

class DialogHelper {
  static void showLoading([String message = ""]) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 1,
        insetPadding: EdgeInsets.symmetric(horizontal: 90),
        child: Container(
          height: 195,
          decoration: BoxDecoration(
            color: kwhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              h10,
              Container(
                height: 100,
                width: 90,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(ImageAssets.ic_logo),
                  ),
                ),
              ),
              h10,
              CircularProgressIndicator(
                color: kgreen,
                strokeWidth: 5,
              ),
              h10,
              Text(
               text_loading.tr,
                style: TextStyle(
                  color: kblack,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              h5
            ],
          ),
        ),
      ),
      transitionDuration: Duration(milliseconds: 500),
      barrierDismissible: false,
    );
  }

  static void hideLoading() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }
}

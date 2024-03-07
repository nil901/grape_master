import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/auth/LocalString.dart';
import 'package:grape_master/util/image_assets.dart';

import 'color.dart';

class NoActivityFound extends StatelessWidget {
  const NoActivityFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ImageAssets.ic_no_data_found,height: 90,),
          
         // Text(text_data_not_found.tr,style: TextStyle(color: kblack, fontWeight: FontWeight.bold, fontSize: 20),),
        ],
      );
  }
}
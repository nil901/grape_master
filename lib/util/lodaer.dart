import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/auth/LocalString.dart';

import 'color.dart';
import 'constants.dart';
import 'image_assets.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column( 
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [ 
            Center(child: Image.asset(ImageAssets.ic_logo,height: 100,)),
            CircularProgressIndicator(color: kgreen,),
            h10,
            Text(text_loading.tr)
          ],
        );
  }
}
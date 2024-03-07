import 'package:flutter/material.dart';
import 'package:grape_master/util/image_assets.dart';

class Aduio_screen extends StatelessWidget {
  const Aduio_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: Center(  
      child: Image.asset(ImageAssets.ic_no_data_found,height: 90,),
      ),
    );
  }
}
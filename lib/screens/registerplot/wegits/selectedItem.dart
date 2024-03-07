
import 'package:flutter/material.dart';

import '../../../util/color.dart';
import '../../../util/constants.dart';

class SelectedItems extends StatelessWidget {
  
  const SelectedItems({super.key, this.name, this.image, required this.bgColor, this.id});
  final name; 
  final image; 
  final Color bgColor;
  final id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Material(
        elevation: 3,
         borderRadius: BorderRadius.circular(5),
        child: Container( 
          height: 120,
          width: 160,
          decoration: BoxDecoration( 
            color: id =="1" || id =="4" ||id =="5"||id =="8"? kplotblue :id =="7" ? kdeeporange:kplotlime, 
            borderRadius: BorderRadius.circular(5)
          ),
          child: Column(  
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [ 
              Image.asset(image,height: 60,),
              h10,
              Text("${name}",style: TextStyle(color: ktext,fontWeight: FontWeight.w500,fontSize: 15),)
            ],
          ),
        ),
      ),
    );
  }
}
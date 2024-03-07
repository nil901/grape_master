import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/registerplot/plot_wegits/my_plot.dart/update_plot.dart';
import 'package:grape_master/util/constants.dart';
import 'package:grape_master/util/image_assets.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../model/home_model/plot_model.dart';
import '../../../../util/color.dart';
import '../../../auth/LocalString.dart';

class MyPlotScreen extends StatelessWidget {
  const MyPlotScreen({super.key, required this.plotdetails});
  final PlotRagisterModelDATA plotdetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kgreen,
          title: Text(
          txt_my_plot.tr,
            style: TextStyle(
                color: kwhite, fontWeight: FontWeight.w400, fontSize: 22),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              h10,
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: (){
                        Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade, // Choose your desired animation type
                child:UpdatePlot(plotdetails:plotdetails),
              ),
            );
                  },
                  child: Container(
                    height: 35,
                    width: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20), color: kgreen),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        w10,
                        h10,
                        Center(
                          child: Text(
                          txt_my_plot.tr,
                            style: TextStyle(
                                color: kwhite,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        w10,
                        Center(
                          child: Image.asset(
                            ImageAssets.ic_pen,
                            height: 22,
                            color: kwhite,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              h10,
             ExpandedClass(title: txt_crop_name.tr,name: plotdetails.CROP_NAME== 'null'?'-':plotdetails.CROP_NAME.toString()),
             h18,
             ExpandedClass(title: txt_crop_variaty.tr,name: plotdetails.V_NAME == 'null'?'-':plotdetails.V_NAME.toString(),),
               h18,
             ExpandedClass(title: txt_lagvadiche_prakar.tr,name: plotdetails.CHATANI_TYPE == 'null'? "-" : plotdetails.CHATANI_TYPE.toString(),),
               h18,
             ExpandedClass(title: txt_lagvadichitarikh.tr,name: plotdetails.SOWING_DATE == 'null'? '-': plotdetails.SOWING_DATE.toString()),
                h18,
             ExpandedClass(title: txt_soil_type.tr,name: plotdetails.ST_NAME== 'null'? '-':plotdetails.ST_NAME.toString()),
               h18,
                ExpandedClass(title: txt_irrigation.tr,name: plotdetails.WATER_SOURCE == 'null'?'-':plotdetails.WATER_SOURCE.toString(),),
            //      h18,
            //  ExpandedClass(title: txt_method_of_watering.tr,name: plotdetails.METHOD_OF_WATER == 'null'?'-':plotdetails.METHOD_OF_WATER.toString(),),
                 h18,
             ExpandedClass(title: txt_structure.tr,name: plotdetails.PLOT_SRUCTURE == null? '-':plotdetails.PLOT_SRUCTURE.toString()),
                 h18,
             ExpandedClass(title: txt_method_of_watering.tr,name: plotdetails.METHOD_OF_WATER == 'null'? '-':plotdetails.METHOD_OF_WATER.toString()),
              h18,
               ExpandedClass(title:txt_lagvad_padhat.tr,name: plotdetails.CULTIVATION_TYPE == 'null' ? '-':plotdetails.CULTIVATION_TYPE.toString()),
                h18,
               ExpandedClass(title: crop_distance.tr,name: plotdetails.CROP_DISTANCE == 'null' ? '-':plotdetails.CROP_DISTANCE.toString()),
                h18,
               ExpandedClass(title: txt_purpose.tr,name: plotdetails.CROP_DISTANCE == 'null' ? '-':plotdetails.EXPORT_LOCAL.toString()),
                  h18,
                  ExpandedClass(title: txt_totalarea.tr,name: plotdetails.CROP_DISTANCE == 'null' ? '-':plotdetails.PLOT_AREA.toString()),
             
                h18,
               ExpandedClass(title: txt_previous_year_problem.tr,name: plotdetails.PREVIOUS_YEAR_PROBLEM == 'null' ?'-':plotdetails.PREVIOUS_YEAR_PROBLEM.toString(),)
            ],
          ),
        ),
      ),
    );
  }
}


class ExpandedClass extends StatelessWidget {
  const ExpandedClass({super.key, this.title, this.name});
  final title; 
  final name;


  @override
  Widget build(BuildContext context) {
    return Material(
  elevation: 5,
  borderRadius: BorderRadius.circular(5),
  child: Container(
  
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Row(
           mainAxisAlignment: MainAxisAlignment.center,
        children: [
          w20,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,  // Adjusted this line
                  crossAxisAlignment: CrossAxisAlignment.start,      // Adjusted this line
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),w20,
          Expanded(
            child: Column(
               mainAxisAlignment: MainAxisAlignment.start,  // Adjusted this line
                  crossAxisAlignment: CrossAxisAlignment.start,      // Adjusted this line
              children: [
                Text(
                  name == 'null' ? "-" : name,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kgreen),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ),
);

  }
}
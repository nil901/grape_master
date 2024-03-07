import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/auth/LocalString.dart';
import 'package:grape_master/util/constants.dart';
import 'package:grape_master/util/no_activity_found.dart';

import '../../../../model/plot_information_model/nutrient_managment_model.dart';
import '../../../../util/color.dart';

class ViewReport extends StatelessWidget {
  const ViewReport({super.key, required this.items});
  final NutrientManagementModelDATA items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kgreen,
          title: Text(
            description.tr,
            style: TextStyle(
                color: kwhite, fontWeight: FontWeight.w400, fontSize: 22),
          )),
      body: items.DESCRIPTION == 'null' ? Center(child: NoActivityFound(),):
      
      






      
      
       SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    children: [
                      h10,
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Report',
                          style: TextStyle(
                              color: kgreen,
                              fontWeight: FontWeight.w400,
                              fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(
                          color: kgreen,
                        ),
                      ),
                      Html(
                        data: items.TOTAL_RECORD,
                        style: {
                          "body": Style(
                              color: grey800,
                              fontSize: FontSize(
                                  15.0)), // Adjust the font size as needed
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
      
      
      
      
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    children: [
                      h10,
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Schedule',
                          style: TextStyle(
                              color: kgreen,
                              fontWeight: FontWeight.w400,
                              fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(
                          color: kgreen,
                        ),
                      ),
                      Html(
                        data: items.TOTAL_RECORD1,
                        style: {
                          "body": Style(
                              color: grey800,
                              fontSize: FontSize(
                                  15.0)), // Adjust the font size as needed
                        },
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

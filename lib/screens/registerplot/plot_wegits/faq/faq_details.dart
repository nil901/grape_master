
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/plot_information_model/faq_questionlist_model.dart';
import '../../../../util/color.dart';
import '../../../../util/constants.dart';
import '../../../auth/LocalString.dart';

class FaqDetails extends StatelessWidget {
  const FaqDetails({super.key, required this.items});
  final FaqQuetionListModelDATA items;
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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(  
                children: [ 
                  Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Material(
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Q :- ${items.FAQ_NAME}",
                                            style: TextStyle(
                                                color: kblack,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.7),
                                          ),
                                          Divider(
                                            color: ktext,
                                            thickness: 0.5,
                                          ),
                                          Text(
                                            "${items.FAQ_DESCRIPTION}",
                                            style: TextStyle(
                                                color: ktext,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15.3),
                                          ),
                                         
                                          h10,
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                ],
              ),
            ),
          ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/auth/LocalString.dart';

import '../../../model/plot_information_model/aks_questions.dart';
import '../../../util/color.dart';
import '../../../util/constants.dart';

class QuestionDetails extends StatelessWidget {
  const QuestionDetails({super.key, required this.items}); 
  final AskQuestionModelDATA items;

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

          body:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: kwhite,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Material(
                                    elevation: 3,
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                   height:  items.IMAGE_URL!.isEmpty?25:200,
                                      decoration: BoxDecoration(
                                          color: kwhite,
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                               items.IMAGE_URL.toString()))),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            height: 25,
                                            width: 80,
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [kgreen, klime],
                                                ),
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10))),
                                                        child: Text("${items.REG_DATE}",style: TextStyle(color: kwhite),),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                h10,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${ txt_category.tr} - ${items.FAQC_NAME}",
                                      style: TextStyle(
                                          color: klime,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                   h5,
                                    Text("${items.NEWQUETION == null ? '-':'Q :-${items.NEWQUETION}'}",
                                      style: TextStyle(
                                          color: kblack,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    h2,
                                    Text(
                                     txt_answers.tr,
                                      style: TextStyle(
                                          color: ktext,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                items.QUE_ANSWER ==  null ?Text(txt_not_given.tr):  Html(shrinkWrap: true,data:items.QUE_ANSWER.toString()),
                                   
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
    );
  }
}
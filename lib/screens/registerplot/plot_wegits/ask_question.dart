import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/registerplot/plot_wegits/aks_question_form.dart';
import 'package:grape_master/screens/registerplot/plot_wegits/quetion_details.dart';
import 'package:grape_master/util/constants.dart';
import 'package:grape_master/util/lodaer.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../util/color.dart';
import '../../../util/no_activity_found.dart';
import '../../../util/util.dart';
import '../../auth/LocalString.dart';
import '../../post/post_controller.dart';
import '../plot_controller.dart';

class AskQutions extends StatefulWidget {
  const AskQutions({super.key});

  @override
  State<AskQutions> createState() => _AskQutionsState();
}

class _AskQutionsState extends State<AskQutions> {
  plotcnt? eProvider;

  @override
  void initState() {
    eProvider = Provider.of<plotcnt>(context, listen: false);
    init();
    // TODO: implement initState
    super.initState();
  }

  void init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await eProvider?.askQutionListApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kgreen,
          title: Text(
          txt_ask_question.tr,
            style: TextStyle(
                color: kwhite, fontWeight: FontWeight.w400, fontSize: 23),
          )),
      floatingActionButton: InkWell(
        onTap: () {
         
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType
                                    .fade, // Choose your desired animation type
                                child: AskQutionsForm(
                                  
                                ),
                              ),
                            );
        },
        child: CircleAvatar(
          radius: 32,
          backgroundColor: kwhite,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: klime,
            child: Icon(
              Icons.add,
              size: 30,
              color: kwhite,
            ),
          ),
        ),
      ),
      body: Consumer<plotcnt>(builder: (context, ePv, child) {
        return ePv.askQuestionModel?.DATA == null
            ? Center(child: Loader())
            : ePv.askQuestionModel?.DATA!.length == 0
                ? Center(child: Column( 
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: [ 
                    
                    Text(
                txt_ask_question.tr,
            style: TextStyle(
                color: kgreen, fontWeight: FontWeight.w400, fontSize: 17),
          ),
          h10,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 5),
            child: InkWell(
              onTap: (){
                Navigator.pop(context);
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType
                                    .fade, // Choose your desired animation type
                                child: AskQutionsForm(
                                  
                                ),
                              ),
                            );
              },
              child: Container( 
                alignment: Alignment.center,
                height: 45, 
                decoration: BoxDecoration(  
                  borderRadius: BorderRadius.circular(20), 
                  color: kgreen
                ),
                child:  Text(
          txt_ask_your_queston.tr ,
              style: TextStyle(
                  color: kwhite, fontWeight: FontWeight.w400, fontSize: 17),
                      ),
              ),
            ),
          )

                  ],
                ))
                : ListView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: ePv.askQuestionModel?.DATA?.length,
                    itemBuilder: (BuildContext context, int index) {
                      var items = ePv.askQuestionModel?.DATA?[index];
                      print('${items!.REG_DATE}');

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType
                                  .fade, // Choose your desired animation type
                              child: QuestionDetails(
                                items: items,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Material(
                                            elevation: 3,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Container(
                                            height:      items.IMAGE_URL!.isEmpty?25:200,
                                              decoration: BoxDecoration(
                                                  color: kwhite,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          items.IMAGE_URL.toString()))),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    height: 25,
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          begin:
                                                              Alignment.topLeft,
                                                          end: Alignment
                                                              .bottomRight,
                                                          colors: [
                                                            kgreen,
                                                            klime
                                                          ],
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        10))),
                                                    child: Text(
                                                      "${items.REG_DATE}",
                                                      style: TextStyle(
                                                          color: kwhite),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        h10,
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${txt_category.tr} - ${items.FAQC_NAME}",
                                              style: TextStyle(
                                                  color: klime,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            h5,
                                            Text(
                                              "${txt_question.tr} - ${items.NEWQUETION == null ? '-' : '${items.NEWQUETION}'}",
                                              style: TextStyle(
                                                  color: kblack,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            h2,
                                            Text(
                                             answer.tr,
                                              style: TextStyle(
                                                  color: ktext,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          items.QUE_ANSWER == null ?Text(txt_not_given.tr) :  Html(
                                                shrinkWrap: true,
                                                data:
                                                    items.QUE_ANSWER.toString()),
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
                    });
      }),
    );
  }
}

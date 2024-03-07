import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grape_master/util/constants.dart';
import 'package:grape_master/util/image_assets.dart';
import 'package:grape_master/util/large_button.dart';
import 'package:grape_master/util/lodaer.dart';
import 'package:grape_master/util/no_activity_found.dart';
import 'package:provider/provider.dart';

import '../../../../util/color.dart';
import '../../../auth/LocalString.dart';
import '../../plot_controller.dart';

class ObservationReport extends StatefulWidget {
  const ObservationReport({super.key});

  @override
  State<ObservationReport> createState() => _ObservationReportnState();
}

class _ObservationReportnState extends State<ObservationReport> {
  plotcnt? eProvider;
  void initState() {
    eProvider = Provider.of<plotcnt>(context, listen: false);
    init();
    // TODO: implement initState
    super.initState();
  }

  void init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await eProvider?.observationApiList();
    });
  }

  bool visibale = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kgreen,
          title: Text(
          txt_observation_report.tr,
            style: TextStyle(
                color: kwhite, fontWeight: FontWeight.w400, fontSize: 22),
          )),
      body: Consumer<plotcnt>(builder: (context, ePv, child) {
        return ePv.observationReportModel?.data == null
            ? Center(
                child: Loader(),
              )
            : ePv.observationReportModel?.data.length == 0
                ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text(txt_observation_msg.tr,style: TextStyle(fontWeight: FontWeight.w600),)),
                    ),
                  
                   
                  ],
                )
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          txt_observation_msg.tr,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        Expanded(
                          child: ListView.builder(

                              // physics: NeverScrollableScrollPhysics(),

                              shrinkWrap: true,
                              itemCount:
                                  ePv.observationReportModel?.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                var items =
                                    ePv.observationReportModel?.data[index];
                                var data1 = ePv.observationReportModel
                                    ?.data[index].questionList.length;

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2, vertical: 8),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {});
                                      visibale = !visibale;
                                    },
                                    child: Column(
                                      children: [
                                        Material(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          elevation: 3,
                                          child: Container(
                                            height: 40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "${items?.codDay}",
                                                    style: TextStyle(
                                                        color: kdategreen,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16),
                                                  ),
                                                  Icon( visibale ? Icons.arrow_drop_down: Icons.arrow_drop_up)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                            visible: visibale,
                                            child: ListView.builder(

                                                // physics: NeverScrollableScrollPhysics(),

                                                shrinkWrap: true,
                                                itemCount:
                                                    items?.questionList.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int i) {
                                                  var data1 =
                                                      items?.questionList[i];
                                                  return InkWell(
                                                    onTap: () async {
                                                      ePv.answerSubmit(data1.qId).then((value) { 
                                                          showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        20.0),
                                                                child:
                                                                    AlertDialog(
                                                                  insetPadding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              12),
                                                                  contentPadding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  content:
                                                                      SingleChildScrollView(
                                                                          child:
                                                                              questinanslist(
                                                                                ans:data1.answer , 
                                                                                qetionid: data1.qId,codId: items?.codId,

                                                                    qetions: data1
                                                                        .question,
                                                                  )),
                                                                ));
                                                          });
                                                      });
                                                    
                                                    },
                                                    child: Material(
                                                      elevation: 2,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 5,
                                                                vertical: 5),
                                                        child: Container(
                                                          height: 35,
                                                          child: Material(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            elevation: 3,
                                                            child: Container(
                                                              height: 30,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5)),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      data1!
                                                                          .question,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              grey800,
                                                                          fontWeight:
                                                                              FontWeight.w400),
                                                                    ),
                                                                    CircleAvatar(
                                                                      radius:
                                                                          10,
                                                                      backgroundColor:
                                                                          klangbig,
                                                                      child: Image
                                                                          .asset(
                                                                        ImageAssets
                                                                            .ic_tick,
                                                                        height:
                                                                            13,
                                                                        color:
                                                                            kwhite,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                })),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: InkWell(
                            onTap: () {
                              ePv.ObservationReportPostApi(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 48,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: kgreen),
                              child: Text(
                                submit.tr,
                                style: TextStyle(
                                    color: kwhite,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
      }),
    );
  }
}

class questinanslist extends StatefulWidget {
  const questinanslist({super.key, this.qetions, this.qetionid, this.codId, this.ans});
  final qetions;
  final qetionid;
  final codId;
   final ans;

  @override
  State<questinanslist> createState() => _questinanslistState();
}

class _questinanslistState extends State<questinanslist> {
  @override
  Widget build(BuildContext context) {
    return Consumer<plotcnt>(builder: (context, ePv, child) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 70,
              color: kgreen,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "       ",
                      style: TextStyle(color: kwhite, fontSize: 18),
                    ),
                    Text(
                      txt_select_option.tr,
                      style: TextStyle(color: kwhite, fontSize: 20),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.clear,
                          color: kwhite,
                          size: 25,
                        ))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  h10,
                  Text(
                    "Submited Answer - ${widget.ans}",
                    style: TextStyle(
                        color: klime,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  h10,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Text(
                      widget.qetions.toString(),
                      style: TextStyle(
                          color: kblack,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  h10,
                  ListView.builder(

                      // physics: NeverScrollableScrollPhysics(),

                      shrinkWrap: true,
                      itemCount: ePv.submitAnswerModel?.data.length == null
                          ? 0
                          : ePv.submitAnswerModel?.data.length,
                      itemBuilder: (BuildContext context, int i) {
                        return Row(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 20,
                              width: 10,
                              child: Radio<String>(
                                activeColor: kgreen,
                                value: ePv.submitAnswerModel!.data[i].qaId
                                    .toString(),
                                groupValue: ePv.updaesh,
                                onChanged: (value1) {
                                  setState(() {
                                    ePv.updaesh = value1!;
                                    log("${value1}");
                                    // print(value.selectedGender);
                                    // _selectedGender = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          w20,
                          Text(
                            ePv.submitAnswerModel!.data[i].answer.toString(),
                            style: TextStyle(
                                color: kblack,
                                fontSize: 16,
                                fontFamily: 'newfont',
                                fontWeight: FontWeight.w500),
                          ),
                        ]);
                      })
                ],
              ),
            ),
           ePv.updaesh == 'null' ? Text(""): Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    ePv.answerchoose(context,widget.qetionid,widget.codId);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                        color: kgreen, borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      submit.tr,
                      style: TextStyle(
                          color: kwhite,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}

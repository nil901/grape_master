import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/registerplot/plot_controller.dart';
import 'package:grape_master/screens/registerplot/plot_wegits/ask_question.dart';
import 'package:grape_master/screens/registerplot/plot_wegits/dairy/dairy_screen.dart';
import 'package:grape_master/screens/registerplot/plot_wegits/dsease_Screens/dsease__control_Screens.dart';
import 'package:grape_master/screens/registerplot/plot_wegits/faq/faq_screen.dart';
import 'package:grape_master/screens/registerplot/plot_wegits/my_plot.dart/my_plot_scrren.dart';
import 'package:grape_master/screens/registerplot/plot_wegits/nutrient_managment/nutrient_management.dart';
import 'package:grape_master/screens/registerplot/plot_wegits/observationreport/observation_report.dart';
import 'package:grape_master/screens/registerplot/plot_wegits/schedule.dart';
import 'package:grape_master/screens/registerplot/subscription_screen.dart';
import 'package:grape_master/screens/registerplot/wegits/selectedItem.dart';
import 'package:grape_master/util/prefs/PreferencesKey.dart';
import 'package:grape_master/util/prefs/app_preference.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../model/home_model/plot_model.dart';
import '../../util/color.dart';
import '../../util/constants.dart';
import '../../util/image_assets.dart';
import '../auth/LocalString.dart';

class PlotDetails extends StatefulWidget {
  const PlotDetails({super.key, required this.plotdetails});
  final PlotRagisterModelDATA plotdetails;

  @override
  State<PlotDetails> createState() => _PlotDetailsState();
}

class _PlotDetailsState extends State<PlotDetails> {
  plotcnt? eProvider;
  void initState() {
    eProvider = Provider.of<plotcnt>(context, listen: false);
    init();
    // TODO: implement initState
    super.initState();
  }

  void init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await eProvider?.pakageListApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: kgreen,
            title: Text(
             txt_farm_detail.tr,
              style: TextStyle(
                  color: kwhite, fontWeight: FontWeight.w400, fontSize: 25),
            )),
        body: Consumer<plotcnt>(builder: (context, ePv, child) {
          ePv.plotId = widget.plotdetails.PLOT_ID;
          ePv.CropId = widget.plotdetails.CROP_ID;
          ePv.viriatyId = widget.plotdetails.CROPVARIETY_ID;
          ePv.chataniID = widget.plotdetails.CHATANI_ID;
          ePv.StId = widget.plotdetails.ST_ID;
          ePv.purningType = "";
          ePv.waterspplayplot = widget.plotdetails.WATER_SOURCE.toString();
          ePv.exportlocal = widget.plotdetails.EXPORT_LOCAL.toString();
          ePv.metodwater = widget.plotdetails.METHOD_OF_WATER.toString();

          return SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${txt_plot_name.tr} ${plot.tr}${widget.plotdetails.NEW_PLOT_NAME}",
                            style: TextStyle(
                                color: ktext,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          Divider(
                            color: kblack,
                          ),
                          Row(
                            children: [
                              Text(
                                "${txt_crop_name.tr} - ${widget.plotdetails.CROP_NAME}",
                                style: TextStyle(
                                    color: ktext,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "",
                                style: TextStyle(
                                    color: kgreen,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          h2,
                          Divider(
                            color: kblack,
                          ),
                          Row(
                            children: [
                              Text(
                                "${txt_crop_variaty.tr} -",
                                style: TextStyle(
                                    color: ktext,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "  ${widget.plotdetails.V_NAME}",
                                style: TextStyle(
                                    color: kblack,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          h2,
                          Divider(
                            color: kblack,
                          ),
                          Row(
                            children: [
                              Text(
                                "${txt_mobile.tr} -",
                                style: TextStyle(
                                    color: ktext,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                " ${AppPreference().getString(PreferencesKey.umobile)} ",
                                style: TextStyle(
                                  color: klime,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          h2,
                          Divider(
                            color: kblack,
                          ),
                          Row(
                            children: [
                              Text(
                                "${txt_package_status.tr} ",
                                style: TextStyle(
                                    color: ktext,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "${ePv.PakageName}",
                                style: TextStyle(
                                    color: kblack,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          h2,
                          Divider(
                            color: kblack,
                          ),
                          Row(
                            children: [
                              Text(
                                "${txt_payment_date.tr}",
                                style: TextStyle(
                                    color: kgreen,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "${widget.plotdetails.REG_DATE == null ? "":widget.plotdetails.REG_DATE} ",
                                style: TextStyle(
                                  color: kgreen,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              h10,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: ePv.items.length,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1.3 / 0.9,
                        crossAxisSpacing: 3,
                        mainAxisSpacing: 10,
                        crossAxisCount:
                            2, // You can adjust the cross axis count as needed
                      ),
                      itemBuilder: (context, i) {
                        var item = ePv.items[i];
                        Color backgroundColor =
                            Color((i * 0x12121212) & 0xFFFFFF);
                        log("${ePv.items[i] == '1'}");

                        return InkWell(
                          onTap: () {
                            if (item['id'] == '1') {
                              if (ePv.pakageListModel?.DATA?[0]?.STATUS ==
                                  'Deactive') {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: AlertDialog(
                                            insetPadding: EdgeInsets.all(12),
                                            contentPadding: EdgeInsets.zero,
                                            content: SingleChildScrollView(
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // Your header and close button code here
                                                    h10,

                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10),
                                                      child: Row(
                                                        children: [
                                                          Image.asset(
                                                            ImageAssets.ic_logo,
                                                            height: 30,
                                                          ),
                                                          Text(
                                                           txt_package_expirt_title.tr,
                                                            style: TextStyle(
                                                                color: kblack,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    h5,
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                                      child: Text(
                                                        txt_package_expire_msg.tr,
                                                        style: TextStyle(
                                                            color: kblack,
                                                            fontWeight:
                                                                FontWeight.w400),
                                                      ),
                                                    ),
                                                    h20,
                                                    h20,
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 28),
                                                      child: Align(
                                                        alignment: Alignment
                                                            .bottomRight,
                                                        child: InkWell(
                                                          onTap: () {
                                                            Navigator.pop(context);
                                                            Navigator.push(
                                                              context,
                                                              PageTransition(
                                                                  type: PageTransitionType
                                                                      .fade, // Choose your desired animation type
                                                                  child:
                                                                      SubscriptionScrren()),
                                                            );
                                                            // Navigator.pop(context);
                                                          },
                                                          child: Text(
                                                            txt_okk.tr,
                                                            style: TextStyle(
                                                                color: klime,
                                                                fontSize: 20),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    h20,
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ));
                                    });
                              } else {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType
                                        .fade, // Choose your desired animation type
                                    child: SchefuleScreen(cropname: widget.plotdetails.CROP_NAME,plotdetails: widget.plotdetails,),
                                  ),
                                );
                              }
                          
                          
                            } else if (item['id'] == '2') {
                                if (ePv.pakageListModel?.DATA?[0]?.STATUS ==
                                  'Deactive') {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: AlertDialog(
                                            insetPadding: EdgeInsets.all(12),
                                            contentPadding: EdgeInsets.zero,
                                            content: SingleChildScrollView(
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // Your header and close button code here
                                                    h10,

                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10),
                                                      child: Row(
                                                        children: [
                                                          Image.asset(
                                                            ImageAssets.ic_logo,
                                                            height: 30,
                                                          ),
                                                          Text(
                                                           txt_package_expirt_title.tr,
                                                            style: TextStyle(
                                                                color: kblack,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    h5,
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                                      child: Text(
                                                        txt_package_expire_msg.tr,
                                                        style: TextStyle(
                                                            color: kblack,
                                                            fontWeight:
                                                                FontWeight.w400),
                                                      ),
                                                    ),
                                                    h20,
                                                    h20,
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 28),
                                                      child: Align(
                                                        alignment: Alignment
                                                            .bottomRight,
                                                        child: InkWell(
                                                          onTap: () {
                                                            Navigator.pop(context);
                                                            Navigator.push(
                                                              context,
                                                              PageTransition(
                                                                  type: PageTransitionType
                                                                      .fade, // Choose your desired animation type
                                                                  child:
                                                                      SubscriptionScrren()),
                                                            );
                                                            // Navigator.pop(context);
                                                          },
                                                          child: Text(
                                                            txt_okk.tr,
                                                            style: TextStyle(
                                                                color: klime,
                                                                fontSize: 20),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    h20,
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ));
                                    });
                              } else {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType
                                      .fade, // Choose your desired animation type
                                  child: AskQutions(),
                                ),
                              );
                              }
                          
                              
                            } else if (item['id'] == '3') {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType
                                      .fade, // Choose your desired animation type
                                  child: NutrientManagement(),
                                ),
                              );
                            } else if (item['id'] == '4') {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType
                                      .fade, // Choose your desired animation type
                                  child: FaqScreen(),
                                ),
                              );
                            } else if (item['id'] == '5') {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType
                                      .fade, // Choose your desired animation type
                                  child: DairyScreen(),
                                ),
                              );
                            } else if (item['id'] == '6') {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType
                                      .fade, // Choose your desired animation type
                                  child: DseaseControlScreen(),
                                ),
                              );
                            } else if (item['id'] == '7') {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType
                                      .fade, // Choose your desired animation type
                                  child: MyPlotScreen(
                                    plotdetails: widget.plotdetails,
                                  ),
                                ),
                              );
                            } else if (item['id'] == '8') {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType
                                        .fade, // Choose your desired animation type
                                    child: ObservationReport()),
                              );
                            } else if (item['id'] == '9') {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType
                                        .fade, // Choose your desired animation type
                                    child: SubscriptionScrren()),
                              );
                            }
                          },
                          child: SelectedItems(
                            bgColor: backgroundColor,
                            name: item["name"],
                            image: item["image"],
                            id: item["id"],
                          ),
                        );
                      }),
                ),
              ),
              h10,
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType
                            .fade, // Choose your desired animation type
                        child: SubscriptionScrren()),
                  );
                },
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: 120,
                    width: 160,
                    decoration: BoxDecoration(
                        color: kplotblue,
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Image.asset(
                          ImageAssets.ic_pack,
                          height: 70,
                        ),
                        h10,
                        Text(
                         txt_subscription.tr,
                          style: TextStyle(
                              color: ktext,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              h10
            ]),
          );
        }));
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Container(
            child: AlertDialog(
              title: Container(
                child: Row(
                  children: [
                    Image.asset(
                      ImageAssets.ic_logo,
                      height: 30,
                    ),
                    Text(' The pakage is over'),
                  ],
                ),
              ),
              content: Text('The pakage is over! Buy a new pakage'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType
                            .fade, // Choose your desired animation type
                        child: SubscriptionScrren(),
                      ),
                    );
                    // Navigator.of(context).pop();
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(color: klime),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

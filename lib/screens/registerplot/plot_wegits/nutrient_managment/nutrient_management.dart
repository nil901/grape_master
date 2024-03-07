import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../../util/color.dart';
import '../../../../util/constants.dart';
import '../../../../util/lodaer.dart';
import '../../../../util/no_activity_found.dart';
import '../../../auth/LocalString.dart';
import '../../plot_controller.dart';
import 'add_report_screen.dart';
import 'nutrient_details.dart';

class NutrientManagement extends StatefulWidget {
  const NutrientManagement({super.key});

  @override
  State<NutrientManagement> createState() => _NutrientManagementState();
}

class _NutrientManagementState extends State<NutrientManagement> {
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
      await eProvider?.NetrientManagementList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kgreen,
          title: Text(
           txt_soil_water_reports.tr,
            style: TextStyle(
                color: kwhite, fontWeight: FontWeight.w400, fontSize: 22),
          )),
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              type:
                  PageTransitionType.fade, // Choose your desired animation type
              child: AddReportScreen(),
            ),
          );
        },
        child: CircleAvatar(
          radius: 45,
          backgroundColor: kwhite,
          child: CircleAvatar(
            radius: 42,
            backgroundColor: klime,
            child: Icon(
              Icons.add,
              size: 35,
              color: kwhite,
            ),
          ),
        ),
      ),
      body: Consumer<plotcnt>(builder: (context, ePv, child) {
      
        return ePv.nutrientManagementModel?.DATA == null
            ? Center(child: Loader())
            : ePv.nutrientManagementModel?.DATA!.length == 0
                ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,),
                  child: Center(child: Text(txt_report_msg.tr,style: TextStyle(color: kblack,fontWeight: FontWeight.w500,fontSize: 18),)),
                )
                : ListView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: ePv.nutrientManagementModel?.DATA!.length,
                    itemBuilder: (BuildContext context, int index) {
                      var items = ePv.nutrientManagementModel?.DATA?[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType
                                        .fade, // Choose your desired animation type
                                    child: NutrientDetails(
                                      items: items,
                                    ),
                                  ),
                                );
                              },
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
                                              height: 210,
                                              decoration: BoxDecoration(
                                                  color: kblue,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(items!
                                                          .REPORT_PHOTO
                                                          .toString()))),
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
                                                      "${items.SAMPLE_DATE}",
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
                                              "${txt_report_cat.tr} :-  ${items.REPORT_NAME}",
                                              style: TextStyle(
                                                  color: kblack,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            h2,
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    });
      }),
    );
  }
}

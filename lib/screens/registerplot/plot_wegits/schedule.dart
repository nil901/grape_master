import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grape_master/model/home_model/plot_model.dart';
import 'package:grape_master/screens/registerplot/plot_wegits/schedule_details.dart';
import 'package:grape_master/util/constants.dart';
import 'package:grape_master/util/image_assets.dart';
import 'package:grape_master/util/large_button.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../util/color.dart';
import '../../auth/LocalString.dart';
import '../plot_controller.dart';
import 'faq/old_shadule.dart';

class SchefuleScreen extends StatefulWidget {
  const SchefuleScreen({super.key, required this.cropname, required this.plotdetails});
  final cropname;
   final PlotRagisterModelDATA plotdetails;

  @override
  State<SchefuleScreen> createState() => _SchefuleScreenState();
}

class _SchefuleScreenState extends State<SchefuleScreen> {
  plotcnt? eProvider;
  void initState() {
    eProvider = Provider.of<plotcnt>(context, listen: false);
    init();
    // TODO: implement initState
    super.initState();
  }

  void init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await eProvider?.scheduleListApi('Current');
    });
  } 

   void _launchPhoneCall(String phoneNumber) async {
  String url = 'tel:$phoneNumber';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

  @override
  Widget build(BuildContext context) {
    log("${widget.plotdetails.EXPORT_LOCAL}");
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kgreen,
          title: Text(
            "${widget.cropname} शेड्यूल",
            style: TextStyle(
                color: kwhite, fontWeight: FontWeight.w400, fontSize: 25),
          )),
      body: Consumer<plotcnt>(builder: (context, ePv, child) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Material(
                  borderRadius: BorderRadius.circular(8),
                  elevation: 6,
                  child: Container(
                      width: double.infinity,
                     
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: kplotlime),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {
                                
                              });
                              ePv.scheduleId = 1;
                                log(' dddd${  ePv.scheduleId}');
                               ePv.scheduleListApi('Current');
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                h16,
                                Image.asset(
                                  ImageAssets.ic_spray,
                                  height: 40,
                                ),
                                h12,
                                Text(
                                 spray.tr,
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                h10
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: (){
                               setState(() {
                                
                              });
                               ePv.scheduleId = 2;
                                 log('dddd${  ePv.scheduleId}');
                                ePv.scheduleListApi('Current');
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                h16,
                                Image.asset(
                                  ImageAssets.ic_fertilizer,
                                  height: 40,
                                ),
                                h12,
                                Text(
                                 fertilizer.tr,
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                h10
                              ],
                            ),
                          ),
                          InkWell(
                           
                              onTap: (){
                                 setState(() {
                                
                              });
                               ePv.scheduleId = 3;
                               log('ddd${  ePv.scheduleId}');
                              // ePv.scheduleListApi();
                            ePv.scheduleListApi('Current');
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                h16,
                                Image.asset(
                                  ImageAssets.ic_general,
                                  height: 40,
                                ),
                                h12,
                                Text(
                                general.tr,
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                h10
                              ],
                            ),
                          ),
                        ],
                      ))),
              h14,
              Align(
                  alignment: Alignment.centerRight,
                  child: LargeButton(
                    onPress: () {
                       Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType
                                            .fade, // Choose your desired animation type
                                        child:oldShidule( 

                                          cropname :widget.cropname,
                                          date: widget.plotdetails.SOWING_DATE,
                                        ),
                                      ),
                                    );

                   
                    },
                    text: Text(
                     old_schedule.tr,
                      style: TextStyle(
                          fontSize: 17,
                          color: kwhite,
                          fontWeight: FontWeight.w500),
                    ),
                  )),
              h18,
              widget.plotdetails.EXPORT_LOCAL =="Local"?
            Text(
               txt_schedule_market.tr,
                style: TextStyle(
                    fontSize: 18, color: klime, fontWeight: FontWeight.w500),
              ): widget.plotdetails.EXPORT_LOCAL?.isEmpty  == " " ? Text(""):Text(
               txt_schedule_Export_market.tr,
                style: TextStyle(
                    fontSize: 18, color: klime, fontWeight: FontWeight.w500),
              ),
             
              // Text(
              //   "This Schedule is for local market",
              //   style: TextStyle(
              //       fontSize: 15, color: klime, fontWeight: FontWeight.w500),
              // ),

              Expanded(
                child: ePv.sheduleListModel?.DATA?.length== 0? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 150),
                  child:Text.rich(
                       TextSpan(
                         children: [
                           TextSpan(
                             text: txt_plot_schedule_msg.tr,
                             style: TextStyle(color: kblack, fontSize: 15, fontWeight: FontWeight.bold),
                           ),
                          TextSpan(
                             text: number.tr,
                             style: TextStyle(color: klime, fontSize: 15, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                             recognizer: TapGestureRecognizer()
                               ..onTap = () {
                                 // Handle the click action here, e.g., navigate to a new screen or perform some other action
                               _launchPhoneCall(number.tr);
                               },
                           ),
                           TextSpan(
                             text: text_plot_scedule_msg1.tr,
                             style: TextStyle(color: kblack, fontSize: 15, fontWeight: FontWeight.bold, ),
                           ), 
                            TextSpan(
                             text: text_plot_scedule_msg1.tr,
                             style: TextStyle(color: kblack, fontSize: 15, fontWeight: FontWeight.bold, ),
                           ),
                            TextSpan(
                             text: '🙏',
                             style: TextStyle(color: kblack, fontSize: 15, fontWeight: FontWeight.bold, ),
                           ),
                         ],
                       ),
                     ),
                ): ePv.sheduleListModel?.DATA == null ?Padding(
                  padding: const EdgeInsets.symmetric(vertical: 150),
                  child: Column(
                    children: [
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 10),
                     child: Text.rich(
                     TextSpan(
                       children: [
                         TextSpan(
                           text: txt_plot_schedule_msg.tr,
                           style: TextStyle(color: kblack, fontSize: 15, fontWeight: FontWeight.bold),
                         ),
                        TextSpan(
                           text: number.tr,
                           style: TextStyle(color: klime, fontSize: 15, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                           recognizer: TapGestureRecognizer()
                             ..onTap = () {
                               // Handle the click action here, e.g., navigate to a new screen or perform some other action
                             _launchPhoneCall(number.tr);
                             },
                         ),
                         TextSpan(
                           text: text_plot_scedule_msg1.tr,
                           style: TextStyle(color: kblack, fontSize: 15, fontWeight: FontWeight.bold, ),
                         ), 
                          TextSpan(
                           text: text_plot_scedule_msg1.tr,
                           style: TextStyle(color: kblack, fontSize: 15, fontWeight: FontWeight.bold, ),
                         ),
                          TextSpan(
                           text: '🙏',
                           style: TextStyle(color: kblack, fontSize: 15, fontWeight: FontWeight.bold, ),
                         ),
                       ],
                     ),
                   ),
                   ),

                    ],
                  ),
                ):ePv.sheduleListModel?.ResponseCode ==1?Padding(
                  padding: const EdgeInsets.symmetric(vertical: 150),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child:Text.rich(
  TextSpan(
    children: [
      TextSpan(
        text: txt_plot_schedule_msg.tr,
        style: TextStyle(color: kblack, fontSize: 15, fontWeight: FontWeight.bold),
      ),
      TextSpan(
        text: number.tr,
        style: TextStyle(color: klime, fontSize: 15, fontWeight: FontWeight.bold),
      ),
      TextSpan(
        text: text_plot_scedule_msg1.tr,
        style: TextStyle(color: kblack, fontSize: 15, fontWeight: FontWeight.bold),
      ),
    ],
  ),
),

                       ), 
                       
                        
                    ],
                  ),
                ) : ListView.builder(
                   // physics: NeverScrollableScrollPhysics(),
                    // physics: NeverScrollableScrollPhysics(),

                    shrinkWrap: true,
                    itemCount: ePv.sheduleListModel?.DATA?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      var items = ePv.sheduleListModel?.DATA?[index];
                    //  DateTime currentDate = DateTime.parse("2024-02-02");
                      DateTime originalDate = DateFormat('MM/dd/yyyy').parse(widget.plotdetails.SOWING_DATE.toString());
                        
                  DateTime incrementedDate = originalDate.add(Duration(days: int.parse(items!.SCHEDULE_DAY!.toString())));
                  String formattedDate = DateFormat('dd-MM-yyyy').format(incrementedDate);
                  print("${widget!.plotdetails.SOWING_DATE!}");


                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                              alignment: Alignment.center,
                                height: 24,
                                width: 92,
                                decoration: BoxDecoration(  
                                  color: kdategreen,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  )
                                ),
                                child: Text(
                                        "${
                                         formattedDate
                                        }",
                                        style: TextStyle(
                                            color: kwhite,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      ), 
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                 Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType
                                            .fade, // Choose your desired animation type
                                        child: scheduledetails(
                                          items: items!,
                                          date: widget.plotdetails.SOWING_DATE,
                                         
                                        ),
                                      ),
                                    );
                              },
                              child: Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 30,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [kgreen, klime],
                                            ),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                topRight: Radius.circular(5))),
                                        child:                                Center(
                                        child: Text(
                                          "${txt_schedule_day.tr}${items?.SCHEDULE_DAY}",
                                          style: TextStyle(
                                              color: kwhite,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.7),
                                        ),
                                      ),
                                      ),
                                      h8,
                                      Center(
                                        child: Text(
                                          "${items?.SCHEDULE_TITLE}",
                                          style: TextStyle(
                                              color: klime,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.7),
                                        ),
                                      ),
                                      h5,
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 5),
                                        child: Expanded(
                                          child: Text(
                                           
                                            
                                             overflow: TextOverflow.ellipsis,
                                            "${items?.DESCRIPTION}",
                                            style: TextStyle(
                                                color: ktext,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                       "${txt_view_more.tr}>> ",
                                          style: TextStyle(
                                              color: klime,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                      ),
                                      h10,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              )
            ],
          ),
        );
      }),
    );
  }
}

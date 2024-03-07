import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/auth/LocalString.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../model/plot_information_model/shedule_list_model.dart';
import '../../../util/color.dart';
import '../../../util/constants.dart';
import '../plot_controller.dart';

class scheduledetails extends StatelessWidget {
   scheduledetails({super.key, required this.items, this.date});
  final SheduleListModelDATA items;
  final date;
   plotcnt? eProvider;

  @override
  Widget build(BuildContext context) {
   
                     DateTime currentDate = DateTime.parse("2024-02-02");
                      DateTime originalDate = DateFormat('MM/dd/yyyy').parse(date);
                        
                  DateTime incrementedDate = originalDate.add(Duration(days: int.parse(items!.SCHEDULE_DAY!.toString())));
                  String formattedDate = DateFormat('dd-MM-yyyy').format(incrementedDate);
               
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kgreen,
          title: Text(
            description.tr,
            style: TextStyle(
                color: kwhite, fontWeight: FontWeight.w400, fontSize: 22),
          )),
      body:  Consumer<plotcnt>(builder: (context, ePv, child) {
       return Column(
          children: [
            h10,
            Padding(
             padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Align(
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
                      )),
                  child: Text(
                    "${formattedDate}",
                    style: TextStyle(
                        color: kwhite, fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 12),
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
                          child: Center(
                            child: Text(
                              "${txt_schedule_day.tr}-${items?.SCHEDULE_DAY}",
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
                                color: kblack,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.7),
                          ),
                        ),
                        h5,
                        h10,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Divider(
                                thickness: 0.5,
                                color: klime,
                              )),
                              w10,
                              Text(
                             txt_schedule_msg_title.tr,
                                style: TextStyle(
                                    color: klime, fontWeight: FontWeight.w500),
                              ),
                              w10,
                              Expanded(
                                  child: Divider(
                                thickness: 0.5,
                                color: klime,
                              )),
                            ],
                          ),
                        ),
                        h10,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Center(
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
                        h10,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 70),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Divider(
                                thickness: 0.5,
                                color: klime,
                              )),
                              w10,
                              Text(
                                  txt_aff_parameter.tr,
                                style: TextStyle(
                                    color: klime, fontWeight: FontWeight.w500),
                              ),
                              w10,
                              Expanded(
                                  child: Divider(
                                thickness: 0.5,
                                color: klime,
                              )),
                            ],
                          ),
                        ),
                        h10,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Center(
                            child: Text(
                              // maxLines: 2,
                              // overflow: TextOverflow.ellipsis,
                              "${items.FUNCTIONAL_COMPONANT == " " ? "-" : items.FUNCTIONAL_COMPONANT}",
                               style: TextStyle(
                                  color: ktext,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                        h10,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 100),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Divider(
                                thickness: 0.5,
                                color: klime,
                              )),
                              w10,
                              Text(
                               txt_purpose.tr,
                                style: TextStyle(
                                    color: klime, fontWeight: FontWeight.w500),
                              ),
                              w10,
                              Expanded(
                                  child: Divider(
                                thickness: 0.5,
                                color: klime,
                              )),
                            ],
                          ),
                        ),
                        h10,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Center(
                            child: Text(
                              // maxLines: 2,
                              // overflow: TextOverflow.ellipsis,
                              "${items?.DISEASE_PEST == " " ? "-" : items?.DISEASE_PEST}",
                              style: TextStyle(
                                  color: ktext,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                        h10,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 120),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Divider(
                                thickness: 0.5,
                                color: klime,
                              )),
                              w10,
                              Text(
                                "PHI",
                                style: TextStyle(
                                    color: klime, fontWeight: FontWeight.w500),
                              ),
                              w10,
                              Expanded(
                                  child: Divider(
                                thickness: 0.5,
                                color: klime,
                              )),
                            ],
                          ),
                        ),
                        h10,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Center(
                            child: Text(
                              // maxLines: 2,
                              // overflow: TextOverflow.ellipsis,
                              "${items.PHI == 'null' ? '-' :items.PHI}",
                              style: TextStyle(
                                  color: ktext,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){
                      print("jdjd");
                      ePv?.ComplitetheScheduleApi(context,items.SCHEDULE_ID);
                    },
                    child: Container( 
                      alignment: Alignment.center,
                      height: 45,
                      color: klime,
                      child: Text(
                                // maxLines: 2,
                                // overflow: TextOverflow.ellipsis,
                              txt_complete_schedule.tr,
                                style: TextStyle(
                                    color: kwhite,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15),)
                      
                    ),
                  ),
                  
                ),
             
                  Expanded(
                  child: InkWell(
                    onTap: (){
                      ePv?.addDairyScheduleApi(context ,items.SCHEDULE_TITLE,items.DESCRIPTION,items.SCHEDULE_ID,items.FUNCTIONAL_COMPONANT,items.DISEASE_PEST,items.PHI);
                    },
                    child: Container(
                         alignment: Alignment.center,
                      height: 45,
                      color: kgreen,
                      child: Text(
                                // maxLines: 2,
                                // overflow: TextOverflow.ellipsis,
                               txt_add_to_diary.tr,
                                style: TextStyle(
                                    color: kwhite,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15),),
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      }
      ),
    );
  }
}

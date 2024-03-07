import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grape_master/util/lodaer.dart';
import 'package:grape_master/util/no_activity_found.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../../util/color.dart';
import '../../../../util/constants.dart';
import '../../../auth/LocalString.dart';
import '../../plot_controller.dart';
import '../schedule_details.dart';

class oldShidule extends StatefulWidget {
  const oldShidule({super.key, this.cropname, this.date});
 final  cropname;
 final date;

  @override
  State<oldShidule> createState() => _oldShiduleState();
}

class _oldShiduleState extends State<oldShidule> {
   plotcnt? eProvider;
  void initState() {
    eProvider = Provider.of<plotcnt>(context, listen: false);
    init();
    // TODO: implement initState
    super.initState();
  }

  void init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await eProvider?.oldsheduleApi('Previous');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
        appBar: AppBar(
          backgroundColor: kgreen,
          leading: InkWell(
            
            onTap: ()async{
            await  eProvider?.oldsheduleApi('Current');
              navigator!.pop(context);
            },
            child: Icon(Icons.arrow_back)),
          title: Text(
           "${widget.cropname} ${old_schedule.tr} ",
            style: TextStyle(
                color: kwhite, fontWeight: FontWeight.w400, fontSize: 22)
          )),

          body:Consumer<plotcnt>(builder: (context, ePv, child) {
            return eProvider?.sheduleListModel?.DATA?.length  == 0 ? Center(child: NoActivityFound(),): eProvider?.sheduleListModel?.DATA == null? Center(child:  NoActivityFound(),): Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    // physics: NeverScrollableScrollPhysics(),

                    shrinkWrap: true,
                    itemCount: ePv.sheduleListModel?.DATA?.length,
                    itemBuilder: (BuildContext context, int index) {
                      var items = ePv.sheduleListModel?.DATA?[index];
                        DateTime currentDate = DateTime.parse("2024-02-02");
                      DateTime originalDate = DateFormat('MM/dd/yyyy').parse(widget.date);
                        
                  DateTime incrementedDate = originalDate.add(Duration(days: int.parse(items!.SCHEDULE_DAY!.toString())));
                  String formattedDate = DateFormat('dd-MM-yyyy').format(incrementedDate);

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
                                        "${formattedDate}",
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
                                          date: widget.date,
                                         
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
                                          "${txt_schedule_day.tr} ${items?.SCHEDULE_DAY}",
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
                                        child: Text(
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          "${items?.DESCRIPTION}",
                                          style: TextStyle(
                                              color: ktext,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "${txt_view_more.tr} >> ",
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
                        );
          }
    ));



    
  }
}
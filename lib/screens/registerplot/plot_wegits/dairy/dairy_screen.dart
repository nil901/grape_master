import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/auth/LocalString.dart';
import 'package:grape_master/util/lodaer.dart';
import 'package:grape_master/util/no_activity_found.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../../util/color.dart';
import '../../../../util/constants.dart';
import '../../plot_controller.dart';
import 'dairy_details.dart';

class DairyScreen extends StatefulWidget {
  const DairyScreen({super.key});

  @override
  State<DairyScreen> createState() => _DairyScreenState();
}

class _DairyScreenState extends State<DairyScreen> {
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
      await eProvider?.dairyListApi();
     
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kgreen,
          title: Text(
           txt_diary.tr,
            style: TextStyle(
                color: kwhite, fontWeight: FontWeight.w400, fontSize: 22),
          )),
      body: Consumer<plotcnt>(builder: (context, ePv, child) {
        return  ePv.dairyListModel?.data == null ? Center(child:Loader(),):ePv.dairyListModel?.data.length == 0 ?Center(child: NoActivityFound(),):
          Padding(
          padding: const EdgeInsets.all(3.0),
          child: ListView.builder(
              //physics: NeverScrollableScrollPhysics(),
              // physics: NeverScrollableScrollPhysics(),
      
              shrinkWrap: true,
              itemCount: ePv.dairyListModel?.data.length,
              itemBuilder: (BuildContext context, int index) {
                var items = ePv.dairyListModel?.data[index];
      
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: InkWell(
                    onTap: (){
                       Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType
                                        .fade, // Choose your desired animation type
                                    child: DairyDetails(items:items! ,),
                                  ),
                                );
                    },
                    child: Material(
                      elevation: 2,
                      // borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                            //  borderRadius: BorderRadius.circular(10),
                            ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${items?.title}",
                                      style: TextStyle(
                                          color: klime,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.7),
                                    ),
                                    Divider(
                                      color: ktext,
                                      thickness: 0.5,
                                    ),
                                    Text(
                                       maxLines: 2,
                                      "${items?.description}",
                                      style: TextStyle(
                                          color: kblack,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.3),
                                    ),
                                    h10,
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 35,
                              height: 120,
                             
                              color: kgreen,
                              child: Icon(
                                Icons.arrow_forward,
                                color: kwhite,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        );
      }
      ),
    );
  }
}

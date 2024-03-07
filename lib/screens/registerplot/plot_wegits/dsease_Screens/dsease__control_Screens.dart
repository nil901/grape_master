import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grape_master/util/lodaer.dart';
import 'package:grape_master/util/no_activity_found.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../../util/color.dart';
import '../../../../util/constants.dart';
import '../../../../util/image_assets.dart';
import '../../../auth/LocalString.dart';
import '../../plot_controller.dart';
import 'dsease_details.dart';

class DseaseControlScreen extends StatefulWidget {
  const DseaseControlScreen({super.key});

  @override
  State<DseaseControlScreen> createState() => _DseaseControlScreenState();
}

class _DseaseControlScreenState extends State<DseaseControlScreen> {
  plotcnt? eProvider;

  @override
  void initState() {
    eProvider = Provider.of<plotcnt>(context, listen: false);
    init();
    // TODO: implement initState
    super.initState();
  }

  void init() async {
   await eProvider?.deseasecategoreyListApi(); 
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kgreen,
          title: Text(
           txt_disease_control.tr,
            style: TextStyle(
                color: kwhite, fontWeight: FontWeight.w400, fontSize: 22),
          )),
      body: Consumer<plotcnt>(builder: (context, ePv, child) {
        return ePv.diseaseInformationModel?.data == null ? Center(child: Loader()) :ePv.diseasecategoreyModel?.data.length == 0? Center(child: NoActivityFound(),) : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Text(
                  txt_category .tr,
                  style: TextStyle(
                      color: kgreen, fontWeight: FontWeight.w500, fontSize: 19),
                ),
                h10,
                Material(
                    borderRadius: BorderRadius.circular(15),
                    elevation: 6,
                    child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: kgreen50),
                        child: SizedBox(
                          width: 100,
                          height: 106,
                          child: ListView.builder(

                              // physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: ePv.diseasecategoreyModel?.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                var items =
                                    ePv.diseasecategoreyModel?.data[index];

                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: InkWell(
                                    onTap: (){
                                      print("jhhvv");
                                       ePv.deseaseinformationListApi(items.dcId);

                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          height: 8,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        CircleAvatar(
                                          radius: 29.5,
                                          backgroundColor: grey800,
                                          child: CircleAvatar(
                                            radius: 29,
                                            backgroundColor: kgreen50,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: Image.network(
                                                items!.dcImage.toString(),
                                                fit: BoxFit.fill,
                                                errorBuilder:
                                                    (context, error, stackTrace) {
                                                  // Handle the error, you can return a placeholder image or any other widget
                                                  return Image.asset(
                                                    ImageAssets.ic_logo,
                                                    fit: BoxFit.fill,
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        h2,
                                        h2,
                                        h2,
                                        Text(
                                          "${items!.dcName}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ))),
                SizedBox(
                  height: 8,
                ),
                Divider(
                  color: ktext,
                  thickness: 0.5,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: Column(
                    children: [
                      h10,
                      Text(
                        "Disease information :",
                        style: TextStyle(
                            color: kblack,
                            fontWeight: FontWeight.w500,
                            fontSize: 19),
                      ),
                    ],
                  ),
                ),
                h10,
                h2,
                h10,
                GridView.builder(
                    shrinkWrap: true,
                    itemCount: ePv.diseaseInformationModel!.data.length,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2),
                    itemBuilder: (context, i) {
                      var items = ePv.diseaseInformationModel!.data[i];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType
                                  .fade, // Choose your desired animation type
                              child: DseaseDetails(
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
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                h10,
                                Material(
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: 170,
                                    width: 142,
                                    decoration: BoxDecoration(
                                        // image: DecorationImage(
                                        //     fit: BoxFit.cover,
                                        //     // image: NetworkImage(
                                        //     //     items.drImg)

                                        //         ),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Image.network(
                                      items!.drImg.toString(),
                                      fit: BoxFit.fill,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        // Handle the error, you can return a placeholder image or any other widget
                                        return Image.asset(
                                          ImageAssets.ic_logo,
                                          fit: BoxFit.fill,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                h10,
                                Text(
                                  "${items.drName}",
                                  style: TextStyle(
                                      color: kblack,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    })
              ],
            ),
          ),
        );
      }),
    );
  }
}

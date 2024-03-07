import 'dart:developer';

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
import 'faq_controller.dart';
import 'faq_details.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
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
      await eProvider?.faqCategoreyListApi();
       
    
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kgreen,
          title: InkWell(
            onTap: (){
              print("hello");
              eProvider?.faqCategoreyListApi();
            },
            child: Text(
             txt_faq.tr,
              style: TextStyle(
                  color: kwhite, fontWeight: FontWeight.w400, fontSize: 22),
            ),
          )),
      body: Consumer<plotcnt>(builder: (context, ePv, child) {
        return  ePv.faqCategoreyModel?.data == null ? Center(child: Loader()): ePv.faqCategoreyModel?.data.length == 0? Center(child: NoActivityFound(),) : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    h10,
                    Text(
                     txt_category.tr,
                      style: TextStyle(
                          color: kgreen,
                          fontWeight: FontWeight.w500,
                          fontSize: 19),
                    ),
                    h10,
                    h2,
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
                                  itemCount:
                                      ePv.faqCategoreyModel?.data.length ?? 0,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var items =
                                        ePv.faqCategoreyModel?.data[index];

                                    log("${ePv.catid}");
                                    return Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: InkWell(
                                        onTap: () {
                                          ePv.catid = items?.fqcId;
                                          log("${ePv.catid}");
                                          ePv.faqQuetionList(items?.fqcId);
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
                                                  borderRadius: BorderRadius.circular(100),
                                                  child: Image.network(
                                                    items!.fqcImage.toString(),
                                                    fit: BoxFit.fill,
                                                    errorBuilder: (context, error,
                                                        stackTrace) {
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
                                              "${items!.fqcName} ",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            h2
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ))),
                  ],
                ),
              ),
              h10,
              Divider(
                color: ktext,
                thickness: 0.5,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  h10,
                    Text(
                     " ${txt_question.tr} :",
                      style: TextStyle(
                          color: kblack,
                          fontWeight: FontWeight.w500,
                          fontSize: 19),
                    ),
                    ePv.faqQuetionListModel?.DATA == null
                        ? Center(
                            child: Loader(),
                          )
                        : ePv.faqQuetionListModel?.DATA?.length == 0? Center(child: NoActivityFound(),): ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            // physics: NeverScrollableScrollPhysics(),

                            shrinkWrap: true,
                            itemCount: ePv.faqQuetionListModel?.DATA?.length,
                            itemBuilder: (BuildContext context, int index) {
                              var items = ePv.faqQuetionListModel?.DATA?[index];

                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType
                                            .fade, // Choose your desired animation type
                                        child: FaqDetails(
                                          items: items!,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Q :- ${items?.FAQ_NAME}",
                                              style: TextStyle(
                                                  color: kblack,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16.7),
                                            ),
                                            Divider(
                                              color: ktext,
                                              thickness: 0.5,
                                            ),
                                            Text(
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              "${items?.FAQ_DESCRIPTION}",
                                              style: TextStyle(
                                                  color: ktext,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13.3),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                "${txt_view_more.tr} >> ",
                                                style: TextStyle(
                                                    color: klime,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            h10,
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            })
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}

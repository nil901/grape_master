import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/auth/LocalString.dart';
import 'package:grape_master/screens/auth/phone_pay.dart';
import 'package:grape_master/screens/registerplot/plot_controller.dart';
import 'package:grape_master/util/constants.dart';
import 'package:grape_master/util/image_assets.dart';
import 'package:grape_master/util/large_button.dart';
import 'package:grape_master/util/lodaer.dart';
import 'package:grape_master/util/no_activity_found.dart';
import 'package:provider/provider.dart';

import '../../util/color.dart';

class SubscriptionScrren extends StatefulWidget {
  const SubscriptionScrren({super.key});

  @override
  State<SubscriptionScrren> createState() => _SubscriptionScrrenState();
}

class _SubscriptionScrrenState extends State<SubscriptionScrren> {
  plotcnt? eProvider;
  void initState() {
    eProvider = Provider.of<plotcnt>(context, listen: false);
    init();
    // TODO: implement initState
    super.initState();
  }

  void init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await eProvider?.subcriptionListListApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kgreen,
          title: Text(
           txt_subscription.tr,
            style: TextStyle(
                color: kwhite, fontWeight: FontWeight.w400, fontSize: 22),
          )),
      body: Consumer<plotcnt>(builder: (context, ePv, child) {
        return ePv.scriptionListModel?.DATA == null
            ? Center(
                child: Loader(),
              )
            : ePv.scriptionListModel?.DATA?.length == 0
                ? Center(
                    child: NoActivityFound(),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: ePv.scriptionListModel?.DATA?.length,
                    itemBuilder: (BuildContext context, int index) {
                      var items = ePv.scriptionListModel?.DATA?[index];
                      return Padding(
                        padding: const EdgeInsets.all(25),
                        child: Material(
                          elevation: 2,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            alignment: Alignment.center,
                          
                            decoration: BoxDecoration(
                              color: kwhite,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                h25,
                                Text(
                                  "${items?.PACKAGE_NAME}",
                                  style: TextStyle(
                                    color: kgreen,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                                h25,
                                Container(
                                  height: 200,
                                  width: 210,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              items!.CROP_IMAGE.toString()))),
                                ),
                                h34,
                                Text(
                                  "Rs.${items?.AMOUNT}",
                                  style: TextStyle(
                                    color: kblack,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 37,
                                  ),
                                ),
                                h10,
                                Text(
                                  "${items?.PACKAGE_DAY} Days",
                                  style: TextStyle(
                                    color: kdeeporange900,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                                h10,
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${items?.PACKAGE_DESCRIPTION}",
                                    style: TextStyle(
                                        color: grey800,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15),
                                  ),
                                ),
                                h26,
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: LargeButton(
                                    onPress: () {
                                      Get.to(PhonePayPayment());
                                    },
                                    text: Text(
                                      "Buy Now",
                                      style: TextStyle(
                                          color: kwhite,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:grape_master/util/lodaer.dart';
import 'package:grape_master/util/no_activity_found.dart';
import 'package:provider/provider.dart';

import '../../util/color.dart';
import '../../util/constants.dart';
import '../../util/prefs/PreferencesKey.dart';
import '../../util/prefs/app_preference.dart';
import '../address/address_controller.dart';

class MyLeedsScreen extends StatefulWidget {
  const MyLeedsScreen({super.key, required this.ShopID});
   final   ShopID;

  @override
  State<MyLeedsScreen> createState() => _MyLeedsScreenState();
}

class _MyLeedsScreenState extends State<MyLeedsScreen> {
  AddressController? pve;

  @override
  void initState() {
    pve = Provider.of<AddressController>(context, listen: false);
    init();
    super.initState();
  }

  void init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await pve?.myleadModelApi(widget.ShopID);
      // await pve?.cityListApi();
      // await pve?.talukaListApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kgreen,
          title: Text(
            "My Leads",
            style: TextStyle(
                color: kwhite, fontWeight: FontWeight.w400, fontSize: 18),
          )),
      body: Consumer<AddressController>(builder: (context, ePv, child) {
        return ePv.myLeadsModel?.data! == null ? Center(child: Loader()): ePv.myLeadsModel?.data!.length == 0 ?Center(child: NoActivityFound(),): ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: ePv.myLeadsModel?.data!
                .length, // Replace 'itemCount' with the actual number of items
            itemBuilder: (context, index) {
              var item = ePv.myLeadsModel?.data![index];
              return Padding(
                padding: const EdgeInsets.all(9.0),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            alignment: Alignment.center,
                            height: 25,
                            width: 80,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [kgreen, klime],
                                ),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10))),
                            child: Text(
                              "${item?.regDate}",
                              style: TextStyle(color: kwhite),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Former Name -",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                 item!.fullName.toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 0.60,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Mobile No. -",
                                    style: TextStyle(
                                        color: klighblue,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "${item.mobileNumber}",
                                    style: TextStyle(
                                        color: klime,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 0.60,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Enquiry Date  -",
                                    style: TextStyle(
                                        fontSize: 15,
                                     
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "${item.regDate}",
                                    style: TextStyle(
                                      color:kblue,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 0.60,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Enquiry For - ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "${item.productName}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        h8,
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

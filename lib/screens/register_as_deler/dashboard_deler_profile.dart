import 'package:flutter/material.dart';
import 'package:grape_master/screens/register_as_deler/product_list_from.dart';
import 'package:grape_master/screens/register_as_deler/upadte_deler_profile.dart';
import 'package:grape_master/util/no_activity_found.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../util/color.dart';
import '../../util/constants.dart';
import '../../util/image_assets.dart';
import '../../util/lodaer.dart';
import '../../util/prefs/PreferencesKey.dart';
import '../../util/prefs/app_preference.dart';
import '../address/address_controller.dart';
import 'my_leeds.dart';

class DealerDashboardScreen extends StatefulWidget {
  const DealerDashboardScreen({super.key});

  @override
  State<DealerDashboardScreen> createState() => _DealerDashboardScreenState();
}

class _DealerDashboardScreenState extends State<DealerDashboardScreen> {
    AddressController? pve;

  bool isOpen = false;
  bool isOpen1 = false;
  bool isOpen2 = false;

  @override
  void initState() {
    pve = Provider.of<AddressController>(context, listen: false);
    init();
    super.initState();
  }

  void init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await pve?.delerlistinformationApi();
      // await pve?.cityListApi();
      // await pve?.talukaListApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
             Navigator.pop(context);
            pve?.cleardata();
           // pve?.imageData1();
           
          },
          child: Icon(Icons.arrow_back)),
          backgroundColor: kgreen,
          title: Text(
            "Dealer Dashboard",
            style: TextStyle(
                color: kwhite, fontWeight: FontWeight.w400, fontSize: 18),
          )),
      body: Consumer<AddressController>(builder: (context, ePv, child) {
       return ePv.delearListEmployeeModel?.DATA?.isEmpty ==  null ? Center(child: Loader(),):ePv.delearListEmployeeModel?.DATA?.length == 0 ? Center(child: NoActivityFound(),): Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 18,
                        ),
                        Row(
                          children: [
                            Text(
                              "Shop Name -",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${ePv.delearListEmployeeModel?.DATA!?[0]?.SHOP_NAME.toString()}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(height: 3),
                        Divider(
                          thickness: 0.60,
                        ),
                        Row(
                          children: [
                            Text(
                              "Dealer Name -",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${ePv.delearListEmployeeModel?.DATA?[0]?.DEALER_NAME.toString()}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(height: 3),
                        Divider(
                          thickness: 0.60,
                        ),
                        Row(
                          children: [
                            Text(
                              "Village  -",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${ ePv.delearListEmployeeModel?.DATA?[0]?.VILLAGE.toString()}",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(height: 3),
                        Divider(
                          thickness: 0.60,
                        ),
                        Row(
                          children: [
                            Text(
                              "Mobile No - ",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${ePv.delearListEmployeeModel?.DATA![0]?.CONTACT_NUMBER.toString()}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(height: 3),
                        Divider(
                          thickness: 0.60,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Align(
                alignment: Alignment.centerRight,
                child: InkWell(
             onTap: (){
              ePv.updateLocation(context);
             },
                  child: Container(
                    alignment: Alignment.center,
                    height: 42,
                    width: 130,
                    decoration: BoxDecoration(color: kgreen),
                    child: Text(
                      "Update  Location",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            ),
            h10,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType
                                  .fade, // Choose your desired animation type
                              child: UpdateDealer(items:  ePv.delearListEmployeeModel!.DATA![0]!)),
                        );
                      },
                      child: Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: 140,
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
                                ImageAssets.ic_man1,
                                height: 70,
                              ),
                              h10,
                              Text(
                                "My Profile",
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
                  ),
                  w10,
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType
                                  .fade, // Choose your desired animation type
                              child: MyLeedsScreen(ShopID: ePv.delearListEmployeeModel!.DATA![0]!.SHOP_ID.toString(),)),
                        );
                      },
                      child: Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: 140,
                          width: 160,
                          decoration: BoxDecoration(
                              color: kgreen50,
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Image.asset(
                                ImageAssets.ic_lead,
                                height: 70,
                              ),
                              h10,
                              Text(
                                "My Leads",
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
                  ),
                ],
              ),
            ),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType
                            .fade, // Choose your desired animation type
                        child: ProductListdeler(shopid:ePv.delearListEmployeeModel!.DATA![0]!.SHOP_ID.toString(),)),
                  );
                },
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: 140,
                    width: 180,
                    decoration: BoxDecoration(
                        color: kdeeporange,
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Image.asset(
                          ImageAssets.ic_lead,
                          height: 70,
                        ),
                        h10,
                        Text(
                          "Product",
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
            ),
          ],
        );
      }
      ),
    );
  }
}

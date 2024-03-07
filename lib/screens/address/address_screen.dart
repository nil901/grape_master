import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:grape_master/util/color.dart';
import 'package:grape_master/util/constants.dart';
import 'package:provider/provider.dart';
import '../../util/large_button.dart';
import '../../util/prefs/PreferencesKey.dart';
import '../../util/prefs/app_preference.dart';
import '../../util/util.dart';
import '../auth/LocalString.dart';
import '../post/post_controller.dart';
import 'address_controller.dart';

// ignore: must_be_immutable
class AddressScreen extends StatefulWidget {
  AddressScreen({super.key, this.name});
  final name;

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final stateController = TextEditingController();

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
      await pve?.stateListApi();
      await pve?.cityListApi();
      await pve?.talukaListApi();
      AppPreference().initialAppPreference();
      
    });
  }

  @override
  Widget build(BuildContext context) {
    String? mobile = AppPreference().getString(PreferencesKey.umobile);
    String? fullname = AppPreference().getString(PreferencesKey.uName);

    pve?.mobileNumbercontroller.text = mobile;
    pve?.fullNamecontroller.text = widget.name == null ? fullname : widget.name;
    return WillPopScope(
      onWillPop: () async {
    // Handle back button press
     SystemNavigator.pop();
      _oneButtonPressed(context);
      
    return false; // Return false to prevent default behavior
  },
      child: Scaffold(
        appBar: AppBar(
           leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kwhite),
          onPressed: () {
            // Navigate back when the back arrow is pressed
              //  Navigator.of(context).pop();
               _oneButtonPressed(context);
             SystemNavigator.pop();
              

        
          },
        ),
            backgroundColor: kgreen,
            title: Text(
              profile.tr,
              style: TextStyle(
                  color: kwhite, fontWeight: FontWeight.w400, fontSize: 22),
            )),
        body: Consumer<AddressController>(builder: (context, ePv, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  h20,
                  Text(
                      txt_fullname.tr,
                    style: TextStyle(
                        color: kgreen,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                  TextField(
                    controller: ePv.fullNamecontroller,
                    cursorColor: kblack,
                    style: TextStyle(color: kblack),
                    decoration: InputDecoration(
                     contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: klime), // Change color here
                      ),
                    ),
                  ),
                  h20,
                  Text(
                    txt_mobile.tr,
                    style: TextStyle(
                        color: kgreen,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                  TextField(
                    cursorColor: kblack,
                    controller: ePv.mobileNumbercontroller,
                    enabled: false
                    ,
                    style: TextStyle(color: kblack),
                    decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: klime), // Change color here
                      ),
                    ),
                  ),
                  h24,
                  Text(
                    txt_state.tr,
                    style: TextStyle(
                        color: kgreen,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                  h10,
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: kblack, width: 0.3),
                          borderRadius: BorderRadius.circular(3)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: Text(
                            txt_select_state.tr,
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: ePv.stateModel?.data
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item.stateId.toString(),
                                        child: Text(
                                          item.stateName,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  ?.toList() ??
                              [],
                          value: ePv.selectedState,
                          onChanged: (value) async {
                            setState(() {
                              ePv.selectedState =
                                  value; // Corrected assignment here
                              pve!.selectedStateId = value;
                              ePv.selectedCity = null;
                              ePv.cityid = null;
                              ePv.cityid = null;
                              ePv.selectedtaluka = null;
                              //ePv.selectedCity = null;
                              // ePv.selectedCity = "";
                              // ePv.citymodel?.data.clear();

                              print(pve!.selectedStateId);

                              pve?.cityListApi();
                              if (pve!.selectedState == 'null') {
                                Utils().validationTostmassage(txt_select_state.tr);
                              } else {
                                // await pve?.cityListApi();
                              }

                              print(value);
                            });
                          },
                          buttonStyleData: const ButtonStyleData(
                            // padding: EdgeInsets.symmetric(horizontal: 5),
                            height: 40,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                  h20,
                  Text(
                    txt_district.tr,
                    style: TextStyle(
                        color: kgreen,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                  h10,
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: kblack, width: 0.3),
                        borderRadius: BorderRadius.circular(3)),
                    child: InkWell(
                      onTap: () {
                        if (ePv.selectedState == null) {
                          Utils().validationTostmassage(
                            txt_select_district.tr,
                          );
                        }
                      },
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: Text(
                            txt_select_district.tr,
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: ePv.citymodel?.data
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item.cityId.toString(),
                                        child: Text(
                                          item.cityName,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  ?.toList() ??
                              [],
                          value: ePv.selectedCity,
                          onChanged: (value) async {
                            setState(() {
                              ePv.cityid = null;
                              ePv.selectedtaluka = null;
                              ePv.talukaId = null;

                              pve!.selectedCity = value;
                              ePv.cityid = value;
                              print(value);
                              ePv.talukaListApi();
                            });
                          },
                          buttonStyleData: const ButtonStyleData(
                            // padding: EdgeInsets.symmetric(horizontal: 5),
                            height: 40,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                  h12,
                  Text(
                    txt_Taluka.tr,
                    style: TextStyle(
                        color: kgreen,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                  h10,
                  InkWell(
                    onTap: () {
                      if (ePv.selectedState == null) {
                        Utils().validationTostmassage(
                          txt_select_Taluka.tr,
                        );
                      } else {}
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: kblack, width: 0.3),
                          borderRadius: BorderRadius.circular(3)),
                      child: InkWell(
                        onTap: () {
                          if (ePv.selectedCity == null) {
                            Utils().validationTostmassage("Select state");
                          }
                        },
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Text(
                              txt_select_Taluka.tr,
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: ePv.talukamodel?.data
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item.talukaId.toString(),
                                          child: Text(
                                            item.talukaName,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    ?.toList() ??
                                [],
                            value: ePv.selectedtaluka,
                            onChanged: (value) async {
                              setState(() {
                                ePv.talukaId = null;
                                pve!.selectedtaluka = value;
                                ePv.talukaId = value;
                                print(value);
                              });
                            },
                            buttonStyleData: const ButtonStyleData(
                              // padding: EdgeInsets.symmetric(horizontal: 5),
                              height: 40,
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  h12,
                  Text(
                    txt_Village.tr,
                    style: TextStyle(
                        color: kgreen,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                  h10,
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: kblack, width: 0.3),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15 ),
                      child: TextField(
                        controller: ePv.vilageNameController,
                        cursorColor: Colors.black,
                        style: TextStyle(
                            fontSize: 13,
                            color: grey800,
                            fontWeight: FontWeight.w400),
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(fontSize: 15, color: grey800),
                          hintText: txt_Village.tr,
                        ),
                      ),
                    ),
                  ),
                  h30,
                  Center(
                    child: LargeButton(
                      onPress: () {
                        ePv.addressApi(context);
                        // Navigator.push(
                        //   context,
                        //   PageTransition(
                        //     type: PageTransitionType.fade, // Choose your desired animation type
                        //     child: MyHomePage(),
                        //   ),
                        // );

                        // Get.to(MyHomePage());
                      },
                      text: Text(
                        txt_submit.tr,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: kwhite),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Future<bool> _oneButtonPressed(BuildContext context) async {
    DateTime backPressedTime = DateTime.now();
    final differene = DateTime.now().difference(backPressedTime);
    backPressedTime = DateTime.now();

    if (differene >= const Duration(seconds: 2)) {
      Fluttertoast.showToast(
        msg: "Click Again To Close The App",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: kblack,
        textColor: kwhite,
        fontSize: 13.0,
      );
      return false;
    } else {
      SystemNavigator.pop(animated: true);
      return true;
    }
  }
}

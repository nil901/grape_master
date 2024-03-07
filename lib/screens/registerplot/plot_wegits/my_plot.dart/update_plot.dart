import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/auth/LocalString.dart';
import 'package:grape_master/screens/registerplot/plot_controller.dart';
import 'package:grape_master/util/constants.dart';
import 'package:grape_master/util/image_assets.dart';
import 'package:grape_master/util/large_button.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../../model/home_model/plot_model.dart';
import '../../../../util/color.dart';

class UpdatePlot extends StatefulWidget {
  const UpdatePlot({
    super.key, required this.plotdetails,
  });
   final PlotRagisterModelDATA plotdetails;

  @override
  State<UpdatePlot> createState() => _UpdatePlotState();
}

class _UpdatePlotState extends State<UpdatePlot> {
  bool isOpen = false;
  bool isOpen2 = false;
  bool isOpen3 = false;
  bool isOpen4 = false;

  String selectedValue = 'Caltivation type';
  int? selectedValue1;
  String selectedvarity = 'Variety';
  String selectedtypeofLand = 'Type of land';
  DateTime selectedDate = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      print('Selected Date: ${selectedDate.toLocal()}');
    }
  }

  plotcnt? eProvider;
  void initState() {
  

    eProvider = Provider.of<plotcnt>(context, listen: false);
    init();
    // TODO: implement initState
    super.initState();
  }

  void init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
     eProvider?.landtype =  widget.plotdetails.ST_ID == null ? null :  widget.plotdetails.ST_ID ;
      eProvider?.cultivationType =  widget.plotdetails.CHATANI_ID ?? "";
       eProvider?.updatedatetimeContoller.text =  widget.plotdetails.SOWING_DATE.toString() == 'null' ?"-": widget.plotdetails.SOWING_DATE.toString(); 
      await eProvider?.culitivationApi();
      await eProvider?.vationApi();
      await eProvider?.landTypeApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    //  log(" crop id : -- ${widget.cropid.cropId}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kgreen,
        leading: InkWell(
            onTap: () {
              eProvider?.cultivationcontroller.clear();
              eProvider?.varietycontroller.clear();
              eProvider?.datetimeContoller.clear();
              eProvider?.landtypeContoller.clear();
              eProvider?.plantingDistance.clear();
              eProvider?.pastproblemController.clear();
              eProvider?.plantingDistance1.clear();
              eProvider?.newQuetionnController.clear();
              eProvider?.quetionCategoreyController.clear();
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
        title: Text(
          "${txt_my_plot.tr} - ${widget.plotdetails.CROP_NAME}",
          style: TextStyle(
            color: kwhite,
            fontWeight: FontWeight.w400,
            fontSize: 22,
          ),
        ),
      ),
      body: Consumer<plotcnt>(builder: (context, ePv, child) {
        ePv.updatecultivationcontroller.text = widget.plotdetails.V_NAME.toString() == 'null'? "-": widget.plotdetails.V_NAME.toString();
        ePv.soiltypeController.text = widget.plotdetails.ST_NAME.toString();

      //  ePv.updatelandtypeContoller.text = widget.plotdetails.ST_NAME.toString();
       ePv.waterScorceController.text = widget.plotdetails.WATER_SOURCE.toString() == 'null' ?"-": widget.plotdetails.WATER_SOURCE.toString(); 
       ePv.updateplantingDistance.text = widget.plotdetails.CROP_DISTANCE.toString();
       ePv!.updateplotAreaController.text =widget.plotdetails.PLOT_AREA.toString();
       ePv.previousController.text = widget.plotdetails.PREVIOUS_YEAR_PROBLEM.toString() == 'null' ?'-':widget.plotdetails.PREVIOUS_YEAR_PROBLEM.toString();
        // ePv.verityid = widget.plotdetails.CROPVARIETY_ID;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            h2,
                            Text(
                              "पीक व्हारायटी निवडा *",
                              style: TextStyle(
                                  color: kgreen,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                            h10,
                            Container(
                              height: 35,
                              decoration: BoxDecoration(
                                // border: Border.all(width: 0.5, color: ktext),
                                color: lgrey,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: TextField(
                                          enabled: false,
                                          controller: ePv!.updatecultivationcontroller,
                                          cursorColor: klime,
                                          style: TextStyle(color: kblack),
                                          decoration: InputDecoration(
                                            hintText: "Select State",
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  
                                  ],
                                ),
                              ),

                            ),
                            h10,
                            Text(
                             txt_select_chatni_type.tr,
                              style: TextStyle(
                                  color: kgreen,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                            h10,
                            Container(
                              height: 35,
                              decoration: BoxDecoration(
                                  border: Border.all(color: kblack, width: 0.3),
                                  borderRadius: BorderRadius.circular(3)),
                              child: InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      isExpanded: true,
                                      hint: Text(
                                        txt_select_chatni_type.tr,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      items: ePv.cultivationTypeModel?.data
                                              .map((item) =>
                                                  DropdownMenuItem<String>(
                                                    value: item.chataniId
                                                        .toString(),
                                                    child: Text(
                                                      item.chataniType,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ))
                                              ?.toList() ??
                                          [],
                                      value: ePv.cultivationType,
                                      onChanged: (value) async {
                                        setState(() {
                                          ePv.cultivationType = value;

                                          var selectedCrop =
                                              ePv.selectedcrop?.data.firstWhere(
                                            (item) =>
                                                item.cropId.toString() == value,
                                            orElse: () => ePv.selectedcrop!.data
                                                .first, // Fallback if not found
                                          );
                                          ePv.cultivationname =
                                              selectedCrop?.cropName;
                                          print(
                                              'Selected Crop ID: ${selectedCrop?.cropId}');
                                          print(
                                              'Selected Crop Name: ${selectedCrop?.cropName}');
                                          print(value);
                                        });
                                      },
                                      buttonStyleData: const ButtonStyleData(
                                        // padding: EdgeInsets.symmetric(horizontal: 5),
                                        height: 40,
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 40,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          
                            if (isOpen)
                              ListView(
                                shrinkWrap: true,
                                primary: false,
                                children:
                                    ePv.cultivationTypeModel!.data.map((state) {
                                  return Container(
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            onTap: () {
                                              isOpen = false;
                                              ePv!.updatecultivationcontroller.text =
                                                  state.chataniType;
                                              setState(() {});
                                            },
                                            child: Text(state.chataniType,
                                                style: TextStyle(fontSize: 16)),
                                          )));
                                }).toList(),
                              ),
                            h14,
                            Text(
                                                            txt_date_of_planting.tr,

                              style: TextStyle(
                                  color: kgreen,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                            h10,
                            InkWell(
                              onTap: () async {
                                await selectDate(context);
                                // Format the selected date and set it to the _datetimeController.text
                                String displayFormat = DateFormat('dd-MM-yyyy').format(selectedDate);
  ePv.updatedatetimeContoller.text = displayFormat;

  // Convert the date to 'yyyy-MM-dd' format for API
   ePv.apidateformat = DateFormat('yyyy-MM-dd').format(selectedDate);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                height: 35,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(width: 0.5, color: ktext),
                                    borderRadius: BorderRadius.circular(3)),
                                child: Padding(
                                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: TextField(
                                    style: TextStyle(color: kblack),
                                    controller: ePv.updatedatetimeContoller,
                                    enabled: false,
                                    onTap: () {
                                      print("dkdkd");
                                      selectDate(context);
                                    },
                                    cursorColor: klime,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Date of Planting",
                                        hintStyle: TextStyle(
                                            color: grey800, fontSize: 15)),
                                  ),
                                ),
                              ),
                            ),
                            h10,
                            Text(
                             txt_soil_type.tr,
                              style: TextStyle(
                                  color: kgreen,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                            h10,
                              Container(
                                    height: 35,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: kblack, width: 0.3),
                                        borderRadius: BorderRadius.circular(3)),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton2<String>(
                                            isExpanded: true,
                                            hint: Text(
                                              jaminprakar.tr,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color:
                                                    Theme.of(context).hintColor,
                                              ),
                                            ),
                                            items: ePv.landTypeModel?.data
                                                    .map((item) =>
                                                        DropdownMenuItem<
                                                            String>(
                                                          value: item.stId
                                                              .toString(),
                                                          child: Text(
                                                            item.stName,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ))
                                                    ?.toList() ??
                                                [],
                                            value: ePv.landtype,
                                            onChanged: (value) async {
                                            setState(() {
                                              
                                            });
                                                ePv.landtype = value;

                                                print(value);
                                             
                                            },
                                            buttonStyleData:
                                                const ButtonStyleData(
                                              // padding: EdgeInsets.symmetric(horizontal: 5),
                                              height: 40,
                                            ),
                                            menuItemStyleData:
                                                const MenuItemStyleData(
                                              height: 40,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                            h10,
                            if (isOpen3)
                              ListView(
                                shrinkWrap: true,
                                primary: false,
                                children: ePv.landTypeModel!.data.map((state) {
                                  return Container(
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            onTap: () {
                                              isOpen3 = false;
                                              ePv!.soilId = state.stId;
                                              ePv!.landtypeContoller.text =
                                                  state.stName;
                                              setState(() {});
                                            },
                                            child: Text(state.stName,
                                                style: TextStyle(fontSize: 16)),
                                          )));
                                }).toList(),
                              ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "सिंचन स्रोत निवडा (एकाधिक निवड) *",
                                  style: TextStyle(
                                      color: kgreen,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                                h10,
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: RatingDialog(),
                                          );
                                        });
                                  },
                                  child: Container(
                                    height: 35,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0.5, color: ktext),
                                        borderRadius: BorderRadius.circular(3)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                        child: TextField(
                                          enabled: false,
                                          controller: ePv!.waterScorceController,
                                          cursorColor: klime,
                                          style: TextStyle(color: kblack),
                                          decoration: InputDecoration(
                                            hintText: "सिंचन स्रोत निवडा",
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            h10,
                            Text(
                              "पिकतील अंतर",
                              style: TextStyle(
                                  color: kgreen,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                            h10,
                            InkWell(
                              onTap: () {
                                setState(() {});
                                isOpen3 = !isOpen3;
                              },
                              child: Container(
                                height: 35,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(width: 0.5, color: ktext),
                                    borderRadius: BorderRadius.circular(3)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: TextField(
                                    controller: ePv!.updateplantingDistance,
                                    cursorColor: klime,
                                    style: TextStyle(color: kblack),
                                    decoration: InputDecoration(
                                      hintText: "type of land",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            h10,
                            Text(
                              "उद्देश",
                              style: TextStyle(
                                  color: kgreen,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                            h10,
                            Container(
                              height: 35,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0.5, color: ktext),
                                  borderRadius: BorderRadius.circular(3)),
                              child: Row(
                                children: [
                                  Radio<String>(
                                    activeColor: kblue,
                                    value: 'Export',
                                    groupValue: ePv.updaesh,
                                    onChanged: (value1) {
                                      setState(() {
                                        ePv.updaesh = value1!;
                                        // print(value.selectedGender);
                                        // _selectedGender = value!;
                                      });
                                    },
                                  ),
                                  Text(
                                  txt_export.tr,
                                    style: TextStyle(
                                        color: kblack,
                                        fontSize: 15,
                                        fontFamily: 'newfont'),
                                  ),
                                  Radio<String>(
                                    activeColor: kblue,
                                    value: 'Local',
                                    groupValue: ePv.updaesh,
                                    onChanged: (value1) {
                                      setState(() {
                                        ePv.updaesh = value1!;
                                      });
                                    },
                                  ),
                                  Text(
                                   txt_local.tr,
                                    style: TextStyle(
                                        color: kblack,
                                        fontSize: 15,
                                        fontFamily: 'newfont'),
                                  ),
                                ],
                              ),
                            ),
                             h10,
                            Text(
                              "प्लॉट चे क्षेत्रफळ (एकर मध्ये) *",
                              style: TextStyle(
                                  color: kgreen,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                            h10,
                            InkWell(
                              onTap: () {
                                setState(() {});
                                isOpen3 = !isOpen3;
                              },
                              child: Container(
                                height: 35,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(width: 0.5, color: ktext),
                                    borderRadius: BorderRadius.circular(3)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: TextField(
                                    controller: ePv!.updateplotAreaController,
                                    cursorColor: klime,
                                    style: TextStyle(color: kblack),
                                    decoration: InputDecoration(
                                      hintText: "type of land",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          
                              h10,
                            Text(
                              "मागील वर्षी आलेल्या समस्या",
                              style: TextStyle(
                                  color: kgreen,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                            h10,
                            InkWell(
                              onTap: () {
                                setState(() {});
                                isOpen3 = !isOpen3;
                              },
                              child: Container(
                                height: 35,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(width: 0.5, color: ktext),
                                    borderRadius: BorderRadius.circular(3)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18),
                                  child: TextField(
                                    controller: ePv!.previousController,
                                    cursorColor: klime,
                                    style: TextStyle(color: kblack),
                                    decoration: InputDecoration(
                                      hintText: "type of land",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            h10,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // SizedBox(height: MediaQuery.of(context).size.height -610,),
              h10,
              LargeButton(
                onPress: () {
                  ePv.editplot(context,widget.plotdetails.CROPVARIETY_ID.toString());
                },
                text: Text(
                 submit.tr,
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w700, color: kwhite),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
 

  //  "PLOT_ID": "",
  //     "USER_ID": 	
  //     "CROP_ID": CropId.toString(),
  //     "CROPVARIETY_ID": veriteytype.toString(),
  //     "CHATANI_ID": chataniid == null ? "" : chataniid,
  //     "ST_ID":landtype,
  //     "WATER_SOURCE": waterScorceController.text,
  //     "PLOT_SRUCTURE": "",
  //     "CULTIVATION_TYPE": cultivationname!.replaceAll("-", "null"),
  //     "METHOD_OF_WATER": waterspplayplot.replaceAll("-", "null"),
  //     "CROP_DISTANCE":distance!.replaceAll("-", "null") ,
  //     "EXPORT_LOCAL":updaesh!.replaceAll("-", "null"),
  //     "PLOT_AREA": caluculateareacontroller.text,
  //     "LATITUDE_1": "",
  //     "LONGITUDE_1": "",
  //     "LATITUDE_2": "",
  //     "LONGTUDE_2": "",
  //     "PREVIOUS_YEAR_PROBLEM": previousController.text,
  //     "SOWING_DATE": "02\/14\/2024",
  //     "TASK": "EDIT",
  //     "EXTRA1": "",
  //     "EXTRA2": "",
  //     "EXTRA3": "",
  //     "LANG_ID": ""
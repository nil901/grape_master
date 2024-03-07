import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/auth/LocalString.dart';
import 'package:grape_master/screens/registerplot/plot_controller.dart';
import 'package:grape_master/util/constants.dart';
import 'package:grape_master/util/image_assets.dart';
import 'package:grape_master/util/large_button.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../model/home_model/selected_crop_model.dart';
import '../../util/color.dart';
import '../Home/google_map.dart';

class CropFormAdd extends StatefulWidget {
  const CropFormAdd({super.key, required this.cropid});
  final CropModel cropid;

  @override
  State<CropFormAdd> createState() => _CropFormAddState();
}

class _CropFormAddState extends State<CropFormAdd> {
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
      lastDate: DateTime.now(),
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
        eProvider?.selctedvalue= null;
   eProvider?. cultivationType= null;
  eProvider?. veriteytype= null;
 eProvider?.landtype= null;
   eProvider?. chataniid;
      await eProvider?.chataniApi();
      await eProvider?.culitivationApi();
      await eProvider?.vationApi();
      await eProvider?.landTypeApi();
      Future.delayed(const Duration(milliseconds: 5), () {

// Here you can write your code

setState(()async {
   await eProvider?.chataniApi();
      await eProvider?.culitivationApi();
      await eProvider?.vationApi();
      await eProvider?.landTypeApi();
// Here you can write your code for open new view
});

});
    });

    eProvider?.plantingDistance?.addListener(() {
      // Implement the logic to restrict multiple consecutive dots
      String? text = eProvider?.plantingDistance?.text?.toString();
      if (text != null && text.contains('..')) {
        eProvider?.plantingDistance?.text = text.replaceAll('..', '.');
        eProvider?.plantingDistance?.selection = TextSelection.fromPosition(
          TextPosition(offset: eProvider?.plantingDistance?.text?.length ?? 0),
        );
      }
    });

    eProvider?.plantingDistance1?.addListener(() {
      // Implement the logic to restrict multiple consecutive dots
      String? text = eProvider?.plantingDistance1?.text?.toString();
      if (text != null && text.contains('..')) {
        eProvider?.plantingDistance1?.text = text.replaceAll('..', '.');
        eProvider?.plantingDistance1?.selection = TextSelection.fromPosition(
          TextPosition(offset: eProvider?.plantingDistance1?.text?.length ?? 0),
        );
      }
    });

    eProvider?.caluculateareacontroller?.addListener(() {
      // Implement the logic to restrict multiple consecutive dots
      String? text = eProvider?.caluculateareacontroller?.text?.toString();
      if (text != null && text.contains('..')) {
        eProvider?.caluculateareacontroller?.text = text.replaceAll('..', '.');
        eProvider?.caluculateareacontroller?.selection =
            TextSelection.fromPosition(
          TextPosition(
              offset: eProvider?.caluculateareacontroller?.text?.length ?? 0),
        );
      }
    });
    eProvider?.waterScorceController?.addListener(() {
      // Implement the logic to restrict multiple consecutive dots
      String? text = eProvider?.waterScorceController?.text?.toString();
      if (text != null && text.contains('..')) {
        text = text.replaceAll('[', '.').replaceAll(']', '.');
        eProvider?.waterScorceController?.text = text;
        eProvider?.waterScorceController?.selection =
            TextSelection.fromPosition(
          TextPosition(
              offset: eProvider?.waterScorceController?.text?.length ?? 0),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    log(" crop id aa: -- ${widget.cropid.cropId}");

    //  eProvider?.CropId = widget.cropid.cropId.toString();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kgreen,
        leading: InkWell(
            onTap: () {
              eProvider?.cultivationType = null;
              eProvider?..veriteytype = null;
              eProvider?.landtype = null;
              eProvider?.cultivationcontroller.clear();
              eProvider?.varietycontroller.clear();
              eProvider?.datetimeContoller.clear();
              eProvider?.landtypeContoller.clear();
              eProvider?.plantingDistance.clear();
              eProvider?.pastproblemController.clear();
              eProvider?.plantingDistance1.clear();
              eProvider?.newQuetionnController.clear();
              eProvider?.quetionCategoreyController.clear();
              eProvider?.waterScorceController.clear();
              eProvider?.selectedOptions.clear();
              eProvider?.caluculateareacontroller.clear();

              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
        title: Text(
          widget.cropid.cropName,
          style: TextStyle(
            color: kwhite,
            fontWeight: FontWeight.w400,
            fontSize: 22,
          ),
        ),
      ),
      body: Consumer<plotcnt>(builder: (context, ePv, child) {
        ePv.CropId = widget.cropid.cropId.toString();

        log(" crop idss : -- ${ePv.CropId}");
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
                            if (widget.cropid.cropId == 1)
                             Text(
                              txt_variety.tr,
                              style: TextStyle(
                                  color: kgreen,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                              if(widget.cropid.cropId ==1)
                            h10,
                              if(widget.cropid.cropId ==1)
                            Container(
                              height: 35,
                              decoration: BoxDecoration(
                                  border: Border.all(color: kblack, width: 0.3),
                                  borderRadius: BorderRadius.circular(3)),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    isExpanded: true,
                                    hint: Text(
                                      txt_variety.tr,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    items: ePv.varietyModel?.data
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item.cropvarietyId
                                                      .toString(),
                                                  child: Text(
                                                    item.cropvarietyName,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ))
                                            ?.toList() ??
                                        [],
                                    value: ePv.veriteytype,
                                    onChanged: (value) async {
                                      setState(() {
                                        ePv.veriteytype = value;

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
                              h10,
                              if(widget.cropid.cropId ==1)
                              Text(
                                txt_select_chatni_type.tr,
                                style: TextStyle(
                                    color: kgreen,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              ),
                            h10,
                            if (widget.cropid.cropId == 1)
                              Container(
                                height: 35,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: kblack, width: 0.3),
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
                                        items: ePv.chatanitypeModel?.data
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
                                        value: ePv.chataniid,
                                        onChanged: (value) async {
                                          setState(() {
                                            ePv.chataniid = value;

                                            var selectedCrop = ePv
                                                .chatanitypeModel?.data
                                                .firstWhere(
                                              (item) =>
                                                  item.chataniId.toString() ==
                                                  value,
                                              orElse: () => ePv
                                                  .chatanitypeModel!
                                                  .data
                                                  .first, // Fallback if not found
                                            );
                                            //   ePv.cultivationname = selectedCrop?.chataniId;
                                            print(
                                                'Selected Crop ID: ${selectedCrop?.chataniId}');
                                            print(
                                                'Selected Crop Name: ${selectedCrop?.chataniType}');
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
                                if(widget.cropid.cropId == 1)
                              h10,
                              if(widget.cropid.cropId == 1)
                              
                            Text(
                              txt_date_of_planting.tr,
                              style: TextStyle(
                                  color: kgreen,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                              if(widget.cropid.cropId == 1)
                            h10,
                              if(widget.cropid.cropId == 1)
                            InkWell(
                              onTap: () async {
                                await selectDate(context);
                                // Format the selected date and set it to the _datetimeController.text
                                ePv.datetimeContoller.text =
                                    DateFormat('dd-MM-yyyy')
                                        .format(selectedDate);
                                      ePv.apidateformat = DateFormat('yyyy-MM-dd').format(selectedDate);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                height: 35,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(width: 0.5, color: ktext),
                                    borderRadius: BorderRadius.circular(3)),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        style: TextStyle(color: kblack),
                                        controller: ePv.datetimeContoller,
                                        enabled: false,
                                        onTap: () {
                                          print("dkdkd");
                                          selectDate(context);
                                        },
                                        cursorColor: klime,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: txt_date_of_planting.tr,
                                            hintStyle: TextStyle(
                                                color: grey800, fontSize: 15)),
                                      ),
                                    ),
                                    Icon(Icons.arrow_drop_down)
                                  ],
                                ),
                              ),
                            ),
                              if(widget.cropid.cropId != 1)
                          
                            // s
                            
                            //  if(widget.cropid.cropId != 1)
                            Text(
                              txt_lagvadiche_prakar.tr,
                              style: TextStyle(
                                  color: kgreen,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                             if(widget.cropid.cropId != 1)
                            h10,
                             if(widget.cropid.cropId != 1)
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
                                        txt_lagvadiche_prakar.tr,
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
                            h10,
                            if(widget.cropid.cropId != 1)
                            Text(
                              txt_date_of_planting.tr,
                              style: TextStyle(
                                  color: kgreen,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                              if(widget.cropid.cropId != 1)
                            h10,
                              if(widget.cropid.cropId != 1)
                            InkWell(
                              onTap: () async {
                                await selectDate(context);
                                // Format the selected date and set it to the _datetimeController.text
                                ePv.datetimeContoller.text =
                                    DateFormat('dd-MM-yyyy')
                                        .format(selectedDate);
                                      ePv.apidateformat = DateFormat('yyyy-MM-dd').format(selectedDate);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                height: 35,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(width: 0.5, color: ktext),
                                    borderRadius: BorderRadius.circular(3)),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        style: TextStyle(color: kblack),
                                        controller: ePv.datetimeContoller,
                                        enabled: false,
                                        onTap: () {
                                          print("dkdkd");
                                          selectDate(context);
                                        },
                                        cursorColor: klime,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: txt_date_of_planting.tr,
                                            hintStyle: TextStyle(
                                                color: grey800, fontSize: 15)),
                                      ),
                                    ),
                                    Icon(Icons.arrow_drop_down)
                                  ],
                                ),
                              ),
                            ),
                            h10,
                            if(widget.cropid.cropId !=1)
                            Text(
                              txt_variety.tr,
                              style: TextStyle(
                                  color: kgreen,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                              if(widget.cropid.cropId !=1)
                            h10,
                              if(widget.cropid.cropId !=1)
                            Container(
                              height: 35,
                              decoration: BoxDecoration(
                                  border: Border.all(color: kblack, width: 0.3),
                                  borderRadius: BorderRadius.circular(3)),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    isExpanded: true,
                                    hint: Text(
                                      txt_variety.tr,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    items: ePv.varietyModel?.data
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item.cropvarietyId
                                                      .toString(),
                                                  child: Text(
                                                    item.cropvarietyName,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ))
                                            ?.toList() ??
                                        [],
                                    value: ePv.veriteytype,
                                    onChanged: (value) async {
                                      setState(() {
                                        ePv.veriteytype = value;

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
                              if (widget.cropid.cropId !=1)
                            h10,
                            if (widget.cropid.cropId != 22 &&
                                widget.cropid.cropId != 21)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    if (widget.cropid.cropId ==1)
                                  h10,
                                  Text(
                                    jaminprakar.tr,
                                    style: TextStyle(
                                        color: kgreen,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  )
                                  ,
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
                                                ePv.landtype = value;

                                                print(value);
                                              });
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
                                ],
                              ),
                            if (widget.cropid.cropId == 3 ||
                                widget.cropid.cropId == 9 ||
                                widget.cropid.cropId == 4 ||
                                widget.cropid.cropId == 2 ||
                                widget.cropid.cropId == 1 ||
                                widget.cropid.cropId == 6 ||
                                widget.cropid.cropId == 11 ||
                                widget.cropid.cropId == 8 ||
                                widget.cropid.cropId == 10)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    select_irrigation_source_multiple_selection
                                        .tr,
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
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: RatingDialog(),
                                            );
                                          });
                                    },
                                    child: Container(
                                      height: 35,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 0.5, color: ktext),
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: TextField(
                                          enabled: false,
                                          controller: ePv.waterScorceController,
                                          cursorColor: klime,
                                          style: TextStyle(color: kblack),
                                          decoration: InputDecoration(
                                            hintText:
                                                select_irrigation_source.tr,
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            if (widget.cropid.cropId == 3)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  h10,
                                  Text(
                                    txt_structure.tr,
                                    style: TextStyle(
                                        color: kgreen,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  h10,
                                  Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: kblack, width: 0.35)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 35,
                                            child: RadioListTile(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 0),
                                              title: Text(
                                                txt_shednet.tr,
                                                style: TextStyle(
                                                    color: kblack,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15),
                                              ),
                                              value: txt_shednet.tr,
                                              groupValue: ePv.rachna1,
                                              onChanged: (value) {
                                                setState(() {
                                                  ePv.rachna1 =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            child: RadioListTile(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 0),
                                              title: Text(
                                                txt_polyhouse.tr,
                                                style: TextStyle(
                                                    color: kblack,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15),
                                              ),
                                              value: txt_polyhouse.tr,
                                              groupValue: ePv.rachna1,
                                              onChanged: (value) {
                                                setState(() {
                                                  ePv.rachna1 =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            child: RadioListTile(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 0),
                                              title: Text(
                                                txt_open.tr,
                                                style: TextStyle(
                                                    color: kblack,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15),
                                              ),
                                              value: txt_open.tr,
                                              groupValue: ePv.rachna1,
                                              onChanged: (value) {
                                                setState(() {
                                                  ePv.rachna1 =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                          ),
                                          h10
                                        ],
                                      )),
                                ],
                              ),
                            if (widget.cropid.cropId == 10 ||
                                widget.cropid.cropId == 9 ||
                                widget.cropid.cropId == 6 ||
                                widget.cropid.cropId == 2 ||
                                widget.cropid.cropId == 11 ||
                                widget.cropid.cropId == 8)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  h10,
                                  Text(
                                    txt_lagvad_padhat.tr,
                                    style: TextStyle(
                                        color: kgreen,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  h10,
                                  Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: kblack, width: 0.35)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 35,
                                            child: RadioListTile(
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              visualDensity:
                                                  const VisualDensity(
                                                horizontal: VisualDensity
                                                    .minimumDensity,
                                                vertical: VisualDensity
                                                    .minimumDensity,
                                              ),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 0),
                                              title: Text(
                                                txt_surrey_method.tr,
                                                style: TextStyle(
                                                    color: kblack,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15),
                                              ),
                                              value: txt_surrey_method.tr,
                                              groupValue: ePv.selectedOption,
                                              onChanged: (value) {
                                                setState(() {
                                                  ePv.selectedOption =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            child: RadioListTile(
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              visualDensity:
                                                  const VisualDensity(
                                                horizontal: VisualDensity
                                                    .minimumDensity,
                                                vertical: VisualDensity
                                                    .minimumDensity,
                                              ),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 0),
                                              title: Text(
                                                txt_bed_method.tr,
                                                style: TextStyle(
                                                    color: kblack,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15),
                                              ),
                                              value: txt_bed_method.tr,
                                              groupValue: ePv.selectedOption,
                                              onChanged: (value) {
                                                setState(() {
                                                  ePv.selectedOption =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            child: RadioListTile(
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              visualDensity:
                                                  const VisualDensity(
                                                horizontal: VisualDensity
                                                    .minimumDensity,
                                                vertical: VisualDensity
                                                    .minimumDensity,
                                              ),
                                              dense: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 0),
                                              title: Text(
                                                txt_mulching_method.tr,
                                                style: TextStyle(
                                                    color: kblack,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15),
                                              ),
                                              value: txt_mulching_method.tr,
                                              groupValue: ePv.selectedOption,
                                              onChanged: (value) {
                                                setState(() {
                                                  ePv.selectedOption =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                          ),
                                          h10
                                        ],
                                      )),
                                ],
                              ),
                            if (widget.cropid.cropId == 4)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  h10,
                                  Text(
                                    txt_cultivation_method.tr,
                                    style: TextStyle(
                                        color: kgreen,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  h10,
                                  Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: kblack, width: 0.35)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 35,
                                            child: RadioListTile(
                                              contentPadding: EdgeInsets.only(
                                                  left: 0, right: 0),
                                              title: Text(
                                                txt_sapat_vapha_padhat.tr,
                                                style: TextStyle(
                                                    color: kblack,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15),
                                              ),
                                              value: txt_sapat_vapha_padhat.tr,
                                              groupValue: ePv.selectedOption,
                                              onChanged: (value) {
                                                setState(() {
                                                  ePv.selectedOption =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            child: RadioListTile(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 0),
                                              title: Text(
                                                txt_lagvad_padhat.tr,
                                                style: TextStyle(
                                                    color: kblack,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15),
                                              ),
                                              value: txt_lagvad_padhat.tr,
                                              groupValue: ePv.selectedOption,
                                              onChanged: (value) {
                                                setState(() {
                                                  ePv.selectedOption =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                          ),
                                          h10
                                        ],
                                      )),
                                ],
                              ),
                            if (widget.cropid.cropId == 4)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  h10,
                                  Text(
                                    txt_method_of_watering.tr,
                                    style: TextStyle(
                                        color: kgreen,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  h10,
                                  Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: kblack, width: 0.35)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 35,
                                            child: RadioListTile(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 0),
                                              title: Text(
                                                txt_drip.tr,
                                                style: TextStyle(
                                                    color: kblack,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15),
                                              ),
                                              value: txt_drip.tr,
                                              groupValue: ePv.waterspplayplot,
                                              onChanged: (value) {
                                                setState(() {
                                                  ePv.waterspplayplot =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            child: RadioListTile(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 0),
                                              title: Text(
                                                txt_patpani.tr,
                                                style: TextStyle(
                                                    color: kblack,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15),
                                              ),
                                              value: txt_patpani.tr,
                                              groupValue: ePv.waterspplayplot,
                                              onChanged: (value) {
                                                setState(() {
                                                  ePv.waterspplayplot =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            child: RadioListTile(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 0),
                                              title: Text(
                                                txt_sprinkler.tr,
                                                style: TextStyle(
                                                    color: kblack,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15),
                                              ),
                                              value: txt_sprinkler.tr,
                                              groupValue: ePv.waterspplayplot,
                                              onChanged: (value) {
                                                setState(() {
                                                  ePv.waterspplayplot =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                          ),
                                          h10
                                        ],
                                      )),
                                ],
                              ),
                            h10,
                            if (widget.cropid.cropId == 1)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "रचना",
                                    style: TextStyle(
                                        color: kgreen,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  h10,
                                  Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: kblack, width: 0.35)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 35,
                                            child: RadioListTile(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 0),
                                              title: Text(
                                                'Y',
                                                style: TextStyle(
                                                    color: kblack,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15),
                                              ),
                                              value: 'Y',
                                              groupValue: ePv.rachna1,
                                              onChanged: (value) {
                                                setState(() {
                                                  ePv.rachna1 =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            child: RadioListTile(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 0),
                                              title: Text(
                                                'मंडप',
                                                style: TextStyle(
                                                    color: kblack,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15),
                                              ),
                                              value: 'मंडप',
                                              groupValue: ePv.rachna1,
                                              onChanged: (value) {
                                                setState(() {
                                                  ePv.rachna1 =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                          ),
                                          h10
                                        ],
                                      )),
                                ],
                              ),
                            if (widget.cropid.cropId == 22)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    txt_lagvad_padhat.tr,
                                    style: TextStyle(
                                        color: kgreen,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  h10,
                                  Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: kblack, width: 0.35)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 35,
                                            child: RadioListTile(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 0),
                                              title: Container(
                                                child: Text(
                                                  txt_rope_lagvad_padhat.tr,
                                                  style: TextStyle(
                                                      color: kblack,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 15),
                                                ),
                                              ),
                                              value: txt_rope_lagvad_padhat.tr,
                                              groupValue: ePv.selectedOption,
                                              onChanged: (value) {
                                                setState(() {
                                                  ePv.selectedOption =
                                                      value.toString();
                                                  print(value);
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            child: RadioListTile(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 0),
                                              title: Text(
                                                txt_Ek_dola_padhat.tr,
                                                style: TextStyle(
                                                    color: kblack,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15),
                                              ),
                                              value: txt_Ek_dola_padhat.tr,
                                              groupValue: ePv.selectedOption,
                                              onChanged: (value) {
                                                setState(() {
                                                  ePv.selectedOption =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            child: RadioListTile(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 0),
                                              title: Text(
                                                txt_donteen_dola_padhat.tr,
                                                style: TextStyle(
                                                    color: kblack,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15),
                                              ),
                                              value: txt_donteen_dola_padhat.tr,
                                              groupValue: ePv.selectedOption,
                                              onChanged: (value) {
                                                setState(() {
                                                  // log("$")
                                                  ePv.selectedOption =
                                                      value.toString();
                                                  log(ePv.selectedOption);
                                                });
                                              },
                                            ),
                                          ),
                                          h10
                                        ],
                                      )),
                                  h10
                                ],
                              ),
                            if (widget.cropid.cropId == 3 ||
                                widget.cropid.cropId == 6 ||
                                widget.cropid.cropId == 9 ||
                                widget.cropid.cropId == 2 ||
                                widget.cropid.cropId == 8 ||
                                widget.cropid.cropId == 11 ||
                                widget.cropid.cropId == 10)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  h10,
                                  Text(
                                    txt_method_of_watering.tr,
                                    style: TextStyle(
                                        color: kgreen,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  h10,
                                  Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: kblack, width: 0.35)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 35,
                                            child: RadioListTile(
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              visualDensity:
                                                  const VisualDensity(
                                                horizontal: VisualDensity
                                                    .minimumDensity,
                                                vertical: VisualDensity
                                                    .minimumDensity,
                                              ),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 0),
                                              title: Text(
                                                txt_drip.tr,
                                                style: TextStyle(
                                                    color: kblack,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15),
                                              ),
                                              value: txt_drip.tr,
                                              groupValue: ePv.waterspplayplot,
                                              onChanged: (value) {
                                                setState(() {
                                                  ePv.waterspplayplot =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            child: RadioListTile(
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              visualDensity:
                                                  const VisualDensity(
                                                horizontal: VisualDensity
                                                    .minimumDensity,
                                                vertical: VisualDensity
                                                    .minimumDensity,
                                              ),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 0),
                                              title: Text(
                                                txt_patpani.tr,
                                                style: TextStyle(
                                                    color: kblack,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15),
                                              ),
                                              value: txt_patpani.tr,
                                              groupValue: ePv.waterspplayplot,
                                              onChanged: (value) {
                                                setState(() {
                                                  ePv.waterspplayplot =
                                                      value.toString();
                                                });
                                              },
                                            ),
                                          ),
                                          h10
                                        ],
                                      )),
                                  h10
                                ],
                              ),
                            if (widget.cropid.cropId != 34 &&
                                widget.cropid.cropId != 29 &&
                                widget.cropid.cropId != 40 &&
                                widget.cropid.cropId != 32 &&
                                widget.cropid.cropId != 30 &&
                                widget.cropid.cropId != 39 &&
                                widget.cropid.cropId != 31 &&
                                widget.cropid.cropId != 21)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //    if(  widget.cropid.cropId != 37)
                 if (widget.cropid.cropId == 1)
                 h10,
                                  Text(
                                    txt_planting_distance.tr,
                                    style: TextStyle(
                                        color: kgreen,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  h10,
                                  Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0.5, color: ktext),
                                        borderRadius: BorderRadius.circular(3)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              width: 80,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                  color: kgreenlight,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 2, left: 15),
                                                child: TextField(
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(
                                                        4), // Limit to 10 characters
                                                  ],
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller:
                                                      ePv.plantingDistance,
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                  cursorColor: klime,
                                                  decoration: InputDecoration(
                                                      hintText:
                                                          txt_planting_distance
                                                              .tr,
                                                      hintStyle: TextStyle(
                                                          color: grey800,
                                                          fontSize: 13),
                                                      border: InputBorder.none),
                                                ),
                                              ),
                                            ),
                                          ),
                                          w10,
                                          Image.asset(
                                            ImageAssets.ic_close,
                                            height: 20,
                                            color: kgreen,
                                          ),
                                          w10,
                                          Expanded(
                                            child: Container(
                                              width: 80,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                  color: kgreenlight,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 2, left: 15),
                                                child: TextField(
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(
                                                        4), // Limit to 10 characters
                                                  ],
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                  cursorColor: klime,
                                                  controller:
                                                      ePv.plantingDistance1,
                                                  decoration: InputDecoration(
                                                      hintText:
                                                          txt_planting_distance
                                                              .tr,
                                                      hintStyle: TextStyle(
                                                          color: grey800,
                                                          fontSize: 13),
                                                      border: InputBorder.none),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            if (widget.cropid.cropId != 17 &&
                                widget.cropid.cropId != 34 &&
                                widget.cropid.cropId != 23 &&
                                widget.cropid.cropId != 31 &&
                                widget.cropid.cropId != 29 &&
                                widget.cropid.cropId != 40 &&
                                widget.cropid.cropId != 32 &&
                                widget.cropid.cropId != 24 &&
                                widget.cropid.cropId != 41 &&
                                widget.cropid.cropId != 21 &&
                                widget.cropid.cropId != 36 &&
                                widget.cropid.cropId != 39 &&
                                widget.cropid.cropId != 27 &&
                                widget.cropid.cropId != 22 &&
                                widget.cropid.cropId != 37 &&
                                widget.cropid.cropId != 33 &&
                                widget.cropid.cropId != 30)
                              //  if(widget.cropid.cropId != 27||widget.cropid.cropId != 22 )
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  h10,
                                  Text(
                                    txt_purpose.tr,
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
                                            width: 0.5, color: ktext),
                                        borderRadius: BorderRadius.circular(3)),
                                    child: Row(
                                      children: [
                                        Radio<String>(
                                          activeColor: kblue,
                                          value:'Local',
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
                                        Radio<String>(
                                          activeColor: kblue,
                                          value: "Export",
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
                                        if (widget.cropid.cropId == 1)
                                          Row(
                                            children: [
                                              Radio<String>(
                                                activeColor: kblue,
                                                value: "Bedana",
                                                groupValue: ePv.updaesh,
                                                onChanged: (value1) {
                                                  setState(() {
                                                    ePv.updaesh = value1!;
                                                  });
                                                },
                                              ),
                                              Text(
                                                txt_bedana.tr,
                                                style: TextStyle(
                                                    color: kblack,
                                                    fontSize: 15,
                                                    fontFamily: 'newfont'),
                                              )
                                            ],
                                          )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            if (widget.cropid.cropId != 39 ||
                                widget.cropid.cropId != 34 ||
                                widget.cropid.cropId != 31)
                              h10,
                            Text(
                              txtplot_area_in_acre.tr,
                              style: TextStyle(
                                  color: kgreen,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                            h10,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: kblack, width: 0.35)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(fontSize: 14),
                                      cursorColor: klime,
                                      controller: ePv.caluculateareacontroller,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(
                                            4), // Limit to 10 characters
                                      ],
                                      decoration: InputDecoration(
                                          hintText: plotcalculation.tr,
                                          hintStyle: TextStyle(
                                              color: grey800, fontSize: 15),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (widget.cropid.cropId != 27 &&
                                widget.cropid.cropId != 17 &&
                                widget.cropid.cropId != 34 &&
                                widget.cropid.cropId != 23 &&
                                widget.cropid.cropId != 31 &&
                                widget.cropid.cropId != 33 &&
                                widget.cropid.cropId != 29 &&
                                widget.cropid.cropId != 40 &&
                                widget.cropid.cropId != 32 &&
                                widget.cropid.cropId != 24 &&
                                widget.cropid.cropId != 41 &&
                                widget.cropid.cropId != 21 &&
                                widget.cropid.cropId != 36 &&
                                widget.cropid.cropId != 22 &&
                                widget.cropid.cropId != 37 &&
                                widget.cropid.cropId != 30 &&
                                widget.cropid.cropId != 39)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  h10,
                                  Text(
                                    txt_previous_year_problem.tr,
                                    style: TextStyle(
                                        color: kgreen,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  h10,
                                  Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: kblack, width: 0.35)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: TextField(
                                        style: TextStyle(fontSize: 14),
                                        cursorColor: klime,
                                        controller: ePv.pastproblemController,
                                        decoration: InputDecoration(
                                            hintText:
                                                txt_previous_year_problem.tr,
                                            hintStyle: TextStyle(
                                                color: grey800, fontSize: 15),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
                  ePv.validationRegtrationcrop(context);
                },
                text: Text(
                  txt_submit.tr,
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w700, color: kwhite),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

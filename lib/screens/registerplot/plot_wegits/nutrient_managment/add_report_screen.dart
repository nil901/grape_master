import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/auth/LocalString.dart';
import 'package:grape_master/screens/registerplot/plot_wegits/nutrient_managment/custorm_dropdown.dart';
import 'package:grape_master/util/constants.dart';
import 'package:grape_master/util/large_button.dart';
import 'package:grape_master/util/lodaer.dart';
import 'package:grape_master/util/no_activity_found.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../util/color.dart';
import '../../../../util/image_assets.dart';
import '../../plot_controller.dart';

class AddReportScreen extends StatefulWidget {
  const AddReportScreen({
    super.key,
  });

  @override
  State<AddReportScreen> createState() => _AddReportScreenState();
}

class _AddReportScreenState extends State<AddReportScreen> {
  bool isOpen = false;
  bool isOpen1 = false;
  bool isOpen2 = false;
  String? selectedValue;

  File? image1;
  dynamic imageData = "";
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
      await eProvider?.selectedPlotModel();
      await eProvider?.reportListApi();
    });
  }

  Future PickImageImag(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      // Navigator.of(context).pop();
      eProvider?.imageData = base64Encode(imageTemporary.readAsBytesSync());

      setState(() {});

      this.image1 = imageTemporary;
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDropdownOpen = false;
    return Scaffold(
      appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
                eProvider?.clearalldata();
                // eProvider?.cleardata();
              },
              child: Icon(Icons.arrow_back)),
          backgroundColor: kgreen,
          title: Text(
            txt_add_report.tr,
            style: TextStyle(
                color: kwhite, fontWeight: FontWeight.w400, fontSize: 22),
          )),
      body: Consumer<plotcnt>(builder: (context, ePv, child) {
        return ePv.selectedcrop!.data.isEmpty == "null"
            ? Center(child: Loader())
            : ePv.selectedcrop!.data.length == 0
                ? Center(child: NoActivityFound())
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: SingleChildScrollView(
                                  child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              h20,
                              Text(
                                txt_crop_g.tr,
                                style: TextStyle(
                                    color: kgreen,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              ),
                              h10,
                              Container(
                                height: 45,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: kblack, width: 0.3),
                                    borderRadius: BorderRadius.circular(3)),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    isExpanded: true,
                                    hint: Text(
                                      txt_crop_g.tr,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    items: ePv.selectedcrop!.data
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item.cropId.toString(),
                                                  child: Text(
                                                    item.cropName,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ))
                                            ?.toList() ??
                                        [],
                                    value: ePv.selctedvalue,
                                    onChanged: (value) {
                                      setState(() {
                                        ePv.selctedvalue =
                                            value; // Corrected assignment here
                                        print(ePv.selctedvalue);

                                        var selectedCrop =
                                            ePv.selectedcrop?.data.firstWhere(
                                          (item) =>
                                              item.cropId.toString() == value,
                                          orElse: () => ePv.selectedcrop!.data
                                              .first, // Fallback if not found
                                        );
                                        print(
                                            'Selected Crop ID: ${selectedCrop?.cropId}');
                                        print(
                                            'Selected Crop Name: ${selectedCrop?.cropName}');
                                      });
                                    },
                                    buttonStyleData: const ButtonStyleData(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 0),
                                      height: 40,
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                    ),
                                  ),
                                ),
                              ),
                              h10,
                              Text(
                                txt_report_cat.tr,
                                style: TextStyle(
                                    color: kgreen,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              ),
                              h10,
                              Container(
                                height: 45,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: kblack, width: 0.3),
                                    borderRadius: BorderRadius.circular(3)),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    isExpanded: true,
                                    hint: Text(
                                      txt_report_cat.tr,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    items: ePv.reportListModel?.data
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value:
                                                      item.reportId.toString(),
                                                  child: Text(
                                                    item.reportName,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ))
                                            ?.toList() ??
                                        [],
                                    value: ePv.obzervationName,
                                    onChanged: (value) {
                                      setState(() {
                                        ePv.cleardata();
                                        ePv.obzervationName =
                                            value; // Corrected assignment here
                                        print(value);

                                        var selectedCrop = ePv
                                            .reportListModel!.data
                                            .firstWhere(
                                          (item) =>
                                              item.reportId.toString() == value,
                                          orElse: () => ePv
                                              .reportListModel!
                                              .data
                                              .first, // Fallback if snot found
                                        );
                                        //  ePv.cleardata();
                                        ePv.reportId = selectedCrop?.reportId;
                                        ePv.reportName =
                                            selectedCrop.reportName;
                                        print(
                                            'Selected Crop ID: ${selectedCrop.reportId}');
                                        print(
                                            'Selected Crop Name: ${selectedCrop.reportName}');
                                      });
                                    },
                                    buttonStyleData: const ButtonStyleData(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 0),
                                      height: 40,
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                    ),
                                  ),
                                ),
                              ),
                              h20,
                              Text(
                                txt_lab_name.tr,
                                style: TextStyle(
                                    color: kgreen,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              ),
                              h10,
                              Container(
                                height: 45,
                                decoration: BoxDecoration(
                                  border: Border.all(color: kblack, width: 0.3),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: TextFormField(
                                    cursorColor: klime,
                                    controller: ePv!.labortaryNameCntroller,
                                    maxLines: 10,
                                    onChanged: (value) {},
                                    style: TextStyle(fontSize: 13),
                                    decoration: InputDecoration(
                                        //  focusedBorder:InputBorder(borderSide: ) ,
                                        hintStyle: TextStyle(color: grey800),
                                        hintText: txt_lab_name.tr,
                                        border: InputBorder.none),
                                    validator: (text) {
                                      if (text!.isEmpty) {
                                        return "Address";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              h20,
                              Text(
                                txt_date_of_sample.tr,
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
                                  ePv.SampleDateController.text =
                                      DateFormat('dd-MM-yyyy')
                                          .format(selectedDate);

                                  ePv.apidateformat = DateFormat('yyyy-MM-dd')
                                      .format(selectedDate);
                                },
                                child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: kblack, width: 0.3),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Row(
                                      children: [
                                        w10,
                                        Expanded(
                                          child: TextFormField(
                                            enabled: false,
                                            cursorColor: klime,
                                            controller:
                                                ePv.SampleDateController,
                                            maxLines: 10,
                                            onChanged: (value) {},
                                            style: TextStyle(fontSize: 13),
                                            decoration: InputDecoration(
                                                //  focusedBorder:InputBorder(borderSide: ) ,
                                                helperStyle:
                                                    TextStyle(color: grey800),
                                                hintText: txt_date_of_sample.tr,
                                                border: InputBorder.none),
                                            validator: (text) {
                                              if (text!.isEmpty) {
                                                return "Address";
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        Icon(Icons.arrow_drop_down)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              h20,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    txt_report_observation.tr,
                                    style: TextStyle(
                                        color: kgreen,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  h10,
                                  Container(
                                    height: 150,
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: kblack, width: 0.3),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: TextFormField(
                                        cursorColor: klime,
                                        controller:
                                            ePv.importanctContController,
                                        maxLines: 10,
                                        onChanged: (value) {},
                                        style: TextStyle(fontSize: 13),
                                        decoration: InputDecoration(
                                            //  focusedBorder:InputBorder(borderSide: ) ,
                                            helperStyle:
                                                TextStyle(color: grey800),
                                            hintText: txt_report_observation.tr,
                                            border: InputBorder.none),
                                        validator: (text) {
                                          if (text!.isEmpty) {
                                            return "Address";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              h10,
                              Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                    decoration: BoxDecoration(
                                      // color: kblack,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        h10,
                                        Text(
                                            ePv.reportName == null
                                                ? ''
                                                : ePv.reportName.toString(),
                                            style: TextStyle(
                                                fontSize: 18, color: green)),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              fertilizer.tr,
                                              style: TextStyle(
                                                  color: grey800,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 17),
                                            ),
                                            Text(
                                              txt_analysis_value.tr,
                                              style: TextStyle(
                                                  color: grey800,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 17),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Divider(
                                            thickness: 1,
                                            color: ktext,
                                          ),
                                        ),
                                        if (ePv.reportId == 1)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 45),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      h10,
                                                      Text(
                                                        txt_nitrogen.tr,
                                                        style: TextStyle(
                                                            color: ktext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16),
                                                      ),
                                                      h20,
                                                      Text(
                                                        txt_calcium_carbonate
                                                            .tr,
                                                        style: TextStyle(
                                                            color: ktext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16),
                                                      ),
                                                      h20,
                                                      Text(
                                                        txt_organic_carbon.tr,
                                                        style: TextStyle(
                                                            color: ktext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16),
                                                      ),
                                                      h25,
                                                      Text(
                                                        txt_phossFurus.tr,
                                                        style: TextStyle(
                                                            color: ktext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16),
                                                      ),

                                                      h20,
                                                      Text(
                                                        txt_patasium.tr,
                                                        style: TextStyle(
                                                            color: ktext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16),
                                                      ),
                                                      h20,
                                                      Text(
                                                        txt_calcium.tr,
                                                        style: TextStyle(
                                                            color: ktext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16),
                                                      ),
                                                      h20,
                                                      Text(
                                                        txt_mg.tr,
                                                        style: TextStyle(
                                                            color: ktext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16),
                                                      ),
                                                      h20,

                                                      Text(
                                                        txt_sulpher.tr,
                                                        style: TextStyle(
                                                            color: ktext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16),
                                                      ),

                                                      //  h20,
                                                      //  Text(
                                                      //   "Sulphur",
                                                      //   style: TextStyle(
                                                      //       color: ktext,
                                                      //       fontWeight: FontWeight.w400,
                                                      //       fontSize: 16),
                                                      // ),
                                                      h20,
                                                      Text(
                                                        txt_ferous.tr,
                                                        style: TextStyle(
                                                            color: ktext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16),
                                                      ),
                                                      h20,
                                                      Text(
                                                        txt_maganese.tr,
                                                        style: TextStyle(
                                                            color: ktext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16),
                                                      ),
                                                      h20,
                                                      Text(
                                                        txt_zn.tr,
                                                        style: TextStyle(
                                                            color: ktext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16),
                                                      ),
                                                      h20,
                                                      Text(
                                                        Copper.tr,
                                                        style: TextStyle(
                                                            color: ktext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16),
                                                      ),
                                                      h20,
                                                      Text(
                                                        txt_boron.tr,
                                                        style: TextStyle(
                                                            color: ktext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16),
                                                      ),
                                                      h20,
                                                      Text(
                                                        txt_molybdenum.tr,
                                                        style: TextStyle(
                                                            color: ktext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16),
                                                      ),
                                                      h20,
                                                      Text(
                                                        BiCarbonate.tr,
                                                        style: TextStyle(
                                                            color: ktext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16),
                                                      ),
                                                      h20,
                                                      Text(
                                                        txt_cloride.tr,
                                                        style: TextStyle(
                                                            color: ktext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16),
                                                      ),
                                                      h20,
                                                      Text(
                                                        txt_na.tr,
                                                        style: TextStyle(
                                                            color: ktext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16),
                                                      ),
                                                      h20,
                                                      Text(
                                                        txt_ph.tr,
                                                        style: TextStyle(
                                                            color: ktext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16),
                                                      ),
                                                      h20,
                                                      Text(
                                                        txt_ec.tr,
                                                        style: TextStyle(
                                                            color: ktext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 30,
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: kblack),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                               FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                              LengthLimitingTextInputFormatter(
                                                                  5),
                                                            ],
                                                            controller: ePv
                                                                .NirogenController,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      h10,
                                                      Container(
                                                        height: 30,
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: kblack),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                               FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                              LengthLimitingTextInputFormatter(5),
                                                            ],
                                                            controller: ePv
                                                                .calciumCarbonateController,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      h10,
                                                      Container(
                                                        height: 30,
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: kblack),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                               FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                              LengthLimitingTextInputFormatter(
                                                                  5),
                                                            ],
                                                            controller: ePv
                                                                .organicCarbonController,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      h10,
                                                      Container(
                                                        height: 30,
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: kblack),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                               FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                              LengthLimitingTextInputFormatter(
                                                                  5),
                                                            ],
                                                            controller: ePv
                                                                .phosphourusController,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      h10,
                                                      Container(
                                                        height: 30,
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: kblack),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                               FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                              LengthLimitingTextInputFormatter(
                                                                  5),
                                                            ],
                                                            controller: ePv
                                                                .patassiumController,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      h10,
                                                      Container(
                                                        height: 30,
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: kblack),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                               FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                              LengthLimitingTextInputFormatter(
                                                                  5),
                                                            ],
                                                            controller: ePv
                                                                .calciumController,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      h10,
                                                      Container(
                                                        height: 30,
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: kblack),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                               FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                              LengthLimitingTextInputFormatter(
                                                                  5),
                                                            ],
                                                            controller: ePv
                                                                .manganesemController,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      h10,
                                                      Container(
                                                        height: 30,
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: kblack),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                               FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                              LengthLimitingTextInputFormatter(
                                                                  5),
                                                            ],
                                                            controller: ePv
                                                                .SulphurController,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      h10,
                                                      Container(
                                                        height: 30,
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: kblack),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                               FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                              LengthLimitingTextInputFormatter(
                                                                  5),
                                                            ],
                                                            controller: ePv
                                                                .ferrousController,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      h10,
                                                      Container(
                                                        height: 30,
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: kblack),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                               FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                              LengthLimitingTextInputFormatter(
                                                                  5),
                                                            ],
                                                            controller: ePv
                                                                .zinccontroller,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      h10,
                                                      Container(
                                                        height: 30,
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: kblack),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                               FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                              LengthLimitingTextInputFormatter(
                                                                  5),
                                                            ],
                                                            controller: ePv
                                                                .croppercontroller,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      h10,
                                                      Container(
                                                        height: 30,
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: kblack),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                               FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                              LengthLimitingTextInputFormatter(
                                                                  5),
                                                            ],
                                                            controller: ePv
                                                                .bororncontroller,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      h10,
                                                      Container(
                                                        height: 30,
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: kblack),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                               FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                              LengthLimitingTextInputFormatter(
                                                                  5),
                                                            ],
                                                            controller: ePv
                                                                .molybdenumcontroller,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      h10,
                                                      Container(
                                                        height: 30,
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: kblack),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                               FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                              LengthLimitingTextInputFormatter(
                                                                  5),
                                                            ],
                                                            controller: ePv
                                                                .bicarbonatecontroller,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      h10,
                                                      Container(
                                                        height: 30,
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: kblack),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                               FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                              LengthLimitingTextInputFormatter(
                                                                  5),
                                                            ],
                                                            controller: ePv
                                                                .chlorideController,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      h10,
                                                      Container(
                                                        height: 30,
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: kblack),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                               FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                              LengthLimitingTextInputFormatter(
                                                                  5),
                                                            ],
                                                            controller: ePv
                                                                .sodiumcontroller,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      h10,
                                                      Container(
                                                        height: 30,
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: kblack),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                               FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                              LengthLimitingTextInputFormatter(
                                                                  5),
                                                            ],
                                                            controller: ePv
                                                                .phcontroller,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      h10,
                                                      Container(
                                                        height: 30,
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: kblack),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                               FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                              LengthLimitingTextInputFormatter(
                                                                  5),
                                                            ],
                                                            controller: ePv
                                                                .phController,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      h10,
                                                      Container(
                                                        height: 30,
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: kblack),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                               FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                              LengthLimitingTextInputFormatter(
                                                                  5),
                                                            ],
                                                            controller: ePv
                                                                .EcController,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        if (ePv.reportId == 2)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 45),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      h10,
                                                      Text(
                                                        txt_nitrogen.tr,
                                                        style: TextStyle(
                                                            color: ktext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16),
                                                      ),
                                                      h20,
                                                      Text(
                                                        NitrateNitrogen.tr,
                                                        style: TextStyle(
                                                            color: ktext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16),
                                                      ),
                                                      h20,
                                                      Text(
                                                        AmmonicalNitrogen.tr,
                                                        style: TextStyle(
                                                            color: ktext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16),
                                                      ),
                                                      h20,
                                                      Text(
                                                        txt_phossFurus.tr,
                                                        style: TextStyle(
                                                            color: ktext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16),
                                                      ),

                                                      h20,
                                                      Text(
                                                        txt_calcium.tr,
                                                        style: TextStyle(
                                                            color: ktext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16),
                                                      ),
                                                      h20,
                                                      Text(
                                                        txt_mg.tr,
                                                        style: TextStyle(
                                                            color: ktext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16),
                                                      ),
                                                      h20,
                                                      Text(
                                                        txt_sulpher.tr,
                                                        style: TextStyle(
                                                            color: ktext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16),
                                                      ),
                                                      h20,

                                                      Text(
                                                        txt_ferous.tr,
                                                        style: TextStyle(
                                                            color: ktext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16),
                                                      ),

                                                      //  h20,
                                                      //  Text(
                                                      //   "Sulphur",
                                                      //   style: TextStyle(
                                                      //       color: ktext,
                                                      //       fontWeight: FontWeight.w400,
                                                      //       fontSize: 16),
                                                      // ),
                                                      h20,
                                                      Text(
                                                        txt_mn.tr,
                                                        style: TextStyle(
                                                            color: ktext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16),
                                                      ),
                                                      h20,
                                                      Text(
                                                        txt_zn.tr,
                                                        style: TextStyle(
                                                            color: ktext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16),
                                                      ),
                                                      h20,
                                                      Text(
                                                        txt_copper.tr,
                                                        style: TextStyle(
                                                            color: ktext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16),
                                                      ),
                                                      h20,
                                                      Text(
                                                        txt_boron.tr,
                                                        style: TextStyle(
                                                            color: ktext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16),
                                                      ),
                                                      h20,
                                                      Text(
                                                        txt_molybdenum.tr,
                                                        style: TextStyle(
                                                            color: ktext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16),
                                                      ),
                                                      h20,
                                                      Text(
                                                        txt_cloride.tr,
                                                        style: TextStyle(
                                                            color: ktext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16),
                                                      ),
                                                      h20,
                                                      Text(
                                                        txt_na.tr,
                                                        style: TextStyle(
                                                            color: ktext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16),
                                                      ),
                                                      h20,
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 30,
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: kblack),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                               FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                              LengthLimitingTextInputFormatter(
                                                                  5),
                                                            ],
                                                            controller: ePv
                                                                .NirogenController,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      h10,
                                                      Container(
                                                        height: 30,
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: kblack),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                               FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                              LengthLimitingTextInputFormatter(
                                                                  5),
                                                            ],
                                                            controller: ePv
                                                                .NitrateNitrogencontroller,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      h10,
                                                      Container(
                                                        height: 30,
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: kblack),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                               FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                              LengthLimitingTextInputFormatter(
                                                                  5),
                                                            ],
                                                            controller: ePv
                                                                .ammonicalnitrogencontroller,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      h10,
                                                      Container(
                                                        height: 30,
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: kblack),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                               FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                              LengthLimitingTextInputFormatter(
                                                                  5),
                                                            ],
                                                            controller: ePv
                                                                .ferrousController,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      h10,
                                                      Container(
                                                        height: 30,
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: kblack),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                               FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                              LengthLimitingTextInputFormatter(
                                                                  5),
                                                            ],
                                                            controller: ePv
                                                                .calciumController,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      h10,
                                                      Container(
                                                        height: 30,
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: kblack),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                               FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                              LengthLimitingTextInputFormatter(
                                                                  5),
                                                            ],
                                                            controller: ePv
                                                                .manganesemController,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      h10,
                                                      Container(
                                                        height: 30,
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: kblack),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                               FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                              LengthLimitingTextInputFormatter(
                                                                  5),
                                                            ],
                                                            controller: ePv
                                                                .SulphurController,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      h10,
                                                      Container(
                                                        height: 30,
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: kblack),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                               FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                              LengthLimitingTextInputFormatter(
                                                                  5),
                                                            ],
                                                            controller: ePv
                                                                .ferrousController,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      h10,
                                                      Container(
                                                        height: 30,
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: kblack),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                               FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                              LengthLimitingTextInputFormatter(
                                                                  5),
                                                            ],
                                                            controller: ePv
                                                                .manganesecontroller,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      h10,
                                                      Container(
                                                        height: 30,
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: kblack),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                               FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                              LengthLimitingTextInputFormatter(
                                                                  5),
                                                            ],
                                                            controller: ePv
                                                                .zinccontroller,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      h10,
                                                      Container(
                                                        height: 30,
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: kblack),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                               FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                              LengthLimitingTextInputFormatter(
                                                                  5),
                                                            ],
                                                            controller: ePv
                                                                .croppercontroller,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      h10,
                                                      Container(
                                                        height: 30,
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: kblack),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                               FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                              LengthLimitingTextInputFormatter(
                                                                  5),
                                                            ],
                                                            controller: ePv
                                                                .bororncontroller,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      h10,
                                                      Container(
                                                        height: 30,
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: kblack),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                               FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                              LengthLimitingTextInputFormatter(
                                                                  5),
                                                            ],
                                                            controller: ePv
                                                                .molybdenumcontroller,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      h10,
                                                      Container(
                                                        height: 30,
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: kblack),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                               FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),                                                              LengthLimitingTextInputFormatter(
                                                                  5),
                                                            ],
                                                            controller: ePv
                                                                .sodiumcontroller,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      h10,
                                                      Container(
                                                        height: 30,
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: kblack),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                               FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                              LengthLimitingTextInputFormatter(
                                                                  5),
                                                            ],
                                                            controller: ePv
                                                                .chlorideController,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      h10,
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        if (ePv.reportId == 3)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 45),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      NitrateNitrogen.tr,
                                                      style: TextStyle(
                                                          color: ktext,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16),
                                                    ),
                                                    h20,
                                                    Text(
                                                      Carbonate.tr,
                                                      style: TextStyle(
                                                          color: ktext,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16),
                                                    ),
                                                    h20,
                                                    Text(
                                                      txt_patasium.tr,
                                                      style: TextStyle(
                                                          color: ktext,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16),
                                                    ),
                                                    h20,
                                                    Text(
                                                      txt_calcium.tr,
                                                      style: TextStyle(
                                                          color: ktext,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16),
                                                    ),
                                                    h20,
                                                    Text(
                                                      txt_mg.tr,
                                                      style: TextStyle(
                                                          color: ktext,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16),
                                                    ),
                                                    h20,
                                                    Text(
                                                      BiCarbonate.tr,
                                                      style: TextStyle(
                                                          color: ktext,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16),
                                                    ),
                                                    h20,
                                                    Text(
                                                      Carbonate.tr,
                                                      style: TextStyle(
                                                          color: ktext,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16),
                                                    ),
                                                    h20,
                                                    Text(
                                                      txt_sodium.tr,
                                                      style: TextStyle(
                                                          color: ktext,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16),
                                                    ),
                                                    h20,
                                                    Text(
                                                      Mgca.tr,
                                                      style: TextStyle(
                                                          color: ktext,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16),
                                                    ),
                                                    h20,
                                                    Text(
                                                      SAR.tr,
                                                      style: TextStyle(
                                                          color: ktext,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16),
                                                    ),
                                                    h20,
                                                    Text(
                                                      "PH",
                                                      style: TextStyle(
                                                          color: ktext,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16),
                                                    ),
                                                    h20,
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 5),
                                                      child: Text(
                                                        "EC",
                                                        style: TextStyle(
                                                            color: ktext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    h10,
                                                    Container(
                                                      height: 30,
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1,
                                                            color: kblack),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 12),
                                                        child: TextField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          inputFormatters: [
                                                             FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                            LengthLimitingTextInputFormatter(
                                                                5),
                                                          ],
                                                          controller: ePv
                                                              .NitrateNitrogencontroller,
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    h10,
                                                    Container(
                                                      height: 30,
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1,
                                                            color: kblack),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 12),
                                                        child: TextField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          inputFormatters: [
                                                             FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                            LengthLimitingTextInputFormatter(
                                                                5),
                                                          ],
                                                          controller: ePv
                                                              .carbonatecontroller,
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    h10,
                                                    Container(
                                                      height: 30,
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1,
                                                            color: kblack),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 12),
                                                        child: TextField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          inputFormatters: [
                                                             FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                            LengthLimitingTextInputFormatter(
                                                                5),
                                                          ],
                                                          //controller:   ePv.,
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    h10,
                                                    Container(
                                                      height: 30,
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1,
                                                            color: kblack),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 12),
                                                        child: TextField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          inputFormatters: [
                                                             FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                            LengthLimitingTextInputFormatter(
                                                                5),
                                                          ],
                                                          controller: ePv
                                                              .calciumController,
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    h10,
                                                    Container(
                                                      height: 30,
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1,
                                                            color: kblack),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 12),
                                                        child: TextField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          inputFormatters: [
                                                             FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                            LengthLimitingTextInputFormatter(
                                                                5),
                                                          ],
                                                          controller: ePv
                                                              .manganesemController,
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    h10,
                                                    Container(
                                                      height: 30,
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1,
                                                            color: kblack),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 12),
                                                        child: TextField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          inputFormatters: [
                                                             FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                            LengthLimitingTextInputFormatter(
                                                                5),
                                                          ],
                                                          controller: ePv
                                                              .bicarbonatecontroller,
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    h10,
                                                    Container(
                                                      height: 30,
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1,
                                                            color: kblack),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 12),
                                                        child: TextField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          inputFormatters: [
                                                             FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                            LengthLimitingTextInputFormatter(
                                                                5),
                                                          ],
                                                          controller: ePv
                                                              .carbonatecontroller,
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    h10,
                                                    Container(
                                                      height: 30,
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1,
                                                            color: kblack),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 12),
                                                        child: TextField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          inputFormatters: [
                                                             FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                            LengthLimitingTextInputFormatter(
                                                                5),
                                                          ],
                                                          controller: ePv
                                                              .sodiumcontroller,
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    h10,
                                                    h10,
                                                    Container(
                                                      height: 30,
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1,
                                                            color: kblack),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 12),
                                                        child: TextField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          inputFormatters: [
                                                             FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                            LengthLimitingTextInputFormatter(
                                                                5),
                                                          ],
                                                          controller: ePv
                                                              .mgcacontroller,
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    h10,
                                                    Container(
                                                      height: 30,
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1,
                                                            color: kblack),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 12),
                                                        child: TextField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          inputFormatters: [
                                                             FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                            LengthLimitingTextInputFormatter(
                                                                5),
                                                          ],
                                                          controller:
                                                              ePv.sarcontroller,
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    h10,
                                                    Container(
                                                      height: 30,
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1,
                                                            color: kblack),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 12),
                                                        child: TextField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          inputFormatters: [
                                                             FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                            LengthLimitingTextInputFormatter(
                                                                5),
                                                          ],
                                                          controller:
                                                              ePv.phcontroller,
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    h10,
                                                    Container(
                                                      height: 30,
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1,
                                                            color: kblack),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 12),
                                                        child: TextField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          inputFormatters: [
                                                             FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                                                            LengthLimitingTextInputFormatter(
                                                                5),
                                                          ],
                                                          controller:
                                                              ePv.EcController,
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        h10,
                                      ],
                                    )),
                              ),
                              h20,
                              Text(
                                txt_photo.tr,
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
                                            child: AlertDialog(
                                              insetPadding: EdgeInsets.all(12),
                                              contentPadding: EdgeInsets.zero,
                                              content: SingleChildScrollView(
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      // Your header and close button code here

                                                      Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      15),
                                                          child:
                                                              Column(children: [
                                                            h10,
                                                            h10,
                                                            Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    'Choose',
                                                                    style: TextStyle(
                                                                        color:
                                                                            kblack,
                                                                        fontSize:
                                                                            20),
                                                                  )
                                                                ])
                                                          ])),

                                                      h40,
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                              PickImageImag(
                                                                  ImageSource
                                                                      .camera);
                                                            },
                                                            child: Column(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .camera_alt,
                                                                  size: 50,
                                                                  color:
                                                                      grey800,
                                                                ),
                                                                Text(
                                                                  'Camera',
                                                                  style:
                                                                      TextStyle(
                                                                    color:
                                                                        grey800,
                                                                    fontSize:
                                                                        18,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                              PickImageImag(
                                                                  ImageSource
                                                                      .gallery);
                                                            },
                                                            child: Column(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .insert_photo,
                                                                  size: 50,
                                                                  color:
                                                                      grey800,
                                                                ),
                                                                Text(
                                                                  'Gallery',
                                                                  style: TextStyle(
                                                                      color:
                                                                          grey800,
                                                                      fontSize:
                                                                          18),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      h20,
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 12),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          child: InkWell(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text(
                                                              'CANCEL',
                                                              style: TextStyle(
                                                                color: klime,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      h20,
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ));
                                      });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 200,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: kblack, width: 0.2),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: image1 != null
                                      ? Image.file(
                                          File(image1!.path),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover,
                                        )
                                      : Icon(
                                          Icons.photo_camera,
                                          size: 40,
                                          color: klime,
                                        ),
                                ),
                              ),
                              h10
                            ],
                          ))),
                          Center(
                              child: LargeButton(
                            onPress: () {
                              ePv!.validationReport(context);
                            },
                            text: Text(
                              txt_submit.tr,
                              style: TextStyle(
                                  color: kwhite, fontWeight: FontWeight.bold),
                            ),
                          ))
                        ]),
                  );
      }),
    );
  }
}

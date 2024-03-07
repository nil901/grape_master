import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:grape_master/util/prefs/PreferencesKey.dart';
import 'package:grape_master/util/prefs/app_preference.dart';
import 'package:grape_master/util/util.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../util/color.dart';
import '../../util/constants.dart';
import '../address/address_controller.dart';
import '../auth/LocalString.dart';

class RegisterDealer extends StatefulWidget {
  const RegisterDealer({super.key});

  @override
  State<RegisterDealer> createState() => _RegisterDealerState();
}

class _RegisterDealerState extends State<RegisterDealer> {
  AddressController? pve;



  @override
  void initState() {
   
    pve = Provider.of<AddressController>(context, listen: false);
        pve?.selectedState =  AppPreference().getInt(PreferencesKey.stateId) == null ? null: AppPreference().getInt(PreferencesKey.stateId).toString();
       pve?.selectedCity  = AppPreference().getInt(PreferencesKey.cityid)  == null ?  null: AppPreference().getInt(PreferencesKey.cityid).toString();
        pve?.selectedtaluka  = AppPreference().getInt(PreferencesKey.talukaid)  == null ? null:AppPreference().getInt(PreferencesKey.talukaid).toString();
    init();
    super.initState();
  }

  void init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await pve?.stateListApi();
      await pve?.cityListApi();
      await pve?.talukaListApi();
    }); 

  


   pve?.pinCodeController?.addListener(() {
      // Implement the logic to restrict multiple consecutive dots 
      String? text = pve?.pinCodeController?.text?.toString();
      if (text != null && text.contains('.')) {
        pve?.pinCodeController?.text = text.replaceAll('.', '');
        pve?.pinCodeController?.selection = TextSelection.fromPosition(
          TextPosition(offset: pve?.pinCodeController?.text?.length ?? 0),
        );
      }
    });  

      pve?.whatsappMobileNumberController?.addListener(() {
      // Implement the logic to restrict multiple consecutive dots 
      String? text = pve?.whatsappMobileNumberController?.text?.toString();
      if (text != null && text.contains('..')) {
        pve?.whatsappMobileNumberController?.text = text.replaceAll('..', '');
        pve?.whatsappMobileNumberController?.selection = TextSelection.fromPosition(
          TextPosition(offset: pve?.whatsappMobileNumberController?.text?.length ?? 0),
        );
      }
    }); 

     
  }

  

 
  Future<void> PickImageImag(ImageSource source) async {
  
  try {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;

    final File imageFile = File(image.path);
  Navigator.pop(context);
    // Compress the image
    Uint8List? compressedImage = await FlutterImageCompress.compressWithFile(
      imageFile.absolute.path,
      quality: 30, // Adjust the quality as needed
    );

    // Convert Uint8List to List<int>
    List<int> compressedImageList = compressedImage!.toList();

    // Save the compressed image to a new file
    final compressedImageFile = File('${imageFile.path}_compressed.jpg');
    await compressedImageFile.writeAsBytes(compressedImageList);

    // Encode the compressed image to base64
    pve?.imageData = base64Encode(compressedImageList);

    setState(() {});
    this.pve?.image = compressedImageFile;
   
  } on PlatformException catch (e) {
    print('Failed to pick image $e');
  }
}


 Future<void> PickImageImag2(ImageSource source) async {
  
  try {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    Navigator.pop(context);

    final File imageFile = File(image.path);

    // Compress the image
    Uint8List? compressedImage = await FlutterImageCompress.compressWithFile(
      imageFile.absolute.path,
      quality: 30, // Adjust the quality as needed
    );

    // Convert Uint8List to List<int>
    List<int> compressedImageList = compressedImage!.toList();

    // Save the compressed image to a new file
    final compressedImageFile = File('${imageFile.path}_compressed.jpg');
    await compressedImageFile.writeAsBytes(compressedImageList);

    // Encode the compressed image to base64
    pve?.imageData1 = base64Encode(compressedImageList);
  

    setState(() {});
    this.pve?.image1 = compressedImageFile;
      print("${ pve?.imageData1}");
  } on PlatformException catch (e) {
    print('Failed to pick image $e');
  }
}

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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Clear data or perform other actions when back button is pressed
          pve?.image = null;
                pve?.image1 = null;
              pve?.imageData1 = null; 
            Navigator.pop(context);
        // Allow the back navigation
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
           leading: InkWell(
            onTap: (){
              Navigator.pop(context);
               pve?.image = null;
                pve?.image1 = null;
              pve?.imageData1 = null; 
    
            },
            child: Icon(Icons.arrow_back)),
            backgroundColor: kgreen,
            title: Text(
            "Register As Dealer",
              style: TextStyle(
                  color: kwhite, fontWeight: FontWeight.w400, fontSize: 22),
            )),
        body: Consumer<AddressController>(builder: (context, ePv, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Shop Name",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        ExpandedContinor(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: TextField(
                               inputFormatters: [
                                  LengthLimitingTextInputFormatter(50),
                                ],
                              controller: ePv.shopNameController,
                              style: TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Shop Name",
                                hintStyle: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                                contentPadding: EdgeInsets.only(top: -20),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Dealer Name",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        ExpandedContinor(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: TextField(
                               inputFormatters: [
                                  LengthLimitingTextInputFormatter(50),
                                ],
                              controller: ePv.dealerNameController,
                              style: TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Dealer Name",
                                hintStyle: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                                contentPadding: EdgeInsets.only(top: -20),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Address of Shop",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        ExpandedContinor(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: TextField(
                              controller: ePv.AddressofShopController,
                              style: TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Shop Address ",
                                hintStyle: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                                contentPadding: EdgeInsets.only(top: -20),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "State",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        InkWell(
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                            border: Border.all(color: kblack, width: 0.3),
                            borderRadius: BorderRadius.circular(3)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Text(
                           "Select State",
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
                                 ?.toList() ?? [],
                            value: ePv.selectedState,
                            onChanged: (value) async {
                              setState(()  {
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
                                  Utils()
                                      .validationTostmassage(txt_select_state.tr);
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
    
                      
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "District",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 30,
                      decoration: BoxDecoration(
                          border: Border.all(color: kblack, width: 0.3),
                          borderRadius: BorderRadius.circular(3)),
                      child: InkWell(
                        onTap: (){
                             if(ePv.selectedState == null){
                                Utils().validationTostmassage(txt_select_district.tr,);
                              }
                        },
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Text(
                            "Select District",
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: ePv.citymodel?.data
                                .map((item) => DropdownMenuItem<String>(
                                      value:item.cityId.toString(),
                                      child: Text(
                                        item.cityName,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                ?.toList() ?? [],
                            value: ePv.selectedCity,
                            onChanged: (value) async {
                              setState(()  {
                                    ePv.cityid = null;
                                    ePv.selectedtaluka = null;
                                    ePv.talukaId  = null;
    
                                    
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
                        
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Taluka",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                         InkWell(
                      onTap: () {
                        if (ePv.selectedState == null) {
                          Utils().validationTostmassage(
                            txt_select_Taluka.tr,
                          );
                        } else {}
                      },
                      child: Container(
                        height: 30,
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
                               'Select Taluka',
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
                       
                        SizedBox(
                          height: 10,
                        ),
                         Text(
                          "Village Name",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        ExpandedContinor(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: TextField(
                              controller: ePv.shopvillagenamecontroller,
                              style: TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Village Name",
                                hintStyle: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                                contentPadding: EdgeInsets.only(top: -20),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Pin Code",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        ExpandedContinor(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: TextField(
                             keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(6),
                              ],
                              controller: ePv.pinCodeController,  
                              style: TextStyle(fontSize: 14),
                              onChanged: (value){
                               
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Pin code ",
                                hintStyle: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                                contentPadding: EdgeInsets.only(top: -20),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                       
                        Text(
                          "Whatsapp Mobile No.",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        ExpandedContinor(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: TextField(
                               keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                              ],
                              controller: ePv.whatsappMobileNumberController,
                              style: TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Whatsapp Mobile No.",
                                hintStyle: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                                contentPadding: EdgeInsets.only(top: -20),
                              ),
                               onChanged: (value) {
                  // Check mobile number validation on every change
                  validateMobileNumber(value);
                  print(  pve?.isMobileValid);
                },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "E-Mail",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        ExpandedContinor(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: TextField(
                              controller: ePv.emailController,
                              style: TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter E-Mail Id",
                                hintStyle: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                                contentPadding: EdgeInsets.only(top: -20),
                              ),
                              onChanged: (value){
                                // Check email validation on every change
                             validateEmail(value);
                              print( ePv.isEmailValid);
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Fertillizer Lic.No",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        ExpandedContinor(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: TextField(
                               inputFormatters: [
                                  LengthLimitingTextInputFormatter(40),
                                ],
                              controller: ePv.fertillizerController,
                              style: TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Fertillizer Lic.No",
                                hintStyle: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                                contentPadding: EdgeInsets.only(top: -20),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Pesticide Lic.No",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        ExpandedContinor(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: TextField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(40),
                                ],
                              controller: ePv.pestrcidelicNoController,
                              style: TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: " Enter Pesticide Lic.No",
                                hintStyle: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                                contentPadding: EdgeInsets.only(top: -20),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Seed Lic.No",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        ExpandedContinor(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: TextField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(40),
                                ],
                              controller: ePv.seedLicNumberController,
                              style: TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: " Enter Seed Lic.No",
                                hintStyle: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                                contentPadding: EdgeInsets.only(top: -20),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Valid Upto",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        InkWell(
                          onTap: () async {
                            await selectDate(context);
                            // Format the selected date and set it to the _datetimeController.text
                            ePv.validUptoController.text =
                                DateFormat('yyyy-MM-dd').format(selectedDate);
                          },
                          child: ExpandedContinor(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      enabled: false,
                                      controller: ePv.validUptoController,
                                      style: TextStyle(fontSize: 14),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: " Enter Valid Upto Date",
                                        hintStyle: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                        contentPadding: EdgeInsets.only(top: -20),
                                      ),
                                    ),
                                  ),
                                  Icon(Icons.arrow_drop_down)
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "PAN No.",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        ExpandedContinor(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: TextField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(40),
                                ],
                              controller: ePv.panNoController,
                              style: TextStyle(fontSize: 14),
                              onChanged: (value){
                                 validatePAN(value); 
                                 log("${ePv.PanValid}"); 
                                  String correctedValue = _autoCorrectPAN(value);
                  if (correctedValue != value) {
                    // Update the text field with corrected value
                    ePv.panNoController.value = TextEditingValue(
                      text: correctedValue,
                      selection: TextSelection.collapsed(offset: correctedValue.length),
                    );
                  }
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: " Enter PAN No",
                                hintStyle: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                                contentPadding: EdgeInsets.only(top: -20),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "GST No",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        ExpandedContinor(
                            
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: TextField(
                              inputFormatters: [
                                  LengthLimitingTextInputFormatter(40),
                                ],
                              controller: ePv.gstNumberController,
                              style: TextStyle(fontSize: 14),
                              onChanged: (value){
                                 validateGST(value); 
                                 log('${ePv.GstValid}');
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: " Enter GST No",
                                hintStyle: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                                contentPadding: EdgeInsets.only(top: -20),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Shop Owner Photo",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 8,
                        ),
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
                                            width:
                                                MediaQuery.of(context).size.width,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                // Your header and close button code here
    
                                                Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                    child: Column(children: [
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
                                                                  color: kblack,
                                                                  fontSize: 20),
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
                                                        PickImageImag(
                                                            ImageSource.camera);
                                                      },
                                                      child: Column(
                                                        children: [
                                                          Icon(
                                                            Icons.camera_alt,
                                                            size: 50,
                                                            color: grey800,
                                                          ),
                                                          Text(
                                                            'Camera',
                                                            style: TextStyle(
                                                              color: grey800,
                                                              fontSize: 18,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        PickImageImag(
                                                            ImageSource.gallery);
                                                      },
                                                      child: Column(
                                                        children: [
                                                          Icon(
                                                            Icons.insert_photo,
                                                            size: 50,
                                                            color: grey800,
                                                          ),
                                                          Text(
                                                            'Gallery',
                                                            style: TextStyle(
                                                                color: grey800,
                                                                fontSize: 18),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                h20,
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 12),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
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
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 0.30),
                                borderRadius: BorderRadius.circular(3)),
                            child:  pve?.image != null
                                ? Image.file(
                                    File( pve!.image!.path),
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                  )
                                : Icon(
                                    Icons.photo_camera,
                                    size: 40,
                                    color: klime,
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Shop Photo",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 8,
                        ),
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
                                            width:
                                                MediaQuery.of(context).size.width,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                // Your header and close button code here
    
                                                Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                    child: Column(children: [
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
                                                                  color: kblack,
                                                                  fontSize: 20),
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
                                                        PickImageImag2(
                                                          
                                                            ImageSource.camera);
                                                      },
                                                      child: Column(
                                                        children: [
                                                          Icon(
                                                            Icons.camera_alt,
                                                            size: 50,
                                                            color: grey800,
                                                          ),
                                                          Text(
                                                            'Camera',
                                                            style: TextStyle(
                                                              color: grey800,
                                                              fontSize: 18,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        PickImageImag2(
                                                            ImageSource.gallery);
                                                      },
                                                      child: Column(
                                                        children: [
                                                          Icon(
                                                            Icons.insert_photo,
                                                            size: 50,
                                                            color: grey800,
                                                          ),
                                                          Text(
                                                            'Gallery',
                                                            style: TextStyle(
                                                                color: grey800,
                                                                fontSize: 18),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                h20,
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 12),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
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
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 0.30),
                                borderRadius: BorderRadius.circular(3)),
                            child:  pve?.image1 != null
                                ? Image.file(
                                    File(pve!.image1!.path),
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                  )
                                : Icon(
                                    Icons.photo_camera,
                                    size: 40,
                                    color: klime,
                                  ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      ePv.registerShopValidation(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 160,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.green),
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }),
    
        
      ),
    );
   
   } 
   

    void validateEmail(String email) {
    // Regular expression for a basic email validation
    RegExp emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    bool isValid = emailRegExp.hasMatch(email);

    setState(() {
      // Update the state based on email validation result
       pve?.isEmailValid = isValid;
    });
  }
   void validateMobileNumber(String mobileNumber) {
    // Regular expression for a basic mobile number validation
     RegExp mobileRegExp = RegExp(r'^[0-9]{6}$|^[0-9]{8}$|^[0-9]{9}$');
    bool isValid = mobileRegExp.hasMatch(mobileNumber);

    setState(() {
      // Update the state based on mobile number validation result
        pve?.isMobileValid = isValid;
    });
  }
 String _autoCorrectPAN(String input) {
    // Your auto-correction logic goes here
    // For example, you might want to convert all characters to uppercase
    return input.toUpperCase();
  }
 void validatePAN(String value) {
    setState(() {
      // Regular expression for PAN validation
      RegExp panRegExp = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
       pve?.PanValid = panRegExp.hasMatch(value);
    });
  } 

   void validateGST(String value) {
    setState(() {
      // Regular expression for GST validation
      RegExp gstRegExp =
          RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[0-9A-Z]{1}[0-9]{1}$');
       pve?.GstValid = gstRegExp.hasMatch(value);
    });
  }

}

class ExpandedContinor extends StatelessWidget {
  const ExpandedContinor({super.key, this.child});
  final child;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 30,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0.30),
            borderRadius: BorderRadius.circular(3)),
        child: child);
  }
}

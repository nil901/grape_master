import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/auth/LocalString.dart';
import 'package:grape_master/util/color.dart';
import 'package:grape_master/util/constants.dart';
import 'package:grape_master/util/image_assets.dart';
import 'package:grape_master/util/util.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../../util/large_button.dart';
import '../../util/prefs/PreferencesKey.dart';
import '../../util/prefs/app_preference.dart';
import 'package:http/http.dart'as http;
import 'address_controller.dart';

// ignore: must_be_immutable
class UpdateProfile extends StatefulWidget {
  UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final stateController = TextEditingController();

  AddressController? pve;

  bool isOpen = false;
  bool isOpen1 = false;
  bool isOpen2 = false;

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
      String? profile1 = AppPreference().getString(PreferencesKey.profilePic);
    await saveImage(profile1);
      await pve?.stateListApi();
      await pve?.cityListApi();
      await pve?.talukaListApi();
    });
  }

  dynamic imageData = "";

  File? image;
  Future PickImageImag(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
    final File imageFile = File(image.path);
 
    // Compress the image
    Uint8List? compressedImage = await FlutterImageCompress.compressWithFile(
      imageFile.absolute.path,
      quality: 30, // Adjust the quality as needed
    );
 List<int> compressedImageList = compressedImage!.toList();

    // Save the compressed image to a new file
    final compressedImageFile = File('${imageFile.path}_compressed1.jpg');
    await compressedImageFile.writeAsBytes(compressedImageList);

      imageData = base64Encode(compressedImageList);

    
          setState(() {});
  // Navigator.pop(context);
      this.image = compressedImageFile;
      // log("${image.p}");
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  }
PickedFile? image1;
  String? profile1 = AppPreference().getString(PreferencesKey.profilePic);

  Future<void> saveImage(profilr) async {
  log("this image path ${profile1}");
  try {
    var response = await http.get(Uri.parse(profile1.toString()));
    final documentDirectory = await getApplicationDocumentsDirectory();
    final file = File('${documentDirectory.path}/profile.jpg');
    file.writeAsBytesSync(response.bodyBytes);
    image1 = PickedFile(file.path);
    image = File(file.path);
    print('Image saved to: ${profile1}');
  } catch (e) {
    print('Failed to save image: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    String? mobile = AppPreference().getString(PreferencesKey.umobile);
    String? fullname = AppPreference().getString(PreferencesKey.uName);
    //String? state = AppPreference().getString(PreferencesKey.statename);
   //int  cityid = AppPreference().getInt(PreferencesKey.cityid);
    // int? talukaName = AppPreference().getInt(PreferencesKey.talukaid);
    String? vilageName = AppPreference().getString(PreferencesKey.areaname);
  
  

     pve!.updatevilageNameController.text = vilageName;
  
    pve?.mobileNumbercontroller.text = mobile;
    pve?.fullNamecontroller.text = fullname;
   // pve?.updatestatecontroller.text = state;
    //pve?.updatedistrictController.text = cityname;
    pve?.vilageNameController.text = vilageName;
    
    print( profile1);
    
//   PickedFile? image;
  
// if (image != null && profile1 != null) {
//   // Create a new PickedFile object with the updated path
//   image = PickedFile(profile1);
// }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: kgreen,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              //  saveImage();
              },
              child: Icon(Icons.arrow_back)),
          title: Text(
            profile.tr,
            style: TextStyle(
                color: kwhite, fontWeight: FontWeight.w400, fontSize: 18),
          )),
      body: Consumer<AddressController>(builder: (context, ePv, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                h10,
                Center(
                  child: Container(
                    height: 130,
                    width: 190,
                    child: Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: kblack,
                            radius: 69,
                            child: CircleAvatar(
                              radius: 70.0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(70),
                                child: ClipOval(
                                  child: image != null
                                      ? Image.file(
                                          width: 200,
                                          height: 200,
                                          File(image!.path) ,
                                          
                                          fit: BoxFit.fill,
                                        )
                                      : ClipOval(
                                          child: image != null
                                              ? Image.network(
                                                profile1.toString(),
                                                  width: 200,
                                                  height: 200,
                                                )
                                              : Image.network(
                                                  height: 200,
                                                      width: 200,
                                                  fit: BoxFit.cover,
                                                  profile1.toString(), errorBuilder:
                                                      (BuildContext context,
                                                          Object error,
                                                          StackTrace?
                                                              stackTrace) {
                                                  // This function will be called when an error occurs while loading the image
                                                  return Image.asset(
                                                      ImageAssets.ic_profile);
                                                })),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 90,
                            right: 2,
                            child: InkWell(
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
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    // Your header and close button code here

                                                    Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 15),
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
                                                                color: grey800,
                                                              ),
                                                              Text(
                                                                'Camera',
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      grey800,
                                                                  fontSize: 18,
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
                                                                color: grey800,
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
                                                      padding: const EdgeInsets
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
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: klime,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      "assets/images/photocamera.png",
                                      color: kwhite,
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                h20,
                Text(
                  txt_fullname.tr,
                  style: TextStyle(
                      color: kgreen, fontWeight: FontWeight.w500, fontSize: 14),
                ),
                TextField(
                  controller: ePv.fullNamecontroller,
                  cursorColor: kblack,
                  style: TextStyle(color: kblack),
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: klime), // Change color here
                    ),
                  ),
                ),
                h20,
                Text(
                  txt_mobile.tr,
                  style: TextStyle(
                      color: kgreen, fontWeight: FontWeight.w500, fontSize: 14),
                ),
                TextField(
                  cursorColor: kblack,
                  controller: ePv.mobileNumbercontroller,
                  enabled: false,
                  style: TextStyle(color: kblack),
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: klime), // Change color here
                    ),
                  ),
                ),
                h24,
                Text(
                  txt_state.tr,
                  style: TextStyle(
                      color: kgreen, fontWeight: FontWeight.w500, fontSize: 14),
                ),
                h10,
                InkWell(
                  onTap: (){
                          pve?.selectedState = null;
                             ePv.cityid = null;
                            ePv.selectedtaluka = null;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: kblack, width: 0.3),
                        borderRadius: BorderRadius.circular(3)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Text(
                           txt_district.tr,
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
                        
                          pve?.selectedState = null;
                           ePv.selectedCity = null;
                            ePv.selectedtaluka = null;
                            ePv.selectedState =
                                value; // Corrected assignment here
                           
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
                  txt_district.tr,
                  style: TextStyle(
                      color: kgreen, fontWeight: FontWeight.w500, fontSize: 14),
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
                            txt_district.tr,
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
                       
                            ePv.cityid = null;
                            ePv.selectedtaluka = null;
                            ePv.talukaId = null;

                            pve!.selectedCity = value;
                            ePv.cityid = value;
                            print(value);
                            ePv.talukaListApi();
                       
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
                      color: kgreen, fontWeight: FontWeight.w500, fontSize: 14),
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
                           txt_Taluka.tr,
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
                            
                          });
                              ePv.talukaId = null;
                              pve!.selectedtaluka = value;
                              ePv.talukaId = value;
                              print(value);
                          
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
                      color: kgreen, fontWeight: FontWeight.w500, fontSize: 14),
                ),
                h10,
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                      border: Border.all(color: kblack, width: 0.3),
                      borderRadius: BorderRadius.circular(3)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: ePv.updatevilageNameController,
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
                      saveImage(profile1).then((value) { 
                        log(" this image path $profile1");
                ePv.update(context, imageData);
                      });
                      
                    },
                    text: Text(
                      submit.tr,
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
    );
  }
}

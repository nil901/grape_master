import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../util/color.dart';
import '../../util/constants.dart';
import '../address/address_controller.dart';

class ProductAddFrom extends StatefulWidget {
  const ProductAddFrom({super.key, this.shopId});
  final shopId;

  @override
  State<ProductAddFrom> createState() => _ProductAddFromState();
}

class _ProductAddFromState extends State<ProductAddFrom> {
  AddressController? pve;

  bool isOpen = false;
  bool isOpen1 = false;
  bool isOpen2 = false;

  @override
  void initState() {
    this.pve?.image3 = null;
    print(pve?.image3);
    pve = Provider.of<AddressController>(context, listen: false);
    // init();
    super.initState();
  }

  // void init() async {
  //   WidgetsBinding.instance.addPostFrameCallback((_) async {
  //     await pve?.stateListApi();
  //     await pve?.cityListApi();
  //     await pve?.talukaListApi();
  //   });
  // }

  Future<void> comanyareaselsperson(ImageSource source) async {
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
      this.pve?.image2 = compressedImageFile;
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  }

  // Future productPhoto(ImageSource source) async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: source);
  //     if (image == null) return;
  //     final imageTemporary = File(image.path);
  //     pve?.imageData1 = base64Encode(imageTemporary.readAsBytesSync());

  //     setState(() {});
  //     this.pve?.image1 = imageTemporary;
  //     // Navigator.pop(context);
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image $e');
  //   }
  // }

  Future<void> productPhoto(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      // Navigator.pop(context);

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
      this.pve?.image= compressedImageFile;
      print("${pve?.imageData1}");
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        pve?.image = null;
        pve?.image1 = null;
        pve?.image2 = null;
        pve?.imageData1 = null;
        pve?.imageData = null;
        pve?.productnameController.clear();
          pve?.cleardata();
        // Clear the image data or perform other actions
        pve?.imageData = null; // Assuming imageData needs to be cleared
        // Add more clearing logic if needed

        // Optionally, you can navigate back
        // Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              pve?.image = null;
              pve?.image1 = null;
              pve?.imageData1 = null;
              pve?.imageData = null;
              pve?.image2 = null;
              pve?.imageData = null;
                pve?.productnameController.clear();
                pve?.cleardata();
            },
            child: Icon(Icons.arrow_back),
          ),
          backgroundColor: kgreen,
          title: InkWell(
            onTap: () {
              // Handle the onTap for the title
              // You can add your logic here
            },
            child: Text("Products"),
          ),
        ),
        body: Consumer<AddressController>(builder: (context, ePv, child) {
          return Container(
            height: MediaQuery.of(context).size.height,
            color: kbgcolor,
            child: Padding(
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
                            "Product Name",
                            style: TextStyle(
                                color: kgreen,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                          h10,
                          Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: kwhite,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 0.40, color: kblack),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: TextField(
                                controller: ePv.productnameController,
                                cursorColor: Colors.black,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: grey800,
                                    fontWeight: FontWeight.w400),
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle:
                                      TextStyle(fontSize: 15, color: grey800),
                                  hintText: "Enter Product Name",
                                ),
                              ),
                            ),
                          ),
                          h20,
                          Text(
                            "Product Description",
                            style: TextStyle(
                                color: kgreen,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                          h10,
                          Container(
                            height: 130,
                            decoration: BoxDecoration(
                              color: kwhite,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 0.40, color: kblack),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: TextField(
                                   inputFormatters: [
                                  LengthLimitingTextInputFormatter(50),
                                ],
                                controller: ePv.productDecriptionController,
                                cursorColor: Colors.black,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: grey800,
                                    fontWeight: FontWeight.w400),
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle:
                                      TextStyle(fontSize: 15, color: grey800),
                                  hintText: "Enter Product Description",
                                ),
                              ),
                            ),
                          ),
                          h20,
                          Text(
                            "Product Photo",
                            style: TextStyle(
                                color: kgreen,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
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
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  // Your header and close button code here

                                                  Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
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
                                                          productPhoto(
                                                              ImageSource
                                                                  .camera);
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
                                                          Navigator.pop(
                                                              context);
                                                          productPhoto(
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
                                                                  fontSize: 18),
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
                                                      alignment:
                                                          Alignment.bottomRight,
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
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black, width: 0.30),
                                  borderRadius: BorderRadius.circular(3)),
                              child: pve?.image != null
                                  ? Image.file(
                                      File(pve!.image!.path),
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
                          h20,
                          Text(
                            "Measure Of Use & Stage",
                            style: TextStyle(
                                color: kgreen,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                          h10,
                          Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: kwhite,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 0.40, color: kblack),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: TextField(
                                   inputFormatters: [
                                  LengthLimitingTextInputFormatter(50),
                                ],
                                controller:
                                    ePv.updatemesasureofuseandstageController,
                                cursorColor: Colors.black,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: grey800,
                                    fontWeight: FontWeight.w400),
                                onChanged: (value) {
                                  setState(() {
                                    print(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle:
                                      TextStyle(fontSize: 15, color: grey800),
                                  hintText: "Measure Of Use & Stage",
                                ),
                              ),
                            ),
                          ),
                          h20,
                          Text(
                            "Price(Rs)",
                            style: TextStyle(
                                color: kgreen,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                          h10,
                          Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: kwhite,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 0.40, color: kblack),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: TextField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                keyboardType: TextInputType.number,
                                controller: ePv.priceController,
                                cursorColor: Colors.black,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: grey800,
                                    fontWeight: FontWeight.w400),
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle:
                                      TextStyle(fontSize: 15, color: grey800),
                                  hintText: "Price",
                                ),
                              ),
                            ),
                          ),
                          h20,
                          Text(
                            "Company Name (Brand Name)",
                            style: TextStyle(
                                color: kgreen,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                          h10,
                          Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: kwhite,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 0.40, color: kblack),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: TextField(
                                   inputFormatters: [
                                  LengthLimitingTextInputFormatter(50),
                                ],
                                controller: ePv.companyNameController,
                                cursorColor: Colors.black,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: grey800,
                                    fontWeight: FontWeight.w400),
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle:
                                      TextStyle(fontSize: 15, color: grey800),
                                  hintText: "Company Name (Brand Name)",
                                ),
                              ),
                            ),
                          ),
                          h20,
                          Text(
                            "Company Area Sale Person's Name",
                            style: TextStyle(
                                color: kgreen,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                          h10,
                          Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: kwhite,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 0.40, color: kblack),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: TextField(
                                   inputFormatters: [
                                  LengthLimitingTextInputFormatter(50),
                                ],
                                controller: ePv.companysalePersonController,
                                cursorColor: Colors.black,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: grey800,
                                    fontWeight: FontWeight.w400),
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle:
                                      TextStyle(fontSize: 15, color: grey800),
                                  hintText: "Company Area Sale Person's Name",
                                ),
                              ),
                            ),
                          ),
                          h20,
                          Text(
                            "Company Area Sale Person's Mobile Number",
                            style: TextStyle(
                                color: kgreen,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                          h10,
                          Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: kwhite,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 0.40, color: kblack),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: TextField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                keyboardType: TextInputType.number,
                                controller: ePv
                                    .companyareasalePersonmobilenumberController,
                                cursorColor: Colors.black,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: grey800,
                                    fontWeight: FontWeight.w400),
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle:
                                      TextStyle(fontSize: 15, color: grey800),
                                  hintText:
                                      "Company Area Sale Person's Mobile Number",
                                ),
                              ),
                            ),
                          ),
                          h20,
                          Text(
                            "Company Area Sale Person's Photo ",
                            style: TextStyle(
                                color: kgreen,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
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
                                                            comanyareaselsperson(
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
                                                            comanyareaselsperson(
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
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 0.30),
                                      borderRadius: BorderRadius.circular(3)),
                                  child: pve?.image2 != null
                                      ? Image.file(
                                          File(pve!.image2!.path),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover,
                                        )
                                      : Icon(Icons.photo_camera_outlined,
                                          size: 35, color: kgreen)))
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        ePv.addProductValidation(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 45,
                        width: 140,
                        decoration: BoxDecoration(
                            color: kgreen,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text("Submit",
                            style: TextStyle(
                                color: kwhite,
                                fontWeight: FontWeight.w600,
                                fontSize: 15)),
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
}

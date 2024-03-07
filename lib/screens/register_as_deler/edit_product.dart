

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grape_master/model/home_model/product_list_api.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../util/color.dart';
import '../../util/constants.dart';
import '../address/address_controller.dart';

class UpdateProductAddFrom extends StatefulWidget {
  const UpdateProductAddFrom({super.key, this.shopId, required this.items });
  final ProductLiastModelDATA items;
  final shopId;

  @override
  State<UpdateProductAddFrom> createState() => _UpdateProductAddFromState();
}

class _UpdateProductAddFromState extends State<UpdateProductAddFrom> {
   AddressController? pve;

  bool isOpen = false;
  bool isOpen1 = false;
  bool isOpen2 = false;

  @override
  void initState() {
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
  
  Future PickImageImag2(ImageSource source) async {
    try {
      final image1 = await ImagePicker().pickImage(source: source);
      if (image1 == null) return;
      final imageTemporary = File(image1.path);
      pve?.imageData1 = base64Encode(imageTemporary.readAsBytesSync());

      setState(() {});
      this.pve?.image1 = imageTemporary;
      Navigator.pop(context);
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  } 

  
  Future PickImageImag(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      pve?.imageData = base64Encode(imageTemporary.readAsBytesSync());

      setState(() {});
      this.pve?.image = imageTemporary;
      Navigator.pop(context);
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  }

  @override
  Widget build(BuildContext context) {
   pve?.productnameController.text = widget.items.PRODUCT_NAME.toString() ;
   pve?.productDecriptionController.text = widget.items.PRODUCT_DESCRIPTION.toString() ;
    pve?.imageData = widget.items.PRODUCT_PHOTO.toString() ;
    pve?.updatemesasureofuseandstageController.text = widget.items.MEASURE_OF_USE.toString() ;
    pve?.priceController.text = widget.items.PRICE.toString() ;
     pve?.companyNameController.text = widget.items.BRAND_NAME.toString() ;
      pve?.companyareasalePersonmobilenumberController.text = widget.items.EMPLOYEE_MOBILE_NO.toString() ;
         pve?.companysalePersonController.text = widget.items.EMPLOYEE_NAME.toString() ;
         log("${widget.items.MEASURE_OF_USE.toString()}");
         

    return  Scaffold( 
       appBar: AppBar(
          backgroundColor: kgreen,
          title: Text(
            "Products",
            style: TextStyle(
                color: kwhite, fontWeight: FontWeight.w400, fontSize: 18),
          )), 

          body:Consumer<AddressController>(builder: (context, ePv, child) {
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
                            color: kgreen, fontWeight: FontWeight.w500, fontSize: 14),
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
                          padding: const EdgeInsets.symmetric(horizontal: 5),
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
                              hintStyle: TextStyle(fontSize: 15, color: grey800),
                              hintText: "Enter Product Name",
                            ),
                          ),
                        ),
                                          ),
                                          h20,
                                           Text(
                        "Product Description",
                        style: TextStyle(
                            color: kgreen, fontWeight: FontWeight.w500, fontSize: 14),
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
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: TextField(
                            controller: ePv.productDecriptionController,
                            cursorColor: Colors.black,
                            style: TextStyle(
                                fontSize: 13,
                                color: grey800,
                                fontWeight: FontWeight.w400),
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(fontSize: 15, color: grey800),
                              hintText: "Enter Product Description",
                            ),
                          ),
                        ),
                                          ),
                                 h20,
                                  Text(
                        "Product Photo",
                        style: TextStyle(
                            color: kgreen, fontWeight: FontWeight.w500, fontSize: 14),
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
                                    border: Border.all(
                                        color: Colors.black, width: 0.30),
                                    borderRadius: BorderRadius.circular(3)),
                                child: pve?.image1 != null
                                    ? Image.file(
                                        File(pve!.image1!.path),
                                        width: MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                      )
                                    :  Image.network(widget.items.PRODUCT_PHOTO.toString())),
                          ),
                          h20,
                                          
                                          
                                           Text(
                        "Measure of use & Stage",
                        style: TextStyle(
                            color: kgreen, fontWeight: FontWeight.w500, fontSize: 14),
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
                          padding:  EdgeInsets.symmetric(horizontal: 5),
                          child: TextField(
                            controller: ePv.updatemesasureofuseandstageController,
                            cursorColor: Colors.black,
                            style: TextStyle(
                                fontSize: 13,
                                color: grey800,
                                fontWeight: FontWeight.w400),
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(fontSize: 15, color: grey800),
                              hintText: "Measure of use & Stage",
                            ),
                          ),
                        ),
                                          ),
                                          h20,
                                          Text(
                        "Price(RS)",
                        style: TextStyle(
                            color: kgreen, fontWeight: FontWeight.w500, fontSize: 14),
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
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: TextField(
                            controller: ePv.priceController,
                            cursorColor: Colors.black,
                            style: TextStyle(
                                fontSize: 13,
                                color: grey800,
                                fontWeight: FontWeight.w400),
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(fontSize: 15, color: grey800),
                              hintText: "Price",
                            ),
                          ),
                        ),
                                          ),
                                          h20,
                                          Text(
                        "Company Name (Brand Name)",
                        style: TextStyle(
                            color: kgreen, fontWeight: FontWeight.w500, fontSize: 14),
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
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: TextField(
                            controller: ePv.companyNameController,
                            cursorColor: Colors.black,
                            style: TextStyle(
                                fontSize: 13,
                                color: grey800,
                                fontWeight: FontWeight.w400),
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(fontSize: 15, color: grey800),
                              hintText: "Company Name (Brand Name)",
                            ),
                          ),
                        ),
                                          ),
                                          h20, 
                                        
                                          Text(
                        "Company Area Sale Person's Name",
                        style: TextStyle(
                            color: kgreen, fontWeight: FontWeight.w500, fontSize: 14),
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
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: TextField(
                            controller: ePv.companysalePersonController,
                            cursorColor: Colors.black,
                            style: TextStyle(
                                fontSize: 13,
                                color: grey800,
                                fontWeight: FontWeight.w400),
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(fontSize: 15, color: grey800),
                              hintText: "Company Area Sale Person's Name",
                            ),
                          ),
                        ),
                                          ),
                                          h20, 
                      
                                        
                                        
                                          Text(
                        "Company Area Sale Person's Mobile Number",
                        style: TextStyle(
                            color: kgreen, fontWeight: FontWeight.w500, fontSize: 14),
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
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: TextField(
                            controller: ePv.companyareasalePersonmobilenumberController,
                            cursorColor: Colors.black,
                            style: TextStyle(
                                fontSize: 13,
                                color: grey800,
                                fontWeight: FontWeight.w400),
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(fontSize: 15, color: grey800),
                              hintText: "Company Area Sale Person's Mobile Number",
                            ),
                          ),
                        ),
                                          ),
                                          h20,
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
                                  border: Border.all(
                                      color: Colors.black, width: 0.30),
                                  borderRadius: BorderRadius.circular(3)),
                              child: pve?.image != null
                                  ? Image.file(
                                      File(pve!.image!.path),
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                    )
                                  : widget.items.EMPLOYEE_PHOTO == ''? Icon( Icons.photo_camera_outlined,size: 35,color:kgreen ):Image.network(
  widget.items.EMPLOYEE_PHOTO.toString(),
  errorBuilder: (context, error, stackTrace) {
    return Icon(Icons.error); // Display an error icon or any other widget
  },
)
 ))
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: (){
                        
                          ePv.editProductValidation(context,widget.items.SP_ID);
                        },
                        child: Container(
                           alignment: Alignment.center,
                          height: 45,
                           width:140 , 
                           decoration:BoxDecoration(  
                             color:kgreen, 
                             borderRadius: BorderRadius.circular(10)
                           ),
                           child: Text("Submit",style:TextStyle(color:kwhite,fontWeight: FontWeight.w600, fontSize: 15)),
                                          
                        ),
                      ),
                    )
                      ],
                    ),
                  ),
            
                  
                );
          }
          ),
            );
  }
}
import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/auth/LocalString.dart';
import 'package:grape_master/screens/post/post_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../model/post_models/post_model.dart';
import '../../util/color.dart';
import '../../util/constants.dart';
import '../../util/large_button.dart';

class EditPostScreen extends StatefulWidget {
  const EditPostScreen({super.key, required this.post});
  final PostModelDATA post;
  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  bool isOpen = false;

  postCnt? eProvider;
  @override
  void initState() {
    eProvider = Provider.of<postCnt>(context, listen: false);
    init();
    // TODO: implement initState
    super.initState();
  }

  void init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async { 
      eProvider?.cropSelected = widget.post?.CROP_ID ?? '';
      await eProvider?.addPostcropApi();
    });
  }

  File? image1;
  dynamic imageData = "";
  Future PickImageImag(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      eProvider?.imageData = base64Encode(imageTemporary.readAsBytesSync());

      setState(() {});

      this.image1 = imageTemporary;
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kgreen,
          title: Text(
           editpost.tr,
            style: TextStyle(
                color: kwhite, fontWeight: FontWeight.w400, fontSize: 18),
          )),
      body: Consumer<postCnt>(builder: (context, ePv, child) {
        eProvider!.cropController.text = widget.post.CROP_NAME.toString();
        eProvider!.discriptionController.text =
            widget.post.POST_DESCRIPTION.toString();
           ///eProvider?.cropID = int.tryParse(widget.post?.CROP_ID ?? '');
          
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
                        border: Border.all(color: kblack, width: 0.3),
                        borderRadius: BorderRadius.circular(3)),
                    child: InkWell(
                      onTap: (){
                           
                      },
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
                          items: ePv.addPostCropModel?.data
                              .map((item) => DropdownMenuItem<String>(
                                    value:item.cropId.toString(),
                                    child: Text(
                                      item.cropName,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                              ?.toList() ?? [],
                          value: ePv.cropSelected,
                          onChanged: (value) async {
                           
                                  setState(() {
                                    
                                  });
                            ePv.cropSelected = value;
                                 

                                  
      
                           
                            
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
                         description.tr,
                        style: TextStyle(
                            color: kgreen,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                      h10,
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(color: kblack, width: 0.3),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: TextFormField(
                            cursorColor: klime,
                            controller: ePv.discriptionController,
                            maxLines: 10,
                            onChanged: (value) {},
                            style: TextStyle(fontSize: 13),
                            decoration: InputDecoration(
                                //  focusedBorder:InputBorder(borderSide: ) ,
                                helperStyle: TextStyle(color: grey800),
                                hintText:description.tr,
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
                         photo.tr,
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
                                                            ImageSource
                                                                .gallery);
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
                                                  padding: const EdgeInsets
                                                          .symmetric(
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
                              alignment: Alignment.center,
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border.all(color: kblack, width: 0.2),
                                  borderRadius: BorderRadius.circular(5)),
                              child: image1 != null
                                  ? Image.file(
                                      File(image1!.path),
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      widget.post.POST_IMAGE.toString()))),
                    ],
                  ),
                ),
              ),
              Center(
                  child: LargeButton(
                onPress: () {
              widget.post.POST_ID;
                  ePv.editpost(context,widget.post.POST_ID);
                },
                text: Text(
                  txt_submit.tr,
                  style: TextStyle(color: kwhite, fontWeight: FontWeight.bold),
                ),
              ))
            ],
          ),
        );
      }),
    );
  }
}

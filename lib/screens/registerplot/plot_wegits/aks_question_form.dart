import 'dart:convert';
import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:grape_master/util/constants.dart';
import 'package:grape_master/util/large_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../../util/color.dart';
import '../../../util/image_assets.dart';
import '../../auth/LocalString.dart';
import '../plot_controller.dart';

class AskQutionsForm extends StatefulWidget {
  const AskQutionsForm({super.key, this.id});

  final id;

  @override
  State<AskQutionsForm> createState() => _AskQutionsFormState();
}

class _AskQutionsFormState extends State<AskQutionsForm> {
  plotcnt? eProvider;
  bool isOpen = false;
  FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  late String _filePath;

  @override
  void initState() {
   // _init();
    eProvider = Provider.of<plotcnt>(context, listen: false);

    init();
    // TODO: implement initState
    super.initState();
  }

  // _init() async {
  //   // Request permissions
  //   var microphoneStatus = await Permission.microphone.request();
  //   var storageStatus = await Permission.storage
  //       .request(); // Add this line to request storage permission
  //   var extrnalStatus = await Permission.manageExternalStorage
  //       .request(); // Add this line to request storage permission

  //   if (microphoneStatus.isGranted && storageStatus.isGranted) {
  //     await _recorder.openRecorder();
  //   } else {
  //     // Handle permission denied
  //     if (!microphoneStatus.isGranted) {
  //       print('Microphone permission denied');
  //     }
  //     if (!storageStatus.isGranted) {
  //       print('Storage permission denied');
  //     }
  //     if (!extrnalStatus.isGranted) {
  //       print('Extrnal permission denied');
  //     }
  //   }
  // }
startRecording() async {
    print('hello');
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String folderPath = path.join(appDocDir.path, '/storage/emulated/0/Music'); // Define the folder name
      await Directory(folderPath).create(recursive: true); // Create the folder if it doesn't exist
      _filePath = path.join(folderPath, 'ttttttttsvsvsv.aac'); // Define the file path within the folder

      print('File path: $_filePath');

      await _recorder.startRecorder(
        toFile: _filePath,
        codec: Codec.aacADTS,
      );

      print('Recorder started');
    } catch (err) {
      print('Error starting recorder: $err');
    }
  }

  stopRecording(context) async {
   // navigator!.pop(context);
    try {
      await _recorder.stopRecorder();
      //isdisplay = true;
      print('Recording stopped');

      if (_filePath != null) {
        print('File saved to: $_filePath');

        // Define the desired directory path
        final desiredDirectory =
            '/my_recordings'; // Change this to your desired directory

        // Get the external storage directory
        final externalDirectory = await getExternalStorageDirectory();
        if (externalDirectory != null) {
          // Create the directory if it doesn't exist
          final musicDirectory =
              Directory('${externalDirectory.path}$desiredDirectory');
          if (!await musicDirectory.exists()) {
            await musicDirectory.create(recursive: true);
          }

          // Define the new file path within the desired directory
          final newFilePath = '${musicDirectory.path}/recorded_audio.aac';
          await File(_filePath).copy(newFilePath);
          print('File saved to: $newFilePath');

          // Open the file using the open_file package
           OpenFile.open(newFilePath);
        }
      }
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }

  void init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await eProvider?.quetionCategoreyListApi();
    });
  }

  File? image1;
  dynamic imageData = "";
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

    // Convert Uint8List to List<int>
     final compressedImageFile = File('${imageFile.path}_compressed.jpg');
    await compressedImageFile.writeAsBytes(compressedImageList);

    // Encode the compressed image to base64
    eProvider?.imageData = base64Encode(compressedImageList);

      setState(() {});
  this.image1 = compressedImageFile;
  //  Navigator.pop(context);
      // this.image1 = imageTemporary;
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
    // Navigator.pop(context);
  }

  @override
  void dispose() {
    _recorder.stopRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
              eProvider?.cropSelected = null;
            eProvider?.quetionCategoreyController.clear();
                   eProvider?.descriptionController.clear();
                          eProvider?.imageData = "";
                          Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back)),
          backgroundColor: kgreen,
          title: Text(
            txt_ask_question.tr,
            style: TextStyle(
                color: kwhite, fontWeight: FontWeight.w400, fontSize: 22),
          )),
      body: Consumer<plotcnt>(builder: (context, ePv, child) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
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
                        txt_category.tr,
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
                          items: ePv.questionCategoreyModel?.data
                              .map((item) => DropdownMenuItem<String>(
                                    value:item.fqcId.toString(),
                                    child: Text(
                                      item.faqcName,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                              ?.toList() ?? [],
                          value: ePv.cropSelected,
                          onChanged: (value) async {
                            setState(()  {
                                  
                            ePv.cropSelected = value;
                                 

                                  
      
                           
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
                      if (isOpen)
                        SizedBox(
                          height: 200,
                          child: ListView(
                            shrinkWrap: true,
                            primary: false,
                            children:
                                ePv.questionCategoreyModel!.data.map((state) {
                              return Container(
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          isOpen = false;
                                          ePv.categoreyPostId = state.fqcId;
                                          ePv!.quetionCategoreyController.clear();
                                          ePv!.quetionCategoreyController.text =
                                              state.faqcName;
                        
                                          setState(() {});
                                        },
                                        child: Text(state.faqcName,
                                            style: TextStyle(fontSize: 16)),
                                      )));
                            }).toList(),
                          ),
                        ),
                      h20,
                      
                           Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${txt_question.tr}",
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
                                        horizontal: 5),
                                    child: TextFormField(
                                      cursorColor: klime,
                                      controller: ePv.newQuetionnController,
                                      maxLines: 10,
                                      onChanged: (value) {},
                                      style: TextStyle(fontSize: 13),
                                      decoration: InputDecoration(
                                         contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                          //  focusedBorder:InputBorder(borderSide: ) ,
                                          helperStyle:
                                              TextStyle(color: grey800),
                                          hintText: txt_question.tr,
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
                          
                      h34,
                      Text(
                        "${txt_photo.tr}",
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
                                                      Navigator.pop(context);
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
                                                       Navigator.pop(context);
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
                          alignment: Alignment.center,
                          height: 200,
                          decoration: BoxDecoration(
                              border: Border.all(color: kblack, width: 0.2),
                              borderRadius: BorderRadius.circular(5)),
                          child: image1 != null
                              ? Image.file(
                                  File(image1!.path),
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
                    ],
                  ),
                ),
              ),
              Center(
                  child: LargeButton(
                onPress: () {
                   ePv.validationPostQuetion(context);
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

class OpenrecoardDilog extends StatefulWidget {
  const OpenrecoardDilog({super.key});

  @override
  State<OpenrecoardDilog> createState() => _OpenrecoardDilogState();
}

class _OpenrecoardDilogState extends State<OpenrecoardDilog> {
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<plotcnt>(builder: (context, ePv, child) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              color: kgreen,
              child: InkWell(
                onTap: () {
                  isloading = !isloading;
                  setState(() {});
                },
                child: Text(
                  "Select to Start",
                  style: TextStyle(
                      color: kwhite, fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ),
            ),
            h20,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(100),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isloading = false;
                    });
                    //  navigator!.pop(context);
                    ePv.startRecording();

                    showDialog(
                        context: context,
                        builder: (context) {
                          return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: AlertDialog(
                                insetPadding: EdgeInsets.all(12),
                                contentPadding: EdgeInsets.zero,
                                content: SingleChildScrollView(
                                    child: OpenAndPickupFile()),
                              ));
                        });
                  },
                  child: isloading == true
                      ? InkWell(
                        onTap: (){
                            ePv.stopRecording(context);
                        },
                        child: CircleAvatar(
                            backgroundColor: kwhite,
                            radius: 40,
                            child: Image.asset(
                              ImageAssets.ic_stop,
                              height: 40,
                            ),
                          ),
                      )
                      : InkWell(
                          onTap: () {
                             isloading == true;
                          
                            ePv.startRecording();
                          },
                          child: CircleAvatar(
                            backgroundColor: kwhite,
                            radius: 40,
                            child: Image.asset(
                              ImageAssets.ic_micc,
                              height: 40,
                            ),
                          ),
                        ),
                ),
              ),
            ),
            Text(
              "Start",
              style: TextStyle(
                  color: kblack, fontSize: 18, fontWeight: FontWeight.w600),
            ),
            h20
          ],
        ),
      );
    });
  }
}

class OpenAndPickupFile extends StatelessWidget {
  const OpenAndPickupFile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<plotcnt>(builder: (context, ePv, child) {
      return Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: kgreen),
          child: Column(
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(color: kgreen),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    h20,
                    Text(
                      "Upload your file",
                      style:
                          TextStyle(color: kwhite, fontWeight: FontWeight.bold),
                    ),
                    h20,
                    InkWell(
                      onTap: () {
                        ePv.openFileExplorer(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 36,
                        width: 120,
                        decoration: BoxDecoration(
                            color: kwhite,
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          "Select",
                          style: TextStyle(
                              color: kgreen, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ));
    });
  }
}

import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/Home/home_controller.dart';
import 'package:grape_master/screens/auth/LocalString.dart';
import 'package:grape_master/util/color.dart';
import 'package:grape_master/util/constants.dart';
import 'package:grape_master/util/image_assets.dart';
import 'package:grape_master/util/lodaer.dart';
import 'package:grape_master/util/util.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:http/http.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'package:share_plus/share_plus.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;

class StackExample extends StatefulWidget {
  @override
  State<StackExample> createState() => _StackExampleState();
}

class _StackExampleState extends State<StackExample> {
  HomeController? eProvider;
  final player = AudioPlayer();
  @override
  void initState() {
    eProvider = Provider.of<HomeController>(context, listen: false);
    init();
    player.play(AssetSource('clap.mp3'));
    // TODO: implement initState
    super.initState();
  }

  final GlobalKey<ScreenshotState> screenshotKey = GlobalKey<ScreenshotState>();
  ScreenshotController screenshotController = ScreenshotController();

  void init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await eProvider?.resultquizeapi();
    });
  }

  @override
  void dispose() {
    player.stop();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<HomeController>(builder: (context, ePv, child) {
          return ePv.resultModel?.DATA == null ||
                  ePv.resultModel?.DATA?.length == 0
              ? Center(
                  child: Loader(),
                )
              : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    h60,
                  h20,
                           Screenshot(
                    controller: screenshotController,
                    key: screenshotKey,
                      child: Material(
                        color: kwhite,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                          child: Center(
                            child: Stack(
                              children: [
                                Container(
                                  width: 380,
                                  height: 560,
                                  color: Colors.transparent,
                                ),
                                Positioned(
                                  top: 20,
                                  child: Container(
                                      width: 360,
                                      height: 535,
                                      decoration: BoxDecoration(
                                          color: kwhite,
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  ImageAssets.ic_score))),
                                      child: Column(
                                        children: [
                                          h50,
                                          h10,
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30, vertical: 3),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                w20,
                                                Expanded(
                                                  child: Container(
                                                    height: 160,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20),
                                                        color: sgreen),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                      children: [
                                                        Center(
                                                            child: Image.asset(
                                                          'assets/images/troph.png',
                                                          height: 65,
                                                        )),
                                                        h5,
                                                        Text(
                                                          "Rank",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color: kred,
                                                              fontWeight:
                                                                  FontWeight.w600),
                                                        ),
                                                        h5,
                                                        Text(
                                                          ePv.resultModel!.DATA![0]!
                                                              .FARMER_RANK
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color: kred,
                                                              fontWeight:
                                                                  FontWeight.w600),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                w30,
                                                Expanded(
                                                  child: Container(
                                                    height: 160,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20),
                                                        color: slime),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                      children: [
                                                        Center(
                                                            child: Image.asset(
                                                          'assets/images/medal.png',
                                                          height: 65,
                                                        )),
                                                        h5,
                                                        Text(
                                                          "Score",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color: kred,
                                                              fontWeight:
                                                                  FontWeight.w600),
                                                        ),
                                                        h5,
                                                        Text(
                                                          ePv.resultModel!.DATA![0]!
                                                              .FARMER_POINT
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color: kred,
                                                              fontWeight:
                                                                  FontWeight.w600),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                w20,
                                              ],
                                            ),
                                          ),
                                          h70,
                                          h70,
                                          Text(
                                            yesterday_s_winner.tr,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: kblack,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          h10,
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Container(
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: kwhite,
                                                  border: Border.all(
                                                      width: 0.75, color: kblack),
                                                  borderRadius:
                                                      BorderRadius.circular(10)),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Expanded(
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                        'assets/images/trophy.png',
                                                        height: 25,
                                                      ),
                                                      w8,
                                                      CircleAvatar(
                                                        radius: 15,
                                                        backgroundImage: ePv
                                                                    .resultModel
                                                                    ?.DATA1?[0]
                                                                    ?.PROFILE_PHOTO
                                                                    ?.isNotEmpty ??
                                                                false
                                                            ? NetworkImage(ePv
                                                                    .resultModel!
                                                                    .DATA1![0]!
                                                                    .PROFILE_PHOTO!
                                                                as String)
                                                            : AssetImage(ImageAssets
                                                                    .ic_profile)
                                                                as ImageProvider<
                                                                    Object>,
                                                      ),
                                                      w8,
                                                      Text(
                                                        ePv.resultModel!.DATA1![0]!
                                                            .FULL_NAME
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: kgreen,
                                                            fontWeight:
                                                                FontWeight.w400),
                                                      ),
                                                      w8,
                                                      Text(
                                                        ePv.resultModel!.DATA1![0]!
                                                            .STATE_NAME
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: klime,
                                                            fontWeight:
                                                                FontWeight.w400),
                                                      ),
                                                      w8,
                                                      Expanded(
                                                        child: Text(
                                                            overflow: TextOverflow.ellipsis,
                                                          "Rank ${ePv.resultModel!.DATA1![0]!.FARMER_RANK}",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: kgreen,
                                                              fontWeight:
                                                                  FontWeight.w400),
                                                        ),
                                                      ),
                                                                         Expanded(
                                                                           child: Image.asset(
                                                                                                                               'assets/images/trophy.png',
                                                                                                                               height: 18,
                                                                                                                             ),
                                                                         ),
                                                      // Image.asset(ImageAssets.ic_pressure,height: 25,),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                                Positioned(
                                    right: 60,
                                    top: 0,
                                    child: Image.asset(
                                      ImageAssets.ic_label,
                                      height: 65,
                                    )),
                                Positioned(
                                    top: 15,
                                    right: 140,
                                    child: Center(
                                        child: Text(
                                      scoreboard.tr,
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: kwhite),
                                    )))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    h10,
                    InkWell(
                      onTap: () async {
                        screenshort();
                      },
                      child: Container(
                        height: 170,
                        decoration: BoxDecoration(
                          color: kgreen,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/bg2.png')),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 55,
                                decoration: BoxDecoration(
                                    color: kgreen,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/whatsapp.png',
                                        height: 35,
                                      ),
                                      w10,
                                      Text(
                                        share_with_your_friends.tr,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: kwhite,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              h30
                            ],
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

  void screenshort() async {
    // Capture the image as a Uint8List
    final Uint8List? capturedImage = await screenshotController.capture();

    if (capturedImage != null && capturedImage.isNotEmpty) {
      // Convert capturedImage (Uint8List) to Image
      ui.Image image = await decodeImageFromList(capturedImage);

      // Convert Image to PNG format
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Save the PNG image to a file
      final Directory tempDir = await getTemporaryDirectory();
      final File imageFile = File('${tempDir.path}/report.png');
      await imageFile.writeAsBytes(pngBytes);

      // Share the PNG image
      Share.shareFiles(
        [imageFile.path],
      );
    } else {
      print('Error capturing image');
    }
  }
}

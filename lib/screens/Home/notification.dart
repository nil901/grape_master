import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/Home/notification_details.dart';
import 'package:grape_master/screens/auth/LocalString.dart';
import 'package:grape_master/util/constants.dart';
import 'package:grape_master/util/no_activity_found.dart';
import 'package:html/parser.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../util/color.dart';
import '../../util/image_assets.dart';
import '../../util/util.dart';
import 'home_controller.dart';
import 'package:http/http.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  HomeController? eProvider;
  List<bool> isOpenList = [];

  @override
  void initState() {
    eProvider = Provider.of<HomeController>(context, listen: false);
    init();
    // TODO: implement initState
    super.initState();
  }

  void init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await eProvider?.notification(context);
      eProvider!.notificationModel!.data!.length == 0
          ? 0
          : isOpenList = List.filled(
              eProvider!.notificationModel!.data!.length ?? 0, false);
    });
  }

  bool like = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kgreen,
          title: Text(
          notifications.tr,
            style: TextStyle(
                color: kwhite, fontWeight: FontWeight.w400, fontSize: 22),
          )),
      body: Consumer<HomeController>(builder: (context, ePv, child) {
        return ePv.notificationModel?.data.length  == 0 ? Center(child: NoActivityFound(),):ListView.builder(
            //scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: ePv.notificationModel?.data.length,
            //physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              var data = ePv.notificationModel!.data![index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    ePv.noteViewApi(context,data.notificationId);
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType
                            .fade, // Choose your desired animation type
                        child: NtificationDetails(notification: data),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      InkWell(
                        onTap: (){
                            Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType
                            .fade, // Choose your desired animation type
                        child: NtificationDetails(notification: data),
                      ),
                    );
                             ePv.noteViewApi(context,data.notificationId);
                        },
                        child: Material(
                          elevation: 3,
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            decoration: BoxDecoration(
                              color: data.noteView == "No" ? kteal50 : kwhite ,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          h10,
                                          Container(
                                            height: 90,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        data.nimage)),
                                                color: kgreen,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                        ],
                                      ),
                                      w20,
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data.notificationTitle,
                                              style: TextStyle(
                                                  color: kgreen,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 17),
                                            ),
                                            h10,
                                            Text(
                                              data.regDate,
                                              style: TextStyle(
                                                  color: grey800,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15),
                                            ),
                                            h10,
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    parse(data
                                                            .notificationMessage)
                                                        .documentElement!
                                                        .text,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          print(data.notificationId);
                      
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Padding(
                                                    padding: const EdgeInsets.all(
                                                        20.0),
                                                    child: AlertDialog(
                                                      insetPadding:
                                                          EdgeInsets.all(12),
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      content:
                                                          SingleChildScrollView(
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
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
                                                              h10,
                                                              h20,
                      
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            15),
                                                                child: Align(
                                                                  alignment: Alignment
                                                                      .centerLeft,
                                                                  child: Text(
                                                                    txt_delete_notification
                                                                        .tr,
                                                                    style: TextStyle(
                                                                        color:
                                                                            kblack,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400),
                                                                  ),
                                                                ),
                                                              ),
                      
                                                              h20,
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            28),
                                                                child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .bottomRight,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        w10,
                                                                        w10,
                                                                        InkWell(
                                                                            onTap:
                                                                                () {
                                                                              ePv.deleteNotification(context,
                                                                                  data.notificationId);
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              txt_okk.tr,
                                                                              style:
                                                                                  TextStyle(color: Colors.black, fontSize: 18),
                                                                            )),
                                                                      ],
                                                                    )),
                                                              ),
                                                              h20,
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ));
                                              });
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: kred,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 0.75,
                                  color: kgreen,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                              ePv.likeunlikenotification(context,data.notificationId);
                                            isOpenList[index] =
                                                !isOpenList[index];
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            isOpenList.length == 0
                                                ? Image.asset(
                                                    ImageAssets.ic_like,
                                                    height: 30,
                                                    color: kgreen,
                                                  )
                                                : isOpenList[index]
                                                    ? Image.asset(
                                                        ImageAssets.ic_likefill,
                                                        height: 30,
                                                        color: kgreen)
                                                    : Image.asset(
                                                        ImageAssets.ic_like,
                                                        height: 30,
                                                        color: kgreen,
                                                      ),
                                            w10,
                                            Text("")
                                          ],
                                        ),
                                      ),
                                      // Row(
                                      //   children: [
                                      //     Image.asset(ImageAssets.ic_comment,
                                      //         height: 28, color: kgreen),
                                      //     w10,
                                      //     Text("")
                                      //   ],
                                      // ),
                                      InkWell(
                                        onTap: () async {
                                          final response = await get(
                                              Uri.parse(data.nimage ?? ' '));
                                          // final bytes = response.bodyBytes;
                                          final Directory temp =
                                              await getTemporaryDirectory();
                                          final File imageFile =
                                              File('${temp.path}/report.png');
                                          await Utils.validateImage(
                                                  data.nimage.toString())
                                              .then((value) async {
                                            if (value) {
                                              imageFile.writeAsBytesSync(
                                                  response.bodyBytes);
                                            } else {
                                              ByteData bytes =
                                                  await rootBundle.load(
                                                      'assets/images/areport.png');
                                              imageFile.writeAsBytes(bytes.buffer
                                                  .asUint8List(
                                                      bytes.offsetInBytes,
                                                      bytes.lengthInBytes));
                                            }
                                            return value;
                                          });
                                          var widget;
                                          Share.shareFiles(
                                            ['${temp.path}/report.png'],
                                            text:
                                                '${Utils.stripHtmlIfNeeded(data!.nimage ?? '')}\n\n\n'
                                                'Get more information download this app\n'
                                                'https://play.google.com/store/apps/details?id=com.wowinfotech0.grapesmaster',
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.share,
                                              color: kgreen,
                                            ),
                                            w10,
                                            Text("Share")
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                h5,
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            });
      }),
    );
  }
}

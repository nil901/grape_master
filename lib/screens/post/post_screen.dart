import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/post/post_controller.dart';
import 'package:grape_master/screens/post/post_details_screen.dart';
import 'package:grape_master/util/constants.dart';
import 'package:grape_master/util/image_assets.dart';
import 'package:grape_master/util/large_button.dart';
import 'package:grape_master/util/lodaer.dart';
import 'package:grape_master/util/util.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:share_plus/share_plus.dart';
import 'package:share_whatsapp/share_whatsapp.dart';

import '../../util/color.dart';
import '../auth/LocalString.dart';
import 'add_post.dart';
import 'my_post_screen.dart';

class PostDetails extends StatefulWidget {
  const PostDetails({super.key});

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  postCnt? eProvider;
  List<bool> isOpenList = [];
  bool isopen = false;
  @override
  void initState() {
    eProvider = Provider.of<postCnt>(context, listen: false);
    init();
    // TODO: implement initState
    super.initState();
  }

  void init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await eProvider?.postlistApi();
      if (eProvider?.postmodel?.DATA != null) {
        isOpenList = List.filled(eProvider!.postmodel!.DATA!.length, false);
      } else {
        // Handle the case where DATA is null or empty
        isOpenList = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              type:
                  PageTransitionType.fade, // Choose your desired animation type
              child: AddPostScreen(),
            ),
          );
          // Get.to(AddPostScreen(), transition: Transition.zoom);
        },
        child: CircleAvatar(
          radius: 30,
          backgroundColor: klime,
          child: Icon(
            Icons.add,
            color: kwhite,
          ),
        ),
      ),
      body: Consumer<postCnt>(builder: (context, ePv, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: LargeButton(
                    onPress: () {},
                    text: Text(
                      txt_homes.tr,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: kwhite),
                    ),
                  )),
                  w16,
                  Expanded(
                      child: LargeButton(
                          onPress: () {
                            Get.to(MyPostScreen());
                          },
                          text: Text(
                            txt_my_post.tr,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: kwhite),
                          )))
                ],
              ),
              h10,
              Expanded(
                child: ePv.postmodel?.DATA!.isEmpty == null
                    ? Loader()
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: ePv.postmodel?.DATA!
                            .length, // Replace 'itemCount' with the actual number of items
                        itemBuilder: (context, index) {
                          var item = ePv.postmodel?.DATA![index];
                          return Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType
                                        .fade, // Choose your desired animation type
                                    child: PostDetailsScreen(
                                      item: item,
                                    ),
                                  ),
                                );
                                //  Get.to(());
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Material(
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 21,
                                                backgroundColor: klime,
                                                child: CircleAvatar(
                                                    radius: 20,
                                                    backgroundImage: AssetImage(
                                                        ImageAssets
                                                            .ic_profile)),
                                              ),
                                              w10,
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${item!.FULL_NAME}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  Text(
                                                    "${item!.REG_DATE}",
                                                    style: TextStyle(
                                                        color: grey800),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          h10,
                                          Text(
                                            "${item!.POST_DESCRIPTION}",
                                            style: TextStyle(
                                                color: grey800, fontSize: 18),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "${txt_view_more.tr}..",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.red),
                                              ),
                                            ],
                                          ),
                                          h10,
                                          Container(
                                            width: double.infinity,
                                            child: Image.network(
                                              "${item?.POST_IMAGE}",
                                              height: 250,
                                              fit: BoxFit.cover,
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent?
                                                          loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                } else {
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: kgreen,
                                                      strokeWidth: 1,
                                                      value: loadingProgress
                                                                  .expectedTotalBytes !=
                                                              null
                                                          ? loadingProgress
                                                                  .cumulativeBytesLoaded /
                                                              (loadingProgress
                                                                      .expectedTotalBytes ??
                                                                  1)
                                                          : null,
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 6),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    item.IS_LIKE == "Yes"
                                                        ? InkWell(
                                                            onTap: () {
                                                              ePv.addlikepost(
                                                                  context,
                                                                  item.POST_ID);
                                                            },
                                                            child: Image.asset(
                                                              ImageAssets
                                                                  .ic_likefill,
                                                              height: 30,
                                                              color: kgreen,
                                                            ),
                                                          )
                                                        : InkWell(
                                                            onTap: () {
                                                              ePv.unlikeaddlikepost(
                                                                  context,
                                                                  item.POST_ID);
                                                            },
                                                            child: Image.asset(
                                                              ImageAssets
                                                                  .ic_like,
                                                              height: 30,
                                                              color: kgreen,
                                                            ),
                                                          ),
                                                    w10,
                                                    Text("${item!.LIKE_COUNT}")
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                        ImageAssets.ic_comment,
                                                        height: 28,
                                                        color: kgreen),
                                                    w10,
                                                    Text(
                                                        "${item!.COMMENT_COUNT}")
                                                  ],
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    final response = await get(
                                                        Uri.parse(
                                                            item!.POST_IMAGE ??
                                                                ''));
                                                    final Directory temp =
                                                        await getTemporaryDirectory();
                                                    final File imageFile = File(
                                                        '${temp.path}/report.png');

                                                    await Utils.validateImage(
                                                            item.POST_IMAGE
                                                                .toString())
                                                        .then((value) async {
                                                      if (value) {
                                                        imageFile
                                                            .writeAsBytesSync(
                                                                response
                                                                    .bodyBytes);
                                                      } else {
                                                        ByteData bytes =
                                                            await rootBundle.load(
                                                                'assets/images/areport.png');
                                                        imageFile.writeAsBytes(bytes
                                                            .buffer
                                                            .asUint8List(
                                                                bytes
                                                                    .offsetInBytes,
                                                                bytes
                                                                    .lengthInBytes));
                                                      }

                                                      // Convert File to XFile
                                                      XFile xFile =
                                                          XFile(imageFile.path);

                                                      // Here you can specify the XFile you want to share
                                                      shareWhatsapp.share(
                                                          text: 'Hello',
                                                          file: xFile);
                                                    });
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
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
              ),
            ],
          ),
        );
      }),
    );
  }
}

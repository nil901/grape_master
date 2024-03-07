import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/post/post_controller.dart';
import 'package:grape_master/util/lodaer.dart';
import 'package:grape_master/util/util.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../model/post_models/post_model.dart';
import '../../util/color.dart';
import '../../util/constants.dart';
import '../../util/image_assets.dart';
import '../auth/LocalString.dart';
import 'package:http/http.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

class PostDetailsScreen extends StatefulWidget {
  const PostDetailsScreen({super.key, required this.item});
  final PostModelDATA item;

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  postCnt? eProvider;
  bool isvisibale = false;

  @override
  void initState() {
    eProvider = Provider.of<postCnt>(context, listen: false);
     
    init();
    // TODO: implement initState
    super.initState();
  }

  void init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
    // widget.item.IS_LIKE == "No" ?false :true;
    if( widget.item.IS_LIKE == "No"){
isvisibale = false;
    }else{
      isvisibale = true;
    }
      await eProvider?.commentlistApi(widget.item.POST_ID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: kgreen,
            title: Text(
              description.tr,
              style: TextStyle(
                  color: kwhite, fontWeight: FontWeight.w400, fontSize: 22),
            )),
        body: Consumer<postCnt>(builder: (context, ePv, child) {
          ePv.PostId = widget.item.POST_ID;
          var dataitems = widget.item;
         
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Material(
                          elevation: 2,
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 5),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 21,
                                        backgroundColor: klime,
                                        child: CircleAvatar(
                                            radius: 20,
                                            backgroundImage: AssetImage(
                                                ImageAssets.ic_profile)),
                                      ),
                                      w10,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${widget.item.FULL_NAME}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            "${widget.item.REG_DATE}",
                                            style: TextStyle(color: grey800),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                h5,
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        height: 28,
                                        decoration: BoxDecoration(
                                            color: kbg,
                                            border: Border.all(
                                                width: 0.75, color: klime),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10))),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Text(
                                            widget.item.CROP_NAME.toString(),
                                            style: TextStyle(
                                                color: kblack,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                h5,
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 5),
                                  child: Column(
                                    children: [
                                      Text(
                                        "${widget.item.POST_DESCRIPTION}",
                                        style: TextStyle(
                                            color: klighblue, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                h10,
                                Container(
                                  width: double.infinity,
                                  child: Image.network(
                                    "${widget.item.POST_IMAGE}",
                                    height: 250,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                h10,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          // Call the like/unlike function
                                          ePv.addlikepost(
                                              context, widget.item.POST_ID);
                                          if (widget.item.IS_LIKE == "Yes") {
                                            isvisibale = false;
                                          }else{
                                             isvisibale = true;
                                          }
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          isvisibale
                                              ? Image.asset(
                                                  ImageAssets.ic_likefill,
                                                  height: 28,
                                                  color: kgreen,
                                                )
                                              : Image.asset(
                                                  ImageAssets.ic_like,
                                                  height: 28,
                                                  color: kgreen,
                                                ),
                                                w10,
                                                Text("Like")
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        final response = await get(Uri.parse(
                                            dataitems.POST_IMAGE ?? ' '));
                                        // final bytes = response.bodyBytes;
                                        final Directory temp =
                                            await getTemporaryDirectory();
                                        final File imageFile =
                                            File('${temp.path}/report.png');
                                        await Utils.validateImage(
                                                dataitems.POST_IMAGE.toString())
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
                                              ' Post Name:- ${dataitems!.POST_DESCRIPTION}\n View this post download this app\n'
                                              'https://play.google.com/store/apps/details?id=com.wowinfotech0.grapesmaster',
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            ImageAssets.ic_share,
                                            height: 25,
                                            color: kgreen,
                                          ),
                                          w10,
                                          Text("Share")
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                h10,
                              ],
                            ),
                          ),
                        ),
                      ),
                      h10,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          children: [
                            Text(
                              "User Comments",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, color: klime),
                            ),
                          ],
                        ),
                      ),
                      ePv.commentlist?.DATA!.isEmpty == null
                          ? Loader()
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: ePv.commentlist?.DATA!
                                  .length, // Replace 'itemCount' with the actual number of items
                              itemBuilder: (context, index) {
                                var item = ePv.commentlist?.DATA![index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 5),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 21,
                                        backgroundColor: klime,
                                        child: CircleAvatar(
                                            radius: 20,
                                            backgroundImage: AssetImage(
                                                ImageAssets.ic_profile)),
                                      ),
                                      w10,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${item!.FULL_NAME}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            "${item!.REG_DATE}",
                                            style: TextStyle(color: grey800),
                                          ),
                                          Text("${item!.REMARK}")
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              }),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 70,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: ePv.commentController,
                          maxLines: 10,
                          onChanged: (value) {},
                          style: TextStyle(fontSize: 13),
                          decoration: InputDecoration(
                            //  focusedBorder:InputBorder(borderSide: ) ,
                            helperStyle: TextStyle(color: grey800),
                            hintText: "Enter Comments ",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          validator: (text) {
                            if (text!.isEmpty) {
                              return "Address";
                            }
                            return null;
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          ePv.postcomment(context);
                        },
                        child: Icon(
                          Icons.send,
                          size: 45,
                          color: klime,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        }));
  }
}

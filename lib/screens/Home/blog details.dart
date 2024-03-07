import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/auth/LocalString.dart';
import 'package:grape_master/util/constants.dart';
import 'package:grape_master/util/image_assets.dart';
import 'package:grape_master/util/util.dart';
import 'package:html/parser.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../model/home_model/blog_model.dart';
import '../../util/color.dart';
import '../../util/lodaer.dart';
import 'package:http/http.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'home_controller.dart';

class BlogScreenDetails extends StatefulWidget {
  const BlogScreenDetails({super.key, required this.data});

  final BlogModel data;

  @override
  State<BlogScreenDetails> createState() => _BlogScreenDetailsState();
}

class _BlogScreenDetailsState extends State<BlogScreenDetails> {
  HomeController? eProvider;
  List<bool> isLikedList = [];
  @override
  void toggleLike(int index) {
    // Ensure that isLikedList has the correct length
    if (index >= 0 && index < isLikedList.length) {
      setState(() {
        isLikedList[index] = !isLikedList[index];
      });
    }
  }
  bool isvisibale = false;
  @override
  Widget build(BuildContext context) {
    var dataitems = widget.data;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: kgreen,
            title: Text(
             description.tr,
              style: TextStyle(
                  color: kwhite, fontWeight: FontWeight.w400, fontSize: 22),
            )),
        body: Consumer<HomeController>(builder: (context, ePv, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
              child: Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(2),
                child: Container(
                  width: double.infinity,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(2)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 15),
                        child: Text(
                           widget.data.postTitle,
                          style: TextStyle(
                              color: kblack,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      h10,
                      Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  widget.data.postImage,
                                ))),
                      ),
                      h10,
                     Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                        widget.data.regDate.toString(),
                          style: TextStyle(
                              color: kblack,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                     
                    
                      
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      
                                    });
                                     ePv.postLikeUnlike(context,widget.data.postId);
                                   isvisibale = !isvisibale;
                                  },
                                  child: Image.asset(
                                    isvisibale ?
                                    ImageAssets.ic_like: widget.data.isLike == "Yes" ?
                                    
                                       ImageAssets.ic_likefill: widget.data.isLike == "No"? ImageAssets.ic_like:   ImageAssets.ic_likefill,
                                    height: 28,
                                    color: kgreen,
                                  ),
                                ),
                                w10,
                                Text(widget.data.likeCount.toString())
                              ],
                            ),
                            InkWell(
                              onTap: ()async{
                                final response = await get(
                                                        Uri.parse(
                                                           dataitems.postImage ??
                                                                ' '));
                                                    // final bytes = response.bodyBytes;
                                                    final Directory temp =
                                                        await getTemporaryDirectory();
                                                    final File imageFile = File(
                                                        '${temp.path}/report.png');
                                                    await Utils.validateImage(
                                                           dataitems.postImage
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
                                                      return value;
                                                    });
                                                    var widget;
                                                    Share.shareFiles(
                                              ['${temp.path}/report.png'],
                                              text:
                                                  '\n\n'
                                                  'Blog Name -${dataitems!.postTitle})\nBlog Desc Name - ${dataitems!.postTitle}\nShare This Post\n'
                                                  'https://play.google.com/store/apps/details?id=com.wowinfotech0.grapesmaster',
                                            );

                              },
                              child: Row(
                                children: [
                                  Image.asset(ImageAssets.ic_share,
                                      height: 28, color: kgreen),
                                  w10,
                                  Text(txt_share.tr)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
          
                       Html(
                            data:widget.data.postDescription,
                            style: {
                              "body": Style(
                                  color: klightblue,
                                  fontSize: FontSize(
                                      16.0)), // Adjust the font size as needed
                            },
                          )
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }
}

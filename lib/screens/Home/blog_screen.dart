import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:grape_master/util/constants.dart';
import 'package:grape_master/util/image_assets.dart';
import 'package:grape_master/util/util.dart';
import 'package:html/parser.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../util/color.dart';
import '../../util/lodaer.dart';
import '../auth/LocalString.dart';
import 'blog details.dart';
import 'home_controller.dart';
import 'package:http/http.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  HomeController? eProvider;

  @override
  void initState() {
    eProvider = Provider.of<HomeController>(context, listen: false);
    init();
    // TODO: implement initState
    super.initState();
  }

  void init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await eProvider?.blogapi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kgreen,
          title: Text(
            blogs.tr,
            style: TextStyle(
                color: kwhite, fontWeight: FontWeight.w400, fontSize: 22),
          )),
      body: Consumer<HomeController>(builder: (context, ePv, child) {
        return ePv.blogmodel?.data.isEmpty == null
            ? Loader()
            : Padding(
                padding: const EdgeInsets.all(6.0),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: ePv.blogmodel?.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      var blog = ePv.blogmodel?.data[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 7, horizontal: 2),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType
                                    .fade, // Choose your desired animation type
                                child: BlogScreenDetails(
                                  data: blog,
                                ),
                              ),
                            );
                          },
                          child: Material(
                            elevation: 6,
                            borderRadius: BorderRadius.circular(2),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, top: 15),
                                    child: Text(
                                      blog!.postTitle,
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
                                              blog!.postImage,
                                            ))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 2),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            parse(blog!.postDescription)
                                                .documentElement!
                                                .text,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Padding(
                                  //     padding: const EdgeInsets.all(5.0),
                                  //     child: Html(
                                  //       data: blog!.postDescription,
                                  //       style: {
                                  //         "body": Style(
                                  //             color: kblack,
                                  //             fontSize: FontSize(
                                  //                 17.0)), // Adjust the font size as needed
                                  //       },
                                  //     )),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Text(
                                      "...",
                                      style: TextStyle(
                                          color: kblack,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "${txt_view_more.tr}>>",
                                          style: TextStyle(
                                              color: kred,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Text(
                                      blog.regDate,
                                      style: TextStyle(
                                          color: grey800,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  
                                                });
                                                ePv.postLikeUnlike(
                                                    context, blog.postId);
                                                print(
                                                    " is like print ${blog.isLike}");
                                              },
                                              child: blog.isLike == 'Yes'
                                                  ? Image.asset(
                                                      ImageAssets.ic_likefill,
                                                      height: 30,
                                                      color: kgreen,
                                                    )
                                                  : Image.asset(
                                                      ImageAssets.ic_like,
                                                      height: 30,
                                                      color: kgreen,
                                                    ),
                                            ),
                                            w10,
                                            Text(blog!.likeCount.toString())
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            final response = await get(
                                                Uri.parse(
                                                    blog!.postImage ?? ' '));
                                            // final bytes = response.bodyBytes;
                                            final Directory temp =
                                                await getTemporaryDirectory();
                                            final File imageFile =
                                                File('${temp.path}/report.png');
                                            await Utils.validateImage(
                                                    blog!.postImage.toString())
                                                .then((value) async {
                                              if (value) {
                                                imageFile.writeAsBytesSync(
                                                    response.bodyBytes);
                                              } else {
                                                ByteData bytes =
                                                    await rootBundle.load(
                                                        'assets/images/areport.png');
                                                imageFile.writeAsBytes(
                                                    bytes.buffer.asUint8List(
                                                        bytes.offsetInBytes,
                                                        bytes.lengthInBytes));
                                              }
                                              return value;
                                            });
                                            var widget;
                                            Share.shareFiles(
                                              ['${temp.path}/report.png'],
                                              text:
                                                  '\n\n'
                                                  'Blog Name -${blog!.postTitle})\nBlog Desc Name - ${blog!.postTitle}\nShare This Post\n'
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
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }));
      }),
    );
  }
}

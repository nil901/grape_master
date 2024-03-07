import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/auth/LocalString.dart';
import 'package:grape_master/screens/post/post_controller.dart';
import 'package:grape_master/screens/post/post_details_screen.dart';
import 'package:grape_master/util/image_assets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../util/color.dart';
import '../../util/constants.dart';
import '../../util/large_button.dart';
import '../../util/lodaer.dart';
import 'edit_post_screen.dart';

class MyPostScreen extends StatefulWidget {
  const MyPostScreen({super.key}); 
 

  @override
  State<MyPostScreen> createState() => _MyPostScreenState();
}

class _MyPostScreenState extends State<MyPostScreen> {
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
      await eProvider?.myPostPostcropApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kgreen,
          title: Text(
           txt_my_post.tr,
            style: TextStyle(
                color: kwhite, fontWeight: FontWeight.w400, fontSize: 18),
          )),
      body: Consumer<postCnt>(builder: (context, ePv, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ePv.mypost?.DATA!.isEmpty == null
              ? Loader()
              :ePv.mypost?.DATA!.length == 0  ? Center(child: Image.asset(ImageAssets.ic_no_data_found,height: 100,)): ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: ePv.mypost?.DATA!
                      .length, // Replace 'itemCount' with the actual number of items
                  itemBuilder: (context, index) {
                    var item = ePv.mypost?.DATA?[index];
                       ePv.PostId = item?.POST_ID;
                      print(ePv.mypost?.DATA!.length);
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
                                item: item!,
                              ),
                            ),
                          );
                          //  Get.to(());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                                  backgroundImage: AssetImage(ImageAssets.ic_profile)
                                                  ),
                                            ),
                                            w10,
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${item?.FULL_NAME}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                Text(
                                                  "${item?.REG_DATE}",
                                                  style:
                                                      TextStyle(color: grey800),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    PageTransition(
                                                        type: PageTransitionType
                                                            .fade, // Choose your desired animation type
                                                        child:
                                                            EditPostScreen(post:item! ,)),
                                                  ); 
                                                },
                                                child: Icon(Icons.edit,
                                                    color: kgreen)),
                                            w10,
                                            InkWell(
                                              onTap: (){
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
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        // Your header and close button code here
                                        h10,

                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                ImageAssets.ic_logo,
                                                height: 50,
                                              ),
                                              Text(
                                                'GrapeMaster',
                                                style: TextStyle(
                                                    color: kblack,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                        ),
                                        h10,
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                             deletepost.tr,
                                              style: TextStyle(
                                                  color: kblack,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                        h20,
                                        h20,
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 28),
                                          child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        nomsg.tr,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 18),
                                                      )),
                                                  w30,
                                                  InkWell(
                                                      onTap: () {
                                            
                                                       ePv.delatePost(context,item?.CROP_ID);
                                                                    Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                       yes.tr,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 18),
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
                                                color: kgreen,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    h10,
                                    Text(
                                      "${item?.POST_DESCRIPTION}",
                                      style: TextStyle(
                                          color: grey800, fontSize: 18),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                         txt_view_more.tr,
                                          style: TextStyle(
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
                                        fit: BoxFit.fill,
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: (){
                                                  ePv.addlikepost(
                                                        context, item?.POST_ID);
                                                        print(  item?.IS_LIKE.toString());
                                            },
                                            child:    Row(
                                                  children: [
                                                    item?.IS_LIKE.toString() == "Yes"
                                                        ? InkWell(
                                                            onTap: () {
                                                              ePv.addlikepost(
                                                                  context,
                                                                  item?.POST_ID);
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
                                                                  item?.POST_ID);
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
                                          ),
                                          Row(
                                            children: [
                                              Image.asset(
                                                  ImageAssets.ic_comment,
                                                  height: 28,
                                                  color: kgreen),
                                              w10,
                                              Text("${item?.COMMENT_COUNT}")
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.share,
                                                color: kgreen,
                                              ),
                                              w10,
                                              Text("Share")
                                            ],
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
        );
      }),
    );
  }
}

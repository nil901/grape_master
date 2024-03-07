import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/Home/shop_details.dart';
import 'package:grape_master/screens/auth/LocalString.dart';
import 'package:grape_master/util/constants.dart';
import 'package:grape_master/util/lodaer.dart';
import 'package:grape_master/util/no_activity_found.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../util/color.dart';
import '../../util/image_assets.dart';
import 'blog details.dart';
import 'home_controller.dart';

class ShopNearYou extends StatefulWidget {
  const ShopNearYou({super.key});

  @override
  State<ShopNearYou> createState() => _ShopNearYouState();
}

class _ShopNearYouState extends State<ShopNearYou> {
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
      await eProvider?.shopnearapi();
    });
  }
  int currentPage = 0;
  int itemsPerPage = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kgreen,
          title: Text(
          nearby_shops.tr,
            style: TextStyle(
                color: kwhite, fontWeight: FontWeight.w400, fontSize: 18),
          )),
      body: Consumer<HomeController>(builder: (context, ePv, child) {
        return ePv.shopnearbyyou?.DATA == null
            ? Loader()
            : ePv.shopnearbyyou?.DATA?.length == 0
                ? Center(
                    child: NoActivityFound(),
                  )
                : Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: ePv.shopnearbyyou?.DATA?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          var blog = ePv.shopnearbyyou?.DATA?[index];
        //                       if (index >= ePv.shopnearbyyou?.data.length) {
        //   // Reached the end of the list, load more items
        //                  ePv.shopnearapi();
        // }
                          String formattedDistance =
                              blog!.TOTAL_DISTANCE!.toStringAsFixed(1);
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 2),
                            child: InkWell(
                              onTap: () {
                                ePv.shopId = blog.SHOP_ID;
                                print(ePv.shopId);
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType
                                        .fade, // Choose your desired animation type
                                    child: ShopDetails(nershpdetails: blog),
                                  ),
                                );
                              },
                              child: Material(
                                elevation: 3,
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Material(
                                              elevation: 0,
                                              child: Container(
                                                height: 80,
                                                width: 75,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            blog!.SHOP_IMAGE.toString()))),
                                                child: 
Image.network(
                                              "${blog?.SHOP_IMAGE}",
                                             height: 250,
                                              fit: BoxFit.cover,

                                              errorBuilder: (context,
                                                        error, stackTrace) {
                                                  // Handle the error, you can return a placeholder image or any other widget
                                                  return Image.asset(
                                                    ImageAssets.ic_logo,
                                                    fit: BoxFit.fill,
                                                  );
                                                },
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
                                            ),
                                          ],
                                        ),
                                        w10,
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                      child: Text(
                                                    blog!.SHOP_NAME.toString(),
                                                    style: TextStyle(
                                                        color: kgreen,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )),
                                                  SizedBox(width: 16),
                                                  Icon(
                                                    Icons.arrow_forward,
                                                    color: kgreen,
                                                  )
                                                ],
                                              ),
                                              h2,
                                              Text(
                                                blog!.ADDRESS.toString(),
                                                style: TextStyle(
                                                    color: ktext,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              h2,
                                              h2,
                                              Text(
                                                "${formattedDistance} Kms.",
                                                style: TextStyle(
                                                    color: klime,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: InkWell(
                                                      onTap: () {
                                                        ePv.openMap(
                                                            blog!.LATITUDE,
                                                            blog!.LONGITUDE);
                                                      },
                                                      child: Image.asset(
                                                        ImageAssets
                                                            .ic_google_icon,
                                                        height: 35,
                                                      )))
                                            ],
                                          ),
                                        )
                                      ],
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

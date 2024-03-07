import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/Home/quzie.dart';
import 'package:grape_master/screens/Home/scrore_count_screen.dart';
import 'package:grape_master/screens/Home/shop_near_you.dart';
import 'package:grape_master/screens/Home/wather_screen.dart';
import 'package:grape_master/screens/Home/wether_screen.dart';
import 'package:grape_master/util/constants.dart';
import 'package:grape_master/util/image_assets.dart';
import 'package:grape_master/util/large_button.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../model/home_model/plot_model.dart';
import '../../util/color.dart';
import '../../util/lodaer.dart';
import '../auth/LocalString.dart';
import '../registerplot/plot_details.dart';
import '../registerplot/register_the_plot.dart';
import 'blog_screen.dart';
import 'home_controller.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
      Future.delayed(Duration(seconds: 1), () async {
        await eProvider?.plotapi(context);
        await eProvider?.quizeapi();
        // Your delayed code here
        print('Delayed code executed after 2 seconds.');
      });

      await eProvider?.wetherforcasting();
      await eProvider?.notification(context);
      //
      // await eProvider?.quizeapi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeController>(builder: (context, ePv, child) {
        return ePv.plotmodel?.DATA?.length == null
            ? Center(child: Loader())
            : SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () async {
                          await ePv.quizeModelLIst?.DATA?.length == 0 || ePv.quizeModelLIst?.DATA?.isEmpty == 'null'
                              ? Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType
                                        .fade, // Choose your desired animation type
                                    child: StackExample(),
                                  ),
                                )
                              : Get.bottomSheet(
                                  isScrollControlled: true,
                                  QuzieBottomSheetScreen());
                        },
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            alignment: Alignment.center,
                            height: 190,
                            decoration: BoxDecoration(
                                color: kwhite,
                                // image: DecorationImage(
                                //    fit: BoxFit.fill,

                                //     image: AssetImage(ImageAssets.ic_quizplay)

                                //     ),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Transform.scale(
                                  scale:
                                      1.0, // Adjust the scale factor as needed
                                  child: Image.asset(
                                    fit: BoxFit.fill,
                                    ImageAssets.ic_quizplay,
                                  )),
                            ),
                          ),
                        ),
                      ),
                      h34,
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: deeporange,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType
                                                  .fade, // Choose your desired animation type
                                              child: BlogScreen(),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              ImageAssets.ic_blogs,
                                              height: 45,
                                            ),
                                            h10,
                                            Text(
                                              blogs.tr,
                                            )
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType
                                                  .fade, // Choose your desired animation type
                                              child: ShopNearYou(),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              ImageAssets.ic_nearby,
                                              height: 50,
                                            ),
                                            h10,
                                            Text(
                                              nearby_shops.tr,
                                            )
                                          ],
                                        ),
                                      ),
                                    ]),
                              ),
                            )),
                      ),
                      h16,
                      Text(txt_my_plots.tr,
                          style: TextStyle(
                            color: kblack,
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                          )),
                      h12,
                      ListView.builder(
                          //scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: ePv.plotmodel?.DATA?.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            var data = ePv.plotmodel!.DATA![index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: PlotListExpanded(
                                plott: data!,
                              ),
                            );
                          }),
                      h2,
                      Center(
                        child: LargeButton(
                          onPress: () {
                            //ePv.wetherforcasting();
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType
                                    .fade, // Choose your desired animation type
                                child: RegisterThePlot(),
                              ),
                            );
                          },
                          text: Text(
                            txt_add_plot.tr,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: kwhite),
                          ),
                        ),
                      ),
                      h10,
                      ePv.watherModel?.current == 0 ||
                              ePv.watherModel?.current == null
                          ? Text("")
                          : Container(
                              height: 250,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(ImageAssets.ic_weaimg)),
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        kwhite,
                                        kwhite,
                                      ]),
                                  border: Border.all(width: 0.5, color: kwhite),
                                  borderRadius: BorderRadius.circular(16)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 9,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              ePv?.wetherforcasting();
                                            },
                                            child: Image.asset(
                                              ImageAssets.ic_rotate,
                                              height: 20,
                                              color: klightgreen,
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    PageTransition(
                                                      type: PageTransitionType
                                                          .fade, // Choose your desired animation type
                                                      child: MyPostApi(),
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  txt_view_all.tr,
                                                  style: TextStyle(
                                                      color: kwhite,
                                                      // decoration: TextDecoration.underline,
                                                      //  decorationThickness: 3.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                              ),
                                              h2,
                                              Container(
                                                width: 70,
                                                height: 2,
                                                color: bluegey,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Image.network(
                                          'https:${ePv?.watherModel!.current?.condition?.icon.toString()}',
                                          height: 50,
                                        ),
                                        Text(
                                          maxLines: 4,
                                          "${ePv?.watherModel!.current?.temp_c.toString()}",
                                          style: TextStyle(
                                              color: kwhite,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(ImageAssets.ic_heat,
                                                height: 30, color: kwhite),
                                            SizedBox(
                                              width: 9,
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  txt_minmax.tr,
                                                  style: TextStyle(
                                                      color: kwhite,
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                    "${ePv?.watherModel?.current?.feelslike_c.toString()}/${ePv?.watherModel?.current?.temp_c.toString()}",
                                                    style: TextStyle(
                                                        color: kwhite,
                                                        fontSize: 15))
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              ImageAssets.ic_humidity,
                                              height: 28,
                                              color: kwhite,
                                            ),
                                            SizedBox(
                                              width: 9,
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  txt_humidity.tr,
                                                  style: TextStyle(
                                                      color: kwhite,
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                    "${ePv?.watherModel?.current?.humidity.toString()}%",
                                                    style: TextStyle(
                                                        color: kwhite,
                                                        fontSize: 15))
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 18,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(ImageAssets.ic_wind,
                                                height: 30, color: kwhite),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  txt_wind_speed.tr,
                                                  style: TextStyle(
                                                      color: kwhite,
                                                      fontSize: 15),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                    "${ePv?.watherModel?.current?.wind_mph.toString()} Mph",
                                                    style: TextStyle(
                                                        color: kwhite,
                                                        fontSize: 15))
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              ImageAssets.ic_pressure,
                                              height: 28,
                                              color: kwhite,
                                            ),
                                            SizedBox(
                                              width: 9,
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  txt_pressure.tr,
                                                  style: TextStyle(
                                                      color: kwhite,
                                                      fontSize: 15),
                                                ),
                                                SizedBox(
                                                  width: 9,
                                                ),
                                                Text(
                                                    "${ePv?.watherModel?.current?.pressure_mb.toString()} hpa",
                                                    style: TextStyle(
                                                        color: kwhite,
                                                        fontSize: 15))
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                    ],
                  ),
                ),
              );
      }),
    );
  }
}

class PlotListExpanded extends StatelessWidget {
  const PlotListExpanded({super.key, required this.plott});
  final PlotRagisterModelDATA plott;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade, // Choose your desired animation type
            child: PlotDetails(
              plotdetails: plott,
            ),
          ),
        );
      },
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: kteal50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${plot.tr}  ${plott.NEW_PLOT_NAME}",
                      style: TextStyle(
                          color: kgreen,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                    h2,
                    Row(
                      children: [
                        Text(
                          "${txt_crop_name.tr} -",
                          style: TextStyle(
                              color: ktext,
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          " ${plott.CROP_NAME == null ? "-" : plott.CROP_NAME} ",
                          style: TextStyle(
                              color: kgreen,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    h2,
                    Row(
                      children: [
                        Text(
                          "${txt_date_of_planting.tr} -",
                          style: TextStyle(
                              color: ktext,
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          " ${plott.SOWING_DATE == null ? "-" : plott.SOWING_DATE} ",
                          style: TextStyle(
                              color: kgreen,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    h2,
                    Row(
                      children: [
                        Text(
                          txt_plot_status.tr,
                          style: TextStyle(
                              color: ktext,
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "  ${plott.STATUS == "Active" ? active.tr : deactive.tr}",
                          style: TextStyle(
                              color: plott.STATUS == 'Active' ? kgreen : kred,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      ImageAssets.ic_nextArrow,
                      height: 30,
                    ),
                    w10,
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                          height: 58,
                          width: 80,
                          decoration: BoxDecoration(
                              color: kblue,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage("${plott.CROP_IMAGE}")))),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class QuzieBottomSheetScreen extends StatelessWidget {
  const QuzieBottomSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 570,
      decoration: BoxDecoration(
          color: kwhite,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  ImageAssets.ic_clock,
                  height: 70,
                ),
                Positioned(
                    top: 22,
                    left: 18,
                    child: Text(
                      '25',
                      style: TextStyle(color: kgreen, fontSize: 25),
                    )),
              ],
            ),
            h20,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                height: 340,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage(ImageAssets.ic_bg3)),
                  color: kgreen,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      h30,
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: klimegreen,
                            backgroundImage: AssetImage(ImageAssets.ic_icon1),
                          ),
                          w10,
                          Expanded(
                              child: Text(txt_grow1.tr,
                                  style: TextStyle(
                                      color: kblack,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500)))
                        ],
                      ),
                      h10,
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: klimegreen,
                            backgroundImage: AssetImage(ImageAssets.ic_icon2),
                          ),
                          w10,
                          Expanded(
                              child: Text(txt_grow2.tr,
                                  style: TextStyle(
                                      color: kblack,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500)))
                        ],
                      ),
                      h10,
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: klimegreen,
                            backgroundImage: AssetImage(ImageAssets.ic_icon3),
                          ),
                          w10,
                          Expanded(
                              child: Text(txt_grow3.tr,
                                  style: TextStyle(
                                      color: kblack,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500)))
                        ],
                      ),
                      h10,
                      Row(
                        children: [
                          CircleAvatar(
                              radius: 30,
                              backgroundColor: klimegreen,
                              child: Image.asset(ImageAssets.ic_star,
                                  height: 25, color: kwhite)),
                          w10,
                          Expanded(
                              child: Text(txt_grow4.tr,
                                  style: TextStyle(
                                      color: kblack,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500))),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            h30,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType
                          .fade, // Choose your desired animation type
                      child: QuzieScreen(),
                    ),
                  );
                },
                child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    decoration: BoxDecoration(
                        color: kgreen, borderRadius: BorderRadius.circular(30)),
                    child: Text(txt_grow5.tr,
                        style: TextStyle(
                            fontSize: 18,
                            color: kwhite,
                            fontWeight: FontWeight.w600))),
              ),
            )
          ],
        ),
      ),
    );
  }
}

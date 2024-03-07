import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/Home/home_controller.dart';
import 'package:grape_master/screens/auth/LocalString.dart';
import 'package:grape_master/util/color.dart';
import 'package:grape_master/util/constants.dart';
import 'package:grape_master/util/image_assets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class MyPostApi extends StatefulWidget {
  const MyPostApi({super.key});

  @override
  State<MyPostApi> createState() => _MyPostApiState();
}

class _MyPostApiState extends State<MyPostApi> {
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
      await eProvider?.wetherforcasting();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<HomeController>(builder: (context, ePv, child) {
      return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        color: kbluewether,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                h10,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        ePv?.wetherforcasting();
                      },
                      child: Image.asset(
                        ImageAssets.ic_rotate,
                        height: 20,
                        color: klightgreen,
                      ),
                    ),
                  ),
                ),
                h50,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      w10,
                      Text(
                          "${ePv.watherModel!.current?.feelslike_c.toString()}",
                          style: TextStyle(
                              fontSize: 70,
                              fontWeight: FontWeight.bold,
                              color: kwhite)),
                      w10,
                      Image.asset(
                        'assets/celsius.png',
                        height: 60,
                        color: kwhite,
                      )
                    ],
                  ),
                ),
                h70,
                h10,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.30, color: kwhite),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 9,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  today_s_weather.tr,
                                  style: TextStyle(
                                      color: kwhite,
                                      // decoration: TextDecoration.underline,
                                      //  decorationThickness: 3.0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                              ),
                              h2,
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${ePv.watherModel!.current?.condition?.text.toString()}",
                                  style: TextStyle(
                                      color: kwhite,
                                      // decoration: TextDecoration.underline,
                                      //  decorationThickness: 3.0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 40),
                                ),
                              ),
                              Image.network(
                                'https:${ePv.watherModel!.current?.condition?.icon.toString()}',
                                height: 100,
                                width: 100,
                              ),
                            ],
                          ),
                        ),
                        h40,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                          color: kwhite, fontSize: 15),
                                    ),
                                    Text(
                                        "${ePv?.watherModel?.current?.feelslike_c.toString()}/${ePv?.watherModel?.current?.temp_c.toString()}",
                                        style: TextStyle(
                                            color: kwhite, fontSize: 15))
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
                                          color: kwhite, fontSize: 15),
                                    ),
                                    Text(
                                        "${ePv?.watherModel?.current?.humidity.toString()}%",
                                        style: TextStyle(
                                            color: kwhite, fontSize: 15))
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                          color: kwhite, fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                        "${ePv?.watherModel?.current?.wind_mph.toString()} mph",
                                        style: TextStyle(
                                            color: kwhite, fontSize: 15))
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
                                          color: kwhite, fontSize: 15),
                                    ),
                                    SizedBox(
                                      width: 9,
                                    ),
                                    Text(
                                        "${ePv?.watherModel?.current?.pressure_mb.toString()} hpa",
                                        style: TextStyle(
                                            color: kwhite, fontSize: 15))
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        h20
                      ],
                    ),
                  ),
                ),
                h10,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Divider(
                    color: kwhite,
                    thickness: 0.30,
                  ),
                ),
                h20,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.30, color: kwhite),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        h5,
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(hourly_forecast.tr,
                              style: TextStyle(
                                  color: kwhite,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600)),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                                //scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: ePv
                                    .watherModel?.forecast?.forecastday?.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  var data = ePv.watherModel?.forecast
                                      ?.forecastday?[index];

                                  return ListView.builder(
                                      //scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: data?.hour?.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var items = data?.hour?[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 100,
                                                    child: Center(
                                                      child: Text(
                                                        "${items!.time.toString().split(" ")[0]}\n    ${items!.time.toString().split(" ")[1]}",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: kwhite),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              h2,
                                              Image.network(
                                                "https:${items.condition?.icon}",
                                                height: 90,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "${items.temp_c?.toString()}",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: kwhite,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Image.asset(
                                                    'assets/celsius.png',
                                                    height: 15,
                                                    color: kwhite,
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                }),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                h10,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Divider(
                    color: kwhite,
                    thickness: 0.30,
                  ),
                ),
                h16,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.30, color: kwhite),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        h5,
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(daily_forecast.tr,
                              style: TextStyle(
                                  color: kwhite,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600)),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                                //scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: ePv
                                    .watherModel?.forecast?.forecastday?.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  var data = ePv.watherModel?.forecast
                                      ?.forecastday?[index];

                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 100,
                                              child: Center(
                                                child: Text(
                                                  "${data?.date.toString()}",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: kwhite),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        h2,
                                        Image.network(
                                          "https:${data?.day?.condition?.icon}",
                                          height: 90,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "${data!.day?.avgtemp_c.toString()}",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: kwhite,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Image.asset(
                                              'assets/celsius.png',
                                              height: 15,
                                              color: kwhite,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }));
  }
}

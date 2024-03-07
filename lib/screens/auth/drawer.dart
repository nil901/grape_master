import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/auth/LocalString.dart';
import 'package:grape_master/screens/auth/langvange_screen.dart';
import 'package:grape_master/screens/auth/update_lang.dart';
import 'package:grape_master/util/color.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../util/constants.dart';
import '../../util/image_assets.dart';
import '../../util/prefs/app_preference.dart';
import '../Home/about_us.dart';
import '../Home/contact_us.dart';
import '../Home/home_controller.dart';
import '../Home/terms_and_condition.dart';
import '../address/update_profile.dart';
import '../register_as_deler/dashboard_deler_profile.dart';
import '../register_as_deler/register_as_deler.dart';
import 'login.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  // const MyDrawer({Key? key}) : super(key: key);

  String? fullName = "";
  int index = 0;

  String? email = "";

  String? gender = "";

  String address = "";

  String? UserId = "";

  String? shopId = "";

  String? url = "";
  String? salon = "";
  String? mobileNumber = "";

  Future<void> share() async {
    await FlutterShare.share(
        title: 'GrapeMaster ',
        text: 'GrapeMaster\nPlease download  this App.',
        linkUrl:
            'https://play.google.com/store/apps/details?id=com.wowinfotech0.grapesmaster',
        chooserTitle: 'Example Chooser Title');
  }

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
      await eProvider?.versionCodeApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(builder: (context, ePv, child) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.78,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              WlcomeNameLogo(
                loginName: fullName == null ? "" : fullName,
              ),
              ListTile(
                dense : true,
                leading: Icon(Icons.home,size: 25,),
                title: Text(
                txt_homes.tr,
                  style: TextStyle(
                      color: grey800,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                onTap: () {
                  setState(() {
                    index = 0;
                    Navigator.pop(context);
                  });
                },
              ),
              ListTile(
                dense : true,
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateProfile()));
                      },
                      visualDensity: VisualDensity(horizontal: 0, vertical: -1),
                      leading: Icon(
                        Icons.person,
                        size: 30,
                      ),
                      title: Text(
                       profile.tr,
                        style: TextStyle(
                            color: grey800,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),

              ePv.delerStutus == "Yes"
                  ? ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DealerDashboardScreen()));
                        setState(() {
                          index = 1;
                          // Navigator.pop(context);
                        });
                      },
                      visualDensity: VisualDensity(horizontal: 0, vertical: -3),
                      leading: Icon(
                        Icons.person,
                        size: 30,
                      ),
                      title: Text(
                        register_as_dealer.tr,
                        style: TextStyle(
                            color: grey800,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  : ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterDealer()));
                        setState(() {
                          index = 1;
                          // Navigator.pop(context);
                        });
                      },
                      visualDensity: VisualDensity(horizontal: 0, vertical: -3),
                      leading: Icon(
                        Icons.person,
                        size: 30,
                      ),
                      title: Text(
                        register_as_dealer.tr,
                        style: TextStyle(
                            color: grey800,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
              ListTile(
                onTap: () {
                  setState(() {
                    index = 2;
                    Navigator.pop(context);
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Updatelang()));
                        setState(() {
                          index = 1;
                          // Navigator.pop(context);
                        });
                    
                  });
                },
                visualDensity: VisualDensity(horizontal: 0, vertical: -3),
                leading: Image.asset(
                  ImageAssets.ic_web,
                  height: 30,
                  color: grey800,
                ),
                title: Text(
                 txt_change_language.tr,
                  style: TextStyle(
                      color: grey800,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
              ListTile(
                onTap: () => share(),
                visualDensity: VisualDensity(horizontal: 0, vertical: -3),
                leading: Image.asset(
                  ImageAssets.ic_share,
                  height: 30,
                  color: grey800,
                ),
                title: Text(
                 txt_share.tr,
                  style: TextStyle(
                      color: grey800,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
              ListTile(
                onTap: () async {
                  String? url = "";
                  url =
                      "https://play.google.com/store/apps/details?id=com.DZUKOU&hl=en";
                  if (await canLaunch(url!)) {
                    await launch(
                      url!,
                      headers: {
                        "Content-Type": "application/x-www-form-urlencoded",
                        "Content-Disposition": "inline"
                      },
                    );
                  } else
                    // can't launch url, there is some error
                    throw "Could not launch $url";
                },
                visualDensity: VisualDensity(horizontal: 0, vertical: -3),
                leading: Image.asset(
                  ImageAssets.ic_rating,
                  height: 30,
                  color: grey800,
                ),
                title: Text(
                 txt_rate_app.tr,
                  style: TextStyle(
                      color: grey800,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ContactUsScreen()));
                  setState(() {
                    index = 1;
                  });
                },
                visualDensity: VisualDensity(horizontal: 0, vertical: -3),
                leading: Icon(
                  Icons.person,
                  size: 30,
                ),
                title: Text(
                 txt_contact_us.tr,
                  style: TextStyle(
                      color: grey800,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutUS()));
                },
                visualDensity: VisualDensity(horizontal: 0, vertical: -3),
                leading: Image.asset(
                  ImageAssets.ic_phone11,
                  height: 30,
                  color: grey800,
                ),
                title: Text(
                 txt_about_us.tr,
                  style: TextStyle(
                      color: grey800,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TermsAndCondition()));
                },
                leading: Image.asset(
                  ImageAssets.ic_terms,
                  height: 30,
                  color: grey800,
                ),
                title: Text(
                  txt_terms_amp_conditions.tr,
                  style: TextStyle(
                      color: grey800,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),

              ListTile(
                  leading: Image.asset(
                    ImageAssets.ic_logout,
                    height: 30,
                    color: grey800,
                  ),
                  title: Text(
                    txt_logout.tr,
                    style: TextStyle(
                        color: grey800,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    print("jjfdjdf");
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
                                                'Grape Master',
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
                                             logoutmsg.tr,
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
                                                        AppPreference()
                                                            .clearSharedPreferences()
                                                            .then((value) {
                                                          Get.to(LangvangeSelection());
                                                        });
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

                  
                  }),
            
            ],
          ),
        ),
      );
    });
  }
}

class WlcomeNameLogo extends StatelessWidget {
  const WlcomeNameLogo({Key? key, this.loginName}) : super(key: key);
  final loginName;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kgreen,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: Column(
        children: [
          Image.asset(
            ImageAssets.ic_logo,
            height: 200,
            color: kwhite,
          )
        ],
      ),
    );
  }
}

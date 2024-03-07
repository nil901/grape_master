import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/auth/login.dart';
import 'package:grape_master/screens/home_Screen.dart';
import 'package:grape_master/screens/register_as_deler/dashboard_deler_profile.dart';
import 'package:grape_master/screens/register_as_deler/register_as_deler.dart';
import 'package:grape_master/screens/splashScreen.dart';
import 'package:grape_master/util/color.dart';
import 'package:grape_master/util/constants.dart';
import 'package:grape_master/util/image_assets.dart';
import 'package:grape_master/util/prefs/app_preference.dart';

import 'address/update_profile.dart';

class NavigatorDrawer extends StatelessWidget {
  const NavigatorDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeder(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeder(BuildContext context) => Container(
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
  Widget buildMenuItems(context) => Container(
        margin: EdgeInsets.all(0),
        // padding: EdgeInsets.all(5),
        child: Wrap(children: <Widget>[
          ListTile(
              leading: Icon(Icons.home),
              title: Text(
                "Home",
                style: TextStyle(
                    color: grey800, fontSize: 16, fontWeight: FontWeight.w400),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        MyHomePage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));

                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              }),
          ListTile(
              leading: Icon(
                Icons.shopping_cart,
                size: 30,
              ),
              title: Text(
                "My Orders",
                style: TextStyle(
                    color: grey800, fontSize: 16, fontWeight: FontWeight.w400),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        UpdateProfile(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));

                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              }),
          ListTile(
              leading: Icon(
                Icons.person,
                size: 30,
              ),
              title: Text(
                "My Profile",
                style: TextStyle(
                    color: grey800, fontSize: 16, fontWeight: FontWeight.w400),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        UpdateProfile(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));

                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              }),
          ListTile(
              leading: Icon(
                Icons.person,
                size: 30,
              ),
              title: Text(
                "Register As Dealer",
                style: TextStyle(
                    color: grey800, fontSize: 16, fontWeight: FontWeight.w400),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        DealerDashboardScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));

                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              }),
          ListTile(
              leading: Image.asset(
                ImageAssets.ic_web,
                height: 30,
                color: grey800,
              ),
              title: Text(
                "Change Language",
                style: TextStyle(
                    color: grey800, fontSize: 16, fontWeight: FontWeight.w400),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        MyHomePage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));

                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              }),
          ListTile(
              leading: Image.asset(
                ImageAssets.ic_share,
                height: 30,
                color: grey800,
              ),
              title: Text(
                "Share",
                style: TextStyle(
                    color: grey800, fontSize: 16, fontWeight: FontWeight.w400),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        MyHomePage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));

                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              }),
          ListTile(
              leading: Image.asset(
                ImageAssets.ic_share,
                height: 30,
                color: grey800,
              ),
              title: Text(
                "Rate app",
                style: TextStyle(
                    color: grey800, fontSize: 16, fontWeight: FontWeight.w400),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        MyHomePage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));

                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              }),
          ListTile(
              leading: Icon(Icons.question_answer),
              title: Text(
                "About Us",
                style: TextStyle(
                    color: grey800, fontSize: 16, fontWeight: FontWeight.w400),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        MyHomePage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));

                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              }),
          ListTile(
              leading: Icon(Icons.phone_android),
              title: Text(
                "About Us",
                style: TextStyle(
                    color: grey800, fontSize: 16, fontWeight: FontWeight.w400),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        MyHomePage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));

                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              }),
          ListTile(
              leading: Image.asset(
                ImageAssets.ic_terms,
                height: 30,
                color: grey800,
              ),
              title: Text(
                "Terms & Condition",
                style: TextStyle(
                    color: grey800, fontSize: 16, fontWeight: FontWeight.w400),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        MyHomePage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));

                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              }),
          ListTile(
              leading: Image.asset(
                ImageAssets.ic_logout,
                height: 30,
                color: grey800,
              ),
              title: Text(
                "log Out",
                style: TextStyle(
                    color: grey800, fontSize: 16, fontWeight: FontWeight.w400),
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
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    // Your header and close button code here
                                                    h10,

                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10),
                                                      child: Row(
                                                        children: [
                                                          Image.asset(
                                                            ImageAssets.ic_logo,
                                                            height: 50,
                                                          ),
                                                          Text(
                                                            'THe pakage is over',
                                                            style: TextStyle(
                                                                color: kblack,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Text(
                                                      'The pakage is over! Buy a new pakage',
                                                      style: TextStyle(
                                                          color: kblack,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    h20,
                                                    h20,
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 28),
                                                      child: Align(
                                                        alignment: Alignment
                                                            .bottomRight,
                                                        child: InkWell(
                                                          onTap: () {
                                                            // Navigator.push(
                                                            //   context,
                                                            //   PageTransition(
                                                            //       type: PageTransitionType
                                                            //           .fade, // Choose your desired animation type
                                                            //       child:
                                                            //           SubscriptionScrren()),
                                                            // );
                                                            // // Navigator.pop(context);
                                                          },
                                                          child: Text(
                                                            'Ok',
                                                            style: TextStyle(
                                                                color: klime,
                                                                fontSize: 20),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    h20,
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ));});
                // showDialog(
                //   context: context,
                //   builder: (context) {
                //     return AlertDialog(
                //       title: Row(
                //         children: [
                //           Image.asset(
                //             ImageAssets.ic_logo,
                //             height: 40,
                //           ),
                //           Text('GrapeMaster'),
                //         ],
                //       ),
                //       content: Text('Do you want to logout ?'),
                //       actions: [
                //         InkWell(
                //             onTap: () {
                //               Navigator.pop(context);
                //             },
                //             child: Text(
                //               'NO',
                //               style:
                //                   TextStyle(color: Colors.black, fontSize: 18),
                //             )),
                //         w10,
                //         InkWell(
                //             onTap: () {
                //               AppPreference()
                //                   .clearSharedPreferences()
                //                   .then((value) {
                //                 Get.to(LoginScreen());
                //               });
                //             },
                //             child: Text(
                //               'YES',
                //               style:
                //                   TextStyle(color: Colors.black, fontSize: 18),
                //             )),
                //       ],
                //     );
                //   },
                // );

                // Navigator.of(context).pushReplacement(
                //   PageRouteBuilder(
                //     pageBuilder: (context, animation, secondaryAnimation) =>
                //         MyHomePage(),
                //     transitionsBuilder:
                //         (context, animation, secondaryAnimation, child) {
                //       const begin = Offset(1.0, 0.0);
                //       const end = Offset.zero;
                //       const curve = Curves.easeInOut;

                //       var tween = Tween(begin: begin, end: end)
                //           .chain(CurveTween(curve: curve));

                //       var offsetAnimation = animation.drive(tween);

                //       return SlideTransition(
                //         position: offsetAnimation,
                //         child: child,
                //       );
                //     },
                //   ),
              }),
        ]),
      );
}
//  Container(
//             height: 200,
//             decoration: BoxDecoration(  
//               color: kgreen,
//               image: DecorationImage(
//                 image: AssetImage(ImageAssets.ic_logo)
//                 )
//               )
//             ),
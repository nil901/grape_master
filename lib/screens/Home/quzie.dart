import 'dart:async';
import 'dart:developer';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/Home/scrore_count_screen.dart';
import 'package:grape_master/screens/auth/LocalString.dart';
import 'package:grape_master/util/image_assets.dart';
import 'package:provider/provider.dart';

import '../../util/color.dart';
import '../../util/constants.dart';
import 'home_controller.dart';

class QuzieScreen extends StatefulWidget {
  const QuzieScreen({super.key});

  @override
  State<QuzieScreen> createState() => _QuzieScreenState();
}

class _QuzieScreenState extends State<QuzieScreen> {
  HomeController? eProvider;
  final player = AudioPlayer();

  bool isAnswered = false;
  String selectedAnswerID = '0';
  int _secondsRemaining = 25;
  late Timer _timer;
  @override
  void initState() {
    eProvider = Provider.of<HomeController>(context, listen: false);
    init();
    //  player.play(AssetSource('timernew.mp3'));
    //  Player.play('timernew.mp3');

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    player.stop();
    _timer.cancel(); // Cancel the timer to prevent memory leaks
    super.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      player.play(AssetSource('timernew.mp3'));
      player.setReleaseMode(ReleaseMode.loop);
      await eProvider?.quizeapi();
      eProvider?.quizeModelLIst?.DATA?.length == 0
          ? player.stop()
          : player.play(AssetSource('timernew.mp3'));
      startTimer();
    });
  }

  String? SelectedAnswerId;

  void startTimer() {
    player.play(AssetSource('timernew.mp3'));
    player.stop();
    player.play(AssetSource('timernew.mp3'));
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer.cancel(); // Stop the timer when it reaches 0
          eProvider
              ?.postquize(
                  context, eProvider?.quizeModelLIst?.DATA?[0]?.FO_ID, "")
              .then((value) {
            _timer.cancel();
            // player.stop();

            _secondsRemaining = 25;
            player.play(AssetSource('timernew.mp3'));

            startTimer();
            player.play(AssetSource('timernew.mp3'));
            player.setReleaseMode(ReleaseMode.loop);
          });
        }
      });
    });
  }

  Color optionColor = const Color.fromRGBO(255, 255, 255, 1); // Default color
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Show a dialog and handle user's response
        if (eProvider?.quizeModelLIst?.DATA?.length == 0) {
          Navigator.of(context).pop(true);
          return false;
        } else {
          bool shouldPop = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                insetPadding: EdgeInsets.all(12),
                contentPadding: EdgeInsets.zero,
                content: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                ImageAssets.ic_logo,
                                height: 50,
                              ),
                              Text(
                                'Grape Master',
                                style: TextStyle(
                                    color: kblack, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "तुम्हाला नक्की गेम बंद करायचा आहे का",
                              style: TextStyle(
                                  color: kblack, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pop(false); // Cancel pop
                                  },
                                  child: Text(
                                    nomsg.tr,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                ),
                                SizedBox(width: 30),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pop(true); // Allow pop
                                  },
                                  child: Text(
                                    yes.tr,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
          return shouldPop ?? false;
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Consumer<HomeController>(builder: (context, ePv, child) {
            // Future.delayed(Duration(seconds: 25), () async {
            //   await ePv.postquize(context, "0", selectedAnswerID).then((value) {
            //     _timer.cancel();
            //   });
            //   // Any state changes that should trigger a rebuild
            //   //  _secondsRemaining =
            //   //     25; // Reset the timer
            //   // startTimer();
            // });
            return ePv.quizeModelLIst?.DATA?.length == 0
                ? SafeArea(child: StackExample())
                : Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(ImageAssets.ic_bg1)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: SafeArea(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 14),
                                child: Column(
                                  children: [
                                    h40,
                                    Stack(
                                      children: [
                                        h50,
                                        Image.asset(
                                          ImageAssets.ic_clock,
                                          height: 70,
                                        ),
                                        Positioned(
                                            top: 22,
                                            left: 18,
                                            child: Text(
                                              '${_secondsRemaining}',
                                              style: TextStyle(
                                                  color: kgreen, fontSize: 25),
                                            )),
                                      ],
                                    ),
                                    h40,
                                    ListView.builder(
                                        //scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount:
                                            ePv.quizeModelLIst?.DATA?.length ??
                                                0,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          var data =
                                              ePv.quizeModelLIst?.DATA![index];
                                          //     ?.QuestionOptionList;

                                          return Container(
                                            height: 350,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                        ImageAssets.ic_quzie))),
                                            child: Column(
                                              children: [
                                                h20,
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12),
                                                  child: Text(
                                                    "${data?.QUESTION}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                                h10,
                                                ListView.builder(
                                                    //scrollDirection: Axis.horizontal,
                                                    shrinkWrap: true,
                                                    itemCount: data
                                                        ?.QuestionOptionList
                                                        ?.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      var items =
                                                          data?.QuestionOptionList![
                                                              index];

                                                      // Execute API call after 25 seconds

                                                      return Padding(
                                                      
                                                      
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: InkWell(
                                                          onTap: () {
                                                              if(ePv.quizeModelLIst?.DATA?.length  == 0){
                                                            player.stop();
                                                        }
                                                            // player.play(AssetSource(
                                                            //     'timernew.mp3'));
                                                            print(data?.FO_ID);
                                                            print(
                                                                items!.FOO_ID);
                                                            setState(() {
                                                              isAnswered = true;
                                                              selectedAnswerID =
                                                                  items!.FOO_ID
                                                                      .toString();
                                                            });
                                                            Timer(
                                                                Duration(
                                                                    seconds: 1),
                                                                () {
                                                              print(
                                                                  "Yeah, this line is printed immediately");
                                                              ePv
                                                                  .postquize(
                                                                      context,
                                                                      data
                                                                          ?.FO_ID,
                                                                      selectedAnswerID)
                                                                  .then(
                                                                      (value) {
                                                                _timer.cancel();
                                                                player.stop();
                                                                _secondsRemaining =
                                                                    25;
                                                                player.play(
                                                                    AssetSource(
                                                                        'timernew.mp3'));
                                                                startTimer();
                                                                isAnswered =
                                                                    false;
                                                              });
                                                            });
                                                          },
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: 45,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: isAnswered
                                                                  ? items!.IS_ANSWER ==
                                                                          'Yes'
                                                                      ? Colors
                                                                          .green
                                                                      : selectedAnswerID ==
                                                                              items!
                                                                                  .FOO_ID
                                                                          ? Colors
                                                                              .red
                                                                          : Colors
                                                                              .white
                                                                  : Colors
                                                                      .white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                "${items?.F_OPTION}",
                                                                style: TextStyle(
                                                                    color:
                                                                        kblack,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                                    h20
                                              ],
                                            ),
                                          );
                                        })
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.red,
                                  child: Text(
                                    "Q1",
                                    style: TextStyle(
                                   fontSize: 21,
                                        fontWeight: FontWeight.w400,
                                        color: kblack),
                                  ),
                                ),
                                w10,
                                CircleAvatar(
                                   radius: 30,
                                  backgroundColor: Colors.red,
                                  child: Text(
                                    "Q2",
                                    style: TextStyle(
                                           fontSize: 21,
                                        fontWeight: FontWeight.w400,
                                        color: kblack),
                                  ),
                                ),
                                w10,
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.red,
                                  child: Text(
                                    "Q3",
                                    style: TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.w400,
                                        color: kblack),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
          }),
        ),
      ),
    );
  }
}
// class Player {
//   static play(String src) async {
//     final player = AudioPlayer();
//     await player.play(AssetSource(src));
//   }
// }

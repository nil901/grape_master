// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/auth/LocalString.dart';
import 'package:grape_master/screens/live/videos_screen.dart';
import 'package:grape_master/util/color.dart';

import 'aduio.dart';
import 'audio_screen.dart';

class MyFarms extends StatefulWidget {
  @override
  _MyFarmsState createState() => _MyFarmsState();
}

class _MyFarmsState extends State<MyFarms> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation,

    

      body: Column(
        children: [
          // give the tab bar a height [can change hheight to preferred height]
          Container(
            height: 45,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 3.0,
                spreadRadius: 0.0,
              ),
            ]),
            child: Material(
              elevation: 10,
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: klime,
                labelStyle:
                    TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                indicatorWeight: 5.5,
                tabs: [
                  // first tab [you can add an icon using the icon property]
                  Tab(text: txt_video.tr),

                  // second tab [you can add an icon using the icon property]
                  Tab(text: txt_audio.tr),
                ],
              ),
            ),
          ),
          // tab bar view here
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // first tab bar view widget
               VideosScreen(),
                // second tab bar view widget
              Aduio_screen()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

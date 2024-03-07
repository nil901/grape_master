

import 'package:flutter/material.dart';
import 'package:grape_master/util/color.dart';

class BlinkingContainer extends StatefulWidget {
  @override
  _BlinkingContainerState createState() => _BlinkingContainerState();
}

class _BlinkingContainerState extends State<BlinkingContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: _controller,
        child: Container(
          alignment: Alignment.center,
          width: 260,
          height: 35,
          decoration: BoxDecoration(
            color: klime,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text("Live Video (Attend Live Session)",style: TextStyle(color: kwhite,fontWeight: FontWeight.w800),),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

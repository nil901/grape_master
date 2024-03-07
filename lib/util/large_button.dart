import 'package:flutter/material.dart';

import 'color.dart';

class LargeButton extends StatelessWidget {
  const LargeButton({super.key, required this.onPress, this.text});
  final Function onPress;
  final text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPress();
      },
      child: Container(
          alignment: Alignment.center,
          height: 43,
          width: 190,
          decoration: BoxDecoration(
            color: kgreen,
            borderRadius: BorderRadius.circular(22),
          ),
          child: text),
    );
  }
}

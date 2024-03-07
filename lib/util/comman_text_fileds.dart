import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color.dart';

class CommanTextFileds extends StatelessWidget {
  const CommanTextFileds(
      {Key? key,
      this.imageicon,
      this.controller,
      this.hinttext,
      this.maxLength, required this.inputType,
     })
      : super(key: key);
  final imageicon;
  final TextEditingController? controller;
  final hinttext;
  final maxLength;
 final TextInputType  inputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black,width: 0.60),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: Row(
            children: [
              SizedBox(width: 10),
              Image.asset(imageicon, height: 20, color: grey800),
              SizedBox(width: 20),
              Expanded(
                child:  TextField(
                  cursorColor: Colors.black,
                  
                  keyboardType: inputType,
                  style: TextStyle(
                      fontSize: 13,
                      color: grey800,
                      fontWeight: FontWeight.w400),
                  onChanged: (value) {},
                  controller: controller,
                  inputFormatters: [
      
                    LengthLimitingTextInputFormatter(
                        maxLength), // Limit to 10 characters
                  ],
                  decoration: InputDecoration(
                    
                    border: InputBorder.none,
                    hintStyle: TextStyle(fontSize: 13, color: grey800),
                    hintText: hinttext,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

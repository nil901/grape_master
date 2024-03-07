import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/auth/LocalString.dart';
import 'package:grape_master/util/util.dart';

import '../../util/color.dart';
import '../../util/constants.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kgreen,
          title: Text(
           txt_contact_us.tr,
            style: TextStyle(
                color: kwhite, fontWeight: FontWeight.w400, fontSize: 18),
          )),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: (){
                          Utils().launchPhoneCall("9607087801");
                        },
                        child: ContactUsExpandend(
                            contact: '9607087801',
                            text: 'Customer Care (Maharashtra)'),
                      ),
                      h10,
                      InkWell(
                         onTap: (){
                          Utils().launchPhoneCall("7499556104");
                        },
                        child: ContactUsExpandend(
                            contact: '7499556104',
                            text: 'Sales Team (karnataka)'),
                      ),
                      h10,
                    InkWell(
                         onTap: (){
                          Utils().launchPhoneCall("9604146619");
                        },
                        child: ContactUsExpandend(
                            contact: '9604146619',
                            text: 'Sales Team (Maharashtra)'),
                      ),
                      h10,
                       InkWell(
                         onTap: (){
                          Utils().launchPhoneCall("9356930717");
                        },
                        child: ContactUsExpandend(
                            contact: '9356930717',
                            text: 'Customer Care (Maharashtra)'),
                      ),
                      h10,
                      InkWell(
                         onTap: (){
                          Utils().launchPhoneCall("9356930717");
                        },
                        child: ContactUsExpandend(
                            contact: '9356930717',
                            text: 'Customer Care (Maharashtra)'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ContactUsExpandend extends StatelessWidget {
  const ContactUsExpandend({super.key, this.text, this.contact});
  final text;
  final contact;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        height: 65,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              h10,
              Text(
                text,
                style: TextStyle(color: grey800, fontSize: 15),
              ),
              h5,
              Text(
                contact,
                style: TextStyle(
                  color: klime,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.underline,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

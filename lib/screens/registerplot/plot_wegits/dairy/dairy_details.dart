import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/auth/LocalString.dart';
import 'package:grape_master/util/constants.dart';
import 'package:grape_master/util/image_assets.dart';
import 'package:provider/provider.dart';

import '../../../../model/plot_information_model/dairy_list_model.dart';
import '../../../../util/color.dart';
import '../../plot_controller.dart';

class DairyDetails extends StatelessWidget {
  const DairyDetails({super.key, required this.items});
 final  DairyList items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kgreen,
          title: Text(
          description.tr,
            style: TextStyle(
                color: kwhite, fontWeight: FontWeight.w400, fontSize: 22),
          )),
      body:Consumer<plotcnt>(builder: (context, ePv, child) {
        ePv.titleNameController.text = items.title;
        ePv.nameandQuantityofchemicalController.text = items.description;
        ePv.activeCommponetController.text = items.funParameter == null ? '-':items.funParameter.toString();
        ePv.purposeController.text = items.diseasePest == null ? '-':items.diseasePest.toString();
         ePv.phController.text = items.phi == null ?"-":items.phi.toString();
        return Column(
          children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [ 
                      Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 28,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          color: kgreen500,
                        ),
                        child: Text(
                          "${items.regDate}",
                          style: TextStyle(
                              color: kwhite,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Image.asset(
                        ImageAssets.ic_pen,
                        height: 25,
                        color: klime,
                      )
                    ],
                  ),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: 500,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                              child: TextField(
                                style: TextStyle(fontSize: 18,color: klime),
                                controller:  ePv.titleNameController,
                                cursorColor: klime,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                  color: klime, // Set your desired border color
                                ))),
                              ),
                            ),
                            //  Divider(thickness: 2,color: klime,),
                            h20,
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Divider(
                                    thickness: 0.5,
                                    color: klime,
                                  )),
                                  w10,
                                  Text(
                                  txt_schedule_msg_title.tr,
                                    style: TextStyle(
                                        color: klime, fontWeight: FontWeight.w500),
                                  ),
                                  w10,
                                  Expanded(
                                      child: Divider(
                                    thickness: 0.5,
                                    color: klime,
                                  )),
                                ],
                              ),
                            ),
                            TextField(
                              controller:ePv.nameandQuantityofchemicalController,
                              maxLines: 3,
                              minLines: 3,
                              cursorColor: klime,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                color: klime, // Set your desired border color
                              ))),
                            ),
                            h26,
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Divider(
                                    thickness: 0.5,
                                    color: klime,
                                  )),
                                  w10,
                                  Text(
                                   txt_aff_parameter.tr,
                                    style: TextStyle(
                                        color: klime, fontWeight: FontWeight.w500),
                                  ),
                                  w10,
                                  Expanded(
                                      child: Divider(
                                    thickness: 0.5,
                                    color: klime,
                                  )),
                                ],
                              ),
                            ),
                            TextField(
                              controller:  ePv.activeCommponetController,
                              cursorColor: klime,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                color: klime, // Set your desired border color
                              ))),
                            ),
                            h26,
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 70),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Divider(
                                    thickness: 0.5,
                                    color: klime,
                                  )),
                                  w10,
                                  Text(
                                txt_purpose.tr,
                                    style: TextStyle(
                                        color: klime, fontWeight: FontWeight.w500),
                                  ),
                                  w10,
                                  Expanded(
                                      child: Divider(
                                    thickness: 0.5,
                                    color: klime,
                                  )),
                                ],
                              ),
                            ),
                             TextField(
                              cursorColor: klime,
                              controller: ePv.purposeController,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                color: klime, // Set your desired border color
                              ))),
                            ),
                           
                            
                            h10,
                             Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 70),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Divider(
                                    thickness: 0.5,
                                    color: klime,
                                  )),
                                  w10,
                                  Text(
                                    "PHI",
                                    style: TextStyle(
                                        color: klime, fontWeight: FontWeight.w500),
                                  ),
                                  w10,
                                  Expanded(
                                      child: Divider(
                                    thickness: 0.5,
                                    color: klime,
                                  )),
                                ],
                              ),
                            ),
                             TextField(
                              cursorColor: klime,
                              controller: ePv.phController,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                color: klime, // Set your desired border color
                              ))),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  ],
                ),
              ),
            ),
          )
         
      , InkWell(
        onTap: (){
          ePv.DiaryPost(context,items.title,items.pdId);
        },
        child: Container(
            alignment: Alignment.center,
            height: 45,
            color: kgreen,
            child:Text(txt_add_to_diary.tr,style:TextStyle(color: kwhite,fontWeight: FontWeight.w400, fontSize: 14))
           ),
      )
         
          ],
        );
      }
      ),
    );
  }
}

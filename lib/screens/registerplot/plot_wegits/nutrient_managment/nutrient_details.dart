import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/auth/LocalString.dart';
import 'package:grape_master/screens/registerplot/plot_wegits/nutrient_managment/view_report.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../../model/plot_information_model/nutrient_managment_model.dart';
import '../../../../util/color.dart';
import '../../../../util/constants.dart';
import '../../../../util/large_button.dart';
import '../../plot_controller.dart';

class NutrientDetails extends StatefulWidget {
  const NutrientDetails({super.key, required this.items});
  final NutrientManagementModelDATA items;

  @override
  State<NutrientDetails> createState() => _NutrientDetailsState();
}

class _NutrientDetailsState extends State<NutrientDetails> {
  TextEditingController NirogenController = TextEditingController(text: "");
  TextEditingController calciumCarbonateController =
      TextEditingController(text: "");
  TextEditingController organicCarbonController =
      TextEditingController(text: "");
  TextEditingController phosphourusController = TextEditingController(text: "");
  TextEditingController patassiumController = TextEditingController(text: "");
  TextEditingController calciumController = TextEditingController(text: "");
  TextEditingController manganesemController = TextEditingController(text: "");
  TextEditingController SulphurController = TextEditingController(text: "");
  TextEditingController ferrousController = TextEditingController(text: "");
  TextEditingController manganesecontroller = TextEditingController(text: "");
  TextEditingController zinccontroller = TextEditingController(text: "");
  TextEditingController croppercontroller = TextEditingController(text: "");
  TextEditingController bororncontroller = TextEditingController(text: "");
  TextEditingController molybdenumcontroller = TextEditingController(text: "");
  TextEditingController bicarbonatecontroller = TextEditingController(text: "");
  TextEditingController chlorideController = TextEditingController(text: "");
  TextEditingController sodiumcontroller = TextEditingController(text: "");
  TextEditingController phcontroller = TextEditingController(text: "");
  TextEditingController EcController = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    NirogenController.text = widget.items.NITROGEN.toString();
    calciumCarbonateController.text = widget.items.BiCarbonate.toString();
    organicCarbonController.text = widget.items.OrganicCarbon.toString();
    phosphourusController.text = widget.items.PHOSFORUS.toString();
    patassiumController.text = widget.items.POTASIUM.toString();
    calciumController.text = widget.items.CALSIUM.toString();
    manganesemController.text = widget.items.MAGNESIUM.toString();
    SulphurController.text = widget.items.SALPHUR.toString();
    ferrousController.text = widget.items.FEROUS.toString();
    manganesecontroller.text = widget.items.MANGNISE.toString();
    zinccontroller.text = widget.items.ZINK.toString();
    croppercontroller.text = widget.items.Copper.toString();
    bororncontroller.text = widget.items.BORON.toString();
    molybdenumcontroller.text = widget.items.MOLIBHEBAM.toString();
    bicarbonatecontroller.text = widget.items.BiCarbonate.toString();
    chlorideController.text = widget.items.Chloride.toString();
    sodiumcontroller.text = widget.items.Sodium.toString();
    phcontroller.text = widget.items.PH.toString();
    EcController.text = widget.items.EC.toString();

    return Scaffold(
      appBar: AppBar(
          backgroundColor: kgreen,
          title: Text(
            description.tr,
            style: TextStyle(
                color: kwhite, fontWeight: FontWeight.w400, fontSize: 22),
          )),
      body: Consumer<plotcnt>(builder: (context, ePv, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
                child: SingleChildScrollView(
                    child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                h10,
                widget.items.DESCRIPTION == ' '
                    ? Text("")
                    : Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType
                                    .fade, // Choose your desired animation type
                                child: ViewReport(
                                  items: widget.items,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 35,
                            width: 130,
                            decoration: BoxDecoration(
                                color: klime,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              viewreport.tr,
                              style: TextStyle(
                                  color: kwhite,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                Text(
                  txt_report_cat.tr,
                  style: TextStyle(
                      color: kgreen, fontWeight: FontWeight.w500, fontSize: 15),
                ),
                h10,
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                      border: Border.all(color: kblack, width: 0.3),
                      borderRadius: BorderRadius.circular(3)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Text("${widget.items.REPORT_NAME}",
                            style: TextStyle(color: grey800)),
                        //  Icon(Icons.arrow_drop_down)
                      ],
                    ),
                  ),
                ),
                h20,
                Text(
                  txt_lab_name.tr,
                  style: TextStyle(
                      color: kgreen, fontWeight: FontWeight.w500, fontSize: 15),
                ),
                h10,
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                      border: Border.all(color: kblack, width: 0.3),
                      borderRadius: BorderRadius.circular(3)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Text(
                          "${widget.items.LAB_NAME}",
                          style: TextStyle(color: grey800),
                        ),
                        // Icon(Icons.arrow_drop_down)
                      ],
                    ),
                  ),
                ),
                h10,
                Text(
                  txt_date_of_sample.tr,
                  style: TextStyle(
                      color: kgreen, fontWeight: FontWeight.w500, fontSize: 15),
                ),
                h10,
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    border: Border.all(color: kblack, width: 0.3),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            enabled: false,
                            cursorColor: klime,
                            // controller: commentController,
                            maxLines: 10,
                            onChanged: (value) {},
                            style: TextStyle(fontSize: 13),
                            decoration: InputDecoration(
                                //  focusedBorder:InputBorder(borderSide: ) ,
                                helperStyle: TextStyle(color: grey800),
                                hintText: "${widget.items.SAMPLE_DATE}",
                                border: InputBorder.none),
                            validator: (text) {
                              if (text!.isEmpty) {
                                return "Address";
                              }
                              return null;
                            },
                          ),
                        ),
                        // Icon(Icons.arrow_drop_down)
                      ],
                    ),
                  ),
                ),
                h20,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      txt_report_observation.tr,
                      style: TextStyle(
                          color: kgreen,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                    h10,
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: kblack, width: 0.3),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          enabled: false,
                          cursorColor: klime,
                          // controller: commentController,
                          maxLines: 10,
                          onChanged: (value) {},
                          style: TextStyle(fontSize: 13),

                          decoration: InputDecoration(
                              //  focusedBorder:InputBorder(borderSide: ) ,
                              helperStyle: TextStyle(color: grey800),
                              hintText: "${widget.items.DESCRIPTION}",
                              border: InputBorder.none),
                          validator: (text) {
                            if (text!.isEmpty) {
                              return "Address";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                h10,
                Center(
                    child: Text(
                  "Patoile Report",
                  style: TextStyle(
                      color: grey800,
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                )),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Material(
                    elevation: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: kwhite,
                      ),
                      child: Column(
                        children: [
                          h20,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                fertilizer.tr,
                                style: TextStyle(
                                    color: ktext,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17),
                              ),
                              w10,
                              Text(
                                txt_analysis_value.tr,
                                style: TextStyle(
                                    color: grey800,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17),
                              ),
                              w8
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Divider(
                              thickness: 1,
                              color: ktext,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 45),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      txt_nitrogen.tr,
                                      style: TextStyle(
                                          color: ktext,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                    h20,
                                    Text(
                                      txt_calcium_carbonate.tr,
                                      style: TextStyle(
                                          color: ktext,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                    h20,
                                    Text(
                                      txt_organic_carbon.tr,
                                      style: TextStyle(
                                          color: ktext,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                    h25,
                                    Text(
                                      txt_phossFurus.tr,
                                      style: TextStyle(
                                          color: ktext,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),

                                    h20,
                                    Text(
                                      txt_patasium.tr,
                                      style: TextStyle(
                                          color: ktext,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                    h20,
                                    Text(
                                      txt_calcium.tr,
                                      style: TextStyle(
                                          color: ktext,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                    h20,
                                    Text(
                                      txt_mg.tr,
                                      style: TextStyle(
                                          color: ktext,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                    h20,

                                    Text(
                                      txt_sulpher.tr,
                                      style: TextStyle(
                                          color: ktext,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),

                                    //  h20,
                                    //  Text(
                                    //   "Sulphur",
                                    //   style: TextStyle(
                                    //       color: ktext,
                                    //       fontWeight: FontWeight.w400,
                                    //       fontSize: 16),
                                    // ),
                                    h20,
                                    Text(
                                      txt_ferous.tr,
                                      style: TextStyle(
                                          color: ktext,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                    h20,
                                    Text(
                                      txt_maganese.tr,
                                      style: TextStyle(
                                          color: ktext,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                    h20,
                                    Text(
                                      txt_zn.tr,
                                      style: TextStyle(
                                          color: ktext,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                    h20,
                                    Text(
                                      txt_copper.tr,
                                      style: TextStyle(
                                          color: ktext,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                    h20,
                                    Text(
                                      txt_boron.tr,
                                      style: TextStyle(
                                          color: ktext,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                    h20,
                                    Text(
                                      txt_molybdenum.tr,
                                      style: TextStyle(
                                          color: ktext,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                    h20,
                                    Text(
                                      BiCarbonate.tr,
                                      style: TextStyle(
                                          color: ktext,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                    h20,
                                    Text(
                                      txt_cloride.tr,
                                      style: TextStyle(
                                          color: ktext,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                    h20,
                                    Text(
                                      txt_na.tr,
                                      style: TextStyle(
                                          color: ktext,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                    h20,
                                    Text(
                                      txt_ph.tr,
                                      style: TextStyle(
                                          color: ktext,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                    h20,
                                    Text(
                                      txt_ec.tr,
                                      style: TextStyle(
                                          color: ktext,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(width: 1, color: kblack),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: TextField(
                                          controller: NirogenController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    h10,
                                    Container(
                                      height: 30,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(width: 1, color: kblack),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: TextField(
                                          controller:
                                              calciumCarbonateController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    h10,
                                    Container(
                                      height: 30,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(width: 1, color: kblack),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: TextField(
                                          controller: organicCarbonController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    h10,
                                    Container(
                                      height: 30,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(width: 1, color: kblack),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: TextField(
                                          controller: phosphourusController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    h10,
                                    Container(
                                      height: 30,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(width: 1, color: kblack),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: TextField(
                                          controller: patassiumController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    h10,
                                    Container(
                                      height: 30,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(width: 1, color: kblack),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: TextField(
                                          controller: calciumController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    h10,
                                    Container(
                                      height: 30,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(width: 1, color: kblack),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: TextField(
                                          controller: manganesemController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    h10,
                                    Container(
                                      height: 30,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(width: 1, color: kblack),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: TextField(
                                          controller: SulphurController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    h10,
                                    Container(
                                      height: 30,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(width: 1, color: kblack),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: TextField(
                                          controller: ferrousController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    h10,
                                    Container(
                                      height: 30,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(width: 1, color: kblack),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: TextField(
                                          controller: zinccontroller,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    h10,
                                    Container(
                                      height: 30,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(width: 1, color: kblack),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: TextField(
                                          controller: croppercontroller,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    h10,
                                    Container(
                                      height: 30,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(width: 1, color: kblack),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: TextField(
                                          controller: bororncontroller,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    h10,
                                    Container(
                                      height: 30,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(width: 1, color: kblack),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: TextField(
                                          controller: molybdenumcontroller,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    h10,
                                    Container(
                                      height: 30,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(width: 1, color: kblack),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: TextField(
                                          controller: bicarbonatecontroller,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    h10,
                                    Container(
                                      height: 30,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(width: 1, color: kblack),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: TextField(
                                          controller: chlorideController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    h10,
                                    Container(
                                      height: 30,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(width: 1, color: kblack),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: TextField(
                                          controller: sodiumcontroller,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    h10,
                                    Container(
                                      height: 30,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(width: 1, color: kblack),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: TextField(
                                          controller: phcontroller,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    h10,
                                    Container(
                                      height: 30,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(width: 1, color: kblack),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: TextField(
                                          controller: EcController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,

                                          ),
                                          
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                h10,
                Text(
                  txt_photo.tr,
                  style: TextStyle(
                      color: kgreen, fontWeight: FontWeight.w500, fontSize: 15),
                ),
                  h10,
                Container(
                  alignment: Alignment.center,
                  height: 200,
                  decoration: BoxDecoration(
                      border: Border.all(color: kblack, width: 0.2),
                      image: DecorationImage(  
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.items.REPORT_PHOTO.toString())
                      ),
                      borderRadius: BorderRadius.circular(5)),
                )
              ],
            ))),
          ]),
        );
      }),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:grape_master/util/image_assets.dart';
import 'package:grape_master/util/large_button.dart';

import '../../model/home_model/product_list_model.dart';
import '../../util/color.dart';
import '../../util/constants.dart';
import 'home_controller.dart';

class ProductDetails extends StatelessWidget {
   ProductDetails({super.key, required this.product, this.shopId});
  final ProductModel product;
  final shopId;
 

  @override
  Widget build(BuildContext context) {
        final cnt = Get.put(HomeController());
    return Scaffold(
      backgroundColor: kwhite,
      appBar: AppBar(
          backgroundColor: kgreen,
          title: Text(
            "Product Detail",
            style: TextStyle(
                color: kwhite, fontWeight: FontWeight.w400, fontSize: 22),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  "Available",
                  style: TextStyle(
                      color: kgreen, fontWeight: FontWeight.w400, fontSize: 16),
                ),
              ),
              Image.network(
                product.productPhoto.toString(),
                height: 130,
              ),
              h10,
              Text("${product.productName}",
                  style: TextStyle(
                      color: klighblue,
                      fontWeight: FontWeight.w500,
                      fontSize: 17)),
              h6,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Price - ",
                      style: TextStyle(
                          color: grey800,
                          fontWeight: FontWeight.w400,
                          fontSize: 16)),
                  Text("Rs. ${product.price}",
                      style: TextStyle(
                          color: klighblue,
                          fontWeight: FontWeight.w500,
                          fontSize: 15)),
                ],
              ),
              h10,
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Product Description",
                  style: TextStyle(
                      color: kblack, fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ),
              Html(
                data: product.productDescription,
                style: {
                  "body": Style(
                      color: klightblue,
                      fontWeight: FontWeight.w500,
                      fontSize:
                          FontSize(16.0)), // Adjust the font size as needed
                },
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Measure of ues & Stage - ",
                  style: TextStyle(
                      color: kblack, fontWeight: FontWeight.w400, fontSize: 15),
                ),
              ),
              h10,
           h2,              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                height: 230,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: kgreen50, borderRadius: BorderRadius.circular(8)),
                  child: Stack(
                    children: [
                      h10,
                      Positioned(
                        top: 10,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Company Information : -",
                            style: TextStyle(
                                color: kblack,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                        ),
                      ),
                      Positioned(
                          right: 10,
                          top: 4,
                          child: CircleAvatar(
                            backgroundColor:kgreen50,
                            radius: 50,
                         child: ClipRRect(
                          
                          
                          child: Image.network(product.employeePhoto)),
                          )),
                      Positioned(
                        top: 40,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Company Name - ",
                                style: TextStyle(
                                    color: kblack,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
                              ),
                              h5,
                               Text(
                                product.brandName,
                                style: TextStyle(
                                    color: kblack,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 70,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            h10,
                            Positioned(
                              top: 60,
                              child: SizedBox(
                                width: 200,
                                child: Divider(
                                  color: kgreen,
                                ),
                              ),
                            ),
                            h10,
                          
                            Padding(
                               padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Company Area Sale Person's Name - ",
                                    style: TextStyle(
                                        color: kblack,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                  ),
                                 h5,
                                    Text(
                                    product.employeeName,
                                    style:TextStyle(
                                    color: kblack,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          h10,
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Divider(
                                color: kgreen,
                              ),
                            ),
                            h10,
                            Padding(
                               padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Company Area Sale Person's Mobile No - ",
                                    style: TextStyle(
                                        color: kblack,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                  ),
                                  h5,
                                   Text(
                                    product.employeeMobileNo,
                                    style:TextStyle(
                                    color: klime,
                                     decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                                  ),
                                
                                   SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Divider(
                                color: kgreen,
                              ),
                            ),
                                ],
                              ),
                            ),
                           h20
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              h10,
               h10,
                h10,

              LargeButton(onPress: (){
                cnt.EnquireyApi(context,product.spId, shopId);
              },text: Text("Send Enquiry",style: TextStyle(color: kwhite,fontWeight: FontWeight.w500),),)
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:grape_master/screens/address/address_controller.dart';
import 'package:grape_master/screens/auth/LocalString.dart';
import 'package:grape_master/screens/register_as_deler/edit_product.dart';
import 'package:grape_master/screens/register_as_deler/product_add_from.dart';
import 'package:grape_master/util/constants.dart';
import 'package:grape_master/util/image_assets.dart';
import 'package:grape_master/util/lodaer.dart';
import 'package:grape_master/util/no_activity_found.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../util/color.dart';

class ProductListdeler extends StatefulWidget {
  const ProductListdeler({super.key, required this.shopid});
  final shopid;

  @override
  State<ProductListdeler> createState() => _ProductListdelerState();
}

class _ProductListdelerState extends State<ProductListdeler> {
  bool status = false;

  AddressController? pve;

 
  bool isOpen1 = false;
  bool isOpen2 = false;

  @override
  void initState() {
    
    pve = Provider.of<AddressController>(context, listen: false);
    init();

    super.initState();
  }

  void init() async {
    pve?.ShopId = widget.shopid;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await pve?.productlistApi(widget.shopid);

     
    });
  }

  @override
  Widget build(BuildContext context) { 
    Navigator.of(context);
   

    return Scaffold(
        appBar: AppBar(
            backgroundColor: kgreen,
            title: Text(
              "Products",
              style: TextStyle(
                  color: kwhite, fontWeight: FontWeight.w400, fontSize: 25),
            )),
        floatingActionButton: InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType
                    .fade, // Choose your desired animation type
                child: ProductAddFrom(),
              ),
            );
          },
          child: CircleAvatar(
            radius: 32,
            backgroundColor: kwhite,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: klime,
              child: Icon(
                Icons.add,
                size: 30,
                color: kwhite,
              ),
            ),
          ),
        ),
        body: Consumer<AddressController>(builder: (context, ePv, child) {
          return  pve?.isOpenList.length == 0
              ? Center(
                  child: NoActivityFound(),
                )
              :     pve?.isOpenList == null
                  ? Center(
                      child: Loader(),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: ePv.productLiastModel?.DATA?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        // List<bool>  pve?.isOpenList = List.filled(ePv.productLiastModel!.DATA!.length, false);

                        var items = ePv.productLiastModel?.DATA?[index];
                        if ( pve?.isOpenList.length == 0) {
                        } else {
                          if (items?.IS_AVAILABLE == 'No') {
                             pve?.isOpenList[index] = false;
                          } else if (items?.IS_AVAILABLE == 'Yes') {
                             pve?.isOpenList[index] = true;
                          }
                        }

                        // log("${ePv.catid}");
                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 45,
                                      decoration: BoxDecoration(
                                          color: kbg,
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                items!.PRODUCT_PHOTO.toString(),
                                              ))),
                                    ),
                                    w10,
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  items!.PRODUCT_NAME
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: kblack,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    InkWell(
                                                        onTap: () {
                                                          // s
                                                          //   setState(() {
                                                          //        pve?.isOpenList[index] = ! pve?.isOpenList[index];
                                                          //   });

                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            20.0),
                                                                    child:
                                                                        AlertDialog(
                                                                      insetPadding:
                                                                          EdgeInsets.all(
                                                                              12),
                                                                      contentPadding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      content:
                                                                          SingleChildScrollView(
                                                                        child:
                                                                            Container(
                                                                          width: MediaQuery.of(context)
                                                                              .size
                                                                              .width,
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              // Your header and close button code here
                                                                              h10,

                                                                              Padding(
                                                                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Image.asset(
                                                                                        ImageAssets.ic_logo,
                                                                                        height: 40,
                                                                                      ),
                                                                                      w10,
                                                                                      Expanded(
                                                                                        child: Text(
                                                                                           pve?.isOpenList[index] == false ? 'Do you want to change to available this product?' : "do you want to change to unavailable this product?",
                                                                                          style: TextStyle(color: kblack, fontSize: 18, fontWeight: FontWeight.w500),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              h10,
                                                                              h10,
                                                                              h10,
                                                                              h10,

                                                                              Padding(
                                                                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                                child: Row(
                                                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                  children: [
                                                                                    InkWell(
                                                                                      onTap: () {
                                                                                        Navigator.pop(context);
                                                                                      },
                                                                                      child: Text(
                                                                                        'No',
                                                                                        style: TextStyle(fontSize: 18, color: klime),
                                                                                      ),
                                                                                    ),
                                                                                    w20,
                                                                                    w20,
                                                                                    InkWell(
                                                                                      onTap: () {
                                                                                        setState(() {
                                                                                          if ( pve?.isOpenList[index] == false) {
                                                                                             pve?.isOpenList[index] = true;
                                                                                            ePv.productAvalibaleOrNot(context, 'Yes', items.SP_ID, items.PRODUCT_NAME, items.PRODUCT_DESCRIPTION, items.BRAND_NAME);
                                                                                            print( pve?.isOpenList[index]);
                                                                                          } else if ( pve?.isOpenList[index] == true) {
                                                                                             pve?.isOpenList[index] = false;
                                                                                            ePv.productAvalibaleOrNot(context, 'No', items.SP_ID, items.PRODUCT_NAME, items.PRODUCT_DESCRIPTION, items.BRAND_NAME);
                                                                                            print( pve?.isOpenList[index]);
                                                                                          }
                                                                                        });

                                                                                        Navigator.pop(context);
                                                                                      },
                                                                                      child: Text(
                                                                                        'Yes',
                                                                                        style: TextStyle(fontSize: 18, color: klime),
                                                                                      ),
                                                                                    ),
                                                                                    w10,
                                                                                  ],
                                                                                ),
                                                                              ),

                                                                              h20,
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ));
                                                              });
                                                        },
                                                        child:  pve?.isOpenList
                                                                        .length ==
                                                                    0 ||
                                                                items?.IS_AVAILABLE ==
                                                                    "null"
                                                            ? CircleAvatar(
                                                                radius: 3,
                                                                backgroundColor:
                                                                    kwhite,
                                                              )
                                                            :  pve?.isOpenList[
                                                                        index] ==
                                                                    true
                                                                ? Icon(
                                                                    Icons
                                                                        .toggle_on,
                                                                    size: 45,
                                                                    color:
                                                                        kgreen500,
                                                                  )
                                                                : Icon(
                                                                    Icons
                                                                        .toggle_off,
                                                                    size: 45,
                                                                    color:
                                                                        klime)),
                                                    w20,
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          PageTransition(
                                                            type: PageTransitionType
                                                                .fade, // Choose your desired animation type
                                                            child:
                                                                UpdateProductAddFrom(
                                                              items: items,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5),
                                                        child: Image.asset(
                                                          ImageAssets.ic_pen,
                                                          height: 28,
                                                          color: klime,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            Text(
                                              maxLines: 1,
                                              items!.PRODUCT_DESCRIPTION
                                                  .toString(),
                                              style: TextStyle(
                                                  color: kblack,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15),
                                            ),
                                            h5,
                                            Divider(
                                              color: grey800,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      });
        }));
  }
}

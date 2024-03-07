import 'package:flutter/material.dart';
import 'package:grape_master/screens/Home/product_details_screen.dart';
import 'package:grape_master/util/image_assets.dart';
import 'package:grape_master/util/util.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../model/home_model/near_by_shop.model.dart';
import '../../model/home_model/product_list_model.dart';
import '../../util/color.dart';
import '../../util/constants.dart';
import 'home_controller.dart';

class ShopDetails extends StatefulWidget {
  const ShopDetails({super.key, required this.nershpdetails});
  final NearByShopModelDATA nershpdetails;

  @override
  State<ShopDetails> createState() => _ShopDetailsState();
}

class _ShopDetailsState extends State<ShopDetails> {
  HomeController? eProvider;

  @override
  void initState() {
    eProvider = Provider.of<HomeController>(context, listen: false);
    init();
    // TODO: implement initState
    super.initState();
  }

  void init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await eProvider?.ProductListApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kgreen,
          title: Text(
            "${widget.nershpdetails.SHOP_NAME}",
            style: TextStyle(
                color: kwhite, fontWeight: FontWeight.w400, fontSize: 22),
          )),
      body: Consumer<HomeController>(builder: (context, ePv, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 251,
                width: double.infinity,
                decoration: BoxDecoration(
                    // image: DecorationImage(
                    //     fit: BoxFit.cover,
                    //     image: AssetImage(ImageAssets.ic_demo_images))
                    ),
                child: Image.network(
                  widget.nershpdetails.SHOP_IMAGE.toString(),
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    // Handle the error, you can return a placeholder image or any other widget
                    return Image.asset(
                      ImageAssets.ic_logo,
                      fit: BoxFit.fill,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 35,
                                    child: ClipOval(
                                      child: Image.network(
                                        widget.nershpdetails.SHOP_OWNER_PHOTO
                                            .toString(),
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          // Handle the error, you can return a placeholder image or any other widget
                                          return Image.asset(
                                              ImageAssets.ic_profile);
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    h10,
                                    Text(
                                      "Shop Name - ${widget.nershpdetails.SHOP_NAME}",
                                      style: TextStyle(
                                          color: kblack,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    h2,
                                    Divider(
                                      color: kblack,
                                    ),
                                    Text(
                                      "Dealer Name -  ${widget.nershpdetails.DEALER_NAME == null ? " -- " : widget.nershpdetails.VILLAGE}",
                                      style: TextStyle(
                                          color: kblack,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    h2,
                                    Divider(
                                      color: kblack,
                                    ),
                                    Text(
                                      "Village Name -  ${widget.nershpdetails.VILLAGE == null ? " --" : widget.nershpdetails.VILLAGE}",
                                      style: TextStyle(
                                          color: kblack,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    h2,
                                    Divider(
                                      color: kblack,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Mobile No - ",
                                          style: TextStyle(
                                              color: kblack,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            Utils().launchPhoneCall(widget.nershpdetails.CONTACT_NUMBER.toString());
                                          },
                                          child: Text(
                                            " ${widget.nershpdetails.CONTACT_NUMBER}",
                                            style: TextStyle(
                                                color: klime,
                                                fontSize: 14,
                                                decoration:
                                                    TextDecoration.underline,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                    h2,
                                    Divider(
                                      color: kblack,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kdeeporange,
                    ),
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: ePv.data?.length,
                        itemBuilder: (BuildContext context, int index) {
                          var blog = ePv.data?[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 35, vertical: 2),
                            child: InkWell(
                              onTap: () {
                                if (blog!['id'] == '1') {
                                  Utils().launchPhoneCall(widget.nershpdetails.CONTACT_NUMBER.toString());
                                  // ePv.callNumber(
                                  //     widget.nershpdetails.CONTACT_NUMBER);
                                } else if (blog!['id'] == '2') {
                                  ePv.openWhatsApp(
                                      widget.nershpdetails.CONTACT_NUMBER);
                                } else if (blog!['id'] == '3') {
                                  ePv.openMap(widget.nershpdetails!.LATITUDE,
                                      widget.nershpdetails!.LONGITUDE);
                                }
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  h2,
                                
                                  Image.asset(
                                    "${blog!['image']}",
                                    height: 35,
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "${blog!['name']}",
                                    style: TextStyle(
                                        color: kblack,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  h2
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ),
              h2,
              Row(
                children: [
                  Expanded(
                      child: Divider(
                    thickness: 0.75,
                    color: kblack,
                  )),
                  w10,
                  Image.asset(ImageAssets.ic_radio_button,
                      height: 22, color: kgreen),
                  w10,
                  Text(
                    "AVAILABLE PRODUCTS",
                    style: TextStyle(
                        color: klighblue,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                  w10,
                  Image.asset(ImageAssets.ic_radio_button,
                      height: 22, color: kgreen),
                  w10,
                  Expanded(
                      child: Divider(
                    thickness: 0.75,
                    color: kblack,
                  )),
                ],
              ),
              Divider(
                color: grey800,
              ),
              h2,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ePv.productListmodel?.data == null
                    ? Column(
                        children: [
                          Image.asset(
                            ImageAssets.ic_no_data_found,
                            height: 120,
                          )
                        ],
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        itemCount: ePv.productListmodel?.data.length,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 15,
                            crossAxisCount: 2),
                        itemBuilder: (context, i) {
                          var product = eProvider?.productListmodel?.data[i];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType
                                        .fade, // Choose your desired animation type
                                    child: ProductDetails(
                                      product: product,
                                      shopId: widget.nershpdetails.SHOP_ID,
                                    )),
                              );
                            },
                            child: ProductList(
                              product: product!,
                            ),
                          );
                        }),
              ),
              h10
            ],
          ),
        );
      }),
    );
  }
}

class ProductList extends StatelessWidget {
  const ProductList({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: kwhite,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            h30,
            Image.network(
              product.productPhoto.toString(),
              height: 100,
            ),
            h10,
            Text("${product.productName}",
                style: TextStyle(
                    color: klighblue,
                    fontWeight: FontWeight.w500,
                    fontSize: 13)),
            h2,
            Text("By ${product.brandName}",
                style: TextStyle(
                    color: klighblue,
                    fontWeight: FontWeight.w500,
                    fontSize: 13)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 40,
                  width: 38,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(5)),
                    color: klime,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      ImageAssets.ic_enquire,
                      height: 8,
                      width: 30,
                      color: kwhite,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

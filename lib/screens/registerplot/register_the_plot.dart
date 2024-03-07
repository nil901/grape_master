import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/auth/LocalString.dart';
import 'package:grape_master/screens/registerplot/plot_controller.dart';
import 'package:grape_master/util/constants.dart';
import 'package:grape_master/util/image_assets.dart';
import 'package:grape_master/util/lodaer.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../util/color.dart';
import 'crop_form.dart';

class RegisterThePlot extends StatefulWidget {
  const RegisterThePlot({Key? key}) : super(key: key);

  @override
  State<RegisterThePlot> createState() => _RegisterThePlotState();
}

class _RegisterThePlotState extends State<RegisterThePlot> {
  plotcnt? eProvider;
  void initState() {
    eProvider = Provider.of<plotcnt>(context, listen: false);
    init();
    // TODO: implement initState
    super.initState();
  }

  void init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await eProvider?.selectedPlotModel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kgreen,
          title: Text(
            txt_crop_g.tr,
            style: TextStyle(
              color: kwhite,
              fontWeight: FontWeight.w400,
              fontSize: 22,
            ),
          ),
        ),
        body: Consumer<plotcnt>(builder: (context, ePv, child) {
          return ePv.selectedcrop?.data == null
              ? Center(
                  child: Loader(),
                )
              : GridView.builder(
                  itemCount: ePv.selectedcrop?.data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.9,
                    mainAxisSpacing: 1,
                    crossAxisCount:
                        3, // You can adjust the cross axis count as needed
                  ),
                  itemBuilder: (context, i) {
                    var item = ePv.selectedcrop?.data[i];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType
                                .fade, // Choose your desired animation type
                            child: CropFormAdd(
                              cropid: item!,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          h12,
                          CircleAvatar(
                            radius: 40.8,
                            backgroundColor: Colors.grey[800],
                            child: CircleAvatar(
                              radius: 40.5,
                              backgroundColor: Colors.white,
                              child: ClipOval(
                                child: Image.network("${item?.cropImage}",
                                    width:
                                        80, // Set the width and height as per your requirement
                                    height: 80,
                                    fit: BoxFit.cover, loadingBuilder:
                                        (BuildContext context, Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: kgreen,
                                        strokeWidth: 1,
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                (loadingProgress
                                                        .expectedTotalBytes ??
                                                    1)
                                            : null,
                                      ),
                                    );
                                  }
                                }, errorBuilder: (BuildContext context,
                                        Object error, StackTrace? stackTrace) {
                                  return Image.asset(ImageAssets.ic_logo);
                                }),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "${item?.cropName}",
                            style: TextStyle(
                              color: kblack,
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
        }));
  }
}

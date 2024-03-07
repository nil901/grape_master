import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/registerplot/plot_controller.dart';
import 'package:grape_master/util/image_assets.dart';
import 'package:grape_master/util/lodaer.dart';
import 'package:grape_master/util/no_activity_found.dart';
import 'package:provider/provider.dart';
import '../../../../model/plot_information_model/disease_information_model.dart';
import '../../../../util/color.dart';
import '../../../../util/constants.dart';
import '../../../auth/LocalString.dart';

class DseaseDetails extends StatefulWidget {
  const DseaseDetails({super.key, required this.items});
  final Disaseinformation items;

  @override
  State<DseaseDetails> createState() => _DseaseDetailsState();
}

class _DseaseDetailsState extends State<DseaseDetails> {
  plotcnt? eProvider;

  @override
  void initState() {
    eProvider = Provider.of<plotcnt>(context, listen: false);
    init();
    // TODO: implement initState
    super.initState();
  }

  void init() async {
    await eProvider?.deseaseindecriptionApi(widget.items.drId);
  }

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
        body: Consumer<plotcnt>(builder: (context, ePv, child) {
        return ePv.diseaseDescreptionModel?.data.length == 0 ?  Center(child: NoActivityFound(),):ePv.diseaseDescreptionModel?.data == null ?Center(child: Loader(),): ListView.builder(
        
              // physics: NeverScrollableScrollPhysics(),
            
              shrinkWrap: true,
              itemCount: ePv.diseaseDescreptionModel?.data.length,
              itemBuilder: (BuildContext context, int index) {
                var items = ePv.diseaseDescreptionModel?.data[index];
        
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: kwhite,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                h2,
                                Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Material(
                                    elevation: 3,
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      height: 240,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: kwhite,
                                        borderRadius: BorderRadius.circular(10),
                                        // image: DecorationImage(
                                        //     fit: BoxFit.fill,
                                        //     image: AssetImage(
                                        //        ImageAssets.ic_logo))),
                                      ),
                                      child: Image.network(
                                        items!.drImg.toString(),
                                        fit: BoxFit.fill,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          // Handle the error, you can return a placeholder image or any other widget
                                          return Image.asset(
                                            ImageAssets.ic_logo,
                                            fit: BoxFit.fill,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                h10,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${items!.drName.toString()} ",
                                      style: TextStyle(
                                          color: kblack,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Divider(
                                      thickness: 0.4,
                                      color: kblack,
                                    ),
                                    Html(
                                      data: items.drDescription,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              });
        }
        ));
  }
}

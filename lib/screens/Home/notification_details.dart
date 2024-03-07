import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:grape_master/model/home_model/notification_model.dart';
import 'package:grape_master/screens/auth/LocalString.dart';
import 'package:grape_master/util/color.dart';
import 'package:grape_master/util/util.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

class NtificationDetails extends StatelessWidget {
  const NtificationDetails({super.key, required this.notification});
  final Notificationlist notification;
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
          body: SingleChildScrollView(
            child: Column(  
              children: [ 
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(15),
                    child: Container( 
                    
                      child: Column(  
                        children: [ 
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container( 
                              height: 220, 
                              width: double.infinity,
                              decoration: BoxDecoration(  
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage( 
                                  fit: BoxFit.fill,
                                  image: NetworkImage(notification.nimage)
                                )
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell( 
                                    onTap: ()async{
                                      final response = await get(
                                                          Uri.parse(
                                                              notification.nimage ??
                                                                  ' '));
                                                      // final bytes = response.bodyBytes;
                                                      final Directory temp =
                                                          await getTemporaryDirectory();
                                                      final File imageFile = File(
                                                          '${temp.path}/report.png');
                                                      await Utils.validateImage(
                                                              notification.nimage 
                                                                  .toString())
                                                          .then((value) async {
                                                        if (value) {
                                                          imageFile
                                                              .writeAsBytesSync(
                                                                  response
                                                                      .bodyBytes);
                                                        } else {
                                                          ByteData bytes =
                                                              await rootBundle.load(
                                                                  'assets/images/areport.png');
                                                          imageFile.writeAsBytes(bytes
                                                              .buffer
                                                              .asUint8List(
                                                                  bytes
                                                                      .offsetInBytes,
                                                                  bytes
                                                                      .lengthInBytes));
                                                        }
                                                        return value;
                                                      });
                                                      var widget;
                                                      Share.shareFiles(
                                                        [
                                                          '${temp.path}/report.png'
                                                        ],
                                                        text:
                                                            '${Utils.stripHtmlIfNeeded(notification!.nimage ?? '')}\n\n\n'
                                                            '${notification!.notificationTitle}\n${notification!..notificationMessage} Get more information download this app\n'
                                                            'https://play.google.com/store/apps/details?id=com.wowinfotech0.grapesmaster',
                                                      );
                                                   
                                                   
                                    },
                                    child: CircleAvatar(
                                       radius: 22,
                                       backgroundColor: kgreen500,
                                      child: CircleAvatar(  
                                        backgroundColor: kwhite,
                                        radius: 21,
                                        child: Image.asset("assets/images/share_icon.webp"),                                        
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Html(data: notification.notificationMessage)
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
    ); 

  }
}
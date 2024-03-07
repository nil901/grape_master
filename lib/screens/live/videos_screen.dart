import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:grape_master/screens/live/aduio.dart';
import 'package:grape_master/screens/live/video_controller.dart';
import 'package:grape_master/util/color.dart';
import 'package:grape_master/util/constants.dart';
import 'package:grape_master/util/image_assets.dart';
import 'package:grape_master/util/util.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:youtube/youtube_thumbnail.dart';

import '../../util/lodaer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show ByteData, rootBundle;

class VideosScreen extends StatefulWidget {
  const VideosScreen({super.key});

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  // postCnt? pve;
  Videocnt? eProvider;
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1; // Current page index
  bool _isLoading = false; // Flag to track if new data is being loaded
  @override
  void initState() {
    eProvider = Provider.of<Videocnt>(context, listen: false);
    init();
    // TODO: implement
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  void init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await eProvider?.sesstionApi();
      await eProvider?.videoCateogeyApi();
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // User has reached the end of the list
      if (!_isLoading) {
        // Avoid making multiple requests simultaneously
        setState(() {
          _isLoading = true;
        });

        // Fetch the next page of data
        fetchData(_currentPage + 1);
      }
    }
  }

  Future<String?> fetchYouTubeThumbnail(String videoId) async {
    final apiKey = 'YOUR_YOUTUBE_API_KEY';
    final thumbnailUrl = 'https://www.googleapis.com/youtube/v3/videos'
        '?part=snippet&id=$videoId&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(thumbnailUrl));
      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> data = json.decode(response.body);
        final thumbnail =
            data['items'][0]['snippet']['thumbnails']['medium']['url'];
        return thumbnail;
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching thumbnail: $e');
      return null;
    }
  }

  void fetchData(int page) {
    // Call your API or data fetching function here with the specified page number
    // After fetching the data, update the state and stop loading
    // For example:
    // ePv.fetchData(page).then((newData) {
    //   setState(() {
    //     ePv.videoListLinkModel?.data.addAll(newData);
    //     _currentPage = page;
    //     _isLoading = false;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Videocnt>(builder: (context, ePv, child) {
      return ePv.videoListLinkModel?.data.isEmpty == 0 ||
              ePv.videoCategoreyModel?.data == null ||
              ePv.videoCategoreyModel?.data.isEmpty == 0 ||
              ePv.videoListLinkModel?.data.isEmpty == null
          ? Center(child: Loader())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 220,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            ePv.sesstionModel!.data[0].liveVideoBanner),
                      ),
                    ),
                  ),
                  h10,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: InkWell(
                        onTap: () {
                          ePv.openurl(ePv.sesstionModel!.data[0].liveVideoUrl);
                          log(ePv.sesstionModel!.data[0].liveVideoUrl);
                        },
                        child: BlinkingContainer()),
                  ),
                  h5,
                  Divider(),
                  SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: ePv.videoCategoreyModel!.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var item = ePv.videoCategoreyModel?.data[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: InkWell(
                            onTap: () async {
                              await ePv?.video(item?.vcId);
                            },
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 34,
                                  backgroundColor: kwhite,
                                  backgroundImage: NetworkImage(
                                    "${item?.vcImage}",
                                  ),
                                ),
                                h5,
                                Text(
                                  "${item?.vcName}",
                                  style: TextStyle(
                                    color: kblack,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: ePv.videoListLinkModel!.data.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        // var data = ePv.videoListLinkModel?.data[index];
                        if (index < ePv.videoListLinkModel!.data.length) {
                          var data = ePv.videoListLinkModel?.data[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        ePv.openurl(
                                            'https://youtube.com/live/${data?.videoUrl}');
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 80,
                                        width: 150,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    "${YoutubeThumbnail(youtubeId: data?.videoUrl).hd()}"))),
                                        child: Image.asset(
                                          ImageAssets.ic_play_button,
                                          height: 35,
                                          color: klime,
                                        ),
                                      ),
                                    ),
                                    w14,
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              ePv.openurl(YoutubeThumbnail(
                                                      youtubeId: data?.videoUrl)
                                                  .hd());
                                            },
                                            child: Text(
                                                "${data?.videoTitle.toString()}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17)),
                                          ),
                                          h10,
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: InkWell(
                                              onTap: () async {
                                                String imagevedio =
                                                    YoutubeThumbnail(
                                                            youtubeId:
                                                                data?.videoUrl)
                                                        .hd();
                                                print(imagevedio);

                                                // Check if the thumbnail URL is valid

                                              
                                                  final response =
                                                      await http.get(Uri.parse(
                                                         imagevedio));
                                                  if (response.statusCode ==
                                                      200) {
                                                        final Directory temp =
                                                        await getTemporaryDirectory();
                                                    final File imageFile = File(
                                                        '${temp.path}/report.png');
                                                    await Utils.validateImage(
                                                          imagevedio
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
                                                          'GrapeMaster\nVideo Title :- ${data?.videoTitle}\nVideo Description- ${data?.videoDescription == null ?"":data?.videoDescription}\nPlease download this app .\n'
                                                          'https://play.google.com/store/apps/details?id=com.wowinfotech0.grapesmaster',
                                                    );
                                                      }},
                                            
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Image.asset(
                                                    ImageAssets.ic_forward_dark,
                                                    height: 28,
                                                    color: kgreen,
                                                  )),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                )
                              ],
                            ),
                          );
                        } else {
                          return _buildLoadingIndicator();
                        }
                      })
                ],
              ),
            );
    });
  }

  Widget _buildLoadingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

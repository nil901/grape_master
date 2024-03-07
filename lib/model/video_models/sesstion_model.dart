// To parse this JSON data, do
//
//     final sesstionModel = sesstionModelFromJson(jsonString);

import 'dart:convert';

SesstionModel sesstionModelFromJson(String str) => SesstionModel.fromJson(json.decode(str));

String sesstionModelToJson(SesstionModel data) => json.encode(data.toJson());

class SesstionModel {
    String responseCode;
    String responseMessage;
    dynamic otp;
    dynamic staticOtp;
    List<sesstion> data;
    List<Data1> data1;

    SesstionModel({
        required this.responseCode,
        required this.responseMessage,
        required this.otp,
        required this.staticOtp,
        required this.data,
        required this.data1,
    });

    factory SesstionModel.fromJson(Map<String, dynamic> json) => SesstionModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        otp: json["Otp"],
        staticOtp: json["Static_Otp"],
        data: List<sesstion>.from(json["DATA"].map((x) => sesstion.fromJson(x))),
        data1: List<Data1>.from(json["DATA1"].map((x) => Data1.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ResponseCode": responseCode,
        "ResponseMessage": responseMessage,
        "Otp": otp,
        "Static_Otp": staticOtp,
        "DATA": List<dynamic>.from(data.map((x) => x.toJson())),
        "DATA1": List<dynamic>.from(data1.map((x) => x.toJson())),
    };
}

class sesstion {
    int row;
    int videoId;
    String videoTitle;
    String liveVideoUrl;
    String liveVideoBanner;
    String status;
    String regDate;

    sesstion({
        required this.row,
        required this.videoId,
        required this.videoTitle,
        required this.liveVideoUrl,
        required this.liveVideoBanner,
        required this.status,
        required this.regDate,
    });

    factory sesstion.fromJson(Map<String, dynamic> json) => sesstion(
        row: json["Row"],
        videoId: json["VIDEO_ID"],
        videoTitle: json["VIDEO_TITLE"],
        liveVideoUrl: json["LIVE_VIDEO_URL"],
        liveVideoBanner: json["LIVE_VIDEO_BANNER"],
        status: json["STATUS"],
        regDate: json["REG_DATE"],
    );

    Map<String, dynamic> toJson() => {
        "Row": row,
        "VIDEO_ID": videoId,
        "VIDEO_TITLE": videoTitle,
        "LIVE_VIDEO_URL": liveVideoUrl,
        "LIVE_VIDEO_BANNER": liveVideoBanner,
        "STATUS": status,
        "REG_DATE": regDate,
    };
}

class Data1 {
    int column1;

    Data1({
        required this.column1,
    });

    factory Data1.fromJson(Map<String, dynamic> json) => Data1(
        column1: json["Column1"],
    );

    Map<String, dynamic> toJson() => {
        "Column1": column1,
    };
}

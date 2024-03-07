// To parse this JSON data, do
//
//     final videoListLinkModel = videoListLinkModelFromJson(jsonString);

import 'dart:convert';

VideoListLinkModel videoListLinkModelFromJson(String str) => VideoListLinkModel.fromJson(json.decode(str));

String videoListLinkModelToJson(VideoListLinkModel data) => json.encode(data.toJson());

class VideoListLinkModel {
    String responseCode;
    String responseMessage;
    dynamic otp;
    dynamic staticOtp;
    List<Datum> data;
    List<Data1> data1;

    VideoListLinkModel({
        required this.responseCode,
        required this.responseMessage,
        required this.otp,
        required this.staticOtp,
        required this.data,
        required this.data1,
    });

    factory VideoListLinkModel.fromJson(Map<String, dynamic> json) => VideoListLinkModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        otp: json["Otp"],
        staticOtp: json["Static_Otp"],
        data: List<Datum>.from(json["DATA"].map((x) => Datum.fromJson(x))),
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

class Datum {
    int row;
    int videoId;
    String videoTitle;
    Status status;
    RegDate regDate;
    dynamic videoDescription;
    String videoUrl;
    VideoType videoType;
    String videoImage;

    Datum({
        required this.row,
        required this.videoId,
        required this.videoTitle,
        required this.status,
        required this.regDate,
        required this.videoDescription,
        required this.videoUrl,
        required this.videoType,
        required this.videoImage,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        row: json["Row"],
        videoId: json["VIDEO_ID"],
        videoTitle: json["VIDEO_TITLE"],
        status: statusValues.map[json["STATUS"]]!,
        regDate: regDateValues.map[json["REG_DATE"]]!,
        videoDescription: json["VIDEO_DESCRIPTION"],
        videoUrl: json["VIDEO_URL"],
        videoType: videoTypeValues.map[json["VIDEO_TYPE"]]!,
        videoImage: json["VIDEO_IMAGE"],
    );

    Map<String, dynamic> toJson() => {
        "Row": row,
        "VIDEO_ID": videoId,
        "VIDEO_TITLE": videoTitle,
        "STATUS": statusValues.reverse[status],
        "REG_DATE": regDateValues.reverse[regDate],
        "VIDEO_DESCRIPTION": videoDescription,
        "VIDEO_URL": videoUrl,
        "VIDEO_TYPE": videoTypeValues.reverse[videoType],
        "VIDEO_IMAGE": videoImage,
    };
}

enum RegDate {
    THE_01092022,
    THE_02082022,
    THE_09032023,
    THE_09082023,
    THE_14042023,
    THE_26022023
}

final regDateValues = EnumValues({
    "01/09/2022": RegDate.THE_01092022,
    "02/08/2022": RegDate.THE_02082022,
    "09/03/2023": RegDate.THE_09032023,
    "09/08/2023": RegDate.THE_09082023,
    "14/04/2023": RegDate.THE_14042023,
    "26/02/2023": RegDate.THE_26022023
});

enum Status {
    ACTIVE,
    DEACTIVE
}

final statusValues = EnumValues({
    "Active": Status.ACTIVE,
    "Deactive": Status.DEACTIVE
});

enum VideoType {
    OLD
}

final videoTypeValues = EnumValues({
    "Old": VideoType.OLD
});

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

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}

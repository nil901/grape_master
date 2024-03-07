// To parse this JSON data, do
//
//     final myPostModel = myPostModelFromJson(jsonString);

import 'dart:convert';

MyPostModel myPostModelFromJson(String str) => MyPostModel.fromJson(json.decode(str));

String myPostModelToJson(MyPostModel data) => json.encode(data.toJson());

class MyPostModel {
    String responseCode;
    String responseMessage;
    dynamic otp;
    dynamic staticOtp;
    List<Datum> data;
    List<Data1> data1;

    MyPostModel({
        required this.responseCode,
        required this.responseMessage,
        required this.otp,
        required this.staticOtp,
        required this.data,
        required this.data1,
    });

    factory MyPostModel.fromJson(Map<String, dynamic> json) => MyPostModel(
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
    int postId;
    String fullName;
    String mobileNumber;
    String profilePhoto;
    String postImage;
    String postDescription;
    dynamic postTitle;
    String regDate;
    String cropName;
    int likeCount;
    int commentCount;
    String isLike;
    int cropId;

    Datum({
        required this.row,
        required this.postId,
        required this.fullName,
        required this.mobileNumber,
        required this.profilePhoto,
        required this.postImage,
        required this.postDescription,
        required this.postTitle,
        required this.regDate,
        required this.cropName,
        required this.likeCount,
        required this.commentCount,
        required this.isLike,
        required this.cropId,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        row: json["Row"],
        postId: json["POST_ID"],
        fullName: json["FULL_NAME"],
        mobileNumber: json["MOBILE_NUMBER"],
        profilePhoto: json["PROFILE_PHOTO"],
        postImage: json["POST_IMAGE"],
        postDescription: json["POST_DESCRIPTION"],
        postTitle: json["POST_TITLE"],
        regDate: json["REG_DATE"],
        cropName: json["CROP_NAME"],
        likeCount: json["LIKE_COUNT"],
        commentCount: json["COMMENT_COUNT"],
        isLike: json["IS_LIKE"],
        cropId: json["CROP_ID"],
    );

    Map<String, dynamic> toJson() => {
        "Row": row,
        "POST_ID": postId,
        "FULL_NAME": fullName,
        "MOBILE_NUMBER": mobileNumber,
        "PROFILE_PHOTO": profilePhoto,
        "POST_IMAGE": postImage,
        "POST_DESCRIPTION": postDescription,
        "POST_TITLE": postTitle,
        "REG_DATE": regDate,
        "CROP_NAME": cropName,
        "LIKE_COUNT": likeCount,
        "COMMENT_COUNT": commentCount,
        "IS_LIKE": isLike,
        "CROP_ID": cropId,
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

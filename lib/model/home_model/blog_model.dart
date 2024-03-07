// To parse this JSON data, do
//
//     final blogListModel = blogListModelFromJson(jsonString);

import 'dart:convert';

BlogListModel blogListModelFromJson(String str) => BlogListModel.fromJson(json.decode(str));

String blogListModelToJson(BlogListModel data) => json.encode(data.toJson());

class BlogListModel {
    String responseCode;
    String responseMessage;
    dynamic otp;
    dynamic staticOtp;
    List<BlogModel> data;
    List<Data1> data1;

    BlogListModel({
        required this.responseCode,
        required this.responseMessage,
        required this.otp,
        required this.staticOtp,
        required this.data,
        required this.data1,
    });

    factory BlogListModel.fromJson(Map<String, dynamic> json) => BlogListModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        otp: json["Otp"],
        staticOtp: json["Static_Otp"],
        data: List<BlogModel>.from(json["DATA"].map((x) => BlogModel.fromJson(x))),
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

class BlogModel {
    int row;
    int postId;
    String postImage;
    String postDescription;
    String postTitle;
    String regDate;
    int likeCount;
    int commentCount;
    String isLike;

    BlogModel({
        required this.row,
        required this.postId,
        required this.postImage,
        required this.postDescription,
        required this.postTitle,
        required this.regDate,
        required this.likeCount,
        required this.commentCount,
        required this.isLike,
    });

    factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
        row: json["Row"],
        postId: json["POST_ID"],
        postImage: json["POST_IMAGE"],
        postDescription: json["POST_DESCRIPTION"],
        postTitle: json["POST_TITLE"],
        regDate: json["REG_DATE"],
        likeCount: json["LIKE_COUNT"],
        commentCount: json["COMMENT_COUNT"],
        isLike:json["IS_LIKE"],
    );

    Map<String, dynamic> toJson() => {
        "Row": row,
        "POST_ID": postId,
        "POST_IMAGE": postImage,
        "POST_DESCRIPTION": postDescription,
        "POST_TITLE": postTitle,
        "REG_DATE": regDate,
        "LIKE_COUNT": likeCount,
        "COMMENT_COUNT": commentCount,
        "IS_LIKE": isLike,
    };
}

// enum IsLike {
//     NO,
//     YES
// }

// final isLikeValues = EnumValues({
//     "No": IsLike.NO,
//     "Yes": IsLike.YES
// });

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

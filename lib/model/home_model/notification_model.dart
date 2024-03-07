// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
    String responseCode;
    String responseMessage;
    dynamic otp;
    dynamic staticOtp;
    List<Notificationlist> data;
    List<Data1> data1;

    NotificationModel({
        required this.responseCode,
        required this.responseMessage,
        required this.otp,
        required this.staticOtp,
        required this.data,
        required this.data1,
    });

    factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        otp: json["Otp"],
        staticOtp: json["Static_Otp"],
        data: List<Notificationlist>.from(json["DATA"].map((x) => Notificationlist.fromJson(x))),
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

class Notificationlist {
    int row;
    int notificationId;
    String notificationTitle;
    String notificationMessage;
    String nimage;
    String regDate;
    int? notificationLike;
    Note noteView;
    Note noteLike;
    int unseenCount;
    dynamic postId;

    Notificationlist({
        required this.row,
        required this.notificationId,
        required this.notificationTitle,
        required this.notificationMessage,
        required this.nimage,
        required this.regDate,
        required this.notificationLike,
        required this.noteView,
        required this.noteLike,
        required this.unseenCount,
        required this.postId,
    });

    factory Notificationlist.fromJson(Map<String, dynamic> json) => Notificationlist(
        row: json["Row"],
        notificationId: json["NOTIFICATION_ID"],
        notificationTitle: json["NOTIFICATION_TITLE"],
        notificationMessage: json["NOTIFICATION_MESSAGE"],
        nimage: json["NIMAGE"],
        regDate: json["REG_DATE"],
        notificationLike: json["NOTIFICATION_LIKE"],
        noteView: noteValues.map[json["NOTE_VIEW"]]!,
        noteLike: noteValues.map[json["NOTE_LIKE"]]!,
        unseenCount: json["UNSEEN_COUNT"],
        postId: json["POST_ID"],
    );

    Map<String, dynamic> toJson() => {
        "Row": row,
        "NOTIFICATION_ID": notificationId,
        "NOTIFICATION_TITLE": notificationTitle,
        "NOTIFICATION_MESSAGE": notificationMessage,
        "NIMAGE": nimage,
        "REG_DATE": regDate,
        "NOTIFICATION_LIKE": notificationLike,
        "NOTE_VIEW": noteValues.reverse[noteView],
        "NOTE_LIKE": noteValues.reverse[noteLike],
        "UNSEEN_COUNT": unseenCount,
        "POST_ID": postId,
    };
}

enum Note {
    NO,
    YES
}

final noteValues = EnumValues({
    "No": Note.NO,
    "Yes": Note.YES
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

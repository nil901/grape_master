// To parse this JSON data, do
//
//     final videoCategoreyModel = videoCategoreyModelFromJson(jsonString);

import 'dart:convert';

VideoCategoreyModel videoCategoreyModelFromJson(String str) => VideoCategoreyModel.fromJson(json.decode(str));

String videoCategoreyModelToJson(VideoCategoreyModel data) => json.encode(data.toJson());

class VideoCategoreyModel {
    String responseCode;
    String responseMessage;
    dynamic otp;
    dynamic staticOtp;
    List<Datum> data;
    List<Data1> data1;

    VideoCategoreyModel({
        required this.responseCode,
        required this.responseMessage,
        required this.otp,
        required this.staticOtp,
        required this.data,
        required this.data1,
    });

    factory VideoCategoreyModel.fromJson(Map<String, dynamic> json) => VideoCategoreyModel(
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
    int vcId;
    String vcName;
    String vcImage;

    Datum({
        required this.vcId,
        required this.vcName,
        required this.vcImage,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        vcId: json["VC_ID"],
        vcName: json["VC_NAME"],
        vcImage: json["VC_IMAGE"],
    );

    Map<String, dynamic> toJson() => {
        "VC_ID": vcId,
        "VC_NAME": vcName,
        "VC_IMAGE": vcImage,
    };
}

class Data1 {
    int table1;

    Data1({
        required this.table1,
    });

    factory Data1.fromJson(Map<String, dynamic> json) => Data1(
        table1: json["TABLE1"],
    );

    Map<String, dynamic> toJson() => {
        "TABLE1": table1,
    };
}

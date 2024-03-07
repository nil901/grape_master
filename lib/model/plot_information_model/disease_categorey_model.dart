// To parse this JSON data, do
//
//     final diseasecategoreyModel = diseasecategoreyModelFromJson(jsonString);

import 'dart:convert';

DiseasecategoreyModel diseasecategoreyModelFromJson(String str) => DiseasecategoreyModel.fromJson(json.decode(str));

String diseasecategoreyModelToJson(DiseasecategoreyModel data) => json.encode(data.toJson());

class DiseasecategoreyModel {
    String responseCode;
    String responseMessage;
    dynamic otp;
    dynamic staticOtp;
    List<Datum> data;
    List<Data1> data1;

    DiseasecategoreyModel({
        required this.responseCode,
        required this.responseMessage,
        required this.otp,
        required this.staticOtp,
        required this.data,
        required this.data1,
    });

    factory DiseasecategoreyModel.fromJson(Map<String, dynamic> json) => DiseasecategoreyModel(
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
    int dcId;
    String dcName;
    String dcImage;

    Datum({
        required this.dcId,
        required this.dcName,
        required this.dcImage,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        dcId: json["DC_ID"],
        dcName: json["DC_NAME"],
        dcImage: json["DC_IMAGE"],
    );

    Map<String, dynamic> toJson() => {
        "DC_ID": dcId,
        "DC_NAME": dcName,
        "DC_IMAGE": dcImage,
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

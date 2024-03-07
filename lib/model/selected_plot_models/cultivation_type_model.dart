// To parse this JSON data, do
//
//     final cultivationTypeModel = cultivationTypeModelFromJson(jsonString);

import 'dart:convert';

CultivationTypeModel cultivationTypeModelFromJson(String str) => CultivationTypeModel.fromJson(json.decode(str));

String cultivationTypeModelToJson(CultivationTypeModel data) => json.encode(data.toJson());

class CultivationTypeModel {
    String responseCode;
    String responseMessage;
    dynamic otp;
    dynamic staticOtp;
    List<Datum> data;
    List<Data1> data1;

    CultivationTypeModel({
        required this.responseCode,
        required this.responseMessage,
        required this.otp,
        required this.staticOtp,
        required this.data,
        required this.data1,
    });

    factory CultivationTypeModel.fromJson(Map<String, dynamic> json) => CultivationTypeModel(
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
    int chataniId;
    String chataniType;

    Datum({
        required this.chataniId,
        required this.chataniType,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        chataniId: json["CHATANI_ID"],
        chataniType: json["CHATANI_TYPE"],
    );

    Map<String, dynamic> toJson() => {
        "CHATANI_ID": chataniId,
        "CHATANI_TYPE": chataniType,
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

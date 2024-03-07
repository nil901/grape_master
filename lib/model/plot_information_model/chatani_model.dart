// To parse this JSON data, do
//
//     final chatanitypeModel = chatanitypeModelFromJson(jsonString);

import 'dart:convert';

ChatanitypeModel chatanitypeModelFromJson(String str) => ChatanitypeModel.fromJson(json.decode(str));

String chatanitypeModelToJson(ChatanitypeModel data) => json.encode(data.toJson());

class ChatanitypeModel {
    String responseCode;
    String responseMessage;
    dynamic otp;
    dynamic staticOtp;
    List<chatani> data;
    List<Data1> data1;

    ChatanitypeModel({
        required this.responseCode,
        required this.responseMessage,
        required this.otp,
        required this.staticOtp,
        required this.data,
        required this.data1,
    });

    factory ChatanitypeModel.fromJson(Map<String, dynamic> json) => ChatanitypeModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        otp: json["Otp"],
        staticOtp: json["Static_Otp"],
        data: List<chatani>.from(json["DATA"].map((x) => chatani.fromJson(x))),
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

class chatani {
    int chataniId;
    String chataniType;

    chatani({
        required this.chataniId,
        required this.chataniType,
    });

    factory chatani.fromJson(Map<String, dynamic> json) => chatani(
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

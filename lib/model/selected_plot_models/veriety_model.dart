// To parse this JSON data, do
//
//     final varietyModel = varietyModelFromJson(jsonString);

import 'dart:convert';

VarietyModel varietyModelFromJson(String str) => VarietyModel.fromJson(json.decode(str));

String varietyModelToJson(VarietyModel data) => json.encode(data.toJson());

class VarietyModel {
    String responseCode;
    String responseMessage;
    dynamic otp;
    dynamic staticOtp;
    List<VarietyClass> data;
    List<Data1> data1;

    VarietyModel({
        required this.responseCode,
        required this.responseMessage,
        required this.otp,
        required this.staticOtp,
        required this.data,
        required this.data1,
    });

    factory VarietyModel.fromJson(Map<String, dynamic> json) => VarietyModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        otp: json["Otp"],
        staticOtp: json["Static_Otp"],
        data: List<VarietyClass>.from(json["DATA"].map((x) => VarietyClass.fromJson(x))),
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

class VarietyClass {
    int cropvarietyId;
    String cropvarietyName;

    VarietyClass({
        required this.cropvarietyId,
        required this.cropvarietyName,
    });

    factory VarietyClass.fromJson(Map<String, dynamic> json) => VarietyClass(
        cropvarietyId: json["CROPVARIETY_ID"],
        cropvarietyName: json["CROPVARIETY_NAME"],
    );

    Map<String, dynamic> toJson() => {
        "CROPVARIETY_ID": cropvarietyId,
        "CROPVARIETY_NAME": cropvarietyName,
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

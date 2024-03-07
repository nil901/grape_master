// To parse this JSON data, do
//
//     final versionCodeModel = versionCodeModelFromJson(jsonString);

import 'dart:convert';

VersionCodeModel versionCodeModelFromJson(String str) => VersionCodeModel.fromJson(json.decode(str));

String versionCodeModelToJson(VersionCodeModel data) => json.encode(data.toJson());

class VersionCodeModel {
    String responseCode;
    String responseMessage;
    dynamic otp;
    dynamic staticOtp;
    List<VersionCode> data;
    List<Data1> data1;

    VersionCodeModel({
        required this.responseCode,
        required this.responseMessage,
        required this.otp,
        required this.staticOtp,
        required this.data,
        required this.data1,
    });

    factory VersionCodeModel.fromJson(Map<String, dynamic> json) => VersionCodeModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        otp: json["Otp"],
        staticOtp: json["Static_Otp"],
        data: List<VersionCode>.from(json["DATA"].map((x) => VersionCode.fromJson(x))),
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

class VersionCode {
    String versionCode;
    String dealerStatus;
    String consultantPassword;
    String adminId;

    VersionCode({
        required this.versionCode,
        required this.dealerStatus,
        required this.consultantPassword,
        required this.adminId,
    });

    factory VersionCode.fromJson(Map<String, dynamic> json) => VersionCode(
        versionCode: json["VERSION_CODE"],
        dealerStatus: json["DEALER_STATUS"],
        consultantPassword: json["CONSULTANT_PASSWORD"]  == null ? "":json["CONSULTANT_PASSWORD"],
        adminId: json["ADMIN_ID"] == null ? "":json["ADMIN_ID"],
    );

    Map<String, dynamic> toJson() => {
        "VERSION_CODE": versionCode,
        "DEALER_STATUS": dealerStatus,
        "CONSULTANT_PASSWORD": consultantPassword,
        "ADMIN_ID": adminId,
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

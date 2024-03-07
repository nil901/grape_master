// To parse this JSON data, do
//
//     final landTypeModel = landTypeModelFromJson(jsonString);

import 'dart:convert';

LandTypeModel landTypeModelFromJson(String str) => LandTypeModel.fromJson(json.decode(str));

String landTypeModelToJson(LandTypeModel data) => json.encode(data.toJson());

class LandTypeModel {
    String responseCode;
    String responseMessage;
    dynamic otp;
    dynamic staticOtp;
    List<LandModel> data;
    List<Data1> data1;

    LandTypeModel({
        required this.responseCode,
        required this.responseMessage,
        required this.otp,
        required this.staticOtp,
        required this.data,
        required this.data1,
    });

    factory LandTypeModel.fromJson(Map<String, dynamic> json) => LandTypeModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        otp: json["Otp"],
        staticOtp: json["Static_Otp"],
        data: List<LandModel>.from(json["DATA"].map((x) => LandModel.fromJson(x))),
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

class LandModel {
    int stId;
    String stName;

    LandModel({
        required this.stId,
        required this.stName,
    });

    factory LandModel.fromJson(Map<String, dynamic> json) => LandModel(
        stId: json["ST_ID"],
        stName: json["ST_NAME"],
    );

    Map<String, dynamic> toJson() => {
        "ST_ID": stId,
        "ST_NAME": stName,
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

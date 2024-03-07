// To parse this JSON data, do
//
//     final talukaListByModel = talukaListByModelFromJson(jsonString);

import 'dart:convert';

TalukaListByModel talukaListByModelFromJson(String str) => TalukaListByModel.fromJson(json.decode(str));

String talukaListByModelToJson(TalukaListByModel data) => json.encode(data.toJson());

class TalukaListByModel {
    String responseCode;
    String responseMessage;
    dynamic otp;
    dynamic staticOtp;
    List<Datum> data;
    List<Data1> data1;

    TalukaListByModel({
        required this.responseCode,
        required this.responseMessage,
        required this.otp,
        required this.staticOtp,
        required this.data,
        required this.data1,
    });

    factory TalukaListByModel.fromJson(Map<String, dynamic> json) => TalukaListByModel(
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
    int talukaId;
    String talukaName;
    int cityId;
    String status;

    Datum({
        required this.talukaId,
        required this.talukaName,
        required this.cityId,
        required this.status,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        talukaId: json["TALUKA_ID"],
        talukaName: json["TALUKA_NAME"],
        cityId: json["CITY_ID"],
        status: json["STATUS"],
    );

    Map<String, dynamic> toJson() => {
        "TALUKA_ID": talukaId,
        "TALUKA_NAME": talukaName,
        "CITY_ID": cityId,
        "STATUS": status,
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

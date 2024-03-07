// To parse this JSON data, do
//
//     final cityByStateListModel = cityByStateListModelFromJson(jsonString);

import 'dart:convert';

CityByStateListModel cityByStateListModelFromJson(String str) => CityByStateListModel.fromJson(json.decode(str));

String cityByStateListModelToJson(CityByStateListModel data) => json.encode(data.toJson());

class CityByStateListModel {
    String responseCode;
    String responseMessage;
    dynamic otp;
    dynamic staticOtp;
    List<cityList> data;
    List<Data1> data1;

    CityByStateListModel({
        required this.responseCode,
        required this.responseMessage,
        required this.otp,
        required this.staticOtp,
        required this.data,
        required this.data1,
    });

    factory CityByStateListModel.fromJson(Map<String, dynamic> json) => CityByStateListModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        otp: json["Otp"],
        staticOtp: json["Static_Otp"],
        data: List<cityList>.from(json["DATA"].map((x) => cityList.fromJson(x))),
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

class cityList {
    int cityId;
    String cityName;
    int stateId;
    String status;

    cityList({
        required this.cityId,
        required this.cityName,
        required this.stateId,
        required this.status,
    });

    factory cityList.fromJson(Map<String, dynamic> json) => cityList(
        cityId: json["CITY_ID"],
        cityName: json["CITY_NAME"],
        stateId: json["STATE_ID"],
        status: json["STATUS"],
    );

    Map<String, dynamic> toJson() => {
        "CITY_ID": cityId,
        "CITY_NAME": cityName,
        "STATE_ID": stateId,
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

// To parse this JSON data, do
//
//     final dairyListModel = dairyListModelFromJson(jsonString);

import 'dart:convert';

DairyListModel dairyListModelFromJson(String str) => DairyListModel.fromJson(json.decode(str));

String dairyListModelToJson(DairyListModel data) => json.encode(data.toJson());

class DairyListModel {
    String responseCode;
    String responseMessage;
    dynamic otp;
    dynamic staticOtp;
    List<DairyList> data;
    List<Data1> data1;

    DairyListModel({
        required this.responseCode,
        required this.responseMessage,
        required this.otp,
        required this.staticOtp,
        required this.data,
        required this.data1,
    });

    factory DairyListModel.fromJson(Map<String, dynamic> json) => DairyListModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        otp: json["Otp"],
        staticOtp: json["Static_Otp"],
        data: List<DairyList>.from(json["DATA"].map((x) => DairyList.fromJson(x))),
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

class DairyList {
    int row;
    int pdId;
    String title;
    String description;
    String? funParameter;
    String? diseasePest;
    String? phi;
    String status;
    String dayName;
    String regDate;

    DairyList({
        required this.row,
        required this.pdId,
        required this.title,
        required this.description,
        required this.funParameter,
        required this.diseasePest,
        required this.phi,
        required this.status,
        required this.dayName,
        required this.regDate,
    });

    factory DairyList.fromJson(Map<String, dynamic> json) => DairyList(
        row: json["Row"],
        pdId: json["PD_ID"],
        title: json["TITLE"],
        description: json["DESCRIPTION"],
        funParameter: json["FUN_PARAMETER"],
        diseasePest: json["DISEASE_PEST"],
        phi: json["PHI"],
        status: json["STATUS"],
        dayName: json["DAY_NAME"],
        regDate: json["REG_DATE"],
    );

    Map<String, dynamic> toJson() => {
        "Row": row,
        "PD_ID": pdId,
        "TITLE": title,
        "DESCRIPTION": description,
        "FUN_PARAMETER": funParameter,
        "DISEASE_PEST": diseasePest,
        "PHI": phi,
        "STATUS": status,
        "DAY_NAME": dayName,
        "REG_DATE": regDate,
    };
}

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

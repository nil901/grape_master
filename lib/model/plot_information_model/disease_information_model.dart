// To parse this JSON data, do
//
//     final diseaseInformationModel = diseaseInformationModelFromJson(jsonString);

import 'dart:convert';

DiseaseInformationModel diseaseInformationModelFromJson(String str) => DiseaseInformationModel.fromJson(json.decode(str));

String diseaseInformationModelToJson(DiseaseInformationModel data) => json.encode(data.toJson());

class DiseaseInformationModel {
    String responseCode;
    String responseMessage;
    dynamic otp;
    dynamic staticOtp;
    List<Disaseinformation> data;
    List<Data1> data1;

    DiseaseInformationModel({
        required this.responseCode,
        required this.responseMessage,
        required this.otp,
        required this.staticOtp,
        required this.data,
        required this.data1,
    });

    factory DiseaseInformationModel.fromJson(Map<String, dynamic> json) => DiseaseInformationModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        otp: json["Otp"],
        staticOtp: json["Static_Otp"],
        data: List<Disaseinformation>.from(json["DATA"].map((x) => Disaseinformation.fromJson(x))),
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

class Disaseinformation {
    int row;
    int drId;
    String drName;
    String drDescription;
    String drImg;

    Disaseinformation({
        required this.row,
        required this.drId,
        required this.drName,
        required this.drDescription,
        required this.drImg,
    });

    factory Disaseinformation.fromJson(Map<String, dynamic> json) => Disaseinformation(
        row: json["Row"],
        drId: json["DR_ID"],
        drName: json["DR_NAME"],
        drDescription: json["DR_DESCRIPTION"],
        drImg: json["DR_IMG"],
    );

    Map<String, dynamic> toJson() => {
        "Row": row,
        "DR_ID": drId,
        "DR_NAME": drName,
        "DR_DESCRIPTION": drDescription,
        "DR_IMG": drImg,
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

// To parse this JSON data, do
//
//     final cropSelectedModel = cropSelectedModelFromJson(jsonString);

import 'dart:convert';

CropSelectedModel cropSelectedModelFromJson(String str) => CropSelectedModel.fromJson(json.decode(str));

String cropSelectedModelToJson(CropSelectedModel data) => json.encode(data.toJson());

class CropSelectedModel {
    String responseCode;
    String responseMessage;
    dynamic otp;
    dynamic staticOtp;
    List<CropModel> data;
    List<Data1> data1;

    CropSelectedModel({
        required this.responseCode,
        required this.responseMessage,
        required this.otp,
        required this.staticOtp,
        required this.data,
        required this.data1,
    });

    factory CropSelectedModel.fromJson(Map<String, dynamic> json) => CropSelectedModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        otp: json["Otp"],
        staticOtp: json["Static_Otp"],
        data: List<CropModel>.from(json["DATA"].map((x) => CropModel.fromJson(x))),
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

class CropModel {
    int cropId;
    String cropName;
    String cropImage;

    CropModel({
        required this.cropId,
        required this.cropName,
        required this.cropImage,
    });

    factory CropModel.fromJson(Map<String, dynamic> json) => CropModel(
        cropId: json["CROP_ID"],
        cropName: json["CROP_NAME"],
        cropImage: json["CROP_IMAGE"],
    );

    Map<String, dynamic> toJson() => {
        "CROP_ID": cropId,
        "CROP_NAME": cropName,
        "CROP_IMAGE": cropImage,
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

// To parse this JSON data, do
//
//     final faqCategoreyModel = faqCategoreyModelFromJson(jsonString);

import 'dart:convert';

FaqCategoreyModel faqCategoreyModelFromJson(String str) => FaqCategoreyModel.fromJson(json.decode(str));

String faqCategoreyModelToJson(FaqCategoreyModel data) => json.encode(data.toJson());

class FaqCategoreyModel {
    String responseCode;
    String responseMessage;
    dynamic otp;
    dynamic staticOtp;
    List<FaqCategorey> data;
    List<Data1> data1;

    FaqCategoreyModel({
        required this.responseCode,
        required this.responseMessage,
        required this.otp,
        required this.staticOtp,
        required this.data,
        required this.data1,
    });

    factory FaqCategoreyModel.fromJson(Map<String, dynamic> json) => FaqCategoreyModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        otp: json["Otp"],
        staticOtp: json["Static_Otp"],
        data: List<FaqCategorey>.from(json["DATA"].map((x) => FaqCategorey.fromJson(x))),
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

class FaqCategorey {
    int fqcId;
    String fqcName;
    String fqcImage;

    FaqCategorey({
        required this.fqcId,
        required this.fqcName,
        required this.fqcImage,
    });

    factory FaqCategorey.fromJson(Map<String, dynamic> json) => FaqCategorey(
        fqcId: json["FQC_ID"],
        fqcName: json["FQC_NAME"],
        fqcImage: json["FQC_IMAGE"],
    );

    Map<String, dynamic> toJson() => {
        "FQC_ID": fqcId,
        "FQC_NAME": fqcName,
        "FQC_IMAGE": fqcImage,
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

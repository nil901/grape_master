// To parse this JSON data, do
//
//     final submitAnswerModel = submitAnswerModelFromJson(jsonString);

import 'dart:convert';

SubmitAnswerModel submitAnswerModelFromJson(String str) => SubmitAnswerModel.fromJson(json.decode(str));

String submitAnswerModelToJson(SubmitAnswerModel data) => json.encode(data.toJson());

class SubmitAnswerModel {
    String responseCode;
    String responseMessage;
    dynamic otp;
    dynamic staticOtp;
    List<SubmitAnswer> data;
    dynamic data1;

    SubmitAnswerModel({
        required this.responseCode,
        required this.responseMessage,
        required this.otp,
        required this.staticOtp,
        required this.data,
        required this.data1,
    });

    factory SubmitAnswerModel.fromJson(Map<String, dynamic> json) => SubmitAnswerModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        otp: json["Otp"],
        staticOtp: json["Static_Otp"],
        data: List<SubmitAnswer>.from(json["DATA"].map((x) => SubmitAnswer.fromJson(x))),
        data1: json["DATA1"],
    );

    Map<String, dynamic> toJson() => {
        "ResponseCode": responseCode,
        "ResponseMessage": responseMessage,
        "Otp": otp,
        "Static_Otp": staticOtp,
        "DATA": List<dynamic>.from(data.map((x) => x.toJson())),
        "DATA1": data1,
    };
}

class SubmitAnswer {
    int qaId;
    String answer;

    SubmitAnswer({
        required this.qaId,
        required this.answer,
    });

    factory SubmitAnswer.fromJson(Map<String, dynamic> json) => SubmitAnswer(
        qaId: json["QA_ID"],
        answer: json["ANSWER"],
    );

    Map<String, dynamic> toJson() => {
        "QA_ID": qaId,
        "ANSWER": answer,
    };
}

// To parse this JSON data, do
//
//     final observationReportModel = observationReportModelFromJson(jsonString);

import 'dart:convert';

ObservationReportModel observationReportModelFromJson(String str) => ObservationReportModel.fromJson(json.decode(str));

String observationReportModelToJson(ObservationReportModel data) => json.encode(data.toJson());

class ObservationReportModel {
    String responseCode;
    String responseMessage;
    dynamic otp;
    dynamic staticOtp;
    List<Datum> data;
    dynamic data1;

    ObservationReportModel({
        required this.responseCode,
        required this.responseMessage,
        required this.otp,
        required this.staticOtp,
        required this.data,
        required this.data1,
    });

    factory ObservationReportModel.fromJson(Map<String, dynamic> json) => ObservationReportModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        otp: json["Otp"],
        staticOtp: json["Static_Otp"],
        data: List<Datum>.from(json["DATA"].map((x) => Datum.fromJson(x))),
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

class Datum {
    String codId;
    String codDay;
    List<QuestionList> questionList;

    Datum({
        required this.codId,
        required this.codDay,
        required this.questionList,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        codId: json["COD_ID"],
        codDay: json["COD_DAY"],
        questionList: List<QuestionList>.from(json["QuestionList"].map((x) => QuestionList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "COD_ID": codId,
        "COD_DAY": codDay,
        "QuestionList": List<dynamic>.from(questionList.map((x) => x.toJson())),
    };
}

class QuestionList {
    String qId;
    String question;
    String answer;

    QuestionList({
        required this.qId,
        required this.question,
        required this.answer,
    });

    factory QuestionList.fromJson(Map<String, dynamic> json) => QuestionList(
        qId: json["Q_ID"],
        question: json["QUESTION"],
        answer: json["ANSWER"],
    );

    Map<String, dynamic> toJson() => {
        "Q_ID": qId,
        "QUESTION": question,
        "ANSWER": answer,
    };
}

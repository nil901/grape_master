// To parse this JSON data, do
//
//     final reportListModel = reportListModelFromJson(jsonString);

import 'dart:convert';

ReportListModel reportListModelFromJson(String str) => ReportListModel.fromJson(json.decode(str));

String reportListModelToJson(ReportListModel data) => json.encode(data.toJson());

class ReportListModel {
    String responseCode;
    String responseMessage;
    dynamic otp;
    dynamic staticOtp;
    List<Datum> data;
    List<Data1> data1;

    ReportListModel({
        required this.responseCode,
        required this.responseMessage,
        required this.otp,
        required this.staticOtp,
        required this.data,
        required this.data1,
    });

    factory ReportListModel.fromJson(Map<String, dynamic> json) => ReportListModel(
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
    int reportId;
    String reportName;

    Datum({
        required this.reportId,
        required this.reportName,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        reportId: json["REPORT_ID"],
        reportName: json["REPORT_NAME"],
    );

    Map<String, dynamic> toJson() => {
        "REPORT_ID": reportId,
        "REPORT_NAME": reportName,
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

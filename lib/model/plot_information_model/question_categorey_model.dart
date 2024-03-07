// To parse this JSON data, do
//
//     final questionCategoreyModel = questionCategoreyModelFromJson(jsonString);

import 'dart:convert';

QuestionCategoreyModel questionCategoreyModelFromJson(String str) => QuestionCategoreyModel.fromJson(json.decode(str));

String questionCategoreyModelToJson(QuestionCategoreyModel data) => json.encode(data.toJson());

class QuestionCategoreyModel {
    String responseCode;
    String responseMessage;
    dynamic otp;
    dynamic staticOtp;
    List<CategoreyModel> data;
    List<Data1> data1;

    QuestionCategoreyModel({
        required this.responseCode,
        required this.responseMessage,
        required this.otp,
        required this.staticOtp,
        required this.data,
        required this.data1,
    });

    factory QuestionCategoreyModel.fromJson(Map<String, dynamic> json) => QuestionCategoreyModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        otp: json["Otp"],
        staticOtp: json["Static_Otp"],
        data: List<CategoreyModel>.from(json["DATA"].map((x) => CategoreyModel.fromJson(x))),
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

class CategoreyModel {
    int fqcId;
    String faqcName;
    Status status;
    DateTime regDate;

    CategoreyModel({
        required this.fqcId,
        required this.faqcName,
        required this.status,
        required this.regDate,
    });

    factory CategoreyModel.fromJson(Map<String, dynamic> json) => CategoreyModel(
        fqcId: json["FQC_ID"],
        faqcName: json["FAQC_NAME"],
        status: statusValues.map[json["STATUS"]]!,
        regDate: DateTime.parse(json["REG_DATE"]),
    );

    Map<String, dynamic> toJson() => {
        "FQC_ID": fqcId,
        "FAQC_NAME": faqcName,
        "STATUS": statusValues.reverse[status],
        "REG_DATE": regDate.toIso8601String(),
    };
}

enum Status {
    ACTIVE
}

final statusValues = EnumValues({
    "Active": Status.ACTIVE
});

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

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}

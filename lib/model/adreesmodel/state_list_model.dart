// To parse this JSON data, do
//
//     final stateLIstModel = stateLIstModelFromJson(jsonString);

import 'dart:convert';

StateLIstModel stateLIstModelFromJson(String str) => StateLIstModel.fromJson(json.decode(str));

String stateLIstModelToJson(StateLIstModel data) => json.encode(data.toJson());

class StateLIstModel {
    String responseCode;
    String responseMessage;
    dynamic otp;
    dynamic staticOtp;
    List<State> data;
    List<Data1> data1;

    StateLIstModel({
        required this.responseCode,
        required this.responseMessage,
        required this.otp,
        required this.staticOtp,
        required this.data,
        required this.data1,
    });

    factory StateLIstModel.fromJson(Map<String, dynamic> json) => StateLIstModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        otp: json["Otp"],
        staticOtp: json["Static_Otp"],
        data: List<State>.from(json["DATA"].map((x) => State.fromJson(x))),
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

class State {
    int stateId;
    String stateName;
    Status status;

    State({
        required this.stateId,
        required this.stateName,
        required this.status,
    });

    factory State.fromJson(Map<String, dynamic> json) => State(
        stateId: json["STATE_ID"],
        stateName: json["STATE_NAME"],
        status: statusValues.map[json["STATUS"]]!,
    );

    Map<String, dynamic> toJson() => {
        "STATE_ID": stateId,
        "STATE_NAME": stateName,
        "STATUS": statusValues.reverse[status],
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

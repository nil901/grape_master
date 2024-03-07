// To parse this JSON data, do
//
//     final myLeadsModel = myLeadsModelFromJson(jsonString);

import 'dart:convert';

MyLeadsModel myLeadsModelFromJson(String str) => MyLeadsModel.fromJson(json.decode(str));

String myLeadsModelToJson(MyLeadsModel data) => json.encode(data.toJson());

class MyLeadsModel {
    String responseCode;
    String responseMessage;
    dynamic otp;
    dynamic staticOtp;
    List<Datum> data;
    List<Data1> data1;

    MyLeadsModel({
        required this.responseCode,
        required this.responseMessage,
        required this.otp,
        required this.staticOtp,
        required this.data,
        required this.data1,
    });

    factory MyLeadsModel.fromJson(Map<String, dynamic> json) => MyLeadsModel(
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
    int row;
    int speId;
    String productName;
    String productDescription;
    String brandName;
    String productPhoto;
    Status status;
    String regDate;
    String fullName;
    String mobileNumber;
    dynamic address;

    Datum({
        required this.row,
        required this.speId,
        required this.productName,
        required this.productDescription,
        required this.brandName,
        required this.productPhoto,
        required this.status,
        required this.regDate,
        required this.fullName,
        required this.mobileNumber,
        required this.address,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        row: json["Row"],
        speId: json["SPE_ID"],
        productName: json["PRODUCT_NAME"],
        productDescription: json["PRODUCT_DESCRIPTION"],
        brandName: json["BRAND_NAME"],
        productPhoto: json["PRODUCT_PHOTO"],
        status: statusValues.map[json["STATUS"]]!,
        regDate: json["REG_DATE"],
        fullName:json["FULL_NAME"]!,
        mobileNumber: json["MOBILE_NUMBER"],
        address: json["ADDRESS"],
    );

    Map<String, dynamic> toJson() => {
        "Row": row,
        "SPE_ID": speId,
        "PRODUCT_NAME": productName,
        "PRODUCT_DESCRIPTION": productDescription,
        "BRAND_NAME": brandName,
        "PRODUCT_PHOTO": productPhoto,
        "STATUS": statusValues.reverse[status],
        "REG_DATE": regDate,
        "FULL_NAME": fullNameValues.reverse[fullName],
        "MOBILE_NUMBER": mobileNumber,
        "ADDRESS": address,
    };
}

enum FullName {
    DHANANJAY_UPHADE,
    NASHIK,
    SAMADHAN_KHELUKAR
}

final fullNameValues = EnumValues({
    "Dhananjay Uphade": FullName.DHANANJAY_UPHADE,
    "Nashik": FullName.NASHIK,
    "samadhan khelukar": FullName.SAMADHAN_KHELUKAR
});

enum Status {
    PENDING
}

final statusValues = EnumValues({
    "Pending": Status.PENDING
});

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

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}

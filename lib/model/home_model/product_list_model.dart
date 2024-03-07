// To parse this JSON data, do
//
//     final productListModel = productListModelFromJson(jsonString);

import 'dart:convert';

ProductListModel productListModelFromJson(String str) => ProductListModel.fromJson(json.decode(str));

String productListModelToJson(ProductListModel data) => json.encode(data.toJson());

class ProductListModel {
    String responseCode;
    String responseMessage;
    dynamic otp;
    dynamic staticOtp;
    List<ProductModel> data;
    List<Data1> data1;

    ProductListModel({
        required this.responseCode,
        required this.responseMessage,
        required this.otp,
        required this.staticOtp,
        required this.data,
        required this.data1,
    });

    factory ProductListModel.fromJson(Map<String, dynamic> json) => ProductListModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        otp: json["Otp"],
        staticOtp: json["Static_Otp"],
        data: List<ProductModel>.from(json["DATA"].map((x) => ProductModel.fromJson(x))),
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

class ProductModel {
    int row;
    int spId;
    String productName;
    String productDescription;
    dynamic brandName;
    String productPhoto;
    String isAvailable;
    String measureOfUse;
    double price;
    dynamic employeeName;
    dynamic employeeMobileNo;
    dynamic employeePhoto;

    ProductModel({
        required this.row,
        required this.spId,
        required this.productName,
        required this.productDescription,
        required this.brandName,
        required this.productPhoto,
        required this.isAvailable,
        required this.measureOfUse,
        required this.price,
        required this.employeeName,
        required this.employeeMobileNo,
        required this.employeePhoto,
    });

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        row: json["Row"],
        spId: json["SP_ID"],
        productName: json["PRODUCT_NAME"],
        productDescription: json["PRODUCT_DESCRIPTION"],
        brandName: json["BRAND_NAME"],
        productPhoto: json["PRODUCT_PHOTO"],
        isAvailable: json["IS_AVAILABLE"],
        measureOfUse: json["MEASURE_OF_USE"],
        price:  json["PRICE"] ,

        employeeName: json["EMPLOYEE_NAME"],
        employeeMobileNo: json["EMPLOYEE_MOBILE_NO"],
        employeePhoto: json["EMPLOYEE_PHOTO"],
    );

    Map<String, dynamic> toJson() => {
        "Row": row,
        "SP_ID": spId,
        "PRODUCT_NAME": productName,
        "PRODUCT_DESCRIPTION": productDescription,
        "BRAND_NAME": brandName,
        "PRODUCT_PHOTO": productPhoto,
        "IS_AVAILABLE": isAvailable,
        "MEASURE_OF_USE": measureOfUse,
        "PRICE": price,
        "EMPLOYEE_NAME": employeeName,
        "EMPLOYEE_MOBILE_NO": employeeMobileNo,
        "EMPLOYEE_PHOTO": employeePhoto,
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

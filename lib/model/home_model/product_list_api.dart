///
/// Code generated by Sita Web Tool https://sita.app/json-to-dart/
///
const String jsonKeyProductLiastModelResponseCode = 'ResponseCode';
const String jsonKeyProductLiastModelResponseMessage = 'ResponseMessage';
const String jsonKeyProductLiastModelOtp = 'Otp';
const String jsonKeyProductLiastModelStatic_Otp = 'Static_Otp';
const String jsonKeyProductLiastModelDATA = 'DATA';
const String jsonKeyProductLiastModelDATA1 = 'DATA1';
const String jsonKeyProductLiastModelDATA1Column1 = 'Column1';
class ProductLiastModelDATA1 {
/*
{
  "Column1": 1
} 
*/

  int? Column1;

  ProductLiastModelDATA1({
    this.Column1,
  });
  ProductLiastModelDATA1.fromJson(Map<String, dynamic> json) {
    Column1 = json[jsonKeyProductLiastModelDATA1Column1]?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data[jsonKeyProductLiastModelDATA1Column1] = Column1;
    return data;
  }
}

const String jsonKeyProductLiastModelDATARow = 'Row';
const String jsonKeyProductLiastModelDATASP_ID = 'SP_ID';
const String jsonKeyProductLiastModelDATAPRODUCT_NAME = 'PRODUCT_NAME';
const String jsonKeyProductLiastModelDATAPRODUCT_DESCRIPTION = 'PRODUCT_DESCRIPTION';
const String jsonKeyProductLiastModelDATABRAND_NAME = 'BRAND_NAME';
const String jsonKeyProductLiastModelDATAPRODUCT_PHOTO = 'PRODUCT_PHOTO';
const String jsonKeyProductLiastModelDATAIS_AVAILABLE = 'IS_AVAILABLE';
const String jsonKeyProductLiastModelDATAMEASURE_OF_USE = 'MEASURE_OF_USE';
const String jsonKeyProductLiastModelDATAPRICE = 'PRICE';
const String jsonKeyProductLiastModelDATAEMPLOYEE_NAME = 'EMPLOYEE_NAME';
const String jsonKeyProductLiastModelDATAEMPLOYEE_MOBILE_NO = 'EMPLOYEE_MOBILE_NO';
const String jsonKeyProductLiastModelDATAEMPLOYEE_PHOTO = 'EMPLOYEE_PHOTO';
class ProductLiastModelDATA {
/*
{
  "Row": 1,
  "SP_ID": 61,
  "PRODUCT_NAME": "Demo Product",
  "PRODUCT_DESCRIPTION": "demo products",
  "BRAND_NAME": "Test",
  "PRODUCT_PHOTO": "http://newgrapemastersnskapi.cropmaster.in/ImagesUploaded/PHOTO6684747766.jpg",
  "IS_AVAILABLE": "No",
  "MEASURE_OF_USE": "",
  "PRICE": 1000,
  "EMPLOYEE_NAME": "demo",
  "EMPLOYEE_MOBILE_NO": "9834946464",
  "EMPLOYEE_PHOTO": "http://newgrapemastersnskapi.cropmaster.in/ImagesUploaded/EMPLOYEEPHOTO7776789072.jpg"
} 
*/

  int? Row;
  int? SP_ID;
  String? PRODUCT_NAME;
  String? PRODUCT_DESCRIPTION;
  String? BRAND_NAME;
  String? PRODUCT_PHOTO;
  String? IS_AVAILABLE;
  String? MEASURE_OF_USE;
  int? PRICE;
  String? EMPLOYEE_NAME;
  String? EMPLOYEE_MOBILE_NO;
  String? EMPLOYEE_PHOTO;

  ProductLiastModelDATA({
    this.Row,
    this.SP_ID,
    this.PRODUCT_NAME,
    this.PRODUCT_DESCRIPTION,
    this.BRAND_NAME,
    this.PRODUCT_PHOTO,
    this.IS_AVAILABLE,
    this.MEASURE_OF_USE,
    this.PRICE,
    this.EMPLOYEE_NAME,
    this.EMPLOYEE_MOBILE_NO,
    this.EMPLOYEE_PHOTO,
  });
  ProductLiastModelDATA.fromJson(Map<String, dynamic> json) {
    Row = json[jsonKeyProductLiastModelDATARow]?.toInt();
    SP_ID = json[jsonKeyProductLiastModelDATASP_ID]?.toInt();
    PRODUCT_NAME = json[jsonKeyProductLiastModelDATAPRODUCT_NAME]?.toString();
    PRODUCT_DESCRIPTION = json[jsonKeyProductLiastModelDATAPRODUCT_DESCRIPTION]?.toString();
    BRAND_NAME = json[jsonKeyProductLiastModelDATABRAND_NAME]?.toString();
    PRODUCT_PHOTO = json[jsonKeyProductLiastModelDATAPRODUCT_PHOTO]?.toString();
    IS_AVAILABLE = json[jsonKeyProductLiastModelDATAIS_AVAILABLE]?.toString();
    MEASURE_OF_USE = json[jsonKeyProductLiastModelDATAMEASURE_OF_USE]?.toString();
    PRICE = json[jsonKeyProductLiastModelDATAPRICE]?.toInt();
    EMPLOYEE_NAME = json[jsonKeyProductLiastModelDATAEMPLOYEE_NAME]?.toString();
    EMPLOYEE_MOBILE_NO = json[jsonKeyProductLiastModelDATAEMPLOYEE_MOBILE_NO]?.toString();
    EMPLOYEE_PHOTO = json[jsonKeyProductLiastModelDATAEMPLOYEE_PHOTO]?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data[jsonKeyProductLiastModelDATARow] = Row;
    data[jsonKeyProductLiastModelDATASP_ID] = SP_ID;
    data[jsonKeyProductLiastModelDATAPRODUCT_NAME] = PRODUCT_NAME;
    data[jsonKeyProductLiastModelDATAPRODUCT_DESCRIPTION] = PRODUCT_DESCRIPTION;
    data[jsonKeyProductLiastModelDATABRAND_NAME] = BRAND_NAME;
    data[jsonKeyProductLiastModelDATAPRODUCT_PHOTO] = PRODUCT_PHOTO;
    data[jsonKeyProductLiastModelDATAIS_AVAILABLE] = IS_AVAILABLE;
    data[jsonKeyProductLiastModelDATAMEASURE_OF_USE] = MEASURE_OF_USE;
    data[jsonKeyProductLiastModelDATAPRICE] = PRICE;
    data[jsonKeyProductLiastModelDATAEMPLOYEE_NAME] = EMPLOYEE_NAME;
    data[jsonKeyProductLiastModelDATAEMPLOYEE_MOBILE_NO] = EMPLOYEE_MOBILE_NO;
    data[jsonKeyProductLiastModelDATAEMPLOYEE_PHOTO] = EMPLOYEE_PHOTO;
    return data;
  }
}

class ProductLiastModel {
/*
{
  "ResponseCode": "0",
  "ResponseMessage": "Shop List",
  "Otp": null,
  "Static_Otp": null,
  "DATA": [
    {
      "Row": 1,
      "SP_ID": 61,
      "PRODUCT_NAME": "Demo Product",
      "PRODUCT_DESCRIPTION": "demo products",
      "BRAND_NAME": "Test",
      "PRODUCT_PHOTO": "http://newgrapemastersnskapi.cropmaster.in/ImagesUploaded/PHOTO6684747766.jpg",
      "IS_AVAILABLE": "No",
      "MEASURE_OF_USE": "",
      "PRICE": 1000,
      "EMPLOYEE_NAME": "demo",
      "EMPLOYEE_MOBILE_NO": "9834946464",
      "EMPLOYEE_PHOTO": "http://newgrapemastersnskapi.cropmaster.in/ImagesUploaded/EMPLOYEEPHOTO7776789072.jpg"
    }
  ],
  "DATA1": [
    {
      "Column1": 1
    }
  ]
} 
*/

  String? ResponseCode;
  String? ResponseMessage;
  String? Otp;
  String? Static_Otp;
  List<ProductLiastModelDATA?>? DATA;
  List<ProductLiastModelDATA1?>? DATA1;

  ProductLiastModel({
    this.ResponseCode,
    this.ResponseMessage,
    this.Otp,
    this.Static_Otp,
    this.DATA,
    this.DATA1,
  });
  ProductLiastModel.fromJson(Map<String, dynamic> json) {
    ResponseCode = json[jsonKeyProductLiastModelResponseCode]?.toString();
    ResponseMessage = json[jsonKeyProductLiastModelResponseMessage]?.toString();
    Otp = json[jsonKeyProductLiastModelOtp]?.toString();
    Static_Otp = json[jsonKeyProductLiastModelStatic_Otp]?.toString();
  if (json[jsonKeyProductLiastModelDATA] != null) {
  final v = json[jsonKeyProductLiastModelDATA];
  final arr0 = <ProductLiastModelDATA>[];
  v.forEach((v) {
  arr0.add(ProductLiastModelDATA.fromJson(v));
  });
    DATA = arr0;
    }
  if (json[jsonKeyProductLiastModelDATA1] != null) {
  final v = json[jsonKeyProductLiastModelDATA1];
  final arr0 = <ProductLiastModelDATA1>[];
  v.forEach((v) {
  arr0.add(ProductLiastModelDATA1.fromJson(v));
  });
    DATA1 = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data[jsonKeyProductLiastModelResponseCode] = ResponseCode;
    data[jsonKeyProductLiastModelResponseMessage] = ResponseMessage;
    data[jsonKeyProductLiastModelOtp] = Otp;
    data[jsonKeyProductLiastModelStatic_Otp] = Static_Otp;
    if (DATA != null) {
      final v = DATA;
      final arr0 = [];
  v!.forEach((v) {
  arr0.add(v!.toJson());
  });
      data[jsonKeyProductLiastModelDATA] = arr0;
    }
    if (DATA1 != null) {
      final v = DATA1;
      final arr0 = [];
  v!.forEach((v) {
  arr0.add(v!.toJson());
  });
      data[jsonKeyProductLiastModelDATA1] = arr0;
    }
    return data;
  }
}

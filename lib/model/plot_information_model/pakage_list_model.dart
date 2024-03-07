///
/// Code generated by Sita Web Tool https://sita.app/json-to-dart/
///
class PakageListModelDATA1 {
/*
{
  "Column1": 1
} 
*/

  String? Column1;

  PakageListModelDATA1({
    this.Column1,
  });
  PakageListModelDATA1.fromJson(Map<String, dynamic> json) {
    Column1 = json['Column1']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Column1'] = Column1;
    return data;
  }
}

class PakageListModelDATA {
/*
{
  "PLOT_ID": 28588,
  "PPA_ID": 0,
  "PACKAGE_NAME": "",
  "AMOUNT": 0,
  "PAYMENT_STATUS": "Success",
  "TRANSACTION_ID": "",
  "PACKAGE_IMG": "",
  "PACKAGE_DESCRIPTION": "",
  "PACKAGE_DAY": 0,
  "REMAINING_DAY": 0,
  "EXPIRE_DATE": "13/06/2023",
  "REG_DATE": "08/06/2023",
  "STATUS": "Deactive",
  "PAYMENT_DATE": "08/06/2023",
  "CROP_IMAGE": "http://cmadmin.cropmaster.in///Images/Crop67696586657602212023.jpg",
  "SCHEDULE_STATUS": "Deactive",
  "QUESTION_STATUS": "Deactive"
} 
*/

  String? PLOT_ID;
  String? PPA_ID;
  String? PACKAGE_NAME;
  String? AMOUNT;
  String? PAYMENT_STATUS;
  String? TRANSACTION_ID;
  String? PACKAGE_IMG;
  String? PACKAGE_DESCRIPTION;
  String? PACKAGE_DAY;
  String? REMAINING_DAY;
  String? EXPIRE_DATE;
  String? REG_DATE;
  String? STATUS;
  String? PAYMENT_DATE;
  String? CROP_IMAGE;
  String? SCHEDULE_STATUS;
  String? QUESTION_STATUS;

  PakageListModelDATA({
    this.PLOT_ID,
    this.PPA_ID,
    this.PACKAGE_NAME,
    this.AMOUNT,
    this.PAYMENT_STATUS,
    this.TRANSACTION_ID,
    this.PACKAGE_IMG,
    this.PACKAGE_DESCRIPTION,
    this.PACKAGE_DAY,
    this.REMAINING_DAY,
    this.EXPIRE_DATE,
    this.REG_DATE,
    this.STATUS,
    this.PAYMENT_DATE,
    this.CROP_IMAGE,
    this.SCHEDULE_STATUS,
    this.QUESTION_STATUS,
  });
  PakageListModelDATA.fromJson(Map<String, dynamic> json) {
    PLOT_ID = json['PLOT_ID']?.toString();
    PPA_ID = json['PPA_ID']?.toString();
    PACKAGE_NAME = json['PACKAGE_NAME']?.toString();
    AMOUNT = json['AMOUNT']?.toString();
    PAYMENT_STATUS = json['PAYMENT_STATUS']?.toString();
    TRANSACTION_ID = json['TRANSACTION_ID']?.toString();
    PACKAGE_IMG = json['PACKAGE_IMG']?.toString();
    PACKAGE_DESCRIPTION = json['PACKAGE_DESCRIPTION']?.toString();
    PACKAGE_DAY = json['PACKAGE_DAY']?.toString();
    REMAINING_DAY = json['REMAINING_DAY']?.toString();
    EXPIRE_DATE = json['EXPIRE_DATE']?.toString();
    REG_DATE = json['REG_DATE']?.toString();
    STATUS = json['STATUS']?.toString();
    PAYMENT_DATE = json['PAYMENT_DATE']?.toString();
    CROP_IMAGE = json['CROP_IMAGE']?.toString();
    SCHEDULE_STATUS = json['SCHEDULE_STATUS']?.toString();
    QUESTION_STATUS = json['QUESTION_STATUS']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['PLOT_ID'] = PLOT_ID;
    data['PPA_ID'] = PPA_ID;
    data['PACKAGE_NAME'] = PACKAGE_NAME;
    data['AMOUNT'] = AMOUNT;
    data['PAYMENT_STATUS'] = PAYMENT_STATUS;
    data['TRANSACTION_ID'] = TRANSACTION_ID;
    data['PACKAGE_IMG'] = PACKAGE_IMG;
    data['PACKAGE_DESCRIPTION'] = PACKAGE_DESCRIPTION;
    data['PACKAGE_DAY'] = PACKAGE_DAY;
    data['REMAINING_DAY'] = REMAINING_DAY;
    data['EXPIRE_DATE'] = EXPIRE_DATE;
    data['REG_DATE'] = REG_DATE;
    data['STATUS'] = STATUS;
    data['PAYMENT_DATE'] = PAYMENT_DATE;
    data['CROP_IMAGE'] = CROP_IMAGE;
    data['SCHEDULE_STATUS'] = SCHEDULE_STATUS;
    data['QUESTION_STATUS'] = QUESTION_STATUS;
    return data;
  }
}

class PakageListModel {
/*
{
  "ResponseCode": "0",
  "ResponseMessage": "Plot Package List",
  "Otp": null,
  "Static_Otp": null,
  "DATA": [
    {
      "PLOT_ID": 28588,
      "PPA_ID": 0,
      "PACKAGE_NAME": "",
      "AMOUNT": 0,
      "PAYMENT_STATUS": "Success",
      "TRANSACTION_ID": "",
      "PACKAGE_IMG": "",
      "PACKAGE_DESCRIPTION": "",
      "PACKAGE_DAY": 0,
      "REMAINING_DAY": 0,
      "EXPIRE_DATE": "13/06/2023",
      "REG_DATE": "08/06/2023",
      "STATUS": "Deactive",
      "PAYMENT_DATE": "08/06/2023",
      "CROP_IMAGE": "http://cmadmin.cropmaster.in///Images/Crop67696586657602212023.jpg",
      "SCHEDULE_STATUS": "Deactive",
      "QUESTION_STATUS": "Deactive"
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
  List<PakageListModelDATA?>? DATA;
  List<PakageListModelDATA1?>? DATA1;

  PakageListModel({
    this.ResponseCode,
    this.ResponseMessage,
    this.Otp,
    this.Static_Otp,
    this.DATA,
    this.DATA1,
  });
  PakageListModel.fromJson(Map<String, dynamic> json) {
    ResponseCode = json['ResponseCode']?.toString();
    ResponseMessage = json['ResponseMessage']?.toString();
    Otp = json['Otp']?.toString();
    Static_Otp = json['Static_Otp']?.toString();
  if (json['DATA'] != null) {
  final v = json['DATA'];
  final arr0 = <PakageListModelDATA>[];
  v.forEach((v) {
  arr0.add(PakageListModelDATA.fromJson(v));
  });
    DATA = arr0;
    }
  if (json['DATA1'] != null) {
  final v = json['DATA1'];
  final arr0 = <PakageListModelDATA1>[];
  v.forEach((v) {
  arr0.add(PakageListModelDATA1.fromJson(v));
  });
    DATA1 = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ResponseCode'] = ResponseCode;
    data['ResponseMessage'] = ResponseMessage;
    data['Otp'] = Otp;
    data['Static_Otp'] = Static_Otp;
    if (DATA != null) {
      final v = DATA;
      final arr0 = [];
  v!.forEach((v) {
  arr0.add(v!.toJson());
  });
      data['DATA'] = arr0;
    }
    if (DATA1 != null) {
      final v = DATA1;
      final arr0 = [];
  v!.forEach((v) {
  arr0.add(v!.toJson());
  });
      data['DATA1'] = arr0;
    }
    return data;
  }
}

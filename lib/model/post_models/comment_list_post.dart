///
/// Code generated by Sita Web Tool https://sita.app/json-to-dart/
///
class CommentListModelDATA1 {
/*
{
  "Column1": 1
} 
*/

  String? Column1;

  CommentListModelDATA1({
    this.Column1,
  });
  CommentListModelDATA1.fromJson(Map<String, dynamic> json) {
    Column1 = json['Column1']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Column1'] = Column1;
    return data;
  }
}

class CommentListModelDATA {
/*
{
  "Row": 1,
  "PC_ID": 597,
  "REMARK": "test",
  "FULL_NAME": "bshsh",
  "PROFILE_PHOTO": "",
  "REG_DATE": "04/01/2024"
} 
*/

  String? Row;
  String? PC_ID;
  String? REMARK;
  String? FULL_NAME;
  String? PROFILE_PHOTO;
  String? REG_DATE;

  CommentListModelDATA({
    this.Row,
    this.PC_ID,
    this.REMARK,
    this.FULL_NAME,
    this.PROFILE_PHOTO,
    this.REG_DATE,
  });
  CommentListModelDATA.fromJson(Map<String, dynamic> json) {
    Row = json['Row']?.toString();
    PC_ID = json['PC_ID']?.toString();
    REMARK = json['REMARK']?.toString();
    FULL_NAME = json['FULL_NAME']?.toString();
    PROFILE_PHOTO = json['PROFILE_PHOTO']?.toString();
    REG_DATE = json['REG_DATE']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Row'] = Row;
    data['PC_ID'] = PC_ID;
    data['REMARK'] = REMARK;
    data['FULL_NAME'] = FULL_NAME;
    data['PROFILE_PHOTO'] = PROFILE_PHOTO;
    data['REG_DATE'] = REG_DATE;
    return data;
  }
}

class CommentListModel {
/*
{
  "ResponseCode": "0",
  "ResponseMessage": "Post Comment List",
  "Otp": null,
  "Static_Otp": null,
  "DATA": [
    {
      "Row": 1,
      "PC_ID": 597,
      "REMARK": "test",
      "FULL_NAME": "bshsh",
      "PROFILE_PHOTO": "",
      "REG_DATE": "04/01/2024"
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
  List<CommentListModelDATA?>? DATA;
  List<CommentListModelDATA1?>? DATA1;

  CommentListModel({
    this.ResponseCode,
    this.ResponseMessage,
    this.Otp,
    this.Static_Otp,
    this.DATA,
    this.DATA1,
  });
  CommentListModel.fromJson(Map<String, dynamic> json) {
    ResponseCode = json['ResponseCode']?.toString();
    ResponseMessage = json['ResponseMessage']?.toString();
    Otp = json['Otp']?.toString();
    Static_Otp = json['Static_Otp']?.toString();
  if (json['DATA'] != null) {
  final v = json['DATA'];
  final arr0 = <CommentListModelDATA>[];
  v.forEach((v) {
  arr0.add(CommentListModelDATA.fromJson(v));
  });
    DATA = arr0;
    }
  if (json['DATA1'] != null) {
  final v = json['DATA1'];
  final arr0 = <CommentListModelDATA1>[];
  v.forEach((v) {
  arr0.add(CommentListModelDATA1.fromJson(v));
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

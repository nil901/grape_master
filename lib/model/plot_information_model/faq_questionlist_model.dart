///
/// Code generated by Sita Web Tool https://sita.app/json-to-dart/
///
class FaqQuetionListModelDATA1 {
/*
{
  "Column1": 1
} 
*/

  String? Column1;

  FaqQuetionListModelDATA1({
    this.Column1,
  });
  FaqQuetionListModelDATA1.fromJson(Map<String, dynamic> json) {
    Column1 = json['Column1']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Column1'] = Column1;
    return data;
  }
}

class FaqQuetionListModelDATA {
/*
{
  "Row": 1,
  "FAQ_ID": 236,
  "FAQ_NAME": "द्राक्षमळ्यासाठी कोणती जमीन निवडली पाहिजे?",
  "FAQ_DESCRIPTION": "द्राक्ष वेली लागवडीनंतर १५ ते २० वर्षे फळ देत असल्याने लागवडीसाठी योग्य जमीन निवडणे महत्त्वाचे आहे. तसेच द्राक्षबागा लागवडीसाठी जमिनीत थोडी सुधारणा हवी असल्यास नंतर ती सुरू केल्यास कोणतीही अडचण येणार नाही.त्यामुळे द्राक्षबागा लावण्याचा निर्णय घेण्यापूर्वी खालील बाबी लक्षात ठेवाव्यात. 1) माती हलकी ते मध्यम दर्जाची आणि पाण्याचा निचरा होणारी असावी आणि अतिवृष्टीच्या वेळी अतिरिक्त पाण्याचा निचरा करण्याची सोय असावी. २) जमिनीचा उतार ३% पर्यंत असावा आणि जमिनीची खोली किमान १ मीटर असावी. 3) मातीचा वरचा थर लगेचच कठीण खडकाचा थर लावू नये.तसे असल्यास मोठ्या जेसीबीने चरायला हवे. 4) लागवडीपूर्वी माती परीक्षण करणे फायदेशीर ठरते."
} 
*/

  String? Row;
  String? FAQ_ID;
  String? FAQ_NAME;
  String? FAQ_DESCRIPTION;

  FaqQuetionListModelDATA({
    this.Row,
    this.FAQ_ID,
    this.FAQ_NAME,
    this.FAQ_DESCRIPTION,
  });
  FaqQuetionListModelDATA.fromJson(Map<String, dynamic> json) {
    Row = json['Row']?.toString();
    FAQ_ID = json['FAQ_ID']?.toString();
    FAQ_NAME = json['FAQ_NAME']?.toString();
    FAQ_DESCRIPTION = json['FAQ_DESCRIPTION']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Row'] = Row;
    data['FAQ_ID'] = FAQ_ID;
    data['FAQ_NAME'] = FAQ_NAME;
    data['FAQ_DESCRIPTION'] = FAQ_DESCRIPTION;
    return data;
  }
}

class FaqQuetionListModel {
/*
{
  "ResponseCode": "0",
  "ResponseMessage": "FAQ List",
  "Otp": null,
  "Static_Otp": null,
  "DATA": [
    {
      "Row": 1,
      "FAQ_ID": 236,
      "FAQ_NAME": "द्राक्षमळ्यासाठी कोणती जमीन निवडली पाहिजे?",
      "FAQ_DESCRIPTION": "द्राक्ष वेली लागवडीनंतर १५ ते २० वर्षे फळ देत असल्याने लागवडीसाठी योग्य जमीन निवडणे महत्त्वाचे आहे. तसेच द्राक्षबागा लागवडीसाठी जमिनीत थोडी सुधारणा हवी असल्यास नंतर ती सुरू केल्यास कोणतीही अडचण येणार नाही.त्यामुळे द्राक्षबागा लावण्याचा निर्णय घेण्यापूर्वी खालील बाबी लक्षात ठेवाव्यात. 1) माती हलकी ते मध्यम दर्जाची आणि पाण्याचा निचरा होणारी असावी आणि अतिवृष्टीच्या वेळी अतिरिक्त पाण्याचा निचरा करण्याची सोय असावी. २) जमिनीचा उतार ३% पर्यंत असावा आणि जमिनीची खोली किमान १ मीटर असावी. 3) मातीचा वरचा थर लगेचच कठीण खडकाचा थर लावू नये.तसे असल्यास मोठ्या जेसीबीने चरायला हवे. 4) लागवडीपूर्वी माती परीक्षण करणे फायदेशीर ठरते."
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
  List<FaqQuetionListModelDATA?>? DATA;
  List<FaqQuetionListModelDATA1?>? DATA1;

  FaqQuetionListModel({
    this.ResponseCode,
    this.ResponseMessage,
    this.Otp,
    this.Static_Otp,
    this.DATA,
    this.DATA1,
  });
  FaqQuetionListModel.fromJson(Map<String, dynamic> json) {
    ResponseCode = json['ResponseCode']?.toString();
    ResponseMessage = json['ResponseMessage']?.toString();
    Otp = json['Otp']?.toString();
    Static_Otp = json['Static_Otp']?.toString();
  if (json['DATA'] != null) {
  final v = json['DATA'];
  final arr0 = <FaqQuetionListModelDATA>[];
  v.forEach((v) {
  arr0.add(FaqQuetionListModelDATA.fromJson(v));
  });
    DATA = arr0;
    }
  if (json['DATA1'] != null) {
  final v = json['DATA1'];
  final arr0 = <FaqQuetionListModelDATA1>[];
  v.forEach((v) {
  arr0.add(FaqQuetionListModelDATA1.fromJson(v));
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

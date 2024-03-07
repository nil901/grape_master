import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:grape_master/util/util.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import 'package:http/http.dart'as http;

class PhonePayPayment extends StatefulWidget {
  const PhonePayPayment({super.key});

  @override
  State<PhonePayPayment> createState() => _PhonePayPaymentState();
}

class _PhonePayPaymentState extends State<PhonePayPayment> {
  String environment = "PRODUCTION";
  String appId = "";
  String transactionId = DateTime.now().microsecondsSinceEpoch.toString();
 String merchantId = "";
  // String merchantId = "MASJIDONLINE";
  bool enableLogging = true;

  String checksum = "";
   String saltKey = "";
   // String saltKey = "5983212a-8b58-4ce7-b078-6059d207ff85";
  String saltINdex = "1";

  String callbackurl ="https://webhook.site/5831956e-9d9a-4e2b-af52-1ecfc61cd945";
  String body = "";
  String apiEndPoint = "/pg/v1/pay";

  Object? result;
  getCheckSum() {
    final requestdata = {
      "merchantId": merchantId,
      "merchantTransactionId": transactionId,
      "merchantUserId": "9130348515",
      "amount": 1*100,
      "mobileNumber": "9130348515",
      "callbackUrl": callbackurl,
      "paymentInstrument": {"type": "PAY_PAGE"},
    };

    String base64body = base64.encode(utf8.encode(json.encode(requestdata)));
    checksum =
        '${sha256.convert(utf8.encode(base64body + '/pg/v1/pay' + saltKey)).toString()}###$saltINdex';

    log('$checksum');
    return base64body;
  }
// Future<void> fetchData() async {
//     final response = await http.get(Uri.parse('https://webhook.site/5831956e-9d9a-4e2b-af52-1ecfc61cd945'));

//     if (response.statusCode == 200) {
//       print('Response: ${response.body}');
//     } else {
//       print('Error: ${response.statusCode}');
//     }
//   }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phonepeInit();
    body = getCheckSum();
  }

  void phonepeInit() {
    PhonePePaymentSdk.init(environment, appId, merchantId, enableLogging)
        .then((val) => {
              setState(() {
                result = 'PhonePe SDK Initialized - $val';
              })
            })
        .catchError((error) {
      handleError(error);
      return <dynamic>{};
    });
  }

  void startPgTransaction() {
    try {
      var response = PhonePePaymentSdk.startTransaction(
          body, callbackurl, checksum, apiEndPoint);
      response
          .then((val)async{
               
                  if (val != null) {
                    String status = val['status'].toString();
                    String error = val['error'].toString();
                    if (status == 'SUCCESS') {
                  await  checkStatus();
                  setState(() {
                    
                  });
                      result = "flow complite - status: Success";
                    } else {
                      result = "flow complite - status: Success $error";
                    }
                  }
                })
              
          .catchError((error) {
        handleError(error);
        return <dynamic>{};
      });
    } catch (error) {
      handleError(error);
    }
  }

  Future<void> checkStatus() async {
  try {
    String url = "https://api.phonepe.com/apis/hermes/pg/v1/status/$merchantId/$transactionId";
    String concatString = "/pg/v1/status/$merchantId/$transactionId$saltKey";
    var bytes = utf8.encode(concatString);
    var digest = sha256.convert(bytes).toString();
    String xverify = "$digest###$saltINdex";
    print(xverify);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "X-VERIFY": xverify,
      "X-MERCHANT-ID": merchantId,
    };

    await http.get(Uri.parse(url), headers: headers).then((value) {
      Map<String, dynamic> res = jsonDecode(value.body);
      print("NILESH $res");

      try {
        if (res["code"] == "PAYMENT_SUCCESS") {
          Utils().validationTostmassage("mesg: ${res["message"]}");
        } else {
          Utils().validationTostmassage("Something wrong");
          print(result);
        }
      } catch (e) {
        Utils().validationTostmassage("error: $e");
      }
    });
  } catch (e) {
    Utils().validationTostmassage("error: $e");
  }
}


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('phone pay'),
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                startPgTransaction();
              },
              child: Text('Start Trasction'),
            ),
            Text(result.toString())
          ],
        ),
      ),
    );
  }

  void handleError(error) {
    setState(() {
      result = {"error": error};
    });
  }
}  






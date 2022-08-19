// To parse this JSON data, do
//
//     final detCredit = detCreditFromJson(jsonString);

import 'dart:convert';

List<DetCredit> detCreditFromJson(String str) => List<DetCredit>.from(json.decode(str).map((x) => DetCredit.fromJson(x)));

String detCreditToJson(List<DetCredit> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DetCredit {
    DetCredit({
        this.cvCode,
        this.cvName,
        this.soAmt,
        this.soDocumentNo,
        this.documentDate,
        this.reasonCode,
        this.creditManualDate,
    });

    String cvCode;
    String cvName;
    double soAmt;
    String soDocumentNo;
    String documentDate;
    String reasonCode;
    String creditManualDate;

    factory DetCredit.fromJson(Map<String, dynamic> json) => DetCredit(
        cvCode: json["CvCode"],
        cvName: json["CvName"],
        soAmt: json["SoAmt"],
        soDocumentNo: json["SoDocumentNo"],
        documentDate: json["DocumentDate"],
        reasonCode: json["ReasonCode"],
        creditManualDate: json["CreditManualDate"],
    );

    Map<String, dynamic> toJson() => {
        "CvCode": cvCode,
        "CvName": cvName,
        "SoAmt": soAmt,
        "SoDocumentNo": soDocumentNo,
        "DocumentDate": documentDate,
        "ReasonCode": reasonCode,
        "CreditManualDate": creditManualDate,
    };
}

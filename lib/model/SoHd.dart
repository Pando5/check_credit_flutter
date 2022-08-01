// To parse this JSON data, do
//
//     final soHd = soHdFromJson(jsonString);

import 'dart:convert';

List<SoHd> soHdFromJson(String str) => List<SoHd>.from(json.decode(str).map((x) => SoHd.fromJson(x)));

String soHdToJson(List<SoHd> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SoHd {
    SoHd({
        this.cvCode,
        this.cvName,
        this.soAmt,
        this.soDocumentNo,
    });

    String cvCode;
    String cvName;
    int soAmt;
    String soDocumentNo;

    factory SoHd.fromJson(Map<String, dynamic> json) => SoHd(
        cvCode: json["CvCode"],
        cvName: json["CvName"],
        soAmt: json["SoAmt"],
        soDocumentNo: json["SoDocumentNo"],
    );

    Map<String, dynamic> toJson() => {
        "CvCode": cvCode,
        "CvName": cvName,
        "SoAmt": soAmt,
        "SoDocumentNo": soDocumentNo,
    };
}
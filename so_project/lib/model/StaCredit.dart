// To parse this JSON data, do
//
//     final staCredit = staCreditFromJson(jsonString);

import 'dart:convert';

List<StaCredit> staCreditFromJson(String str) => List<StaCredit>.from(json.decode(str).map((x) => StaCredit.fromJson(x)));

String staCreditToJson(List<StaCredit> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StaCredit {
    StaCredit({
        this.orgCode,
        this.orgName,
        this.countDoc,
    });

    String orgCode;
    String orgName;
    int countDoc;

    factory StaCredit.fromJson(Map<String, dynamic> json) => StaCredit(
        orgCode: json["OrgCode"],
        orgName: json["OrgName"],
        countDoc: json["CountDoc"],
    );

    Map<String, dynamic> toJson() => {
        "OrgCode": orgCode,
        "OrgName": orgName,
        "CountDoc": countDoc,
    };
}

// To parse this JSON data, do
//
//     final org = orgFromJson(jsonString);

import 'dart:convert';

List<Org> orgFromJson(String str) => List<Org>.from(json.decode(str).map((x) => Org.fromJson(x)));

String orgToJson(List<Org> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Org {
    Org({
        this.orgCode,
        this.orgName,
        this.countDoc,
    });

    String orgCode;
    String orgName;
    int countDoc;

    factory Org.fromJson(Map<String, dynamic> json) => Org(
        orgCode: json["OrgCode"] as String,
        orgName: json["OrgName"] as String,
        countDoc: json["CountDoc"] as int,
    );

    Map<String, dynamic> toJson() => {
        "OrgCode": orgCode,
        "OrgName": orgName,
        "CountDoc": countDoc,
    };
}

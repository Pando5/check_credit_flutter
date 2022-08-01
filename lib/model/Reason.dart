// To parse this JSON data, do
//
//     final reason = reasonFromJson(jsonString);

import 'dart:convert';

List<Reason> reasonFromJson(String str) => List<Reason>.from(json.decode(str).map((x) => Reason.fromJson(x)));

String reasonToJson(List<Reason> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Reason {
    Reason({
        this.dataCode,
        this.dataName,
    });

    String dataCode;
    String dataName;

    factory Reason.fromJson(Map<String, dynamic> json) => Reason(
        dataCode: json["DataCode"],
        dataName: json["DataName"],
    );

    Map<String, dynamic> toJson() => {
        "DataCode": dataCode,
        "DataName": dataName,
    };
}

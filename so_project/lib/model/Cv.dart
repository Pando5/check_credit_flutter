// To parse this JSON data, do
//
//     final cv = cvFromJson(jsonString);

import 'dart:convert';

List<Cv> cvFromJson(String str) => List<Cv>.from(json.decode(str).map((x) => Cv.fromJson(x)));

String cvToJson(List<Cv> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cv {
    Cv({
        this.dataCode,
        this.dataName,
    });

    String dataCode;
    String dataName;

    factory Cv.fromJson(Map<String, dynamic> json) => Cv(
        dataCode: json["DataCode"],
        dataName: json["DataName"],
    );

    Map<String, dynamic> toJson() => {
        "DataCode": dataCode,
        "DataName": dataName,
    };
}

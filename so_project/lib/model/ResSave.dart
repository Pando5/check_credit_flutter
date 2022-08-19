// To parse this JSON data, do
//
//     final resSave = resSaveFromJson(jsonString);

import 'dart:convert';

ResSave resSaveFromJson(String str) => ResSave.fromJson(json.decode(str));

String resSaveToJson(ResSave data) => json.encode(data.toJson());

class ResSave {
    ResSave({
        this.businessUnit,
        this.subBusinessUnit,
        this.orgCode,
        this.soDocumentType,
        this.soDocumentNo,
        this.approveFlag,
        this.userId,
        this.reasonCode,
        this.remark,
    });

    String businessUnit;
    String subBusinessUnit;
    String orgCode;
    String soDocumentType;
    String soDocumentNo;
    String approveFlag;
    String userId;
    String reasonCode;
    String remark;

    factory ResSave.fromJson(Map<String, dynamic> json) => ResSave(
        businessUnit: json["BusinessUnit"],
        subBusinessUnit: json["SubBusinessUnit"],
        orgCode: json["OrgCode"],
        soDocumentType: json["SoDocumentType"],
        soDocumentNo: json["SoDocumentNo"],
        approveFlag: json["ApproveFlag"],
        userId: json["UserId"],
        reasonCode: json["ReasonCode"],
        remark: json["Remark"],
    );

    Map<String, dynamic> toJson() => {
        "BusinessUnit": businessUnit,
        "SubBusinessUnit": subBusinessUnit,
        "OrgCode": orgCode,
        "SoDocumentType": soDocumentType,
        "SoDocumentNo": soDocumentNo,
        "ApproveFlag": approveFlag,
        "UserId": userId,
        "ReasonCode": reasonCode,
        "Remark": remark,
    };
}

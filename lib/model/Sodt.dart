// To parse this JSON data, do
//
//     final soDt = soDtFromJson(jsonString);

import 'dart:convert';

List<SoDt> soDtFromJson(String str) => List<SoDt>.from(json.decode(str).map((x) => SoDt.fromJson(x)));

String soDtToJson(List<SoDt> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SoDt {
    SoDt({
        this.businessUnit,
        this.subBusinessUnit,
        this.orgCode,
        this.orgName,
        this.documentDate,
        this.soDocumentType,
        this.soDocumentNo,
        this.cvCode,
        this.cvName,
        this.saleMan,
        this.receiveDate,
        this.creditTerm,
        this.dueDay,
        this.dueDate,
        this.cashmanageGrpcode,
        this.cashmanageGrpcodeName,
        this.creditControlSapFlagLimit,
        this.creditControlSapSysdate,
        this.creditControlSapLimit,
        this.creditControlSapMaxdayInv,
        this.creditControlSapOverlimit,
        this.creditControlSapMaxdayChq,
        this.creditControlSapOutstanding,
        this.creditControlSapFlagDiscon,
        this.creditControlSapMessage,
        this.creditControlSapType,
        this.grossAmt,
        this.discAmt,
        this.freightAmt,
        this.vatAmt,
        this.netAmt,
        this.documentStatus,
        this.documentStatusName,
        this.creditControlReason,
        this.creditManualReason,
        this.soTotalAmt,
    });

    String businessUnit;
    String subBusinessUnit;
    String orgCode;
    String orgName;
    String documentDate;
    String soDocumentType;
    String soDocumentNo;
    String cvCode;
    String cvName;
    String saleMan;
    String receiveDate;
    String creditTerm;
    String dueDay;
    String dueDate;
    String cashmanageGrpcode;
    String cashmanageGrpcodeName;
    String creditControlSapFlagLimit;
    String creditControlSapSysdate;
    int creditControlSapLimit;
    int creditControlSapMaxdayInv;
    int creditControlSapOverlimit;
    int creditControlSapMaxdayChq;
    int creditControlSapOutstanding;
    String creditControlSapFlagDiscon;
    String creditControlSapMessage;
    String creditControlSapType;
    int grossAmt;
    int discAmt;
    int freightAmt;
    int vatAmt;
    int netAmt;
    String documentStatus;
    String documentStatusName;
    String creditControlReason;
    String creditManualReason;
    int soTotalAmt;

    factory SoDt.fromJson(Map<String, dynamic> json) => SoDt(
        businessUnit: json["BusinessUnit"],
        subBusinessUnit: json["SubBusinessUnit"],
        orgCode: json["OrgCode"],
        orgName: json["OrgName"],
        documentDate: json["DocumentDate"],
        soDocumentType: json["SoDocumentType"],
        soDocumentNo: json["SoDocumentNo"],
        cvCode: json["CvCode"],
        cvName: json["CvName"],
        saleMan: json["SaleMan"],
        receiveDate: json["ReceiveDate"],
        creditTerm: json["CreditTerm"],
        dueDay: json["DueDay"],
        dueDate: json["DueDate"],
        cashmanageGrpcode: json["CashmanageGrpcode"],
        cashmanageGrpcodeName: json["CashmanageGrpcodeName"],
        creditControlSapFlagLimit: json["CreditControlSapFlagLimit"],
        creditControlSapSysdate: json["CreditControlSapSysdate"],
        creditControlSapLimit: json["CreditControlSapLimit"],
        creditControlSapMaxdayInv: json["CreditControlSapMaxdayInv"],
        creditControlSapOverlimit: json["CreditControlSapOverlimit"],
        creditControlSapMaxdayChq: json["CreditControlSapMaxdayChq"],
        creditControlSapOutstanding: json["CreditControlSapOutstanding"],
        creditControlSapFlagDiscon: json["CreditControlSapFlagDiscon"],
        creditControlSapMessage: json["CreditControlSapMessage"],
        creditControlSapType: json["CreditControlSapType"],
        grossAmt: json["GrossAmt"],
        discAmt: json["DiscAmt"],
        freightAmt: json["FreightAmt"],
        vatAmt: json["VatAmt"],
        netAmt: json["NetAmt"],
        documentStatus: json["DocumentStatus"],
        documentStatusName: json["DocumentStatusName"],
        creditControlReason: json["CreditControlReason"],
        creditManualReason: json["CreditManualReason"],
        soTotalAmt: json["SoTotalAmt"],
    );

    Map<String, dynamic> toJson() => {
        "BusinessUnit": businessUnit,
        "SubBusinessUnit": subBusinessUnit,
        "OrgCode": orgCode,
        "OrgName": orgName,
        "DocumentDate": documentDate,
        "SoDocumentType": soDocumentType,
        "SoDocumentNo": soDocumentNo,
        "CvCode": cvCode,
        "CvName": cvName,
        "SaleMan": saleMan,
        "ReceiveDate": receiveDate,
        "CreditTerm": creditTerm,
        "DueDay": dueDay,
        "DueDate": dueDate,
        "CashmanageGrpcode": cashmanageGrpcode,
        "CashmanageGrpcodeName": cashmanageGrpcodeName,
        "CreditControlSapFlagLimit": creditControlSapFlagLimit,
        "CreditControlSapSysdate": creditControlSapSysdate,
        "CreditControlSapLimit": creditControlSapLimit,
        "CreditControlSapMaxdayInv": creditControlSapMaxdayInv,
        "CreditControlSapOverlimit": creditControlSapOverlimit,
        "CreditControlSapMaxdayChq": creditControlSapMaxdayChq,
        "CreditControlSapOutstanding": creditControlSapOutstanding,
        "CreditControlSapFlagDiscon": creditControlSapFlagDiscon,
        "CreditControlSapMessage": creditControlSapMessage,
        "CreditControlSapType": creditControlSapType,
        "GrossAmt": grossAmt,
        "DiscAmt": discAmt,
        "FreightAmt": freightAmt,
        "VatAmt": vatAmt,
        "NetAmt": netAmt,
        "DocumentStatus": documentStatus,
        "DocumentStatusName": documentStatusName,
        "CreditControlReason": creditControlReason,
        "CreditManualReason": creditManualReason,
        "SoTotalAmt": soTotalAmt,
    };
}

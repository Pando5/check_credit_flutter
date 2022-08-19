import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:so_project/model/Cv.dart';
import 'package:so_project/model/DetCredit.dart';
import 'package:so_project/model/Org.dart';
import 'package:so_project/model/Reason.dart';
import 'package:so_project/model/ResSave.dart';
import 'package:so_project/model/SoHd.dart';
import 'package:so_project/model/Sodt.dart';
import 'package:so_project/model/StaCredit.dart';

abstract class _Apiservice {
  Future unblockService(String pUser, String pCv, String date);
  Future accountService(String date, String pCv, String code);
  Future detailCreditService(String code, String docNo);
  Future reasonService();
  Future statusCreService(String start, String end);
  Future detailCreService(String code, String start, String end);
}

class ApiService extends _Apiservice {
  @override
  Future unblockService(String pUser, String pCv, String date) async {
    // TODO: implement orgService
    var url;
    if (pCv == null) {
      url = Uri.parse(
          "https://farmdev.cpf.co.th/UnBlockSoDeploy/api/SoOrg?pUser=${pUser}&pReqDateDdMmYyyy=${date}&pCv=");
    } else {
      url = Uri.parse(
          "https://farmdev.cpf.co.th/UnBlockSoDeploy/api/SoOrg?pUser=${pUser}&pReqDateDdMmYyyy=${date}&pCv=${pCv}");
    }
    var response = await http.get(url);
    // print('Response body: ${response.body}');
    return orgFromJson(response.body);
  }

  @override
  Future accountService(String date, String pCv, String code) async {
    // TODO: implement orgService
    var url;
    if (pCv == null) {
      url = Uri.parse(
          "https://farmdev.cpf.co.th/UnBlockSoDeploy/api/SoHd?pOrgCode=${code}&pReqDateDdMmYyyy=${date}&pCv=");
    } else {
      url = Uri.parse(
          "https://farmdev.cpf.co.th/UnBlockSoDeploy/api/SoHd?pOrgCode=${code}&pReqDateDdMmYyyy=${date}&pCv=${pCv}");
    }

    var response = await http.get(url);
    // print('Response body: ${response.body}');
    return soHdFromJson(response.body);
  }

  @override
  Future detailCreditService(String code, String docNo) async {
    // TODO: implement orgService
    var url = Uri.parse(
        "https://farmdev.cpf.co.th/UnBlockSoDeploy/api/SoDt?pOrgCode=${code}&pSoDocNo=${docNo}");
    var response = await http.get(url);
    print('Response body: ${response.body}');
    return soDtFromJson(response.body)[0];
  }

  @override
  Future cvService(String pUser, String date) async {
    // TODO: implement orgService
    var url = Uri.parse(
        "https://farmdev.cpf.co.th/UnBlockSoDeploy/api/Customer?pUser=${pUser}&pReqDateDdMmYyyy=${date}");
    var response = await http.get(url);
    print('Response body: ${response.body}');
    return cvFromJson(response.body);
  }

  @override
  Future reasonService() async {
    // TODO: implement orgService
    var url = Uri.parse("https://farmdev.cpf.co.th/UnBlockSoDeploy/api/Reason");
    var response = await http.get(url);
    print('Response body: ${response.body}');
    return reasonFromJson(response.body);
  }

  @override
  Future statusCreService(String start, String end) async {
    // TODO: implement orgService
    var url = Uri.parse(
        "https://farmdev.cpf.co.th/UnBlockSoDeploy/api/StatusSoOrg?pUser=ronnapoom.cha&pStartDateDdMmYyyy=${start}&pEndDateDdMmYyyy=${end}");
    var response = await http.get(url);
    print('Response body: ${response.body}');
    return staCreditFromJson(response.body);
  }

  @override
  Future detailCreService(String code, String start, String end) async {
    // TODO: implement orgService
    var url = Uri.parse(
        "https://farmdev.cpf.co.th/UnBlockSoDeploy/api/StatusSoHd?pOrgCode=${code}&pStartDateDdMmYyyy=${start}&pEndDateDdMmYyyy=${end}");
    var response = await http.get(url);
    print('Response body: ${response.body}');
    return detCreditFromJson(response.body);
  }

  @override
  Future saveService(ResSave resSave) async {
    // TODO: implement orgService
    var url = Uri.parse("https://farmdev.cpf.co.th/UnBlockSoDeploy/api/Save");

    var response = await http.post(
      url,
      body: {
          "BusinessUnit": resSave.businessUnit,
          "SubBusinessUnit": resSave.subBusinessUnit,
          "OrgCode": resSave.orgCode,
          "SoDocumentType": resSave.soDocumentType,
          "SoDocumentNo": resSave.soDocumentNo,
          "ApproveFlag": resSave.approveFlag,
          "UserId": resSave.userId,
          "ReasonCode": resSave.reasonCode,
          "Remark": resSave.remark,
        },
    );
    print('Response body: ${response.body}');
    return jsonDecode(response.body);
  }
}

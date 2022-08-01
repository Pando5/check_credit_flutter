import 'package:http/http.dart' as http;
import 'package:so_project/model/Org.dart';
import 'package:so_project/model/Reason.dart';
import 'package:so_project/model/SoHd.dart';
import 'package:so_project/model/Sodt.dart';
import 'package:so_project/model/StaCredit.dart';

abstract class _Apiservice {
  Future unblockService(String date);
  Future accountService(String date, String code);
  Future detailCreditService(String code, String docNo);
  Future reasonService();
  Future statusCreService(String start, String end);
}

class ApiService extends _Apiservice {

  @override
  Future unblockService(String date) async {
    // TODO: implement orgService
    var url = Uri.parse(
        "https://farmdev.cpf.co.th/UnBlockSoDeploy/api/SoOrg?pUser=ronnapoom.cha&pReqDateDdMmYyyy=${date}&pCv=");
    var response = await http.get(url);
    // print('Response body: ${response.body}');
    return orgFromJson(response.body);
  }

  @override
  Future accountService(String date, String code) async {
    // TODO: implement orgService
    var url = Uri.parse(
        "https://farmdev.cpf.co.th/UnBlockSoDeploy/api/SoHd?pOrgCode=${code}&pReqDateDdMmYyyy=${date}&pCv=");
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
    return soDtFromJson(response.body);
  }

  @override
  Future reasonService() async {
    // TODO: implement orgService
    var url = Uri.parse(
        "https://farmdev.cpf.co.th/UnBlockSoDeploy/api/Reason");
    var response = await http.get(url);
    print('Response body: ${response.body}');
    return reasonFromJson(response.body);
  }

  @override
  Future statusCreService(String start, String end) async {
    // TODO: implement orgService
    var url = Uri.parse(
        "https://farmdev.cpf.co.th/UnBlockSoDeploy/api/StatusSoOrg?pUser=ronnapoom.cha&pStartDateDdMmYyyy=${start}&pEndDateDdMmYyyy=${start}");
    var response = await http.get(url);
    print('Response body: ${response.body}');
    return staCreditFromJson(response.body);
  }
}

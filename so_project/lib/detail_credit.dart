import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:so_project/account.dart';
import 'package:so_project/main_SO.dart';
import 'package:so_project/model/Reason.dart';
import 'package:so_project/model/ResSave.dart';
import 'package:so_project/model/Sodt.dart';
import 'package:so_project/service/service.dart';

class Detail_Credit extends StatefulWidget {
  final String soDocNo;
  final String so_id;
  const Detail_Credit({Key key, this.so_id, this.soDocNo}) : super(key: key);

  @override
  State<Detail_Credit> createState() => _Detail_CreditState();
}

class _Detail_CreditState extends State<Detail_Credit> {
  SoDt data;
  String soDocNo;
  String so_id;
  String remark = "";
  String reasonCode = "";
  String valueChoose;
  var response;
  final amountFormat = NumberFormat("#,##0.00", "en_US");

  // List<SoDt> doc = [];
  List<Reason> reason = [];
  ApiService _apiService = new ApiService();

  Future _callService() async {
    data = await _apiService.detailCreditService(so_id, soDocNo);
    reason = await _apiService.reasonService();
  }

  Future<Null> unblock() async {
    ResSave resSave = ResSave(
      businessUnit: data.businessUnit,
      subBusinessUnit: data.subBusinessUnit,
      orgCode: data.orgCode,
      soDocumentType: data.soDocumentType,
      soDocumentNo: data.soDocumentNo,
      approveFlag: "Y",
      userId: "USERTEST",
      reasonCode: valueChoose,
      remark: remark,
    );
    response = await _apiService.saveService(resSave);
  }

  Future<Null> block() async {
    ResSave resSave = ResSave(
      businessUnit: data.businessUnit,
      subBusinessUnit: data.subBusinessUnit,
      orgCode: data.orgCode,
      soDocumentType: data.soDocumentType,
      soDocumentNo: data.soDocumentNo,
      approveFlag: "N",
      userId: "USERTEST",
      reasonCode: valueChoose,
      remark: remark,
    );
    // print(
    //     '"BusinessUnit": ${resSave.businessUnit}, "SubBusinessUnit": ${resSave.subBusinessUnit}, "OrgCode": $resSave.orgCode, "SoDocumentType": ${resSave.soDocumentType}, "SoDocumentNo": ${resSave.soDocumentNo}, "ApproveFlag": ${resSave.approveFlag}, "UserId": ${resSave.userId}, "ReasonCode": ${resSave.reasonCode}, "Remark": ${resSave.remark},');
    response = await _apiService.saveService(resSave);
  }

  @override
  void initState() {
    // TODO: implement initState
    so_id = widget.so_id;
    soDocNo = widget.soDocNo;
    _callService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: HexColor("#F6F9FF"),
      appBar: AppBar(
        title: Container(
          width: 250,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "SO Unblock",
                style: TextStyle(
                  color: HexColor("#2B3674"),
                  fontFamily: "CPF Imm Sook",
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: HexColor("#FFFFFF"),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios_new,
            color: HexColor("#2B3674"),
          ),
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return Account(
                orgCode: data.orgCode,
                orgName: data.orgName,
              );
            }));
          },
        ),
        elevation: 0,
      ),
      body: FutureBuilder(
        future: _apiService.detailCreditService(so_id, soDocNo),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('เกิดข้อผิดพลาดในการโหลดข้อมูล ${snapshot.error}');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return SingleChildScrollView(
                child: Column(
                  children: [
                    header(_size),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      child: Column(
                        children: [
                          info_account(),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, right: 8),
                                child: Icon(
                                  Icons.monetization_on_outlined,
                                  color: HexColor("#34C5B2"),
                                  size: 25,
                                ),
                              ),
                              Text(
                                "รายละเอียดเงิน",
                                style: TextStyle(
                                  color: HexColor("#2B3674"),
                                  fontFamily: "CPF Imm Sook",
                                  fontSize: 21,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                          info_finance(),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, right: 8),
                                child: Icon(
                                  Icons.credit_card,
                                  color: HexColor("#34C5B2"),
                                  size: 25,
                                ),
                              ),
                              Text(
                                "รายละเอียดเครดิต",
                                style: TextStyle(
                                  color: HexColor("#2B3674"),
                                  fontFamily: "CPF Imm Sook",
                                  fontSize: 21,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                          info_credit(),
                          Botton(),
                        ],
                      ),
                    ),
                  ],
                ),
              );
              break;
            case ConnectionState.active:
              return Text('ข้อมูลคือ ${snapshot.data}');
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [CircularProgressIndicator()],
                ),
              );
              break;
            case ConnectionState.none:
              return Text('No connection');
              break;
            default:
              print('Something else'); // execute unknown()
          }
          return null;
        },
      ),
    );
  }

  Widget header(size) => Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(right: 20, bottom: 20, left: 20),
        decoration: BoxDecoration(
          color: HexColor("#FFFFFF"),
          boxShadow: [
            BoxShadow(
              color: HexColor("#6a78aa").withOpacity(0.3),
              spreadRadius: 0.01,
              blurRadius: 15,
              offset: const Offset(0, 10),
            ),
          ],
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          // border: Border.all(width: 0)
        ),
        alignment: Alignment.center,
        child: Container(
          padding: EdgeInsets.only(top: 15, right: 13, bottom: 15, left: 13),
          decoration: BoxDecoration(
            color: HexColor("#F6F9FF"),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.account_circle_outlined,
                size: 70,
                color: HexColor("#34C5B2"),
              ),
              Container(
                width: size.width * 0.65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ชื่อลูกค้า
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "ชื่อลูกค้า",
                            style: TextStyle(
                              color: HexColor("#6878AB"),
                              fontFamily: "CPF Imm Sook",
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              "${data.cvCode}-${data.cvName}",
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(
                                color: HexColor("#21284F"),
                                fontFamily: "CPF Imm Sook",
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // เลข SO
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "เลข So",
                            style: TextStyle(
                              color: HexColor("#6878AB"),
                              fontFamily: "CPF Imm Sook",
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "${data.soDocumentNo}",
                            style: TextStyle(
                              color: HexColor("#21284F"),
                              fontFamily: "CPF Imm Sook",
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // วงเงินเครดิต/เกินวงเงิน
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "วงเงินเครดิต/เกินวงเงิน",
                            style: TextStyle(
                              color: HexColor("#6878AB"),
                              fontFamily: "CPF Imm Sook",
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "${amountFormat.format(data.creditControlSapLimit)} / ${amountFormat.format(data.creditControlSapOverlimit)}",
                            style: TextStyle(
                              color: HexColor("#21284F"),
                              fontFamily: "CPF Imm Sook",
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget info_account() => Card(
        elevation: 4,
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        margin: EdgeInsets.symmetric(vertical: 20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Container(
            child: Column(
              children: [
                // หน่วยงาน
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "หน่วยงาน",
                        style: TextStyle(
                          color: HexColor("#6878AB"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        alignment: Alignment.centerRight,
                        child: Text(
                          "${data.orgCode}-${data.orgName}",
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          softWrap: false,
                          style: TextStyle(
                            color: HexColor("#21284F"),
                            fontFamily: "CPF Imm Sook",
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // วันที่เช็คเครดิต
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "วันที่เช็คเครดิต",
                        style: TextStyle(
                          color: HexColor("#6878AB"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "${data.creditControlSapSysdate}",
                        style: TextStyle(
                          color: HexColor("#21284F"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                // เงิน So / So คงค้าง
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "เงิน So / So คงค้าง",
                        style: TextStyle(
                          color: HexColor("#6878AB"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "${amountFormat.format(data.netAmt)} / ${amountFormat.format(data.soTotalAmt)}",
                        style: TextStyle(
                          color: HexColor("#21284F"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                // บิลค้างชำระเกินกำหนด(วัน)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "บิลค้างชำระเกินกำหนด(วัน)",
                        style: TextStyle(
                          color: HexColor("#6878AB"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "${data.creditControlSapMaxdayInv}",
                        style: TextStyle(
                          color: HexColor("#21284F"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                // เกินวงเงิน(บาท)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "เกินวงเงิน(บาท)",
                        style: TextStyle(
                          color: HexColor("#6878AB"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "${amountFormat.format(data.creditControlSapOverlimit)}",
                        style: TextStyle(
                          color: HexColor("#21284F"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                // จำนวนวันเช็คคืน(วัน)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "จำนวนวันเช็คคืน(วัน)",
                        style: TextStyle(
                          color: HexColor("#6878AB"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "${data.creditControlSapMaxdayChq}",
                        style: TextStyle(
                          color: HexColor("#21284F"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                // ยอดค้างชำระ(บาท)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ยอดค้างชำระ(บาท)",
                      style: TextStyle(
                        color: HexColor("#6878AB"),
                        fontFamily: "CPF Imm Sook",
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "${amountFormat.format(data.creditControlSapOutstanding)}",
                      style: TextStyle(
                        color: HexColor("#21284F"),
                        fontFamily: "CPF Imm Sook",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget info_finance() => Card(
        elevation: 4,
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        margin: EdgeInsets.only(top: 5, bottom: 20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Container(
            child: Column(
              children: [
                // วันที่เอกสาร
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "วันที่เอกสาร",
                        style: TextStyle(
                          color: HexColor("#6878AB"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "${data.documentDate}",
                        style: TextStyle(
                          color: HexColor("#21284F"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                // วันที่ต้องการสินค้า
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "วันที่ต้องการสินค้า",
                        style: TextStyle(
                          color: HexColor("#6878AB"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "${data.receiveDate}",
                        style: TextStyle(
                          color: HexColor("#21284F"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                // เงื่อนไขการชำระเงิน
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "เงื่อนไขการชำระเงิน",
                        style: TextStyle(
                          color: HexColor("#6878AB"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "${data.creditTerm}",
                        style: TextStyle(
                          color: HexColor("#21284F"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                // วันครบกำหนด
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "วันครบกำหนด",
                        style: TextStyle(
                          color: HexColor("#6878AB"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "${data.dueDate}",
                        style: TextStyle(
                          color: HexColor("#21284F"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                // พนักงานขาย
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "พนักงานขาย",
                        style: TextStyle(
                          color: HexColor("#6878AB"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "${data.saleMan}",
                        style: TextStyle(
                          color: HexColor("#21284F"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                // จำนวนเงิน
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "จำนวนเงิน",
                        style: TextStyle(
                          color: HexColor("#6878AB"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "${amountFormat.format(data.grossAmt)}",
                        style: TextStyle(
                          color: HexColor("#21284F"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                // ส่วนลด
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ส่วนลด",
                        style: TextStyle(
                          color: HexColor("#6878AB"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "${amountFormat.format(data.discAmt)}",
                        style: TextStyle(
                          color: HexColor("#21284F"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                // ค่าขนส่ง
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ค่าขนส่ง",
                        style: TextStyle(
                          color: HexColor("#6878AB"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "${amountFormat.format(data.freightAmt)}",
                        style: TextStyle(
                          color: HexColor("#21284F"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                // จำนวนเงินสุทธิ
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Text(
                          "จำนวนเงินสุทธิ",
                          style: TextStyle(
                            color: HexColor("#6878AB"),
                            fontFamily: "CPF Imm Sook",
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Text(
                        "${amountFormat.format(data.netAmt)}",
                        style: TextStyle(
                          color: HexColor("#21284F"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                // จำนวนเงิน So ค้าง
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "จำนวนเงิน So ค้าง",
                      style: TextStyle(
                        color: HexColor("#6878AB"),
                        fontFamily: "CPF Imm Sook",
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "${amountFormat.format(data.soTotalAmt)}",
                      style: TextStyle(
                        color: HexColor("#21284F"),
                        fontFamily: "CPF Imm Sook",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget info_credit() => Card(
        elevation: 4,
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        margin: EdgeInsets.only(top: 5, bottom: 20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Container(
            child: Column(
              children: [
                // ยอดหนี้ค้างชำระ(บาท)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ยอดหนี้ค้างชำระ(บาท)",
                        style: TextStyle(
                          color: HexColor("#6878AB"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "${amountFormat.format(data.creditControlSapOutstanding)}",
                        style: TextStyle(
                          color: HexColor("#21284F"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                // วันที่เช็คเครดิต
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "วันที่เช็คเครดิต",
                        style: TextStyle(
                          color: HexColor("#6878AB"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "${data.creditControlSapSysdate}",
                        style: TextStyle(
                          color: HexColor("#21284F"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                // วงเงินเครดิต(บาท)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "วงเงินเครดิต(บาท)",
                        style: TextStyle(
                          color: HexColor("#6878AB"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "${amountFormat.format(data.creditControlSapLimit)}",
                        style: TextStyle(
                          color: HexColor("#21284F"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                // บิลค้างชำระเกินกำหนด(วัน)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "บิลค้างชำระเกินกำหนด(วัน)",
                        style: TextStyle(
                          color: HexColor("#6878AB"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "${data.creditControlSapMaxdayInv}",
                        style: TextStyle(
                          color: HexColor("#21284F"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                // เกินวงเงิน(บาท)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "เกินวงเงิน(บาท)",
                        style: TextStyle(
                          color: HexColor("#6878AB"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "${amountFormat.format(data.creditControlSapOverlimit)}",
                        style: TextStyle(
                          color: HexColor("#21284F"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                // จำนวนวันเช็คคืน(วัน)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "จำนวนวันเช็คคืน(วัน)",
                      style: TextStyle(
                        color: HexColor("#6878AB"),
                        fontFamily: "CPF Imm Sook",
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "${data.creditControlSapMaxdayChq}",
                      style: TextStyle(
                        color: HexColor("#21284F"),
                        fontFamily: "CPF Imm Sook",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget Botton() => Column(
        children: [
          GestureDetector(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 10.0),
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                  color: HexColor("#50C5B1"),
                  borderRadius: BorderRadius.circular(8)),
              alignment: Alignment.center,
              child: Text(
                "Unblock",
                style: TextStyle(
                  color: HexColor("#FFFFFF"),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: "CPF Imm Sook",
                ),
              ),
            ),
            onTap: () {
              Unblock();
            },
          ),
          GestureDetector(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 10.0),
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: HexColor("#F5222D"),
                borderRadius: BorderRadius.circular(8),
                // border: Border.all(
                //   width: 1,
                //   color: HexColor("#2B3674"),
                // ),
              ),
              alignment: Alignment.center,
              child: Text(
                "Block",
                style: TextStyle(
                  color: HexColor("#FFFFFF"),
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                  fontFamily: "CPF Imm Sook",
                ),
              ),
            ),
            onTap: () {
              Block();
            },
          ),
        ],
      );

  Future Unblock() => showDialog<String>(
        context: context,
        barrierColor: HexColor("#2B3674").withOpacity(0.5),
        builder: (BuildContext context) => AlertDialog(
            backgroundColor: HexColor("#FFFFFF"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                width: 2,
                color: HexColor("#34C5B2"),
              ),
            ),
            title: Center(
              child: Text(
                "Unblock",
                style: TextStyle(
                  color: HexColor("#34C5B2"),
                  fontFamily: "CPF Imm Sook",
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            content: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height * 0.17,
                color: HexColor("#FFFFFF"),
                child: Column(
                  children: [
                    // สาเหตุ
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                "สาเหตุ",
                                style: TextStyle(
                                  color: HexColor("#21284F"),
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            StatefulBuilder(
                              builder: (BuildContext context,
                                      StateSetter setState) =>
                                  Container(
                                width: MediaQuery.of(context).size.width * 0.67,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                height: 50,
                                decoration: BoxDecoration(
                                  color: HexColor("#FFFFFF"),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    width: 1,
                                    color: HexColor("#D1D7E7"),
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    style: TextStyle(
                                      color: HexColor("#21284F"),
                                      fontFamily: "CPF Imm Sook",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    value: valueChoose,
                                    hint: Text(
                                      "กรุณาเลือกเหตุผล",
                                      style: TextStyle(
                                        color: HexColor("#6878AB")
                                            .withOpacity(0.5),
                                        fontFamily: "CPF Imm Sook",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: HexColor("#D1D7E7"),
                                    ),
                                    isExpanded: true,
                                    onChanged: (newValue) {
                                      setState(() {
                                        valueChoose = newValue;
                                      });
                                    },
                                    items:
                                        reason.map<DropdownMenuItem>((value) {
                                      return DropdownMenuItem(
                                        // alignment: AlignmentDirectional.center,
                                        value: value.dataCode,
                                        child: Text(value.dataName),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    // หมายเหตุ
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 10, top: 15),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "หมายเหตุ",
                                    style: TextStyle(
                                      color: HexColor("#21284F"),
                                      fontFamily: "CPF Imm Sook",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 5,
                                    ),
                                    child: Text(
                                      "(optional)",
                                      style: TextStyle(
                                        color: HexColor("#6878AB"),
                                        fontFamily: "CPF Imm Sook",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: HexColor("#FFFFFF"),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  width: 1,
                                  color: HexColor("#D1D7E7"),
                                ),
                              ),
                              width: MediaQuery.of(context).size.width * 0.67,
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.01),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      maxLength: 500,
                                      minLines: 4,
                                      maxLines: 10,
                                      style: TextStyle(
                                        color: HexColor("#21284F"),
                                        fontFamily: "CPF Imm Sook",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      decoration: InputDecoration(
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide.none,
                                        ),
                                        fillColor: HexColor("#FFFFFF"),
                                        hintText: "กรอกหมายเหตุ",
                                        hintStyle: TextStyle(
                                          color: HexColor("#D1D7E7"),
                                        ),
                                        // filled: true,
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          remark = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // ปุ่ม
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.33,
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                color: HexColor("#FFFFFF"),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  width: 1,
                                  color: HexColor("#2B3674"),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "ยกเลิก",
                                style: TextStyle(
                                  color: HexColor("#2B3674"),
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "CPF Imm Sook",
                                ),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                valueChoose = null;
                                remark = "";
                              });
                              Navigator.pop(context);
                            },
                          ),
                          GestureDetector(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.33,
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                  color: HexColor("#2B3674"),
                                  borderRadius: BorderRadius.circular(8)),
                              alignment: Alignment.center,
                              child: Text(
                                "ตกลง",
                                style: TextStyle(
                                  color: HexColor("#FFFFFF"),
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "CPF Imm Sook",
                                ),
                              ),
                            ),
                            onTap: () async {
                              if (valueChoose != null && valueChoose != "") {
                                await unblock();
                                Navigator.pop(context);

                                if (response["FlagSave"] != "N") {
                                  Confirm_Unblock();
                                } else {
                                  print('test $response');
                                  Error_Unblock();
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
      );

  Future Block() => showDialog<String>(
        context: context,
        barrierColor: HexColor("#2B3674").withOpacity(0.5),
        builder: (BuildContext context) => AlertDialog(
          backgroundColor: HexColor("#FFFFFF"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              width: 2,
              color: HexColor("#F5222D"),
            ),
          ),
          title: Center(
            child: Text(
              "Block",
              style: TextStyle(
                color: HexColor("#F5222D"),
                fontFamily: "CPF Imm Sook",
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          content: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height * 0.17,
              color: HexColor("#FFFFFF"),
              child: Column(
                children: [
                  // สาเหตุ
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              "สาเหตุ",
                              style: TextStyle(
                                color: HexColor("#21284F"),
                                fontSize: 15,
                              ),
                            ),
                          ),
                          StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) =>
                                    Container(
                              width: MediaQuery.of(context).size.width * 0.67,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height: 50,
                              decoration: BoxDecoration(
                                color: HexColor("#FFFFFF"),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  width: 1,
                                  color: HexColor("#D1D7E7"),
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  style: TextStyle(
                                    color: HexColor("#21284F"),
                                    fontFamily: "CPF Imm Sook",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  // decoration: InputDecoration(
                                  //   enabledBorder: OutlineInputBorder(
                                  //     borderRadius: BorderRadius.circular(12),
                                  //     borderSide: BorderSide.none,
                                  //   ),
                                  //   focusedBorder: InputBorder.none,
                                  // ),
                                  value: valueChoose,
                                  hint: Text(
                                    "กรุณาเลือกเหตุผล",
                                    style: TextStyle(
                                      color:
                                          HexColor("#6878AB").withOpacity(0.5),
                                      fontFamily: "CPF Imm Sook",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: HexColor("#D1D7E7"),
                                  ),
                                  isExpanded: true,
                                  onChanged: (newValue) {
                                    setState(() {
                                      valueChoose = newValue;
                                    });
                                  },
                                  items: reason.map<DropdownMenuItem>((value) {
                                    return DropdownMenuItem(
                                      // alignment: AlignmentDirectional.center,
                                      value: value.dataCode,
                                      child: Text(value.dataName),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  // หมายเหตุ
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10, top: 15),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "หมายเหตุ",
                                  style: TextStyle(
                                    color: HexColor("#21284F"),
                                    fontFamily: "CPF Imm Sook",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 5,
                                  ),
                                  child: Text(
                                    "(optional)",
                                    style: TextStyle(
                                      color: HexColor("#6878AB"),
                                      fontFamily: "CPF Imm Sook",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: HexColor("#FFFFFF"),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                width: 1,
                                color: HexColor("#D1D7E7"),
                              ),
                            ),
                            width: MediaQuery.of(context).size.width * 0.67,
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.01),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    maxLength: 500,
                                    minLines: 4,
                                    maxLines: 10,
                                    style: TextStyle(
                                      color: HexColor("#21284F"),
                                      fontFamily: "CPF Imm Sook",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    decoration: InputDecoration(
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                      fillColor: HexColor("#FFFFFF"),
                                      hintText: "กรอกหมายเหตุ",
                                      hintStyle: TextStyle(
                                        color: HexColor("#D1D7E7"),
                                      ),
                                      // filled: true,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        remark = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // ปุ่ม
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.33,
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              color: HexColor("#FFFFFF"),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                width: 1,
                                color: HexColor("#2B3674"),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "ยกเลิก",
                              style: TextStyle(
                                color: HexColor("#2B3674"),
                                fontSize: 19,
                                fontWeight: FontWeight.w500,
                                fontFamily: "CPF Imm Sook",
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              valueChoose = null;
                              remark = "";
                            });
                            Navigator.pop(context);
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.33,
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                color: HexColor("#2B3674"),
                                borderRadius: BorderRadius.circular(8)),
                            alignment: Alignment.center,
                            child: Text(
                              "ตกลง",
                              style: TextStyle(
                                color: HexColor("#FFFFFF"),
                                fontSize: 19,
                                fontWeight: FontWeight.w500,
                                fontFamily: "CPF Imm Sook",
                              ),
                            ),
                          ),
                          onTap: () async {
                            if (valueChoose != null && valueChoose != "") {
                              await block();
                              Navigator.pop(context);

                              if (response["FlagSave"] != "N") {
                                Confirm_Block();
                              } else {
                                Error_Block();
                                print('test $response');
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Future Confirm_Unblock() => showDialog<String>(
        context: context,
        barrierColor: HexColor("#2B3674").withOpacity(0.5),
        builder: (BuildContext context) => AlertDialog(
          // title: Center(child: Text('AlertDialog Title')),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.38,
            color: HexColor("#FFFFFF"),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline_rounded,
                    color: HexColor("#34C5B2"),
                    size: 120,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "การอนุมัติสำเร็จ",
                        style: TextStyle(
                          color: HexColor("#000000"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "คุณทำการอนุมัติเรียบร้อยเเล้ว",
                          style: TextStyle(
                            color: HexColor("#21284F"),
                            fontFamily: "CPF Imm Sook",
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: GestureDetector(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            color: HexColor("#2B3674"),
                            borderRadius: BorderRadius.circular(8)),
                        alignment: Alignment.center,
                        child: Text(
                          "ตกลง",
                          style: TextStyle(
                            color: HexColor("#FFFFFF"),
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                            fontFamily: "CPF Imm Sook",
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return Account(
                            orgCode: data.orgCode,
                            orgName: data.orgName,
                          );
                        }));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Future Confirm_Block() => showDialog<String>(
        context: context,
        barrierColor: HexColor("#2B3674").withOpacity(0.5),
        builder: (BuildContext context) => AlertDialog(
          // title: Center(child: Text('AlertDialog Title')),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.38,
            color: HexColor("#FFFFFF"),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline_rounded,
                    color: HexColor("#34C5B2"),
                    size: 120,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ปฏิเสธการอนุมัติสำเร็จ",
                        style: TextStyle(
                          color: HexColor("#000000"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "คุณปฏิเสธการอนุมัติเรียบร้อยเเล้ว",
                          style: TextStyle(
                            color: HexColor("#21284F"),
                            fontFamily: "CPF Imm Sook",
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: GestureDetector(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            color: HexColor("#2B3674"),
                            borderRadius: BorderRadius.circular(8)),
                        alignment: Alignment.center,
                        child: Text(
                          "ตกลง",
                          style: TextStyle(
                            color: HexColor("#FFFFFF"),
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                            fontFamily: "CPF Imm Sook",
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return Account(
                            orgCode: data.orgCode,
                            orgName: data.orgName,
                          );
                        }));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Future Error_Block() => showDialog<String>(
        context: context,
        barrierColor: HexColor("#2B3674").withOpacity(0.5),
        builder: (BuildContext context) => AlertDialog(
          // title: Center(child: Text('AlertDialog Title')),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.28,
            color: HexColor("#FFFFFF"),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.highlight_off_outlined,
                    color: HexColor("#F5222D"),
                    size: 120,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ปฏิเสธการอนุมัติไม่สำเร็จ",
                        style: TextStyle(
                          color: HexColor("#000000"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 10),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Text(
                  //         "คุณปฏิเสธการอนุมัติเรียบร้อยเเล้ว",
                  //         style: TextStyle(
                  //           color: HexColor("#21284F"),
                  //           fontFamily: "CPF Imm Sook",
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.w400,
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: GestureDetector(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            color: HexColor("#2B3674"),
                            borderRadius: BorderRadius.circular(8)),
                        alignment: Alignment.center,
                        child: Text(
                          "ตกลง",
                          style: TextStyle(
                            color: HexColor("#FFFFFF"),
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                            fontFamily: "CPF Imm Sook",
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          valueChoose = null;
                          remark = "";
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Future Error_Unblock() => showDialog<String>(
        context: context,
        barrierColor: HexColor("#2B3674").withOpacity(0.5),
        builder: (BuildContext context) => AlertDialog(
          // title: Center(child: Text('AlertDialog Title')),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.28,
            color: HexColor("#FFFFFF"),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.highlight_off_outlined,
                    color: HexColor("#F5222D"),
                    size: 120,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "การอนุมัติไม่สำเร็จ",
                        style: TextStyle(
                          color: HexColor("#000000"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 10),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Text(
                  //         "คุณปฏิเสธการอนุมัติเรียบร้อยเเล้ว",
                  //         style: TextStyle(
                  //           color: HexColor("#21284F"),
                  //           fontFamily: "CPF Imm Sook",
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.w400,
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: GestureDetector(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            color: HexColor("#2B3674"),
                            borderRadius: BorderRadius.circular(8)),
                        alignment: Alignment.center,
                        child: Text(
                          "ตกลง",
                          style: TextStyle(
                            color: HexColor("#FFFFFF"),
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                            fontFamily: "CPF Imm Sook",
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          valueChoose = null;
                          remark = "";
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

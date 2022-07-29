import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:so_ui_flutter/main_SO.dart';
import 'package:so_ui_flutter/model/SO.dart';
import 'package:so_ui_flutter/model/account_model.dart';

class Detail_Credit extends StatefulWidget {
  final Account_Model data;
  final String so_id;
  final SO_Model soData;
  const Detail_Credit({Key key, this.data, this.so_id, this.soData})
      : super(key: key);

  @override
  State<Detail_Credit> createState() => _Detail_CreditState();
}

class _Detail_CreditState extends State<Detail_Credit> {
  String valueChoose;
  Account_Model data;
  SO_Model soData;
  String so_id;
  final listItem = ["item1", "item2", "item3", "item4", "item5"];
  final amountFormat = NumberFormat("#,##0.00", "en_US");

  Future<Null> unblock() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt("Open", 1);
    List<String> old_data = preferences.getStringList("Data");
    String dataDecode = '$old_data';
    var tagObjsJson = jsonDecode(dataDecode) as List;
    List<SO_Model> main_data =
        tagObjsJson.map((tagJson) => SO_Model.fromJson(tagJson)).toList();

    for (int i = 0; i < main_data.length; i++) {
      if (main_data[i].id.contains(so_id)) {
        for (int j = 0; j < main_data[i].account.length; j++) {
          if (main_data[i].account[j].id.contains(data.id)) {
            main_data[i].account.removeAt(j);
            break;
          }
        }
      }
    }
    List<String> new_data = [];
    for (var item in main_data) {
      SO_Model item_selected =
          SO_Model(item.id, item.name, item.amount, item.account);
      String jsonProd = jsonEncode(item_selected);
      new_data.add(jsonProd);
    }
    // await Future.delayed(Duration(seconds: 1));
    await preferences.setStringList("Data", new_data);
  }

  Future<Null> block() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt("Open", 1);
    List<String> old_data = preferences.getStringList("Data");
    String dataDecode = '$old_data';
    var tagObjsJson = jsonDecode(dataDecode) as List;
    List<SO_Model> main_data =
        tagObjsJson.map((tagJson) => SO_Model.fromJson(tagJson)).toList();

    for (int i = 0; i < main_data.length; i++) {
      if (main_data[i].id.contains(so_id)) {
        for (int j = 0; j < main_data[i].account.length; j++) {
          if (main_data[i].account[j].id.contains(data.id)) {
            main_data[i].account.removeAt(j);
          }
        }
      }
    }
    List<String> new_data = [];
    for (var item in main_data) {
      SO_Model item_selected =
          SO_Model(item.id, item.name, item.amount, item.account);
      String jsonProd = jsonEncode(item_selected);
      new_data.add(jsonProd);
    }
    // await Future.delayed(Duration(seconds: 1));
    await preferences.setStringList("Data", new_data);
  }

  @override
  void initState() {
    // TODO: implement initState
    data = widget.data;
    so_id = widget.so_id;
    soData = widget.soData;
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
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            header(_size),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Column(
                children: [
                  info_account(),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5, right: 8),
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
                        padding: const EdgeInsets.only(top: 5, right: 8),
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
                          Text(
                            "${data.name}",
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
                            "${data.id}",
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
                            "15,000.00 / 0",
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

                    // Padding(
                    //   padding: const EdgeInsets.only(bottom: 10),
                    //   child: Text(
                    //     "2000202323-มณีรัตน์ พลเดช",
                    //     style: TextStyle(
                    //       color: HexColor("#21284F"),
                    //       fontFamily: "CPF Imm Sook",
                    //       fontSize: 15,
                    //       fontWeight: FontWeight.w600,
                    //     ),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(bottom: 10),
                    //   child: Text(
                    //     "So 120450654727437",
                    //     style: TextStyle(
                    //       color: HexColor("#21284F"),
                    //       fontFamily: "CPF Imm Sook",
                    //       fontSize: 15,
                    //       fontWeight: FontWeight.w600,
                    //     ),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(bottom: 10),
                    //   child: Text(
                    //     "15,000.00 / 0",
                    //     style: TextStyle(
                    //       color: HexColor("#21284F"),
                    //       fontFamily: "CPF Imm Sook",
                    //       fontSize: 15,
                    //       fontWeight: FontWeight.w600,
                    //     ),
                    //   ),
                    // ),
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
                          "${soData.id}-${soData.name}",
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
                        "05/07/2022 14:10:59",
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
                        "${amountFormat.format(data.amount)}/0.00",
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
                        "2",
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
                        "0.00",
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
                        "0",
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
                      "1,160.00",
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
        margin: EdgeInsets.symmetric(vertical: 20),
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
                        "05/07/2022",
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
                        "06/07/2022",
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
                        "0",
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
                        "06/07/2022",
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
                        "9999999",
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
                        "1,740.00",
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
                        "0.00",
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
                        "0.00",
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
                      Text(
                        "จำนวนเงินสุทธิ",
                        style: TextStyle(
                          color: HexColor("#6878AB"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "1,740.00",
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
                      "0.00",
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
        margin: EdgeInsets.symmetric(vertical: 20),
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
                        "1,160.00",
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
                        "05/07/2022 14:10:59",
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
                        "1,740.00/0.00",
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
                        "2",
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
                        "0.00",
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
                      "0",
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
              Confirm_Unblock();
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
              Confirm_Block();
            },
          ),
        ],
      );

  Future Confirm_Unblock() => showDialog<String>(
        context: context,
        barrierColor: HexColor("#2B3674").withOpacity(0.5),
        builder: (BuildContext context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
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
                            Container(
                              width: MediaQuery.of(context).size.width * 0.68,
                              decoration: BoxDecoration(
                                color: HexColor("#FFFFFF"),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField<String>(
                                  style: TextStyle(
                                    color: HexColor("#21284F"),
                                    fontFamily: "CPF Imm Sook",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: HexColor("#D1D7E7"),
                                      ),
                                    ),
                                    focusedBorder: InputBorder.none,
                                  ),
                                  value: valueChoose,
                                  hint: Text(
                                    "กรุณาเลือกเหตุผล",
                                    style: TextStyle(
                                      color:
                                          HexColor("#6878AB").withOpacity(0.5),
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: HexColor("#D1D7E7"),
                                  ),
                                  isExpanded: true,
                                  onChanged: (String newValue) {
                                    setState(() {
                                      valueChoose = newValue;
                                    });
                                  },
                                  items: listItem.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
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
                              width: MediaQuery.of(context).size.width * 0.68,
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
                                          borderSide: BorderSide(
                                            color: HexColor("#D1D7E7"),
                                            width: 1,
                                          ),
                                        ),
                                        fillColor: HexColor("#FFFFFF"),
                                        hintText: "กรอกหมายเหตุ",
                                        hintStyle: TextStyle(
                                          color: HexColor("#D1D7E7"),
                                        ),
                                        filled: true,
                                      ),
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
                            onTap: () {
                              unblock();
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Main_SO();
                              }));
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

  Future Confirm_Block() => showDialog<String>(
        context: context,
        barrierColor: HexColor("#2B3674").withOpacity(0.5),
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
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
                          Container(
                            width: MediaQuery.of(context).size.width * 0.68,
                            decoration: BoxDecoration(
                              color: HexColor("#FFFFFF"),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField<String>(
                                style: TextStyle(
                                  color: HexColor("#21284F"),
                                  fontFamily: "CPF Imm Sook",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: InputDecoration(
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: HexColor("#D1D7E7"),
                                    ),
                                  ),
                                ),
                                value: valueChoose,
                                hint: Text(
                                  "กรุณาเลือกเหตุผล",
                                  style: TextStyle(
                                    color: HexColor("#6878AB").withOpacity(0.5),
                                  ),
                                ),
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: HexColor("#D1D7E7"),
                                ),
                                isExpanded: true,
                                onChanged: (String newValue) {
                                  setState(() {
                                    valueChoose = newValue;
                                  });
                                },
                                items: listItem.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
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
                            width: MediaQuery.of(context).size.width * 0.68,
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
                                        borderSide: BorderSide(
                                          color: HexColor("#D1D7E7"),
                                          width: 1,
                                        ),
                                      ),
                                      fillColor: HexColor("#FFFFFF"),
                                      hintText: "กรอกหมายเหตุ",
                                      hintStyle: TextStyle(
                                        color: HexColor("#D1D7E7"),
                                      ),
                                      filled: true,
                                    ),
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
                          onTap: () {
                            block();
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Main_SO();
                            }));
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
}

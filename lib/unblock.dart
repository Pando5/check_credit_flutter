import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:so_project/account.dart';
import 'package:so_project/model/Org.dart';
import 'package:so_project/model/SO.dart';
import 'package:so_project/model/account_model.dart';
import 'package:so_project/service/service.dart';

class Unblock_SO extends StatefulWidget {
  const Unblock_SO({Key key}) : super(key: key);

  @override
  State<Unblock_SO> createState() => _Unblock_SOState();
}

class _Unblock_SOState extends State<Unblock_SO> {
  String searchText = "";
  List<Org> data = [];
  int open = 0;
  List<Org> dataSearch = [];
  String date = '${DateFormat('ddMMyyyy').format(DateTime.now())}';

  List<SO_Model> unblock = [
    SO_Model(
      "120400",
      "ส่งเสริมฯ-ร้อยเอ็ด",
      5,
      [
        Account_Model("SO 120450654727437", "มณีรัตน์ พลเดช", 1740),
        Account_Model("SO 120450654727326", "วรรณชนะ พาละพล", 1620),
        Account_Model("SO 120450654727424", "วรรณชนะ พาละพล", 1620),
        Account_Model("SO 120450654727307", "สมพร น้อยนาจาร ", 1740),
        Account_Model("SO 120450654727480", "ไสว ฐิติประเสริฐสกุล", 2200),
      ],
    ),
    SO_Model(
      "120500",
      "ส่งเสริมฯ-นครราชสีมา",
      1,
      [
        Account_Model("SO 120450654727437", "มณีรัตน์ พลเดช", 1740),
        Account_Model("SO 120450654727326", "วรรณชนะ พาละพล", 1620),
        Account_Model("SO 120450654727424", "วรรณชนะ พาละพล", 1620),
        Account_Model("SO 120450654727307", "สมพร น้อยนาจาร", 1740),
        Account_Model("SO 120450654727480", "ไสว ฐิติประเสริฐสกุล", 2200),
      ],
    ),
    SO_Model(
      "120600",
      "ส่งเสริมฯ-อุบลราชธานี",
      1,
      [
        Account_Model("SO 120450654727437", "มณีรัตน์ พลเดช", 1740),
        Account_Model("SO 120450654727326", "วรรณชนะ พาละพล", 1620),
        Account_Model("SO 120450654727424", "วรรณชนะ พาละพล", 1620),
        Account_Model("SO 120450654727307", "สมพร น้อยนาจาร", 1740),
        Account_Model("SO 120450654727480", "ไสว ฐิติประเสริฐสกุล", 2200),
      ],
    ),
    SO_Model(
      "120700",
      "ส่งเสริมฯ-สุราษฏร์ธานี",
      3,
      [
        Account_Model("SO 120450654727437", "มณีรัตน์ พลเดช", 1740),
        Account_Model("SO 120450654727326", "วรรณชนะ พาละพล", 1620),
        Account_Model("SO 120450654727424", "วรรณชนะ พาละพล", 1620),
        Account_Model("SO 120450654727307", "สมพร น้อยนาจาร", 1740),
        Account_Model("SO 120450654727480", "ไสว ฐิติประเสริฐสกุล", 2200),
      ],
    ),
    SO_Model(
      "300910",
      "บมจ.ซีพีเอฟ(ประเทศไทย)-พิษณุโลก",
      1,
      [
        Account_Model("SO 120450654727437", "มณีรัตน์ พลเดช", 1740),
        Account_Model("SO 120450654727326", "วรรณชนะ พาละพล", 1620),
        Account_Model("SO 120450654727424", "วรรณชนะ พาละพล", 1620),
        Account_Model("SO 120450654727307", "สมพร น้อยนาจาร", 1740),
        Account_Model("SO 120450654727480", "ไสว ฐิติประเสริฐสกุล", 2200),
      ],
    ),
    SO_Model(
      "301110",
      "บมจ.ซีพีเอฟ(ประเทศไทย)-หาดใหญ่",
      2,
      [
        Account_Model("SO 120450654727437", "มณีรัตน์ พลเดช", 1740),
        Account_Model("SO 120450654727326", "วรรณชนะ พาละพล", 1620),
        Account_Model("SO 120450654727424", "วรรณชนะ พาละพล", 1620),
        Account_Model("SO 120450654727307", "สมพร น้อยนาจาร", 1740),
        Account_Model("SO 120450654727480", "ไสว ฐิติประเสริฐสกุล", 2200),
      ],
    ),
    SO_Model(
      "301510",
      "บมจ.ซีพีเอฟ(ประเทศไทย)-ขอนแก่น",
      3,
      [
        Account_Model("SO 120450654727437", "มณีรัตน์ พลเดช", 1740),
        Account_Model("SO 120450654727326", "วรรณชนะ พาละพล", 1620),
        Account_Model("SO 120450654727424", "วรรณชนะ พาละพล", 1620),
        Account_Model("SO 120450654727307", "สมพร น้อยนาจาร", 1740),
        Account_Model("SO 120450654727480", "ไสว ฐิติประเสริฐสกุล", 2200),
      ],
    ),
    SO_Model(
      "530800",
      "เล้าขายสุกรขุน-ฉะเชิงเทรา",
      14,
      [
        Account_Model("SO 120450654727437", "มณีรัตน์ พลเดช", 1740),
        Account_Model("SO 120450654727326", "วรรณชนะ พาละพล", 1620),
        Account_Model("SO 120450654727424", "วรรณชนะ พาละพล", 1620),
        Account_Model("SO 120450654727307", "สมพร น้อยนาจาร", 1740),
        Account_Model("SO 120450654727480", "ไสว ฐิติประเสริฐสกุล", 2200),
      ],
    ),
    SO_Model(
      "660114",
      "ฟาร์มวังทอง",
      2,
      [
        Account_Model("SO 120450654727437", "มณีรัตน์ พลเดช", 1740),
        Account_Model("SO 120450654727326", "วรรณชนะ พาละพล", 1620),
        Account_Model("SO 120450654727424", "วรรณชนะ พาละพล", 1620),
        Account_Model("SO 120450654727307", "สมพร น้อยนาจาร", 1740),
        Account_Model("SO 120450654727480", "ไสว ฐิติประเสริฐสกุล", 2200),
      ],
    ),
  ];

  List<Org> doc = [];
  ApiService _apiService = new ApiService();

  Future _callService() async {
    doc = await _apiService.unblockService(date);
    setState(() {
      // data = doc;
      dataSearch = doc;
    });
    // print(doc);
  }

  // Future<Null> upload() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   List<String> main_data = [];
  //   for (var item in unblock) {
  //     SO_Model item_selected =
  //         SO_Model(item.id, item.name, item.amount, item.account);
  //     String jsonProd = jsonEncode(item_selected);
  //     main_data.add(jsonProd);
  //   }
  //   // await Future.delayed(Duration(seconds: 1));
  //   preferences.setStringList("Data", main_data);
  // }

  Future<Null> search(String text) async {
    List<Org> Newdata = [];
    doc.forEach((item) {
      if (item.orgName.contains(text) || item.orgCode.contains(text)) {
        Newdata.add(item);
      }
    });
    // print(dataSearch);
    setState(() {
      dataSearch = Newdata;
    });
    print(dataSearch);
  }

  // Future<Null> info() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     open = preferences.getInt("Open");
  //   });
  //   if (open == 0 || open == null) {
  //     setState(() {
  //       data = unblock;
  //       dataSearch = unblock;
  //     });
  //     upload();
  //   } else {
  //     List<String> new_data = preferences.getStringList("Data");
  //     String dataDecode = '$new_data';
  //     var tagObjsJson = await jsonDecode(dataDecode) as List;
  //     List<SO_Model> main_data =
  //         tagObjsJson.map((tagJson) => SO_Model.fromJson(tagJson)).toList();
  //     setState(() {
  //       data = main_data;
  //       dataSearch = main_data;
  //     });
  //   }
  //   // print(main_data);
  // }

  @override
  void initState() {
    // TODO: implement initState
    // info();
    _callService();
    // print(open);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: HexColor("#FFFFFF"),
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.event,
                        size: 30,
                        color: HexColor("#34C5B2"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          '${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                          style: TextStyle(
                            color: HexColor("#21284F"),
                            fontFamily: "CPF Imm Sook",
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Icon(
                        Icons.more_vert,
                        size: 30,
                        color: HexColor("#323232"),
                      ),
                    ),
                    onTap: () {
                      // upload();
                    },
                  )
                ],
              ),
            ],
          ),
          leadingWidth: 0,
          leading: Container()),
      body: Column(
        children: [
          header(_size),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: dataSearch.length,
                  itemBuilder: (context, index) {
                    return list_card(dataSearch[index], index);
                  },
                ),
              ),
            ),
          ),
        ],
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
              offset: const Offset(0, 5),
            ),
          ],
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          // border: Border.all(width: 0)
        ),
        alignment: Alignment.center,
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 10),
                child: Text(
                  "ค้นหา",
                  style: TextStyle(
                    color: HexColor("#21284F"),
                    fontFamily: "CPF Imm Sook",
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                width: size.width * 0.9,
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                decoration: BoxDecoration(
                  color: HexColor("#FFFFFF"),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    width: 1,
                    color: HexColor("#D1D7E7"),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        style: TextStyle(
                          color: HexColor("#21284F"),
                          fontFamily: "CPF Imm Sook",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: InputBorder.none,
                          // fillColor: HexColor("#FFFFFF"),
                          hintText: "input search text",
                          hintStyle: TextStyle(
                            color: HexColor("#D1D7E7"),
                            fontFamily: "CPF Imm Sook",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          // filled: true,
                        ),
                        onChanged: (String value) {
                          search(value);
                        },
                      ),
                    ),
                    Icon(
                      Icons.search,
                      color: HexColor("#D1D7E7"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget list_card(Org data, index) => ListTile(
        shape: Border(
          bottom: BorderSide(
            width: 1.5,
            color: HexColor("#b0b3b8").withOpacity(0.3),
          ),
        ),
        title: Text(
          "${data.orgName}",
          style: TextStyle(
            color: HexColor("#2B3674"),
            fontFamily: "CPF Imm Sook",
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
        ),
        subtitle: Text(
          "${data.orgCode}",
          style: TextStyle(
            color: HexColor("#2B3674").withOpacity(0.5),
            fontFamily: "CPF Imm Sook",
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: Badge(
          badgeColor: HexColor("#1890FF"),
          padding: EdgeInsets.all(6),
          badgeContent: Text(
            "${data.countDoc}",
            style: TextStyle(
              color: HexColor("#FFFFFF"),
              fontFamily: "CPF Imm Sook",
            ),
          ),
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Account(
              data: data,
              so_id: data.orgCode,
            );
          }));
        },
      );
}

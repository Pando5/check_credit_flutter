import 'dart:convert';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:so_project/account.dart';
import 'package:so_project/model/Org.dart';
import 'package:so_project/searchCV.dart';
import 'package:so_project/service/service.dart';

class Unblock_SO extends StatefulWidget {
  const Unblock_SO({Key key}) : super(key: key);

  @override
  State<Unblock_SO> createState() => _Unblock_SOState();
}

class _Unblock_SOState extends State<Unblock_SO> {
  String searchText = "";
  List<Org> dataSearch = [];
  String date = '${DateFormat('ddMMyyyy').format(DateTime.now())}';
  String selectedCvCode = "";
  String selectedCvName = "";

  List<Org> doc = [];
  ApiService _apiService = new ApiService();

  Future _callService() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    selectedCvCode = preferences.getString("CVcode");
    selectedCvName = preferences.getString("CVname");
    if (selectedCvCode == null && selectedCvName == null) {
      selectedCvCode = "";
      selectedCvName = "";
    }
    print(selectedCvCode);
    doc =
        await _apiService.unblockService("ronnapoom.cha", selectedCvCode, date);
    setState(() {
      dataSearch = doc;
    });
  }

  Future<Null> _callCV() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      selectedCvCode = preferences.getString("CVcode");
      selectedCvName = preferences.getString("CVname");
    });

    if (selectedCvCode == null && selectedCvName == null) {
      setState(() {
        selectedCvCode = "";
        selectedCvName = "";
      });
    }
  }

  Future<Null> clear() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("CVcode", "");
    preferences.setString("CVname", "");
  }

  Future<Null> search(String text) async {
    List<Org> Newdata = [];
    doc.forEach((item) {
      if (item.orgName.contains(text) || item.orgCode.contains(text)) {
        Newdata.add(item);
      }
    });
    setState(() {
      dataSearch = Newdata;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _callCV();
    _callService();

    // _callCvService();
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
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Icon(
                      Icons.more_vert,
                      size: 30,
                      color: HexColor("#323232"),
                    ),
                  ),
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
            child: FutureBuilder(
              // กำหนดชนิดข้อมูล
              future: _apiService.unblockService(
                  "ronnapoom.cha", selectedCvCode, date), // ข้อมูล Future
              //builder: (BuildContext context, AsyncSnapshot snapshot) {
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(
                      'เกิดข้อผิดพลาดในการโหลดข้อมูล ${snapshot.error}');
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    return SingleChildScrollView(
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
          child: Container(
            width: size.width * 0.9,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: HexColor("#F6F9FF"),
              borderRadius: BorderRadius.circular(12),
              // border: Border.all(
              //   width: 1,
              //   color: HexColor("#D1D7E7"),
              // ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "ค้นหาจากลูกค้า",
                    style: TextStyle(
                      color: HexColor("#21284F"),
                      fontFamily: "CPF Imm Sook",
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  width: size.width * 0.85,
                  height: 45,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: HexColor("#FFFFFF"),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      width: 1,
                      color: HexColor("#D1D7E7"),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: size.width * 0.7,
                        // height: 45,
                        // padding:
                        //     EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        // decoration: BoxDecoration(
                        //   color: HexColor("#FFFFFF"),
                        //   borderRadius: BorderRadius.circular(12),
                        //   border: Border.all(
                        //     width: 1,
                        //     color: HexColor("#D1D7E7"),
                        //   ),
                        // ),
                        alignment: Alignment.center,
                        child: selectedCvCode == "" || selectedCvCode == null
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "กดปุ่ม",
                                    style: TextStyle(
                                      color: HexColor("#21284F"),
                                      fontFamily: "CPF Imm Sook",
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Icon(
                                    Icons.person,
                                    color: HexColor("#D1D7E7"),
                                  ),
                                  Text(
                                    "เพื่อค้นหา",
                                    style: TextStyle(
                                      color: HexColor("#21284F"),
                                      fontFamily: "CPF Imm Sook",
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: size.width * 0.5,
                                    child: Text(
                                      "${selectedCvCode}-${selectedCvName}",
                                      style: TextStyle(
                                        color: HexColor("#21284F"),
                                        fontFamily: "CPF Imm Sook",
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Icon(Icons.close),
                                    onTap: () {
                                      clear();
                                      _callService();
                                    },
                                  )
                                ],
                              ),
                      ),
                      GestureDetector(
                        child: Icon(
                          Icons.person,
                          size: 35,
                          color: HexColor("#D1D7E7"),
                        ),
                        onTap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return SearchCV();
                          }));
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    width: 150,
                    child: Text(
                      "ค้นหาจากศูนย์",
                      style: TextStyle(
                        color: HexColor("#21284F"),
                        fontFamily: "CPF Imm Sook",
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: size.width * 0.85,
                  height: 45,
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                  decoration: BoxDecoration(
                    color: HexColor("#FFFFFF"),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      width: 1,
                      color: HexColor("#D1D7E7"),
                    ),
                  ),
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
                        suffixIcon: Icon(
                          Icons.search,
                          color: HexColor("#D1D7E7"),
                        )
                        // fillColor: HexColor("#FFFFFF"),
                        // hintText: "input search text",
                        // hintStyle: TextStyle(
                        //   color: HexColor("#D1D7E7"),
                        //   fontFamily: "CPF Imm Sook",
                        //   fontSize: 16,
                        //   fontWeight: FontWeight.w400,
                        // ),
                        // filled: true,
                        ),
                    onChanged: (String value) {
                      search(value);
                    },
                  ),
                ),
              ],
            ),
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
              orgName: data.orgName,
              orgCode: data.orgCode,
            );
          }));
        },
      );
}

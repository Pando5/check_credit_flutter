import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:so_project/main_SO.dart';
import 'package:so_project/model/Cv.dart';
import 'package:so_project/service/service.dart';
import 'package:so_project/unblock.dart';

class SearchCV extends StatefulWidget {
  const SearchCV({Key key}) : super(key: key);

  @override
  State<SearchCV> createState() => _SearchCVState();
}

class _SearchCVState extends State<SearchCV> {
  String date = '${DateFormat('ddMMyyyy').format(DateTime.now())}';
  String selectedCvCode = "";
  String selectedCvName = "";
  List<Cv> cvSearch = [];

  List<Cv> docCv = [];
  ApiService _apiService = new ApiService();
  Future _callCvService() async {
    docCv = await _apiService.cvService("ronnapoom.cha", date);
    setState(() {
    cvSearch = docCv;
    });

  }

  Future<Null> selectCv() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("CVcode", selectedCvCode);
    preferences.setString("CVname", selectedCvName);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return Main_SO();
    }));
    // print(main_data);
  }

  Future<Null> searchCV(String text) async {
    List<Cv> NewCv = [];
    docCv.forEach((item) {
      if (item.dataName.contains(text) || item.dataCode.contains(text)) {
        NewCv.add(item);
      }
    });
    setState(() {
      cvSearch = NewCv;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _callCvService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: HexColor("#F6F9FF"),
      appBar: AppBar(
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
              return Main_SO();
            }));
          },
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          header(_size),
          Expanded(
            child: FutureBuilder(
              // กำหนดชนิดข้อมูล
              future: _apiService.cvService("ronnapoom.cha", date), // ข้อมูล Future
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
                        itemCount: cvSearch.length,
                        itemBuilder: (context, index) {
                          return list_cv(cvSearch[index], index);
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
                          hintText: "ค้นหาจากชื่อ หรือ cvCode",
                          hintStyle: TextStyle(
                            color: HexColor("#D1D7E7"),
                            fontFamily: "CPF Imm Sook",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          // filled: true,
                        ),
                        onChanged: (String value) {
                          searchCV(value);
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

  Widget list_cv(Cv data, index) => ListTile(
        shape: Border(
          bottom: BorderSide(
            width: 1.5,
            color: HexColor("#b0b3b8").withOpacity(0.3),
          ),
        ),
        title: Text(
          "${data.dataName}",
          style: TextStyle(
            color: HexColor("#2B3674"),
            fontFamily: "CPF Imm Sook",
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
        ),
        subtitle: Text(
          "${data.dataCode}",
          style: TextStyle(
            color: HexColor("#2B3674").withOpacity(0.5),
            fontFamily: "CPF Imm Sook",
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        onTap: () {
          setState(() {
            selectedCvCode = data.dataCode;
            selectedCvName = data.dataName;
          });
          selectCv();
        },
      );
}

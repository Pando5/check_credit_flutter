import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:so_project/check_status.dart';
import 'package:so_project/model/DetCredit.dart';
import 'package:so_project/model/StaCredit.dart';
import 'package:so_project/service/service.dart';
import 'package:so_project/unblock.dart';

class Result_Status extends StatefulWidget {
  final StaCredit data;
  final String start;
  final String end;
  const Result_Status({Key key, this.data, this.start, this.end})
      : super(key: key);

  @override
  State<Result_Status> createState() => _Result_StatusState();
}

class _Result_StatusState extends State<Result_Status> {
  // int _selectedIndex = 1;
  StaCredit data;
  String start = "";
  String end = "";
  String searchText = "";
  List<DetCredit> dataSearch = [];
  final amountFormat = NumberFormat("#,##0.00", "en_US");

  List<DetCredit> doc = [];
  ApiService _apiService = new ApiService();

  Future _callService() async {
    doc = await _apiService.detailCreService(data.orgCode, start, end);
    setState(() {
      dataSearch = doc;
    });
  }

  Future<Null> search(String text) async {
    List<DetCredit> new_data = [];
    doc.forEach((item) {
      if (item.cvName.contains(text)) {
        new_data.add(item);
      }
    });
    print(dataSearch);
    setState(() {
      dataSearch = new_data;
    });
  }

  
  @override
  void initState() {
    // TODO: implement initState
    data = widget.data;
    start = widget.start;
    end = widget.end;
    _callService();
    // dataSearch = data.credit;
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
              Expanded(
                child: Text(
                  "${data.orgCode}-${data.orgName}",
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  style: TextStyle(
                    color: HexColor("#2B3674"),
                    fontFamily: "CPF Imm Sook",
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
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
      body: Column(
        children: [
          header(_size),
          Expanded(
            child: FutureBuilder(
              future: _apiService.detailCreService(data.orgCode, start, end),
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
                child: TextFormField(
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
                        borderSide: BorderSide.none),
                    fillColor: HexColor("#FFFFFF"),
                    filled: true,
                    suffixIcon: Icon(
                      Icons.search,
                      color: HexColor("#D1D7E7"),
                    ),
                  ),
                  onChanged: (value) {
                    search(value);
                  },
                ),
              ),
            ],
          ),
        ),
      );

  Widget list_card(DetCredit data, index) => Card(
        color: HexColor("#FFFFFF"),
        elevation: 4,
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        margin: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            title: Text(
              "${data.documentDate.substring(0, 9)} | ${data.cvName}",
              style: TextStyle(
                color: HexColor("#2B3674"),
                fontFamily: "CPF Imm Sook",
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "${amountFormat.format(data.soAmt)} | ${data.reasonCode}",
                    style: TextStyle(
                      color: HexColor("#2B3674").withOpacity(0.5),
                      fontFamily: "CPF Imm Sook",
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Text(
                  "${data.soDocumentNo} | ${data.creditManualDate}",
                  style: TextStyle(
                    color: HexColor("#2B3674").withOpacity(0.5),
                    fontFamily: "CPF Imm Sook",
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:so_project/detail_credit.dart';
import 'package:so_project/model/Org.dart';
import 'package:so_project/model/SoHd.dart';
import 'package:so_project/service/service.dart';

class Account extends StatefulWidget {
  final String orgName;
  final String orgCode;
  const Account({Key key, this.orgName, this.orgCode}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  int _selectedIndex = 0;
  String orgName;
  String orgCode;
  String pCv = "";
  String searchText = "";
  List<SoHd> dataSearch = [];
  final amountFormat = NumberFormat("#,##0.0", "en_US");
  String date = '${DateFormat('ddMMyyyy').format(DateTime.now())}';

  Future<Null> search(String text) async {
    List<SoHd> new_data = [];
    doc.forEach((item) {
      if (item.cvName.contains(text) || item.soDocumentNo.contains(text)) {
        new_data.add(item);
      }
    });
    print("test $dataSearch");
    setState(() {
      dataSearch = new_data;
    });
  }

  List<SoHd> doc = [];
  ApiService _apiService = new ApiService();

  Future _callService() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    pCv = preferences.getString("CVcode");
    print(pCv);
    doc = await _apiService.accountService(date, pCv, orgCode);
    setState(() {
      dataSearch = doc;
    });
  }

  // static const List<Widget> _widgetOptions = <Widget>[
  //   Unblock_SO(),
  //   Check_Status(),
  // ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    orgName = widget.orgName;
    orgCode = widget.orgCode;
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
              Expanded(
                child: Text(
                  "${orgCode}-${orgName}",
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
      body: Column(children: [
        header(_size),
        Expanded(
          child: FutureBuilder(
            // กำหนดชนิดข้อมูล
            future:
                _apiService.accountService(date, pCv, orgCode), // ข้อมูล Future
            //builder: (BuildContext context, AsyncSnapshot snapshot) {
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('เกิดข้อผิดพลาดในการโหลดข้อมูล ${snapshot.error}');
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
      ]),
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
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none),
                    focusedBorder: InputBorder.none,
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

  Widget list_card(SoHd data_card, index) => Card(
        color: HexColor("#FFFFFF"),
        elevation: 4,
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        margin: EdgeInsets.symmetric(vertical: 3, horizontal: 20),
        child: ListTile(
          shape: Border(
            bottom: BorderSide(
              width: 1.5,
              color: HexColor("#b0b3b8").withOpacity(0.3),
            ),
          ),
          title: Text(
            "${data_card.cvName}",
            style: TextStyle(
              color: HexColor("#21284F"),
              fontFamily: "CPF Imm Sook",
              fontSize: 17,
              fontWeight: FontWeight.w400,
            ),
          ),
          subtitle: Text(
            "${data_card.soDocumentNo}",
            style: TextStyle(
              color: HexColor("#2B3674").withOpacity(0.5),
              fontFamily: "CPF Imm Sook",
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: Text(
            "${amountFormat.format(data_card.soAmt)} ฿",
            style: TextStyle(
              color: HexColor("#34C5B2"),
              fontFamily: "CPF Imm Sook",
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return Detail_Credit(
                so_id: orgCode,
                soDocNo: data_card.soDocumentNo,
              );
            }));
          },
        ),
      );
}

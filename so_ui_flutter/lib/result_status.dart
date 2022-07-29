import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:so_ui_flutter/check_status.dart';
import 'package:so_ui_flutter/model/SO.dart';
import 'package:so_ui_flutter/model/account_model.dart';
import 'package:so_ui_flutter/model/credit.dart';
import 'package:so_ui_flutter/model/status.dart';
import 'package:so_ui_flutter/unblock.dart';

class Result_Status extends StatefulWidget {
  final Status_Model data;
  const Result_Status({Key key, this.data}) : super(key: key);

  @override
  State<Result_Status> createState() => _Result_StatusState();
}

class _Result_StatusState extends State<Result_Status> {
  int _selectedIndex = 1;
  Status_Model data;
  String searchText = "";
  List<Credit_Model> dataSearch = [];
  final amountFormat = NumberFormat("#,##0.00", "en_US");

  Future<Null> search(String text) async {
    List<Credit_Model> new_data = [];
    data.credit.forEach((item) {
      if (item.name.contains(text)) {
        new_data.add(item);
      }
    });
    print(dataSearch);
    setState(() {
      dataSearch = new_data;
    });
  }

  String formatdate(date) {
    DateFormat dateFormat = DateFormat("dd/MM/yyyy HH:mm:ss");

    return dateFormat.format(date);
  }

  static const List<Widget> _widgetOptions = <Widget>[
    Unblock_SO(),
    Check_Status(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    data = widget.data;
    dataSearch = data.credit;
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
                  "${data.id}-${data.name}",
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
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: HexColor("#FFFFFF"),
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.lock_open),
      //       label: 'Unblock',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.menu_book),
      //       label: 'Status',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: HexColor("#34C5B2"),
      //   onTap: _onItemTapped,
      // ),
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
                          focusedBorder: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none),
                          fillColor: HexColor("#FFFFFF"),
                          hintText: "input search text",
                          hintStyle: TextStyle(
                            color: HexColor("#D1D7E7"),
                          ),
                          filled: true,
                        ),
                        onChanged: (value) {
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

  Widget list_card(Credit_Model data, index) => Card(
        color: HexColor("#FFFFFF"),
        elevation: 4,
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            title: Text(
              "${data.date} | ${data.name}",
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
                    "${amountFormat.format(data.amount)} | ${data.zone}",
                    style: TextStyle(
                      color: HexColor("#2B3674").withOpacity(0.5),
                      fontFamily: "CPF Imm Sook",
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Text(
                  "${data.id} | ${formatdate(data.date_time)}",
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

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:so_project/check_status.dart';
import 'package:so_project/model/Org.dart';
import 'package:so_project/model/SO.dart';
import 'package:so_project/unblock.dart';
import 'package:so_project/service/service.dart';

class Main_SO extends StatefulWidget {
  final int open;
  const Main_SO({Key key, this.open}) : super(key: key);

  @override
  State<Main_SO> createState() => _Main_SOState();
}

class _Main_SOState extends State<Main_SO> {
  int _selectedIndex = 0;
  int open1 = 0;
  int open2 = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Unblock_SO(),
    Check_Status(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Future<void> getApi() async {
  //   var url = Uri.parse("https://farmdev.cpf.co.th/UnBlockSoDeploy/api/SoOrg?pUser=ronnapoom.cha&pReqDateDdMmYyyy=29072022&pCv=");
  //   var response = await http.get(url);
  //   print(response.body);
  // }
  

  @override
  void initState() {
    // TODO: implement initState
    open1 = widget.open;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: HexColor("#F6F9FF"),
      body: Container(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: HexColor("#FFFFFF"),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.lock_open),
            label: 'Unblock',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Status',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: HexColor("#34C5B2"),
        onTap: _onItemTapped,
      ),
    );
  }
}

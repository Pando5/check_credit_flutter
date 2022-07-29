import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:so_ui_flutter/check_status.dart';
import 'package:so_ui_flutter/model/SO.dart';
import 'package:so_ui_flutter/unblock.dart';

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

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:so_ui_flutter/main_SO.dart';
import 'package:so_ui_flutter/model/SO.dart';
import 'package:so_ui_flutter/model/account_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Main_SO(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  List<SO_Model> unblock = [
    SO_Model(
      "120400",
      "ส่งเสริมฯ-ร้อยเอ็ด",
      5,
      [
        Account_Model("SO 120450654727437", "มณีรัตน์ พลเดช", 1740),
        Account_Model("SO 120450654727326", "วรรณชนะ พาละพล", 1620),
        Account_Model("SO 120450654727424", "วรรณชนะ พาละพล", 1620),
        Account_Model("SO 120450654727307", "สมพร น้อยนาจารย์ ", 1740),
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
        Account_Model("SO 120450654727307", "สมพร น้อยนาจารย์", 1740),
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
        Account_Model("SO 120450654727307", "สมพร น้อยนาจารย์", 1740),
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
        Account_Model("SO 120450654727307", "สมพร น้อยนาจารย์", 1740),
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
        Account_Model("SO 120450654727307", "สมพร น้อยนาจารย์", 1740),
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
        Account_Model("SO 120450654727307", "สมพร น้อยนาจารย์", 1740),
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
        Account_Model("SO 120450654727307", "สมพร น้อยนาจารย์", 1740),
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
        Account_Model("SO 120450654727307", "สมพร น้อยนาจารย์", 1740),
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
        Account_Model("SO 120450654727307", "สมพร น้อยนาจารย์", 1740),
        Account_Model("SO 120450654727480", "ไสว ฐิติประเสริฐสกุล", 2200),
      ],
    ),
  ];

  Future<Null> upload() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> main_data = [];
    for (var item in unblock) {
      SO_Model item_selected =
          SO_Model(item.id, item.name, item.amount, item.account);
      String jsonProd = jsonEncode(item_selected);
      main_data.add(jsonProd);
    }
    await Future.delayed(Duration(seconds: 1));
    preferences.setStringList("Data", main_data);
  }

  void _incrementCounter() {
    
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      // return Form_die();
      return Main_SO();
    }));
  }

  @override
  void initState() {
    // TODO: implement initState
    upload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

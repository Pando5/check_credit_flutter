import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:so_project/model/StaCredit.dart';
import 'package:so_project/result_status.dart';
import 'package:so_project/service/service.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Check_Status extends StatefulWidget {
  const Check_Status({Key key}) : super(key: key);

  @override
  State<Check_Status> createState() => _Check_StatusState();
}

class _Check_StatusState extends State<Check_Status> {
  String startDate = '00/00/00';
  String endDate = '00/00/00';
  DateTime date1 = DateTime.now();
  DateTime date2 = DateTime.now();
  String searchText = "";
  List<StaCredit> data = [];
  String dateSt = "00/00/00";
  String dateEn = "00/00/00";
  DateTime date_Start = DateTime.now();
  DateTime date_End = DateTime.now();

  ApiService _apiService = new ApiService();

  Future _callService() async {
    data = await _apiService.statusCreService(
        '${DateFormat('ddMMyyyy').format(date1)}',
        '${DateFormat('ddMMyyyy').format(date2)}');
    // print('${DateFormat('ddMMyyyy').format(date1)}' +
    //     '${DateFormat('ddMMyyyy').format(date2)}');
  }
  
  void onSelection() {
    setState(() {
      date1 = date_Start;
      date2 = date_End;
      startDate = dateSt;
      endDate = dateEn;
    });
    _callService();
    Navigator.pop(context);
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        date_Start = args.value.startDate;
        date_End = args.value.endDate ?? args.value.startDate;
        dateSt = '${DateFormat('dd/MM/yy').format(args.value.startDate)}';
        dateEn =
            '${DateFormat('dd/MM/yy').format(args.value.endDate ?? args.value.startDate)}';
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _callService();
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
                        Icons.auto_stories,
                        size: 30,
                        color: HexColor("#34C5B2"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          "Check Status",
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
                    onTap: () {},
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
            child: FutureBuilder(
              future: _apiService.statusCreService(
                  '${DateFormat('ddMMyyyy').format(date1)}',
                  '${DateFormat('ddMMyyyy').format(date2)}'), 
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
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return list_card(data[index], index);
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "เริ่มต้น",
                    style: TextStyle(
                      color: HexColor("#21284F"),
                      fontFamily: "CPF Imm Sook",
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    width: size.width * 0.4,
                    height: 60,
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    decoration: BoxDecoration(
                        color: HexColor("#FFFFFF"),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          width: 1,
                          color: HexColor("#D1D7E7"),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width * 0.25,
                          child: Text(
                            startDate,
                            // dateSt,
                            style: TextStyle(
                              color: startDate == "00/00/00"
                                  ? HexColor("#6878AB").withOpacity(0.5)
                                  : HexColor("#21284F"),
                              fontSize: startDate == "00/00/00" ? 15 : 17,
                              fontFamily: "CPF Imm Sook",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.event_note_outlined,
                          color: HexColor("#6878AB").withOpacity(0.5),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    showDate_Picker(context);
                    // showDate_Picker_Start(context);
                  },
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "จนถึง",
                    style: TextStyle(
                      color: HexColor("#21284F"),
                      fontFamily: "CPF Imm Sook",
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    width: size.width * 0.4,
                    height: 60,
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    decoration: BoxDecoration(
                        color: HexColor("#FFFFFF"),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          width: 1,
                          color: HexColor("#D1D7E7"),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width * 0.25,
                          child: Text(
                            endDate,
                            // dateEn,
                            style: TextStyle(
                              color: endDate == "00/00/00"
                                  ? HexColor("#6878AB").withOpacity(0.5)
                                  : HexColor("#21284F"),
                              fontSize: endDate == "00/00/00" ? 15 : 17,
                              fontFamily: "CPF Imm Sook",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.event_note_outlined,
                          color: HexColor("#6878AB").withOpacity(0.5),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    showDate_Picker(context);
                    // showDate_Picker_End(context);
                  },
                )
              ],
            ),
          ],
        ),
      );

  Widget list_card(StaCredit data, index) => ListTile(
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
            return Result_Status(
                data: data,
                start: '${DateFormat('ddMMyyyy').format(date1)}',
                end: '${DateFormat('ddMMyyyy').format(date2)}');
          }));
        },
      );

  void showDate_Picker(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          padding: EdgeInsets.all(15),
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                height: 40,
                child: Icon(Icons.maximize_rounded,
                    size: 80, color: HexColor("#D1D7E7")),
              ),
              Expanded(
                child: SfDateRangePicker(
                  showNavigationArrow: true,
                  onSelectionChanged: _onSelectionChanged,
                  view: DateRangePickerView.month,
                  headerStyle: DateRangePickerHeaderStyle(
                    textStyle: TextStyle(
                      color: HexColor("#2B3674"),
                      fontFamily: "CPF Imm Sook",
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  selectionMode: DateRangePickerSelectionMode.range,
                  initialSelectedRange: PickerDateRange(
                      startDate != "00/00/00"
                          ? date1
                          : DateTime.now().subtract(const Duration(days: 1)),
                      endDate != "00/00/00"
                          ? date2
                          : DateTime.now().add(const Duration(days: 1))),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                          // color: HexColor("#FFFFFF"),
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
                            fontSize: 18,
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
                        width: MediaQuery.of(context).size.width * 0.4,
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                            color: HexColor("#2B3674"),
                            borderRadius: BorderRadius.circular(8)),
                        alignment: Alignment.center,
                        child: Text(
                          "ตกลง",
                          style: TextStyle(
                            color: HexColor("#FFFFFF"),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: "CPF Imm Sook",
                          ),
                        ),
                      ),
                      onTap: () {
                        onSelection();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

 }

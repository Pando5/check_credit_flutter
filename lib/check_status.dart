import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:so_project/model/SO.dart';
import 'package:so_project/model/StaCredit.dart';
import 'package:so_project/model/credit.dart';
import 'package:so_project/model/status.dart';
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
  String selectedDate = "";
  DateTime dateSelect;

  List<StaCredit> doc = [];
  ApiService _apiService = new ApiService();

  Future _callService() async {
    doc = await _apiService.statusCreService('${DateFormat('ddMMyyyy').format(date1)}', '${DateFormat('ddMMyyyy').format(date2)}');
    setState(() {
      data = doc;
      // dataSearch = doc;
    });
    print(doc);
  }

  List<Status_Model> status = [
    Status_Model("100110", "พันธุ์สัตว์(สัตว์ปีก-ใต้)", [
      Credit_Model("505220866500615", "ทวีภัณฑ์ภูเก็ต", 1393508, "01/07/2022",
          DateTime(2022, 7, 5, 9, 22, 1), "B01"),
      Credit_Model("505220866500625", "ทวีศักดิ์ นิยมบัณฑิต", 488650,
          "04/07/2022", DateTime(2022, 7, 5, 13, 42, 35), "C12"),
    ]),
    Status_Model("100800", "พันธุ์สัตว์(สุกร-อีสาน)", [
      Credit_Model("505220866500615", "ทวีภัณฑ์ภูเก็ต", 1393508, "01/07/2022",
          DateTime(2022, 6, 30, 9, 22, 1), "B01"),
      Credit_Model("505220866500625", "ทวีศักดิ์ นิยมบัณฑิต", 488650,
          "04/07/2022", DateTime(2022, 6, 28, 13, 42, 35), "C12"),
    ]),
    Status_Model("120000", "ส่งเสริมฯ-พิษณุโลก", [
      Credit_Model("505220866500615", "ทวีภัณฑ์ภูเก็ต", 1393508, "01/07/2022",
          DateTime(2022, 7, 5, 9, 22, 1), "B01"),
      Credit_Model("505220866500625", "ทวีศักดิ์ นิยมบัณฑิต", 488650,
          "04/07/2022", DateTime(2022, 7, 5, 13, 42, 35), "C12"),
    ]),
    Status_Model("120100", "ส่งเสริมฯ-เชียงใหม่", [
      Credit_Model("505220866500615", "ทวีภัณฑ์ภูเก็ต", 1393508, "01/07/2022",
          DateTime(2022, 7, 5, 9, 22, 1), "B01"),
      Credit_Model("505220866500625", "ทวีศักดิ์ นิยมบัณฑิต", 488650,
          "04/07/2022", DateTime(2022, 7, 15, 13, 42, 35), "C12"),
    ]),
    Status_Model("120200", "ส่งเสริมฯ-ร้อยเอ็ด", [
      Credit_Model("505220866500615", "ทวีภัณฑ์ภูเก็ต", 1393508, "01/07/2022",
          DateTime(2022, 7, 11, 9, 22, 1), "B01"),
      Credit_Model("505220866500625", "ทวีศักดิ์ นิยมบัณฑิต", 488650,
          "04/07/2022", DateTime(2022, 7, 13, 13, 42, 35), "C12"),
    ]),
    Status_Model("120300", "ส่งเสริมฯ-ร้อยเอ็ด", [
      Credit_Model("505220866500615", "ทวีภัณฑ์ภูเก็ต", 1393508, "01/07/2022",
          DateTime(2022, 6, 30, 9, 22, 1), "B01"),
      Credit_Model("505220866500625", "ทวีศักดิ์ นิยมบัณฑิต", 488650,
          "04/07/2022", DateTime(2022, 7, 1, 13, 42, 35), "C12"),
    ]),
    Status_Model("120400", "ส่งเสริมฯ-ร้อยเอ็ด", [
      Credit_Model("505220866500615", "ทวีภัณฑ์ภูเก็ต", 1393508, "01/07/2022",
          DateTime(2022, 7, 5, 9, 22, 1), "B01"),
      Credit_Model("505220866500625", "ทวีศักดิ์ นิยมบัณฑิต", 488650,
          "04/07/2022", DateTime(2022, 7, 5, 13, 42, 35), "C12"),
    ]),
    Status_Model("120500", "ส่งเสริมฯ-ร้อยเอ็ด", [
      Credit_Model("505220866500615", "ทวีภัณฑ์ภูเก็ต", 1393508, "01/07/2022",
          DateTime(2022, 7, 6, 9, 22, 1), "B01"),
      Credit_Model("505220866500625", "ทวีศักดิ์ นิยมบัณฑิต", 488650,
          "04/07/2022", DateTime(2022, 7, 10, 13, 42, 35), "C12"),
    ]),
  ];

  // void onSelectionStart() {
  //   setState(() {
  //     dateSt = selectedDate;
  //     date_Start = dateSelect;
  //   });
  //   List<Status_Model> new_data = [];
  //   for (int i = 0; i < status.length; i++) {
  //     Status_Model new_status = Status_Model(status[i].id, status[i].name, []);
  //     for (int j = 0; j < status[i].credit.length; j++) {
  //       if (status[i].credit[j].date_time.compareTo(date_Start) >= 0 &&
  //           status[i].credit[j].date_time.compareTo(date_End) <= 0) {
  //         new_status.credit.add(status[i].credit[j]);
  //       }
  //     }
  //     print(new_status);
  //     if (new_status.credit.length > 0) {
  //       new_data.add(new_status);
  //     }
  //   }
  //   setState(() {
  //     data = new_data;
  //   });
  //   Navigator.pop(context);
  // }

  // void onSelectionEnd() {
  //   setState(() {
  //     dateEn = selectedDate;
  //     date_End = dateSelect;
  //   });
  //   List<Status_Model> new_data = [];
  //   for (int i = 0; i < status.length; i++) {
  //     Status_Model new_status = Status_Model(status[i].id, status[i].name, []);
  //     for (int j = 0; j < status[i].credit.length; j++) {
  //       if (status[i].credit[j].date_time.compareTo(date_Start) >= 0 &&
  //           status[i].credit[j].date_time.compareTo(date_End) <= 0) {
  //         new_status.credit.add(status[i].credit[j]);
  //       }
  //     }
  //     print(new_status);
  //     if (new_status.credit.length > 0) {
  //       new_data.add(new_status);
  //     }
  //   }
  //   setState(() {
  //     data = new_data;
  //   });
  //   Navigator.pop(context);
  // }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        date1 = args.value.startDate;
        date2 = args.value.endDate ?? args.value.startDate;
        startDate = '${DateFormat('dd/MM/yy').format(args.value.startDate)}';
        endDate =
            '${DateFormat('dd/MM/yy').format(args.value.endDate ?? args.value.startDate)}';
      } else {
        setState(() {
          selectedDate = '${DateFormat('dd/MM/yy').format(args.value)}';
          dateSelect = args.value;
        });
      }
    });
    _callService();
    // if (args.value is PickerDateRange) {
    //   List<Status_Model> new_data = [];
    //   for (int i = 0; i < status.length; i++) {
    //     Status_Model new_status =
    //         Status_Model(status[i].id, status[i].name, []);
    //     for (int j = 0; j < status[i].credit.length; j++) {
    //       if (status[i].credit[j].date_time.compareTo(date1) >= 0 &&
    //           status[i].credit[j].date_time.compareTo(date2) <= 0) {
    //         new_status.credit.add(status[i].credit[j]);
    //       }
    //     }
    //     print(new_status);
    //     if (new_status.credit.length > 0) {
    //       new_data.add(new_status);
    //     }
    //   }
    //   setState(() {
    //     data = new_data;
    //   });
    // }
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
            child: SingleChildScrollView(
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
          // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return Result_Status(
          //     data: data,
          //   );
          // }));
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
                          : DateTime.now().subtract(const Duration(days: 4)),
                      endDate != "00/00/00"
                          ? date2
                          : DateTime.now().add(const Duration(days: 3))),
                ),
              ),
              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   margin: EdgeInsets.only(top: 10, left: 20, right: 20),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       GestureDetector(
              //         child: Container(
              //           width: MediaQuery.of(context).size.width * 0.4,
              //           padding: EdgeInsets.symmetric(vertical: 10.0),
              //           decoration: BoxDecoration(
              //             // color: HexColor("#FFFFFF"),
              //             borderRadius: BorderRadius.circular(8),
              //             border: Border.all(
              //               width: 1,
              //               color: HexColor("#2B3674"),
              //             ),
              //           ),
              //           alignment: Alignment.center,
              //           child: Text(
              //             "ยกเลิก",
              //             style: TextStyle(
              //               color: HexColor("#2B3674"),
              //               fontSize: 18,
              //               fontWeight: FontWeight.w500,
              //               fontFamily: "CPF Imm Sook",
              //             ),
              //           ),
              //         ),
              //         onTap: () {
              //           Navigator.pop(context);
              //         },
              //       ),
              //       GestureDetector(
              //         child: Container(
              //           width: MediaQuery.of(context).size.width * 0.4,
              //           padding: EdgeInsets.symmetric(vertical: 10.0),
              //           decoration: BoxDecoration(
              //               color: HexColor("#2B3674"),
              //               borderRadius: BorderRadius.circular(8)),
              //           alignment: Alignment.center,
              //           child: Text(
              //             "ตกลง",
              //             style: TextStyle(
              //               color: HexColor("#FFFFFF"),
              //               fontSize: 18,
              //               fontWeight: FontWeight.w500,
              //               fontFamily: "CPF Imm Sook",
              //             ),
              //           ),
              //         ),
              //         onTap: () {
              //           onSelection();
              //         },
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }

  // void showDate_Picker_Start(context) {
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     context: context,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(
  //         top: Radius.circular(20),
  //       ),
  //     ),
  //     builder: (context) {
  //       return Container(
  //         height: MediaQuery.of(context).size.height * 0.6,
  //         padding: EdgeInsets.all(15),
  //         alignment: Alignment.center,
  //         child: Column(
  //           children: [
  //             Container(
  //               height: 40,
  //               child: Icon(Icons.maximize_rounded,
  //                   size: 80, color: HexColor("#D1D7E7")),
  //             ),
  //             Expanded(
  //               child: SfDateRangePicker(
  //                 showNavigationArrow: true,
  //                 onSelectionChanged: _onSelectionChanged,
  //                 view: DateRangePickerView.month,
  //                 headerStyle: DateRangePickerHeaderStyle(
  //                   textStyle: TextStyle(
  //                     color: HexColor("#2B3674"),
  //                     fontFamily: "CPF Imm Sook",
  //                     fontSize: 24,
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                 ),
  //                 selectionMode: DateRangePickerSelectionMode.single,
  //                 initialSelectedDate: date_Start,
  //               ),
  //             ),
  //             Container(
  //               width: MediaQuery.of(context).size.width,
  //               margin: EdgeInsets.only(top: 10, left: 20, right: 20),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   GestureDetector(
  //                     child: Container(
  //                       width: MediaQuery.of(context).size.width * 0.4,
  //                       padding: EdgeInsets.symmetric(vertical: 10.0),
  //                       decoration: BoxDecoration(
  //                         // color: HexColor("#FFFFFF"),
  //                         borderRadius: BorderRadius.circular(8),
  //                         border: Border.all(
  //                           width: 1,
  //                           color: HexColor("#2B3674"),
  //                         ),
  //                       ),
  //                       alignment: Alignment.center,
  //                       child: Text(
  //                         "ยกเลิก",
  //                         style: TextStyle(
  //                           color: HexColor("#2B3674"),
  //                           fontSize: 18,
  //                           fontWeight: FontWeight.w500,
  //                           fontFamily: "CPF Imm Sook",
  //                         ),
  //                       ),
  //                     ),
  //                     onTap: () {
  //                       Navigator.pop(context);
  //                     },
  //                   ),
  //                   GestureDetector(
  //                     child: Container(
  //                       width: MediaQuery.of(context).size.width * 0.4,
  //                       padding: EdgeInsets.symmetric(vertical: 10.0),
  //                       decoration: BoxDecoration(
  //                           color: HexColor("#2B3674"),
  //                           borderRadius: BorderRadius.circular(8)),
  //                       alignment: Alignment.center,
  //                       child: Text(
  //                         "ตกลง",
  //                         style: TextStyle(
  //                           color: HexColor("#FFFFFF"),
  //                           fontSize: 18,
  //                           fontWeight: FontWeight.w500,
  //                           fontFamily: "CPF Imm Sook",
  //                         ),
  //                       ),
  //                     ),
  //                     onTap: () {
  //                       onSelectionStart();
  //                     },
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  // void showDate_Picker_End(context) {
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     context: context,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(
  //         top: Radius.circular(20),
  //       ),
  //     ),
  //     builder: (context) {
  //       return Container(
  //         height: MediaQuery.of(context).size.height * 0.6,
  //         padding: EdgeInsets.all(15),
  //         alignment: Alignment.center,
  //         child: Column(
  //           children: [
  //             Container(
  //               height: 40,
  //               child: Icon(Icons.maximize_rounded,
  //                   size: 80, color: HexColor("#D1D7E7")),
  //             ),
  //             Expanded(
  //               child: SfDateRangePicker(
  //                 showNavigationArrow: true,
  //                 onSelectionChanged: _onSelectionChanged,
  //                 view: DateRangePickerView.month,
  //                 headerStyle: DateRangePickerHeaderStyle(
  //                   textStyle: TextStyle(
  //                     color: HexColor("#2B3674"),
  //                     fontFamily: "CPF Imm Sook",
  //                     fontSize: 24,
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                 ),
  //                 selectionMode: DateRangePickerSelectionMode.single,
  //                 initialSelectedDate: date_End,
  //               ),
  //             ),
  //             Container(
  //               width: MediaQuery.of(context).size.width,
  //               margin: EdgeInsets.only(top: 10, left: 20, right: 20),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   GestureDetector(
  //                     child: Container(
  //                       width: MediaQuery.of(context).size.width * 0.4,
  //                       padding: EdgeInsets.symmetric(vertical: 10.0),
  //                       decoration: BoxDecoration(
  //                         // color: HexColor("#FFFFFF"),
  //                         borderRadius: BorderRadius.circular(8),
  //                         border: Border.all(
  //                           width: 1,
  //                           color: HexColor("#2B3674"),
  //                         ),
  //                       ),
  //                       alignment: Alignment.center,
  //                       child: Text(
  //                         "ยกเลิก",
  //                         style: TextStyle(
  //                           color: HexColor("#2B3674"),
  //                           fontSize: 18,
  //                           fontWeight: FontWeight.w500,
  //                           fontFamily: "CPF Imm Sook",
  //                         ),
  //                       ),
  //                     ),
  //                     onTap: () {
  //                       Navigator.pop(context);
  //                     },
  //                   ),
  //                   GestureDetector(
  //                     child: Container(
  //                       width: MediaQuery.of(context).size.width * 0.4,
  //                       padding: EdgeInsets.symmetric(vertical: 10.0),
  //                       decoration: BoxDecoration(
  //                           color: HexColor("#2B3674"),
  //                           borderRadius: BorderRadius.circular(8)),
  //                       alignment: Alignment.center,
  //                       child: Text(
  //                         "ตกลง",
  //                         style: TextStyle(
  //                           color: HexColor("#FFFFFF"),
  //                           fontSize: 18,
  //                           fontWeight: FontWeight.w500,
  //                           fontFamily: "CPF Imm Sook",
  //                         ),
  //                       ),
  //                     ),
  //                     onTap: () {
  //                       onSelectionEnd();
  //                     },
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}

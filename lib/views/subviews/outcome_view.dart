import 'package:flutter/material.dart';
import 'package:money_tracking_project/models/money.dart';
import 'package:money_tracking_project/models/user.dart';
import 'package:money_tracking_project/services/call_api.dart';
import 'package:money_tracking_project/services/provider.dart';
import 'package:money_tracking_project/utils/env.dart';
import 'package:money_tracking_project/views/home_ui.dart';
import 'package:provider/provider.dart';

class OutcomeView extends StatefulWidget {
  final User user;

  OutcomeView({Key? key, required this.user}) : super(key: key);

  @override
  State<OutcomeView> createState() => _OutcomeViewState();
}

class _OutcomeViewState extends State<OutcomeView> {
  TextEditingController outcomeDetailCtrl = TextEditingController(text: '');
  TextEditingController outcomeAmountCtrl = TextEditingController(text: '');
  TextEditingController dateOutcomeCtrl = TextEditingController(text: '');

  //ตัวแปรเก็บค่าจาก provider
  late final totalIn;
  late final totalOut;

  //ตัวแปรเก็บวันที่กิน
  String? _DateIncomeSelected;

  //เมธอดปฏิทิน
  Future<void> _openCalendar() async {
    final DateTime? _picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    //นำผลที่ได้จากการเลือกปฏิทินไปกำหนดให้กับ TextField
    if (_picker != null) {
      setState(() {
        _DateIncomeSelected = _picker.toString().substring(0, 10); //2024-01-31
        dateOutcomeCtrl.text = convertToThaiDate(_picker);
      });
    }
  }

  //เมธอดแปลงวันที่แบบสากล (ปี ค.ศ.-เดือน ตัวเลข-วัน ตัวเลข) ให้เป็นวันที่แบบไทย (วัน เดือน ปี)
  //                             2023-11-25
  convertToThaiDate(date) {
    String day = date.toString().substring(8, 10);
    String year = (int.parse(date.toString().substring(0, 4)) + 543).toString();
    String month = '';
    int monthTemp = int.parse(date.toString().substring(5, 7));
    switch (monthTemp) {
      case 1:
        month = 'มกราคม';
        break;
      case 2:
        month = 'กุมภาพันธ์';
        break;
      case 3:
        month = 'มีนาคม';
        break;
      case 4:
        month = 'เมษายน';
        break;
      case 5:
        month = 'พฤษภาคม';
        break;
      case 6:
        month = 'มิถุนายน';
        break;
      case 7:
        month = 'กรกฎาคม';
        break;
      case 8:
        month = 'สิงหาคม';
        break;
      case 9:
        month = 'กันยายน';
        break;
      case 10:
        month = 'ตุลาคม';
        break;
      case 11:
        month = 'พฤศจิกายน';
        break;
      default:
        month = 'ธันวาคม';
    }

    return int.parse(day).toString() + ' ' + month + ' ' + year;
  }

  //เมธอดแสดงคำเตือนต่างๆ
  showWaringDialog(context, msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Align(
          alignment: Alignment.center,
          child: Text(
            'คำเตือน',
          ),
        ),
        content: Text(
          msg,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'ตกลง',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //เมธอดแสดงผลการทำงานต่างๆ
  Future showCompleteDialog(context, msg) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Align(
          alignment: Alignment.center,
          child: Text(
            'ผลการทำงาน',
          ),
        ),
        content: Text(
          msg,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'ตกลง',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    totalIn = Provider.of<BalanceProvider>(context, listen: false).totalIn;
    totalOut = Provider.of<BalanceProvider>(context, listen: false).totalOut;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 60, 140, 134),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            padding: EdgeInsets.all(20.0),
            child: SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widget.user!.userFullname!}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: widget.user.userImage != null &&
                              widget.user.userImage!.isNotEmpty
                          ? NetworkImage(
                              '${Env.hostName}/moneytracking/picupload/userImage/${widget.user.userImage}')
                          : AssetImage('assets/images/person.png')
                              as ImageProvider,
                      onBackgroundImageError: (exception, stackTrace) {
                        print('Error loading image: $exception');
                      },
                      backgroundColor: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.175,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 57, 126, 121),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        blurRadius: 10,
                        offset: Offset(0, 0.5),
                      )
                    ],
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        "ยอดเงินคงเหลือ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "${(totalIn - totalOut).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "ยอดเงินเข้ารวม",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "${totalIn.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text("ยอดเงินออกรวม",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  )),
                              SizedBox(height: 5),
                              Text(
                                "${totalOut.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.475,
              ),
              Text(
                "เงินออก",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        TextField(
                          controller: outcomeDetailCtrl,
                          decoration: InputDecoration(
                            labelText: 'รายการเงินออก',
                            hintText: 'DETAIL',
                            hintStyle: TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.teal,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.teal,
                                width: 2,
                              ),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        TextField(
                          controller: outcomeAmountCtrl,
                          decoration: InputDecoration(
                            labelText: 'จำนวนเงินออก',
                            hintText: '0.00',
                            hintStyle: TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.teal,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.teal,
                                width: 2,
                              ),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        TextField(
                          controller: dateOutcomeCtrl,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'วัน-เดือน-ปีที่เงินออก',
                            hintText: 'DATE OUTCOME',
                            hintStyle: TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.teal,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.teal,
                                width: 2,
                              ),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: IconButton(
                              onPressed: () {
                                _openCalendar();
                              },
                              icon: Icon(Icons.calendar_month),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            //Validate
                            if (outcomeDetailCtrl.text.trim().length == 0) {
                              showWaringDialog(
                                  context, 'ป้อนรายละเอียดเงินออกด้วย....');
                            } else if (outcomeAmountCtrl.text.trim().length ==
                                0) {
                              showWaringDialog(
                                  context, 'ป้อนจำนวนเงินด้วย....');
                            } else if (dateOutcomeCtrl.text.trim().length ==
                                0) {
                              showWaringDialog(
                                  context, 'เลือกวันที่เงินออกด้วย....');
                            } else {
                              //ส่งข้อมูลที่ผู้ใช้ป้อน/เลือกไปให้ API เพื่อบันทึกการกินลงฐานข้อมูล
                              //แพ็กข้อมูลที่จะส่งรวมกัน
                              Money money = Money(
                                moneyDetail: outcomeDetailCtrl.text.trim(),
                                moneyInOut: outcomeAmountCtrl.text.toString(),
                                moneyDate: dateOutcomeCtrl.text.trim(),
                                moneyType: '2',
                                userId: widget.user
                                    .userId, // ใช้ userId จาก User ที่ถูกส่งมา
                              );

                              //ส่งข้อมูลที่แพ็กไว้ไปให้ API เพื่อบันทึกการกินลงฐานข้อมูล
                              CallAPI.callInsertMoneyInOutAPI(money)
                                  .then((value) {
                                if (value.message == '1') {
                                  //ลงทะเบียนสำเร็จ
                                  showCompleteDialog(
                                    context,
                                    "บันทึกรายการเงินเข้าสำเร็จแล้ว...",
                                  ).then((value) {});
                                } else {
                                  //ลงทะเบียนไม่สำรเร็จ
                                  showWaringDialog(
                                    context,
                                    "บันทึกรายการเงินเข้าไม่สำเร็จ ลองใหม่อีกครั้ง...",
                                  );
                                }
                              });
                            }
                          },
                          child: Text(
                            'บันทึกเงินเข้า',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 90, 157, 152),
                            fixedSize: Size(
                              MediaQuery.of(context).size.width * 0.9,
                              MediaQuery.of(context).size.height * 0.07,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            shadowColor:
                                const Color.fromARGB(255, 90, 157, 152),
                            elevation: 10,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

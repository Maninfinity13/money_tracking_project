import 'package:flutter/material.dart';
import 'package:money_tracking_project/models/user.dart';
import 'package:money_tracking_project/services/call_api.dart';
import 'package:money_tracking_project/views/home_ui.dart';
import 'package:money_tracking_project/views/subviews/main_view.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  //ตัวควบคุม TextField
  TextEditingController userNameCtrl = TextEditingController(text: '');
  TextEditingController userPasswordCtrl = TextEditingController(text: '');

  //เปิด-ปิด ดูรหัสผ่าน
  bool passStatus = true;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 68, 140, 134),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 68, 140, 134),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'เข้าใช้งาน Money Tracking',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.85,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // รูปภาพ
                  Image.asset(
                    'assets/images/money.png',
                    height: MediaQuery.of(context).size.height * 0.35,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  // ชื่อผู้ใช้
                  TextField(
                    controller: userNameCtrl,
                    decoration: InputDecoration(
                      labelText: 'ชื่อผู้ใช้',
                      hintText: 'USERNAME',
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
                  // รหัสผ่าน
                  TextField(
                    obscureText: passStatus,
                    controller: userPasswordCtrl,
                    decoration: InputDecoration(
                      labelText: 'รหัสผ่าน',
                      hintText: 'PASSWORD',
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
                          setState(() {
                            passStatus = !passStatus;
                          });
                        },
                        icon: Icon(
                            passStatus == true ? Icons.lock : Icons.lock_open),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //Validate
                      if (userNameCtrl.text.trim().length == 0) {
                        showWaringDialog(context, 'ป้อนชื่อผู้ใช้ด้วย....');
                      } else if (userPasswordCtrl.text.trim().length == 0) {
                        showWaringDialog(context, 'ป้อนรหัสผ่านด้วย....');
                      } else {
                        //ตรวจสอบชื่อผู้ใช้และรหัสผ่านใน DB ผ่าน API ที่สร้างไว้
                        //สร้างตัวแปรเก็บข้อมูลที่จะส่งไปกับ API
                        User user = User(
                          userName: userNameCtrl.text.trim(),
                          userPassword: userPasswordCtrl.text.trim(),
                        );
                        //เรียกใช้ API
                        CallAPI.callCheckLoginAPI(user).then(
                          (value) {
                            if (value.message == '1') {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeUI(user: value),
                                ),
                              );
                            } else {
                              showWaringDialog(
                                  context, "ชื่อผู้ใช้รหัสผ่านไม่ถูกต้อง...");
                            }
                          },
                        );
                      }
                    },
                    child: Text(
                      'เข้าใช้งาน',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 90, 157, 152),
                      fixedSize: Size(
                        MediaQuery.of(context).size.width * 0.9,
                        MediaQuery.of(context).size.height * 0.07,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      shadowColor: const Color.fromARGB(255, 90, 157, 152),
                      elevation: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

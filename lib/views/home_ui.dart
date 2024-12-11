import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_tracking_project/services/provider.dart';
import 'package:money_tracking_project/views/subviews/income_view.dart';
import 'package:money_tracking_project/views/subviews/main_view.dart';
import 'package:money_tracking_project/views/subviews/outcome_view.dart';
import 'package:money_tracking_project/models/user.dart';
import 'package:provider/provider.dart';

class HomeUI extends StatefulWidget {
  final User user; // เปลี่ยนเป็น required และ non-nullable
  HomeUI({Key? key, required this.user}) : super(key: key);

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  int _selectedIndex = 1;

  // สร้าง getter สำหรับ view ที่ต้องการ
  List<Widget> get _showView => [
        IncomeView(user: widget.user), // ส่ง user ไปยัง IncomeView
        MainView(user: widget.user),  // ส่ง user ไปยัง MainView
        OutcomeView(user: widget.user), // ส่ง user ไปยัง OutcomeView
      ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BalanceProvider(),
      child: Scaffold(
        body: _showView[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(left: 50), // ร่นระยะห่างระหว่าง icon ใน navigation bar
                child: Icon(Icons.attach_money),//หาไอคอนตามรูปไม่เจอ
              ),
              label: 'Income',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Main',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(right: 50), // ร่นระยะห่างระหว่าง icon ใน navigation bar
                child: Icon(Icons.money_off),//หาไอคอนตามรูปไม่เจอ
              ),
              label: 'Outcome',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          selectedIconTheme: const IconThemeData(size: 40), // ขนาดไอคอนเมื่อถูกเลือก
          unselectedIconTheme: const IconThemeData(size: 35), // ขนาดไอคอนเมื่อไม่ได้เลือก
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: const Color.fromARGB(255, 6, 157, 124),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: (paramValue) {
            setState(() {
              _selectedIndex = paramValue;
            });
          },
        ),
      ),
    );
  }
}

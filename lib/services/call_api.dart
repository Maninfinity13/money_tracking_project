//call_api.dart
//ไฟล์นี้จะประกอบเมธอดต่างๆ ที่ใช้เรียก  API ต่างๆ ตามวัตถุประสงค์การทำงานของ App
// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:money_tracking_project/models/user.dart';
import 'package:money_tracking_project/models/money.dart';
import 'package:http/http.dart' as http;
import 'package:money_tracking_project/utils/env.dart';

class CallAPI {
  //เมธอดเรียก API ตรวจสอบชื่อผู้ใช้รหัสผ่าน --------------------------
  static Future<User> callCheckLoginAPI(User user) async {
    //เรียกใช้ API แล้วเก็บค่าที่ได้จาก API ไว้ในตัวแปร
    final responseData = await http.post(
      Uri.parse(Env.hostName + '/moneytracking/apis/check_login_api.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (responseData.statusCode == 200) {
      return User.fromJson(jsonDecode(responseData.body));
    } else {
      throw Exception('Failed to call API');
    }
  }

  //เมธอดเรียก API บันทึกเพิ่มข้อมูลสมาชิกใหม่ --------------------------
  static Future<User> callRegisterUserAPI(User user) async {
    //เรียกใช้ API แล้วเก็บค่าที่ได้จาก API ไว้ในตัวแปร
    final responseData = await http.post(
      Uri.parse(Env.hostName + '/moneytracking/apis/register_user_api.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (responseData.statusCode == 200) {
      return User.fromJson(jsonDecode(responseData.body));
    } else {
      throw Exception('Failed to call API');
    }
  }

  //เมธอดเรียก API ดึงข้อมูลรายการเงินเข้า-ออกของ user คนนั้นๆ --------------------------
  static Future<List<Money>> callGetMoneyDetailListAPI(Money money) async {
    //เรียกใช้ API แล้วเก็บค่าที่ได้จาก API ไว้ในตัวแปร
    final responseData = await http.post(
      Uri.parse(Env.hostName + '/moneytracking/apis/get_money_detail_list_api.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(money.toJson()),
    );

    if (responseData.statusCode == 200) {
      final dataList = await jsonDecode(responseData.body).map<Money>((json) {
        return Money.fromJson(json);
      }).toList();

      return dataList;
    } else {
      throw Exception('Failed to call API');
    }
  }

  //เมธอดเรียก API เพิ่มรายการเงินเข้า-ออก --------------------------
  static Future<Money> callInsertMoneyInOutAPI(Money money) async {
    //เรียกใช้ API แล้วเก็บค่าที่ได้จาก API ไว้ในตัวแปร
    final responseData = await http.post(
      Uri.parse(Env.hostName + '/moneytracking/apis/insert_money_in_out_api.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(money.toJson()),
    );

    if (responseData.statusCode == 200) {
      return Money.fromJson(jsonDecode(responseData.body));
    } else {
      throw Exception('Failed to call API');
    }
  }
}

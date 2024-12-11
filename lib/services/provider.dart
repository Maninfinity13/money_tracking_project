//file นี้ถูกสร้างขึ้นเพื่อให้สามารถส่งข้อมูลจากหน้า MainView ไปยัง subview อื่นๆได้
import 'package:flutter/material.dart';

class BalanceProvider extends ChangeNotifier {
  double _totalIn = 0.0;
  double _totalOut = 0.0;

  double get totalIn => _totalIn;
  double get totalOut => _totalOut;

  void updateBalance(double inAmount, double outAmount) {
    _totalIn = inAmount;
    _totalOut = outAmount;
    notifyListeners();
  }
}
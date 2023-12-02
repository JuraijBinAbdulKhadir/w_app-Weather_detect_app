import 'package:flutter/cupertino.dart';

class MyModel extends ChangeNotifier {

var x;
  void setData(String value){
     x = value;
    notifyListeners();
  }}
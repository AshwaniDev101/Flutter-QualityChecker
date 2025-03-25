import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage.dart';
import 'lockpage/lockpage.dart';



Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  var prefs = await SharedPreferences.getInstance();
  var boolKey = 'isFirstTime';
  var isFirstTime = false;//prefs.getBool(boolKey) ?? true;


  runApp(MaterialApp(home: isFirstTime ? LockPage(prefs, boolKey) : Homepage(), debugShowCheckedModeBanner: false,title: 'Quality Checker',),);
}
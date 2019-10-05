import 'package:flutter/material.dart';
import 'package:chatapp/screens/auth/login.dart';

import 'http.dart';


void main() {
  initHttp();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter chat',
      home: Login(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_molecular_chat/screens/auth/login.dart';

import 'http.dart';

void main() {
  // called to initialyze the interceptor in http.dart
  initHttp();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter chat',
      // When the app is started, it calls to the Login screen
      home: Login(),
    );
  }
}


import 'package:flutter/material.dart';
import 'file:///C:/Users/new/AndroidStudioProjects/flutter_app1/lib/widgets/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUp(),
    );
  }
}


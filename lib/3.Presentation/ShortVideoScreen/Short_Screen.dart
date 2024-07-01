import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class Short_Screen extends StatefulWidget {
  const Short_Screen({super.key});

  @override
  State<Short_Screen> createState() => _Short_ScreenState();
}

class _Short_ScreenState extends State<Short_Screen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('Short')),
      body: Text("Profile_Screen"),
    );
  }
}
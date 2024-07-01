import 'package:flutter/material.dart';

class Add_Video_Screen extends StatefulWidget {
  const Add_Video_Screen({super.key});

  @override
  State<Add_Video_Screen> createState() => _Add_Video_ScreenState();
}

class _Add_Video_ScreenState extends State<Add_Video_Screen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar( title: Text('Add Video')),
      body: Text(""),);
  }
}
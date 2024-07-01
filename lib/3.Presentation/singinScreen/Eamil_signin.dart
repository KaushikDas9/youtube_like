// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_clone/2.Domain/Auth/Sign_up.dart';
import 'package:youtube_clone/3.Presentation/HomeScreen/Home_Page.dart';
import 'package:youtube_clone/3.Presentation/ManageAllScreen/Manage_All_Screen.dart';

class EmailSignin extends StatefulWidget {
  const EmailSignin({super.key});

  @override
  State<EmailSignin> createState() => _email_loginState();
}

class _email_loginState extends State<EmailSignin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Form(
        key: _formKey,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text("Login"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              controller: _emailController,
              validator: (value) {
                if (value.toString().isEmpty) {
                  return 'Please enter your Email';
                } else {
                  print("Vali:${value}");
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              controller: _passwordController,
              obscureText: true,
              validator: (value) {
                if (value.toString().isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  
                  print(_emailController.text.toString());
                  print(_passwordController.text.toString());

                  await Sign_Up_SupaBase().signInWithEmail (
                      email: _emailController.text.toString(),
                      password: _passwordController.text.toString());
                }
              },
              child: const Text("LOGIN")),
        ]),
      ),
    );
  }
}

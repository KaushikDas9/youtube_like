// ignore_for_file: camel_case_types
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_clone/2.Domain/Auth/Sign_up.dart';
import 'package:youtube_clone/3.Presentation/HomeScreen/Home_Page.dart';
import 'package:youtube_clone/3.Presentation/ManageAllScreen/Manage_All_Screen.dart';
import 'package:youtube_clone/3.Presentation/singinScreen/Eamil_signin.dart';

class EmailLogin extends StatefulWidget {
  const EmailLogin({super.key});

  @override
  State<EmailLogin> createState() => _email_loginState();
}

class _email_loginState extends State<EmailLogin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text('SignUp')),
      body: Form(
        key: _formKey,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text("SIGN UP"),
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
          CupertinoButton(
            child: Text("Already Have Account"),
            onPressed: () {
              Get.off(EmailSignin());
            },
          ),
          ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                

                  await Sign_Up_SupaBase().signUpNewUser(
                      email: _emailController.text.toString(),
                      password: _passwordController.text.toString());
                }
              },
              child: const Text("SIGN UP")),
        ]),
      ),
    );
  }
}

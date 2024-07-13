import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  static const String routeName = "loginPage";
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text("Login Page"),
      ),
    );
  }
}
import 'package:chat_autonomos/pages/login.dart';
import 'package:chat_autonomos/pages/registrar.dart';
import 'package:flutter/material.dart';

class LoginOuRegistrar extends StatefulWidget {
  const LoginOuRegistrar({super.key});

  @override
  State<LoginOuRegistrar> createState() => LoginOuRegistrarState();
}

class LoginOuRegistrarState extends State<LoginOuRegistrar> {
  bool login = true;

  void tooglePages() {
    setState(() {
      login = !login;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(login){
      return LoginPage(onTap: tooglePages);
    }
    else{
      return RegistrarPage(onTap: tooglePages);
    }
  }
}

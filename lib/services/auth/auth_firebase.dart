import 'package:chat_autonomos/pages/home.dart';
import 'package:chat_autonomos/services/auth/login_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthFirebase extends StatelessWidget {
  const AuthFirebase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return const HomePage();
            }
            else{
              return const LoginOuRegistrar();
            }
          }),
    );
  }
}

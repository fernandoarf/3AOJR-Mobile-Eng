import 'package:chat_autonomos/components/button_input.dart';
import 'package:chat_autonomos/components/text_input.dart';
import 'package:chat_autonomos/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signInUser(
          emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[850],
        body: SafeArea(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(height: 25),
              const Icon(
                Icons.chat_bubble_outline,
                size: 80,
                color: Colors.white,
              ),
              const SizedBox(height: 25),
              const Text("Bem vindo",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(height: 25),
              TextInput(
                  controller: emailController,
                  obscureText: false,
                  placeholder: "Insira seu E-mail"),
              const SizedBox(height: 25),
              TextInput(
                  controller: passwordController,
                  obscureText: true,
                  placeholder: "Insira sua senha"),
              const SizedBox(height: 25),
              ButtonInput(onTap: signIn, text: 'Login'),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Não possui uma conta?",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Registrar",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ),
                ],
              )
            ]),
          ),
        )));
  }
}

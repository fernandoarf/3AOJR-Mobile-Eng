import 'package:chat_autonomos/components/button_input.dart';
import 'package:chat_autonomos/components/text_input.dart';
import 'package:chat_autonomos/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrarPage extends StatefulWidget {
  final void Function()? onTap;
  const RegistrarPage({super.key, required this.onTap});

  @override
  State<RegistrarPage> createState() => _RegistrarPageState();
}

class _RegistrarPageState extends State<RegistrarPage> {
  bool clienteAutonomo = false;
  final emailController = TextEditingController();
  final nomeController = TextEditingController();
  final areaController = TextEditingController();
  final descricaoController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[850],
        body: SafeArea(
            child: SingleChildScrollView(
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
              const Text("Registrar",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(height: 25),
              Row(children: [
                const Text(
                  "Cliente",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Switch(
                  value: clienteAutonomo,
                  onChanged: (value) {
                    setState(() {
                      clienteAutonomo = value;
                    });
                  },
                ),
                const Text(
                  "Autônomo",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )
              ]),
              const SizedBox(height: 15),
              TextInput(
                  controller: nomeController,
                  obscureText: false,
                  placeholder: "Insira seu Nome"),
              const SizedBox(height: 25),
              TextInput(
                  controller: emailController,
                  obscureText: false,
                  placeholder: "Insira seu E-mail"),
              const SizedBox(height: 25),
              if (clienteAutonomo == true) ...[
                TextInput(
                    controller: areaController,
                    obscureText: false,
                    placeholder: "Insira sua área de atuação"),
                const SizedBox(height: 25),
                TextInput(
                    controller: descricaoController,
                    obscureText: false,
                    placeholder: "Insira uma breve descrição de sua atuação"),
                const SizedBox(height: 25),
              ],
              TextInput(
                  controller: passwordController,
                  obscureText: true,
                  placeholder: "Insira sua senha"),
              const SizedBox(height: 25),
              TextInput(
                  controller: repeatPasswordController,
                  obscureText: true,
                  placeholder: "Repita sua senha"),
              const SizedBox(height: 25),
              ButtonInput(onTap: registrar, text: 'Registrar'),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Já uma conta?",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Logar",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50)
            ]),
          ),
        ))));
  }

  Future<void> registrar() async {
    if (passwordController.text != repeatPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Senhas inseridas não são iguais")));
      return;
    }
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.createUser(
          emailController.text,
          passwordController.text,
          nomeController.text,
          areaController.text,
          descricaoController.text,
          clienteAutonomo);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}

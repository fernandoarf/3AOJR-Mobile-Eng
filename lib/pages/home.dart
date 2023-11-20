import 'package:chat_autonomos/pages/chat.dart';
import 'package:chat_autonomos/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.grey,
        actions: [
          IconButton(onPressed: signOut, icon: const Icon(Icons.logout))
        ],
      ),
      body: _buildListUsers(),
    );
  }

  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  Widget _buildListUsers() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("users").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Erro ao exibir lista de Clientes/Autônomos");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Carregando...");
        }
        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((e) => _buildItemUser(e))
              .toList(),
        );
      },
    );
  }

  Widget _buildItemUser(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data =
        documentSnapshot.data()! as Map<String, dynamic>;
    if (_firebaseAuth.currentUser!.email != data['email']) {
      return ListTile(
        minVerticalPadding: 20,
        tileColor: Colors.grey[850],
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        title: Text(
          data['nome'],
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        titleAlignment: ListTileTitleAlignment.threeLine,
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data['area'], style: const TextStyle(color: Colors.grey)),
            Text(data['descricao'], style: const TextStyle(color: Colors.grey))
          ],
        ),
        trailing: Text(
          data['email'],
          style: const TextStyle(color: Colors.grey),
        ),
        leading: const Icon(
          Icons.person,
          color: Colors.blueGrey,
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  recieverUserEmail: data['email'],
                  recieverUserID: data['uid'],
                  recieverUserNome: data['nome']!,
                  recieverUserAutonomo: data['autonomo']!
                ),
              ));
        },
      );
    } else {
      return Container();
    }
  }

}

import 'package:chat_autonomos/components/text_input.dart';
import 'package:chat_autonomos/services/chat/chat_gpt_service.dart';
import 'package:chat_autonomos/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  final String recieverUserEmail;
  final String recieverUserID;
  final String recieverUserNome;
  final bool recieverUserAutonomo;
  const ChatPage(
      {super.key,
      required this.recieverUserEmail,
      required this.recieverUserID,
      required this.recieverUserNome,
      required this.recieverUserAutonomo});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _msgController = TextEditingController();
  final ChatService _chatService = ChatService();
  final ChatGPTService _chatGPTService = ChatGPTService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMsg() async {
    if (_msgController.text.isNotEmpty) {
      final String currentUser = _firebaseAuth.currentUser!.uid;
      final String userEmail = _firebaseAuth.currentUser!.email.toString();
      await _chatService.sendMsg(
          widget.recieverUserID, currentUser, userEmail, _msgController.text);
      final String msg = _msgController.text;
      //Se é Cliente, recebe uma resposta do ChatGPT sobre a pergunta
      FirebaseFirestore.instance
          .collection("users")
          .doc(_firebaseAuth.currentUser!.uid)
          .get()
          .then((DocumentSnapshot doc) async {
        final user = doc.data() as Map<String, dynamic>;
        try {
          if (user['autonomo'] == false && widget.recieverUserAutonomo == true) {
            String? respostaChatGPT = await _chatGPTService.callChatGPT(msg);
            await _chatService.sendMsg(currentUser, widget.recieverUserID,
                widget.recieverUserEmail, respostaChatGPT);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(user['autonomo'].toString())));
          }
        } on Exception catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.toString())));
        }
      });
      _msgController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.recieverUserNome,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              widget.recieverUserEmail,
              style: const TextStyle(fontSize: 12),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(child: buildListMsg()),
          buildMsg(),
          const SizedBox(
            height: 25,
          )
        ],
      ),
    );
  }

  Widget buildListMsg() {
    return StreamBuilder(
      stream: _chatService.getMsg(
          widget.recieverUserID, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Erro ao carregar mensagens");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Carregando...");
        }
        return ListView(
          children:
              snapshot.data!.docs.map((e) => buildListMsgItem(e)).toList(),
        );
      },
    );
  }

  Widget buildListMsgItem(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    bool ladoDireito = (data['senderId'] == _firebaseAuth.currentUser!.uid);

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment:
            ladoDireito ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: ladoDireito ? Colors.green[400] : Colors.grey[800],
            ),
            child: Column(
              crossAxisAlignment: ladoDireito
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  data['mensagem'],
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  convertTimestamp(data['timestamp']),
                  style: const TextStyle(fontSize: 10, color: Colors.white),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMsg() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(children: [
        Expanded(
            child: TextInput(
          controller: _msgController,
          obscureText: false,
          placeholder: "Mensagem",
        )),
        IconButton(
            onPressed: sendMsg,
            icon: const Icon(
              Icons.send,
              size: 30,
            ))
      ]),
    );
  }

  String convertTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('HH:mm').format(dateTime);
  }
}

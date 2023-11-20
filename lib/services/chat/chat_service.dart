import 'package:chat_autonomos/model/mensagem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> sendMsg(String idReceiver, String idSender, String senderEmail, String msg) async {
    
    final Timestamp timestamp = Timestamp.now();

    Mensagem mensagem = Mensagem(
        senderId: idSender,
        senderEmail: senderEmail,
        receiverId: idReceiver,
        mensagem: msg,
        timestamp: timestamp);

    List<String> idSenderReceiver = [idSender, idReceiver];
    idSenderReceiver.sort();
    String chatId = idSenderReceiver.join("__");

    await _firebaseFirestore
        .collection("chats")
        .doc(chatId)
        .collection("mensagens")
        .add(mensagem.toMap());
  }

  Stream<QuerySnapshot> getMsg(String idReceiver, String idSender) {
    List<String> idSenderReceiver = [idSender, idReceiver];
    idSenderReceiver.sort();
    String chatId = idSenderReceiver.join("__");
    return _firebaseFirestore
        .collection("chats")
        .doc(chatId)
        .collection("mensagens")
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class Mensagem {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String mensagem;
  final Timestamp timestamp;

  Mensagem(
      {required this.senderId,
      required this.senderEmail,
      required this.receiverId,
      required this.mensagem,
      required this.timestamp});

  Map<String, dynamic> toMap(){
    return {
      'senderId':senderId,
      'senderEmail':senderEmail,
      'receiverId':receiverId,
      'mensagem':mensagem,
      'timestamp':timestamp
    };
  }
}

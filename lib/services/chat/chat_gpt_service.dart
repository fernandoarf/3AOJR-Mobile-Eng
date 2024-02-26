import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatGPTService with ChangeNotifier {
  final String apiKey = "";
  final String apiUrl = "https://api.openai.com/v1/chat/completions";

  Future<String> callChatGPT(String inputText) async {
    List<Map<String, String>> messages = [
      {"role": "system", "content": "Você é um assistente que responde perguntas à clientes. Deve responder de forma objetiva e clara."},
      {"role": "user", "content": inputText}
    ];

    final Map<String, dynamic> requestData = {
      "model": "gpt-3.5-turbo",
      "messages": messages,
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: json.encode(requestData),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return utf8.decode(latin1.encode(responseData['choices'][0]['message']['content']),allowMalformed: true);
      } else {
        throw Exception("Error calling GPT-3.5 Turbo: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Exception calling GPT-3.5 Turbo: $e");
    }
  }
}

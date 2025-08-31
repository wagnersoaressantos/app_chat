
import 'package:app_chat/models/text_model.dart';
import 'package:app_chat/shared/widgets/chat_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatPage extends StatefulWidget {
  final String nickname;
  const ChatPage({super.key, required this.nickname});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final db = FirebaseFirestore.instance;
  final textoController = TextEditingController(text: '');
  String userId = "";

  @override
  void initState() {
    super.initState();
    carregarUsuario();
  }

  carregarUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('user_id')!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('chat')),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: db.collection('chats').snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? CircularProgressIndicator()
                        : ListView(
                            children: snapshot.data!.docs.map((e) {
                              var textModel = TextModel.fromJson(
                                (e.data() as Map<String, dynamic>),
                              );
                              return ChatWidget(
                                textModel: textModel,
                                souEu: textModel.userId == userId,
                              );
                            }).toList(),
                          );
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                ),
                // margin: EdgeInsets.all(8),
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textoController,
                        decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        var textModel = TextModel(nickname: widget.nickname,text: textoController.text,userId: userId, grupoId: null);
                        await db.collection("chats").add(textModel.toJson());
                        textoController.text = '';
                      },
                      icon: Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

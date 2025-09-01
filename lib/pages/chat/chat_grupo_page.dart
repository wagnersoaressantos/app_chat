import 'dart:async';

import 'package:app_chat/models/text_model.dart';
import 'package:app_chat/shared/widgets/chat_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatGrupoPage extends StatefulWidget {
  final String nickname;
  final String grupoId;
  final String grupoNome;
  const ChatGrupoPage({
    super.key,
    required this.nickname,
    required this.grupoId,
    required this.grupoNome,
  });

  @override
  State<ChatGrupoPage> createState() => _ChatGrupoPageState();
}

class _ChatGrupoPageState extends State<ChatGrupoPage> {
  final db = FirebaseFirestore.instance;
  final textoController = TextEditingController(text: '');
  bool _timeout = false;
  String userId = "";
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _timeout = true;
        });
      }
    });
    carregarUsuario();
  }

  Future<void> carregarUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('user_id')!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(widget.grupoNome)),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: db
                      .collection('chats')
                      .where('grupoId', isEqualTo: widget.grupoId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      if (_timeout) {
                        return const Center(
                          child: Text("Nenhuma mensagem ainda"),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }

                    return ListView(
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
                        var textModel = TextModel(
                          nickname: widget.nickname,
                          text: textoController.text,
                          userId: userId,
                          grupoId: widget.grupoId,
                        );
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

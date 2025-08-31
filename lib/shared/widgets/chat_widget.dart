import 'package:app_chat/models/text_model.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  final TextModel textModel;
  final bool souEu;
  const ChatWidget({super.key, required this.textModel, required this.souEu});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: souEu ? Alignment.bottomRight : Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 2),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: souEu ? Colors.cyanAccent : Colors.green,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            if (!souEu) Text('${textModel.nickname}:'),
            Text(textModel.text),
          ],
        ),
      ),
    );
  }
}

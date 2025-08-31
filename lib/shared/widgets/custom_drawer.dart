import 'package:app_chat/pages/chat/chat_page.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    var nicknameController = TextEditingController(text: "");
    // final remoteConfig = FirebaseRemoteConfig.instance;
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.chat),
            title: Text('chat'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: SizedBox(
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Text(remoteConfig.getString('texto_chat')),
                          TextField(controller: nicknameController),
                          TextButton(
                            onPressed: () {
                              // analytics.logEvent(name: 'chat_page');
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatPage(
                                    nickname: nicknameController.text,
                                  ),
                                ),
                              );
                            },
                            child: Text("Entrar no chat"),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => ChatPage(nickname: "",)),
              // );
            },
          ),
        ],
      ),
    );
  }
}

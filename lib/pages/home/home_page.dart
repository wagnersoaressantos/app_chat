import 'package:app_chat/models/grupo_model.dart';
import 'package:app_chat/pages/chat/chat_grupo_page.dart';
import 'package:app_chat/shared/widgets/custom_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var nicknameController = TextEditingController(text: "");
    final db = FirebaseFirestore.instance;
    TextEditingController nomeGrupoController = TextEditingController();
    Future<void> criarGrupo() async {
      if (nomeGrupoController.text.trim().isEmpty) return;
      final grupo = GrupoModel(id: '', nome: nomeGrupoController.text.trim());
      await db.collection('chats_grup').add(grupo.toMap());
      nomeGrupoController.clear();
    }

    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('App Chat Grupo'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext bc) {
                  return AlertDialog(
                    title: const Text("Criar Grupo"),
                    content: TextField(controller: nomeGrupoController),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancelar"),
                      ),
                      TextButton(
                        onPressed: () async {
                          await criarGrupo();
                          Navigator.pop(context);
                        },
                        child: const Text("Salvar"),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.group_add),
          ),
        ],
      ),

      body: Container(
        child: Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: db.collection('chats_grup').snapshots(),

            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Erro ao carregar grupos'));
              }
              final grupos = snapshot.data!.docs
                  .map((doc) => GrupoModel.fromDocument(doc))
                  .toList();
              if (grupos.isEmpty) {
                return const Center(child: Text('Nenhum grupo criado ainda.'));
              }
              return !snapshot.hasData
                  ? CircularProgressIndicator()
                  : ListView.builder(
                      itemCount: grupos.length,
                      itemBuilder: (context, index) {
                        final grupo = grupos[index];
                        return ListTile(
                          title: Text(grupo.nome),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: SizedBox(
                                    height: 200,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Informe seu NickName:'),
                                        TextField(
                                          controller: nicknameController,
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ChatGrupoPage(
                                                      nickname:
                                                          nicknameController
                                                              .text,
                                                      grupoId: grupo.id,
                                                      grupoNome: grupo.nome,
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
                          },
                        );
                      },
                    );
            },
          ),
        ),
      ),
    );
  }
}

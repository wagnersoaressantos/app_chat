import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nomeGrupoController = TextEditingController();
    return Scaffold(
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
      body: Container(),
    );
  }
}

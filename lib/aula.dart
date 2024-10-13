import 'package:flutter/material.dart';
import 'package:flutter_application_1/cadastro.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AulaStl extends StatelessWidget {
  const AulaStl({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AulaStf(),
    );
  }
}

class AulaStf extends StatefulWidget {
  const AulaStf({super.key});
  @override
  State<AulaStf> createState() => _AulaStfState();
}

class _AulaStfState extends State<AulaStf> {
  final TextEditingController _nomeController = TextEditingController();
  final aulaStream = Supabase.instance.client.from('aulas').stream(primaryKey: ['id']);

  Future<void> singOut() async {
    await Supabase.instance.client.auth.signOut();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const CadastroStl()),
    );
  }

  Future<void> novaAula() async {
    final nome = _nomeController.text.trim();
    if (nome.isNotEmpty) {
      await Supabase.instance.client.from('aulas').insert({'nome': nome});
      _nomeController.clear();
    }
  }

  Future<void> atualizarAula(aulaid, novoTexto) async{
    await Supabase.instance.client.from('aulas').update({'nome' : novoTexto}).eq('id', aulaid);
  }

  Future<void> deletarAula(String aulaid) async {
    await Supabase.instance.client.from('aulas').delete().eq('id', aulaid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'MELP',
            style: TextStyle(color: Colors.white),
          ),
        ), 
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
              SizedBox(
                width: 500,
                child: TextField(
                  controller: _nomeController,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    hintText: 'Insira o nome da aula',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.menu_book_rounded),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      borderSide: BorderSide(
                        color: Color.fromARGB(179, 143, 137, 137),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      borderSide: BorderSide(
                        color: Color.fromARGB(179, 143, 137, 137),
                      ),
                    )
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: novaAula,
                child: const Text('Criar'),
              ),

              ElevatedButton(
                onPressed: singOut,
                child: const Text('Sair'),
              ),
            ],),
            
            const SizedBox(height: 32),
            Expanded(
              child: StreamBuilder<List<Map<String, dynamic>>>(
                stream: aulaStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    final aulas = snapshot.data!;
                    return ListView.builder(
                      itemCount: aulas.length,
                      itemBuilder: (context, index) {
                        final aula = aulas[index];
                        final aulaId = aula['id'].toString();
                        return ListTile(
                          title: Text(aula['nome'] ?? 'Nome não encontrado'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(onPressed: (){
                                showDialog(context: context, builder: (context){
                                  return SimpleDialog(
                                    title: const Text("Editar nota"),
                                    children: [
                                      TextFormField(
                                        initialValue: aula['nome'],
                                        onFieldSubmitted: (value) async{
                                          await atualizarAula(aulaId, value);
                                        }),
                                    ],
                                  );
                                });
                              }, icon: const Icon(Icons.edit)),
                              IconButton(onPressed: () async{
                                bool deletedConfirmed = await showDialog(context: context, builder: (context){
                                  return AlertDialog(
                                    title: const Text('Deletar aula'),
                                    content: const Text('Você tem certeza?'),
                                    actions: [
                                      TextButton(onPressed: (){
                                        Navigator.pop(context, false);
                                      }, child: const Text('Cancelar')),
                                      TextButton(onPressed: (){
                                        Navigator.pop(context, true);
                                      }, child: const Text('Deletar'))
                                    ],
                                    
                                  );
                                });
                                if(deletedConfirmed){
                                  await deletarAula(aulaId);
                                }
                              }, icon: const Icon(Icons.delete))
                            ],
                            ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

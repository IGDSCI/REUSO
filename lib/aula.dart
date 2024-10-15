// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom_widgets/text_field.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/perfil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AulaStl extends StatelessWidget {
  const AulaStl({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const HomeStl(),
        '/perfil': (context) => const PerfilStl(),
      },
      home: const AulaStf(),
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
  List<dynamic> aulas = [];

  @override
  void initState() {
    super.initState();
    _loadAulas();
  }

  Future<void> novaAula() async {
    final nome = _nomeController.text.trim();
    if (nome.isNotEmpty) {
      final response = await Supabase.instance.client.from('aulas').insert({
        'nome': nome,
      }).execute();
      if (response.status == 200) {
        _loadAulas();
        _nomeController.clear();
        _loadAulas();
      } else {
        _loadAulas();
      }
    }
  }

  Future<void> _loadAulas() async {
    final response = await Supabase.instance.client.from('aulas').select().execute();
    if (response.status == 200) {
      setState(() {
        aulas = response.data;
      });
    } else {
      
    }
  }

  Future<void> atualizarAula(String aulaId, String novoNome) async {
    await Supabase.instance.client.from('aulas').update({'nome': novoNome}).eq('id', aulaId).execute();
    _loadAulas();
  }

  Future<void> deletarAula(String aulaId) async {
    await Supabase.instance.client.from('aulas').delete().eq('id', aulaId).execute();
    _loadAulas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(
        child: Text(
          'MELP',
          style: TextStyle(color: Colors.white),
        )), 
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 32,
            color: Colors.white,
          ), 
          onPressed: (){
            Navigator.of(context).pushNamed('/home');
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: const Icon(
                Icons.person,
                size: 32,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/perfil');
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(
              controller: _nomeController,
              hintText: 'Nome da Aula',
            ),

            const SizedBox(height: 8),

            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: novaAula,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 33, 54, 243)),
                  elevation: MaterialStateProperty.all<double>(0),
                ),
                child: const Text(
                  'Adicionar aula',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                itemCount: aulas.length,
                itemBuilder: (context, index) {
                  final aula = aulas[index];
                  final aulaId = aula['id'].toString();
                  return Card(
                    color: const Color.fromARGB(255, 158, 157, 157),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            aula['nome'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      final nomeController = TextEditingController(text: aula['nome']);
                                      return AlertDialog(
                                        title: const Text('Editar aula'),
                                        content: 
                                        CustomTextField(
                                          controller: nomeController,
                                          hintText: 'Nome da Aula',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              atualizarAula(aulaId, nomeController.text);
                                              Navigator.pop(context);
                                            },
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 50, 97, 52)),
                                            ),
                                            child: const Text(
                                              'Salvar',
                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                              ),
                                          ),
                                          TextButton(
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 129, 47, 47)),
                                            ),
                                            onPressed: () => Navigator.pop(context),
                                            child: const Text(
                                              'Cancelar',
                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  bool deletedConfirmed = await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Deletar Aula'),
                                        content: const Text('Você tem certeza?'),
                                        actions: [
                                          TextButton(
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 50, 97, 52)),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context, true);
                                            },
                                            child: const Text(
                                              'Deletar',
                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                            ),
                                          ),

                                          TextButton(
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 129, 47, 47)),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context, false);
                                            },
                                            child: const Text(
                                              'Cancelar',
                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  if (deletedConfirmed) {
                                    await deletarAula(aulaId);
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

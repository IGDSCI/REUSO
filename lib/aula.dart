import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/perfil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AulaStl extends StatelessWidget {
  const AulaStl({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AulaStf(),
      routes: {
        '/home': (context) => const HomeStl(),
        '/perfil': (context) => const PerfilStl(),
      },
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
  List<dynamic> aulas = []; // Lista para armazenar as aulas

  @override
  void initState() {
    super.initState();
    _loadAulas(); // Carrega as aulas ao iniciar
  }

  Future<void> novaAula() async {
    final nome = _nomeController.text.trim();
    
    if (nome.isNotEmpty) {
      final response = await Supabase.instance.client.from('aulas').insert({
        'nome': nome,
      }).execute();

      if (response.status == 200) {
        _loadAulas(); // Atualiza a lista de aulas
        _nomeController.clear();
        _loadAulas();
      } else {
        print('Erro ao inserir aula: ');
        _loadAulas();
      }
    }
  }

  Future<void> _loadAulas() async {
    final response = await Supabase.instance.client.from('aulas').select().execute();
    if (response.status == 200) {
      setState(() {
        aulas = response.data; // Armazena as aulas na lista
      });
    } else {
      print('Erro ao carregar aulas:');
    }
  }

  Future<void> atualizarAula(String aulaId, String novoNome) async {
    await Supabase.instance.client.from('aulas').update({'nome': novoNome}).eq('id', aulaId).execute();
    _loadAulas(); // Atualiza a lista após a edição
  }

  Future<void> deletarAula(String aulaId) async {
    await Supabase.instance.client.from('aulas').delete().eq('id', aulaId).execute();
    _loadAulas(); // Atualiza a lista após a exclusão
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
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
                hintText: 'Nome da Aula',
              ),
            ),
            ElevatedButton(
              onPressed: novaAula,
              child: const Text('Adicionar Aula'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: aulas.length,
                itemBuilder: (context, index) {
                  final aula = aulas[index];
                  final aulaId = aula['id'].toString();

                  return Card(
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
                                  // Mostrar diálogo para editar a aula
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      final nomeController = TextEditingController(text: aula['nome']);
                                      return AlertDialog(
                                        title: const Text('Editar Aula'),
                                        content: TextField(
                                          controller: nomeController,
                                          decoration: const InputDecoration(hintText: 'Nome da Aula'),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              // Atualizar a aula
                                              atualizarAula(aulaId, nomeController.text);
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Salvar'),
                                          ),
                                          TextButton(
                                            onPressed: () => Navigator.pop(context),
                                            child: const Text('Cancelar'),
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
                                            onPressed: () {
                                              Navigator.pop(context, false);
                                            },
                                            child: const Text('Cancelar'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context, true);
                                            },
                                            child: const Text('Deletar'),
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

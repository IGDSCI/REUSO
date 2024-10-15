// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/perfil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExercicioStl extends StatelessWidget {
  const ExercicioStl({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ExercicioStf(),
      routes: {
        '/home': (context) => const HomeStl(),
        '/perfil': (context) => const PerfilStl(),
      },
    );
  }
}

class ExercicioStf extends StatefulWidget {
  const ExercicioStf({super.key});
  
  @override
  State<ExercicioStf> createState() => _ExercicioStfState();
}

class _ExercicioStfState extends State<ExercicioStf> {
  final TextEditingController _enunciadoController = TextEditingController();
  final TextEditingController _opcaoAController = TextEditingController();
  final TextEditingController _opcaoBController = TextEditingController();
  final TextEditingController _opcaoCController = TextEditingController();
  final TextEditingController _opcaoDController = TextEditingController();
  List<dynamic> exercicios = [];

  @override
  void initState() {
    super.initState();
    _loadExercicios();
  }

  Future<void> novoExercicio() async {
    final enunciado = _enunciadoController.text.trim();
    final opcaoA = _opcaoAController.text.trim();
    final opcaoB = _opcaoBController.text.trim();
    final opcaoC = _opcaoCController.text.trim();
    final opcaoD = _opcaoDController.text.trim();
    
    final response = await Supabase.instance.client.from('exercicio').insert({
      'enunciado': enunciado, 
      'opcaoA': opcaoA, 
      'opcaoB': opcaoB, 
      'opcaoC': opcaoC, 
      'opcaoD': opcaoD
    }).execute();

    if (response.status == 200) {
      _loadExercicios();
      _enunciadoController.clear();
      _opcaoAController.clear();
      _opcaoBController.clear();
      _opcaoCController.clear();
      _opcaoDController.clear();
      _loadExercicios(); 
    } else {
      print('Erro ao inserir exercício:');
      _loadExercicios(); 
    }
  }

  Future<void> _loadExercicios() async {
    final response = await Supabase.instance.client.from('exercicio').select().execute();
    if (response.status == 200) {
      setState(() {
        exercicios = response.data;
      });
    } else {
      print('Erro ao carregar exercícios: ');
    }
  }

  Future<void> atualizarExercicio(String exercicioId, Map<String, dynamic> dadosAtualizados) async {
    await Supabase.instance.client.from('exercicio').update(dadosAtualizados).eq('id', exercicioId).execute();
    _loadExercicios();
  }

  Future<void> deletarExercicio(String exercicioId) async {
    await Supabase.instance.client.from('exercicio').delete().eq('id', exercicioId).execute();
    _loadExercicios();
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),

              TextField(
                  controller: _enunciadoController,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    label: Text(
                      'Enunciado',
                      style: TextStyle(color: Color.fromARGB(255, 104, 104, 104)),
                    ),
                    border: OutlineInputBorder(),
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
          
                const SizedBox(height: 16),
          
              TextField(
                  controller: _opcaoAController,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    label: Text(
                      'Opção A',
                      style: TextStyle(color: Color.fromARGB(255, 104, 104, 104)),
                    ),
                    border: OutlineInputBorder(),
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
          
                const SizedBox(height: 16),
          
              TextField(
                  controller: _opcaoBController,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    label: Text(
                      'Opção B',
                      style: TextStyle(color: Color.fromARGB(255, 104, 104, 104)),
                    ),
                    border: OutlineInputBorder(),
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
          
                const SizedBox(height: 16),
          
              TextField(
                  controller: _opcaoCController,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    label: Text(
                      'Opção C',
                      style: TextStyle(color: Color.fromARGB(255, 104, 104, 104)),
                    ),
                    border: OutlineInputBorder(),
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
          
                const SizedBox(height: 16),
          
              TextField(
                  controller: _opcaoDController,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    label: Text(
                      'Opção D',
                      style: TextStyle(color: Color.fromARGB(255, 104, 104, 104)),
                    ),
                    border: OutlineInputBorder(),
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
          
                const SizedBox(height: 16),
          
              SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: novoExercicio,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 33, 54, 243)),
                      elevation: MaterialStateProperty.all<double>(0),
                    ),
                    child: const Text(
                      'Enviar',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
          
              const SizedBox(height: 16),
              Container(
                height: 230,
                child: Expanded(
                  child: ListView.builder(
                    itemCount: exercicios.length,
                    itemBuilder: (context, index) {
                      final exercicio = exercicios[index];
                      final exercicioId = exercicio['id'].toString();
                  
                      return Card(
                        color: const Color.fromARGB(255, 158, 157, 157),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                exercicio['enunciado'],
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text('A: ${exercicio['opcaoA']}'),
                              Text('B: ${exercicio['opcaoB']}'),
                              Text('C: ${exercicio['opcaoC']}'),
                              Text('D: ${exercicio['opcaoD']}'),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          final enunciadoController = TextEditingController(text: exercicio['enunciado']);
                                          final opcaoAController = TextEditingController(text: exercicio['opcaoA']);
                                          final opcaoBController = TextEditingController(text: exercicio['opcaoB']);
                                          final opcaoCController = TextEditingController(text: exercicio['opcaoC']);
                                          final opcaoDController = TextEditingController(text: exercicio['opcaoD']);
                                          
                                          return AlertDialog(
                                            title: const Text('Editar Exercício'),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [

                                                TextField(
                                                  controller: enunciadoController,
                                                  cursorColor: Colors.black,
                                                  decoration: const InputDecoration(
                                                    label: Text(
                                                      'Enunciado',
                                                      style: TextStyle(color: Color.fromARGB(255, 104, 104, 104)),
                                                    ),
                                                    border: OutlineInputBorder(),
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

                                                const SizedBox(height: 16),

                                                TextField(
                                                  controller: opcaoAController,
                                                  cursorColor: Colors.black,
                                                  decoration: const InputDecoration(
                                                    label: Text(
                                                      'Opcao A',
                                                      style: TextStyle(color: Color.fromARGB(255, 104, 104, 104)),
                                                    ),
                                                    border: OutlineInputBorder(),
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

                                                const SizedBox(height: 16),

                                                TextField(
                                                  controller: opcaoBController,
                                                  cursorColor: Colors.black,
                                                  decoration: const InputDecoration(
                                                    label: Text(
                                                      'Opcao B',
                                                      style: TextStyle(color: Color.fromARGB(255, 104, 104, 104)),
                                                    ),
                                                    border: OutlineInputBorder(),
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

                                                const SizedBox(height: 16),

                                                TextField(
                                                  controller: opcaoCController,
                                                  cursorColor: Colors.black,
                                                  decoration: const InputDecoration(
                                                    label: Text(
                                                      'Opcao C',
                                                      style: TextStyle(color: Color.fromARGB(255, 104, 104, 104)),
                                                    ),
                                                    border: OutlineInputBorder(),
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

                                                const SizedBox(height: 16),

                                                TextField(
                                                  controller: opcaoDController,
                                                  cursorColor: Colors.black,
                                                  decoration: const InputDecoration(
                                                    label: Text(
                                                      'Opcao D',
                                                      style: TextStyle(color: Color.fromARGB(255, 104, 104, 104)),
                                                    ),
                                                    border: OutlineInputBorder(),
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
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  atualizarExercicio(exercicioId, {
                                                    'enunciado': enunciadoController.text,
                                                    'opcaoA': opcaoAController.text,
                                                    'opcaoB': opcaoBController.text,
                                                    'opcaoC': opcaoCController.text,
                                                    'opcaoD': opcaoDController.text,
                                                  });
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
                                                onPressed: () => Navigator.pop(context),
                                                style: ButtonStyle(
                                                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 129, 47, 47)),
                                                ),
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
                                            title: const Text('Deletar Exercício'),
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
                                        await deletarExercicio(exercicioId);
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

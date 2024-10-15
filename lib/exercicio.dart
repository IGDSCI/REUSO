import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExercicioStl extends StatelessWidget {
  const ExercicioStl({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExercicioStf(),
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
  List<dynamic> exercicios = []; // Lista para armazenar os exercícios

  @override
  void initState() {
    super.initState();
    _loadExercicios(); // Carrega os exercícios ao iniciar
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
      _loadExercicios(); // Atualiza a lista de exercícios
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
        exercicios = response.data; // Armazena os exercícios na lista
      });
    } else {
      print('Erro ao carregar exercícios: ');
    }
  }

  Future<void> atualizarExercicio(String exercicioId, Map<String, dynamic> dadosAtualizados) async {
    await Supabase.instance.client.from('exercicio').update(dadosAtualizados).eq('id', exercicioId).execute();
    _loadExercicios(); // Atualiza a lista após a edição
  }

  Future<void> deletarExercicio(String exercicioId) async {
    await Supabase.instance.client.from('exercicio').delete().eq('id', exercicioId).execute();
    _loadExercicios(); // Atualiza a lista após a exclusão
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Exercício'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _enunciadoController,
              decoration: const InputDecoration(
                hintText: 'Enunciado',
              ),
            ),
            TextField(
              controller: _opcaoAController,
              decoration: const InputDecoration(
                hintText: 'Opcao A',
              ),
            ),
            TextField(
              controller: _opcaoBController,
              decoration: const InputDecoration(
                hintText: 'Opcao B',
              ),
            ),
            TextField(
              controller: _opcaoCController,
              decoration: const InputDecoration(
                hintText: 'Opcao C',
              ),
            ),
            TextField(
              controller: _opcaoDController,
              decoration: const InputDecoration(
                hintText: 'Opcao D',
              ),
            ),
            ElevatedButton(onPressed: novoExercicio, child: const Text('Enviar')),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: exercicios.length,
                itemBuilder: (context, index) {
                  final exercicio = exercicios[index];
                  final exercicioId = exercicio['id'].toString();

                  return Card(
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
                                  // Mostrar dialogo para editar o exercício
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
                                              decoration: const InputDecoration(hintText: 'Enunciado'),
                                            ),
                                            TextField(
                                              controller: opcaoAController,
                                              decoration: const InputDecoration(hintText: 'Opcao A'),
                                            ),
                                            TextField(
                                              controller: opcaoBController,
                                              decoration: const InputDecoration(hintText: 'Opcao B'),
                                            ),
                                            TextField(
                                              controller: opcaoCController,
                                              decoration: const InputDecoration(hintText: 'Opcao C'),
                                            ),
                                            TextField(
                                              controller: opcaoDController,
                                              decoration: const InputDecoration(hintText: 'Opcao D'),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              // Atualizar o exercício
                                              atualizarExercicio(exercicioId, {
                                                'enunciado': enunciadoController.text,
                                                'opcaoA': opcaoAController.text,
                                                'opcaoB': opcaoBController.text,
                                                'opcaoC': opcaoCController.text,
                                                'opcaoD': opcaoDController.text,
                                              });
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
                                        title: const Text('Deletar Exercício'),
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
          ],
        ),
      ),
    );
  }
}

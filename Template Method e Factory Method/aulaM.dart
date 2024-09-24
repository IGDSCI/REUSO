import 'package:flutter/material.dart';

// Classe base com o metodo template
abstract class SessaoDeAulaProgramacao {
  void conduzirAula() {
    _prepararMateriais();
    _agendarAula();
    _conduzirAula();
    _acompanhar();
  }

  void _prepararMateriais() {
    print('Preparando materiais...');
  }

  void _agendarAula() {
    print('Agendando aula...');
  }

  void _conduzirAula() {
    print('Conduzindo aula...');
  }

  void _acompanhar() {
    print('Acompanhando...');
  }
}

// Subclasse para Aula de Logica de Programacao
class SessaoDeAulaLogicaProgramacao extends SessaoDeAulaProgramacao {
  @override
  void _prepararMateriais() {
    print('Preparando materiais de logica de programacao (fluxogramas, pseudocodigo, etc.)...');
  }

  @override
  void _agendarAula() {
    print('Agendando aula de logica de programacao...');
  }

  @override
  void _conduzirAula() {
    print('Conduzindo aula de logica de programacao com atividades de resolucao de problemas...');
  }

  @override
  void _acompanhar() {
    print('Fornecendo feedback sobre exercicios e problemas de logica de programacao...');
  }
}

// Subclasse para Aula de Estruturas de Dados
class SessaoDeAulaEstruturasDados extends SessaoDeAulaProgramacao {
  @override
  void _prepararMateriais() {
    print('Preparando materiais sobre estruturas de dados (diagramas, exemplos de codigo, etc.)...');
  }

  @override
  void _agendarAula() {
    print('Agendando aula sobre estruturas de dados...');
  }

  @override
  void _conduzirAula() {
    print('Conduzindo aula sobre estruturas de dados com exercicios de codificacao e discussao...');
  }

  @override
  void _acompanhar() {
    print('Fornecendo feedback sobre tarefas e projetos de estruturas de dados...');
  }
}

void main() {
  runApp(MeuApp());
}

class MeuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sessao de Aula de Programacao',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TelaDeAula(),
    );
  }
}

class TelaDeAula extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sessao de Aula de Programacao'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              final sessaoDeAula = SessaoDeAulaLogicaProgramacao();
              sessaoDeAula.conduzirAula();
            },
            child: Text('Conduzir Aula de Logica de Programacao'),
          ),
          ElevatedButton(
            onPressed: () {
              final sessaoDeAula = SessaoDeAulaEstruturasDados();
              sessaoDeAula.conduzirAula();
            },
            child: Text('Conduzir Aula de Estruturas de Dados'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

// Classe base com o método template
abstract class EducationalActivity {
  void conductActivity() {
    _prepareMaterials();
    _conductSession();
    _evaluateResults();
    _provideFeedback();
  }

  void _prepareMaterials() {
    print('Preparando materiais...');
  }

  void _conductSession() {
    print('Conduzindo sessão...');
  }

  void _evaluateResults() {
    print('Avaliar resultados...');
  }

  void _provideFeedback() {
    print('Fornecendo feedback...');
  }
}

// Subclasse para Quiz de Lógica de Programação
class LogicQuizActivity extends EducationalActivity {
  @override
  void _prepareMaterials() {
    print('Preparando perguntas do quiz de lógica de programação...');
  }

  @override
  void _conductSession() {
    print('Conduzindo quiz de lógica de programação...');
  }

  @override
  void _evaluateResults() {
    print('Corrigindo quiz de lógica de programação...');
  }

  @override
  void _provideFeedback() {
    print('Fornecendo feedback para o quiz de lógica de programação...');
  }
}

// Subclasse para Quiz de Condicionais
class ConditionalsQuizActivity extends EducationalActivity {
  @override
  void _prepareMaterials() {
    print('Preparando perguntas do quiz de condicionais...');
  }

  @override
  void _conductSession() {
    print('Conduzindo quiz de condicionais...');
  }

  @override
  void _evaluateResults() {
    print('Corrigindo quiz de condicionais...');
  }

  @override
  void _provideFeedback() {
    print('Fornecendo feedback para o quiz de condicionais...');
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atividade Educacional',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ActivityScreen(),
    );
  }
}

class ActivityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Atividade Educacional'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              final activity = LogicQuizActivity();
              activity.conductActivity();
            },
            child: Text('Conduzir Quiz de Lógica de Programação'),
          ),
          ElevatedButton(
            onPressed: () {
              final activity = ConditionalsQuizActivity();
              activity.conductActivity();
            },
            child: Text('Conduzir Quiz de Condicionais'),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

// Classe base com o metodo template
abstract class GeradorDeRelatorioEstudante {
  void gerarRelatorio() {
    _coletarDados();
    _analisarDados();
    _formatarRelatorio();
    _entregarRelatorio();
  }

  void _coletarDados() {
    print('Coletando dados dos alunos...');
  }

  void _analisarDados() {
    print('Analisando dados...');
  }

  void _formatarRelatorio() {
    print('Formatando relatorio...');
  }

  void _entregarRelatorio() {
    print('Entregando relatorio...');
  }
}

// Subclasse para Relatorio de Desempenho em Testes
class GeradorDeRelatorioDesempenhoTestes extends GeradorDeRelatorioEstudante {
  @override
  void _coletarDados() {
    print('Coletando notas de testes...');
  }

  @override
  void _analisarDados() {
    print('Analisando desempenho em testes...');
  }

  @override
  void _formatarRelatorio() {
    print('Formatando relatorio de desempenho em testes...');
  }
}

// Subclasse para Relatorio de Participacao em Aula
class GeradorDeRelatorioParticipacaoAula extends GeradorDeRelatorioEstudante {
  @override
  void _coletarDados() {
    print('Coletando dados de participacao em sala de aula...');
  }

  @override
  void _analisarDados() {
    print('Analisando participacao em sala de aula...');
  }

  @override
  void _formatarRelatorio() {
    print('Formatando relatorio de participacao em sala de aula...');
  }
}

void main() {
  runApp(MeuApp());
}

class MeuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerador de Relatorios de Alunos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TelaDeRelatorio(),
    );
  }
}

class TelaDeRelatorio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerador de Relatorios de Alunos'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              final gerador = GeradorDeRelatorioDesempenhoTestes();
              gerador.gerarRelatorio();
            },
            child: Text('Gerar Relatorio de Desempenho em Testes'),
          ),
          ElevatedButton(
            onPressed: () {
              final gerador = GeradorDeRelatorioParticipacaoAula();
              gerador.gerarRelatorio();
            },
            child: Text('Gerar Relatorio de Participacao em Aula'),
          ),
        ],
      ),
    );
  }
}

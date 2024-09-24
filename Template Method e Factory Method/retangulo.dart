import 'package:flutter/material.dart';

// Interface da fabrica de retangulos
abstract class FabricaDeRetanguloModulo {
  Widget criarRetangulo(String titulo, [String descricao = '']);
}

// Fabrica para criar um retangulo simples com apenas o nome do modulo
class FabricaDeRetanguloModuloSimples extends FabricaDeRetanguloModulo {
  @override
  Widget criarRetangulo(String titulo, [String descricao = '']) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        titulo,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// Fabrica para criar um retangulo com o nome do modulo e uma descricao
class FabricaDeRetanguloModuloDetalhado extends FabricaDeRetanguloModulo {
  @override
  Widget criarRetangulo(String titulo, [String descricao = '']) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          if (descricao.isNotEmpty)
            Text(
              descricao,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MeuApp());
}

class MeuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Exemplo de Metodo de Fabrica com Retangulo'),
        ),
        body: DemonstraçãoDeModulo(),
      ),
    );
  }
}

class DemonstraçãoDeModulo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Escolha qual fabrica usar aqui
    FabricaDeRetanguloModulo fabricaDeRetangulo =
        FabricaDeRetanguloModuloDetalhado(); // Altere para FabricaDeRetanguloModuloSimples() para retangulo simples

    return SingleChildScrollView(
      child: Column(
        children: [
          fabricaDeRetangulo.criarRetangulo('Matematica',
              'Introducao a algebrar, geometria e calculo.'),
          fabricaDeRetangulo.criarRetangulo('Fisica',
              'Fundamentos de mecanica, termodinamica e eletromagnetismo.'),
          SizedBox(height: 20),
          FabricaDeRetanguloModuloSimples().criarRetangulo('Biologia'),
          FabricaDeRetanguloModuloSimples().criarRetangulo('Quimica'),
        ],
      ),
    );
  }
}

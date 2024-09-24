import 'package:flutter/material.dart';

// Interface da fabrica de botoes
abstract class FabricaDeBotoes {
  Widget criarBotao(String rotulo);
}

// Fabrica para criar botoes elevados
class FabricaDeBotaoElevado extends FabricaDeBotoes {
  @override
  Widget criarBotao(String rotulo) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(rotulo),
    );
  }
}

// Fabrica para criar botoes textuais
class FabricaDeBotaoTexto extends FabricaDeBotoes {
  @override
  Widget criarBotao(String rotulo) {
    return TextButton(
      onPressed: () {},
      child: Text(rotulo),
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
          title: Text('Metodo da Fabrica de Botoes'),
        ),
        body: DemonstracaoDeBotoes(),
      ),
    );
  }
}

class DemonstracaoDeBotoes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Escolha qual fabrica usar aqui
    FabricaDeBotoes fabricaDeBotao =
        FabricaDeBotaoElevado(); // Altere para FabricaDeBotaoTexto() se preferir o outro tipo de botao

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          fabricaDeBotao.criarBotao('Botao Alto'),
          SizedBox(height: 20),
          FabricaDeBotaoTexto().criarBotao('Botao Sem Borda'),
        ],
      ),
    );
  }
}

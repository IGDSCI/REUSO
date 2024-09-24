import 'package:flutter/material.dart';

// Interface da fabrica de perfis
abstract class FabricaDePerfilUsuario {
  Widget criarPerfil(String nome, String email);
}

// Fabrica para criar um perfil de Admin
class FabricaDePerfilAdmin extends FabricaDePerfilUsuario {
  @override
  Widget criarPerfil(String nome, String email) {
    return Card(
      color: Colors.blueAccent,
      child: ListTile(
        leading: Icon(Icons.admin_panel_settings, color: Colors.white),
        title: Text(nome,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(email, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

// Fabrica para criar um perfil de Usuario Regular
class FabricaDePerfilRegular extends FabricaDePerfilUsuario {
  @override
  Widget criarPerfil(String nome, String email) {
    return Card(
      color: Colors.grey[200],
      child: ListTile(
        leading: Icon(Icons.person, color: Colors.black),
        title: Text(nome),
        subtitle: Text(email),
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
          title: Text('Metodo da Fabrica de Perfil'),
        ),
        body: DemonstracaoDePerfilUsuario(),
      ),
    );
  }
}

class DemonstracaoDePerfilUsuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Escolha qual fabrica usar aqui
    FabricaDePerfilUsuario fabricaDePerfil =
        FabricaDePerfilAdmin(); // Altere para FabricaDePerfilRegular() para um perfil regular

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          fabricaDePerfil.criarPerfil(
              'Alice Johnson', 'alice.johnson@example.com'),
          SizedBox(height: 20),
          FabricaDePerfilRegular()
              .criarPerfil('Bob Smith', 'bob.smith@example.com'),
        ],
      ),
    );
  }
}

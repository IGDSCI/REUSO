import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PerfilStl extends StatelessWidget {
  const PerfilStl({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const PerfilStf(),
    );
  }
}

class PerfilStf extends StatefulWidget {
  const PerfilStf({super.key});

  @override
  State<PerfilStf> createState() => _PerfilStfState();
}

class _PerfilStfState extends State<PerfilStf> {
  String? userId;
  String? userName;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      setState(() {
        userId = user.id; // Armazena o userId do usuário autenticado
      });
      await _fetchUserName(userId); // Busca o nome do usuário na tabela 'usuarios'
    }
  }

  Future<void> _fetchUserName(String? userId) async {
    if (userId == null) return; // Verifica se userId é nulo

    final response = await Supabase.instance.client
        .from('usuarios') // Nome da tabela
        .select('nome') // Campo a ser selecionado
        .eq('userid', userId) // Filtra pelo userId
        .single() // Garante que apenas um registro seja retornado
        .execute();

    if (response.status == 200) {
      setState(() {
        userName = response.data['nome']; // Armazena o nome do usuário
        errorMessage = null; // Reseta a mensagem de erro
      });
    } else {
      setState(() {
        errorMessage = 'Erro ao buscar nome: ';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: errorMessage != null
            ? Text(errorMessage!, style: TextStyle(color: Colors.red))
            : userName != null
                ? Text('Nome: $userName')
                : userId != null
                    ? Text('Carregando nome...')
                    : Text('Carregando...'),
      ),
    );
  }
}

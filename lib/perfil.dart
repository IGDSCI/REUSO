import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PerfilStl extends StatelessWidget {
  const PerfilStl({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const PerfilStf(),
      routes: {
        '/home': (context) => const HomeStl(),
        '/perfil': (context) => const PerfilStl(),
        '/login': (context) => const LoginStl(),
      },
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
        userId = user.id;
      });
      await _fetchUserName(userId);
    }
  }

  Future<void> _fetchUserName(String? userId) async {
    if (userId == null) return;

    final response = await Supabase.instance.client
        .from('usuarios')
        .select('nome')
        .eq('userid', userId)
        .single()
        .execute();

    if (response.status == 200) {
      setState(() {
        userName = response.data['nome'];
        errorMessage = null;
      });
    } else {
      setState(() {
        errorMessage = 'Erro ao buscar nome: ';
      });
    }
  }

  Future<void> _logout() async {
    await Supabase.instance.client.auth.signOut();
    Navigator.of(context).pushNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'MELP',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 32,
            color: Colors.white,
          ),
          onPressed: () {
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
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: _logout,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 129, 47, 47),
                    ),
                  ),
                  child: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 104, 104, 104),
                  border: Border.all(
                    color: Colors.black,
                    width: 4,
                  ),
                ),
                child: const Icon(
                  Icons.person,
                  size: 64,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16,),
              errorMessage != null
                  ? Text(errorMessage!, style: const TextStyle(color: Colors.red))
                  : userName != null
                      ? Text(
                        'Nome: $userName',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      )
                      : userId != null
                          ? const Text('Carregando nome...')
                          : const Text('Carregando...'),
            ],
          ),
        ],
      ),
    );
  }
}

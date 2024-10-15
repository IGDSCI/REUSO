import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CadastroStl extends StatelessWidget {
  const CadastroStl({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CadastroStf(),
      routes: {
        '/login': (context) => const LoginStl(),
      },
    );
  }
}

class CadastroStf extends StatefulWidget {
  const CadastroStf({super.key});

  @override
  State<CadastroStf> createState() => _CadastroStfState();
}

class _CadastroStfState extends State<CadastroStf> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usuarioController = TextEditingController();

  Future<void> singUp() async {
    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final user = response.user;
      if (user != null) {
        await novoUsuario(user.id);
      }

      if (!mounted) return;

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeStl()));
    } on AuthException catch (e) {
      print(e);
    }
  }

  Future<void> novoUsuario(String userId) async {
    final nome = _usuarioController.text.trim();
    if (nome.isNotEmpty) {
      await Supabase.instance.client.from('usuarios').insert({
        'nome': nome,
        'userid': userId,
      });
      _usuarioController.clear();
    }
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Cadastro',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _emailController,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
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
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  cursorColor: Colors.black,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Senha',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
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
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _usuarioController,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    hintText: 'Insira seu nome de usuário',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
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
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: singUp,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 33, 54, 243)),
                      elevation: MaterialStateProperty.all<double>(0),
                    ),
                    child: const Text(
                      'Cadastrar',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Já tem conta?'),
                    const SizedBox(width: 4),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacementNamed('/login');
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Color.fromARGB(255, 33, 54, 243),
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

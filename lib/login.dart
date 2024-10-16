import 'package:flutter/material.dart';
import 'package:flutter_application_1/aula.dart';
import 'package:flutter_application_1/cadastro.dart';
import 'package:flutter_application_1/custom_widgets/text_field.dart';
import 'package:flutter_application_1/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginStl extends StatelessWidget {
  const LoginStl({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginStf(),
      routes: {
        '/aula': (context) => const AulaStl(),
        '/cadastro': (context) => const CadastroStl(),
        '/home': (context) => const HomeStl(),
      },
    );
  }
}

class LoginStf extends StatefulWidget {
  const LoginStf({super.key});
  @override
  State<LoginStf> createState() => _LoginStfState();
}


class _LoginStfState extends State<LoginStf> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> singIn() async{
    try{
      await Supabase.instance.client.auth.signInWithPassword(
        password: _passwordController.text.trim(),
        email: _emailController.text.trim(),
      );

      if(!mounted) return;

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HomeStl()));
    } on AuthException catch (e){
      print(e);
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
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
              const Text(
                'Login',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            
              const SizedBox(height: 16),

              CustomTextField(
                controller: _emailController,
                hintText: 'Email',
                prefixIcon: Icons.email,
              ),
            
              const SizedBox(height: 16),

              CustomTextField(
                controller: _passwordController,
                hintText: 'Senha',
                prefixIcon: Icons.lock,
                obscureText: true,
              ),
            
              const SizedBox(height: 16),
            
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: singIn,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 33, 54, 243)),
                    elevation: MaterialStateProperty.all<double>(0),
                  ),
                  child: const Text(
                    'Logar',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            
              const SizedBox(height: 8),
            
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Não possui conta?'),
                  const SizedBox(width: 4),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed('/cadastro');
                      },
                      child: const Text(
                        'Cadastre-se',
                        style: TextStyle(
                          color: Color.fromARGB(255, 33, 54, 243),
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],),
          ),
        ),
      ),
    );
  }
}
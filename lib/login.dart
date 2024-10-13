import 'package:flutter/material.dart';
import 'package:flutter_application_1/Home.dart';
import 'package:flutter_application_1/cadastro.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginStl extends StatelessWidget {
  const LoginStl({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoginStf(),
      routes: {
        '/home': (context) => const HomeStl(),
        '/cadastro': (context) => const CadastroStl(),
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
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
            const Text(
              'Login',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
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
                )
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
                )
              ),
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
                  style: TextStyle(color: Colors.white),
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
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],),
        ),
      ),
    );
  }
}
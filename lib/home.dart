import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/aula.dart';
import 'package:flutter_application_1/exercicio.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/perfil.dart';

class HomeStl extends StatelessWidget {
  const HomeStl({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeStf(),
      routes: {
        '/aula': (context) => const AulaStl(),
        '/exercicio': (context) => const ExercicioStl(),
        '/perfil': (context) => const PerfilStl(),
        '/login': (context) => const LoginStl(),
      },
    );
  }
}

class HomeStf extends StatefulWidget {
  const HomeStf({super.key});

  @override
  State<HomeStf> createState() => _HomeStfState();
}

class _HomeStfState extends State<HomeStf> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(
        child: Text(
          'MELP',
          style: TextStyle(color: Colors.white),
        )), 
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 32,
            color: Colors.white,
          ), 
          onPressed: (){
            Navigator.of(context).pushNamed('/login');
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
      body: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed('/aula');
              },
              child: Container(
                height: 100,
                width: 100, 
                color: Colors.grey,
                child: const Center(child: Text('AULA')),
              ),
            ),
          ),

          const SizedBox(height: 24),

          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed('/exercicio');
              },
              child: Container(
                height: 100,
                width: 100, 
                color: Colors.grey,
                child: const Center(child: Text('EXERCÍCIOS')),
              ),
            ),
          ),
        ],),

        const SizedBox(width: 24),

        Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Container(
            height: 100,
            width: 100, 
            color: Colors.grey,
            child: const Center(child: Text('SUPORTE')),
          ),

          const SizedBox(height: 24),

          Container(
            height: 100,
            width: 100, 
            color: Colors.grey,
            child: const Center(child: Text('AJUSTES')),
          ),
        ],)
      ],),
    );
  }
}
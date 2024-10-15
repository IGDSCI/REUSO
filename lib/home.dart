import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/aula.dart';
import 'package:flutter_application_1/custom_widgets/card.dart';
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
      body: const Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
          
           CustomClickableCard(
            text: 'AULA',
            backgroundColor: Color.fromARGB(255, 107, 33, 243),
            routeName: '/aula',
          ),


          SizedBox(height: 24),

          CustomClickableCard(
            text: 'EXERCÍCIOS',
            backgroundColor: Color.fromARGB(255, 33, 54, 243),
            routeName: '/exercicio',
          ),

        ],),

        SizedBox(width: 24),

        Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [

          CustomClickableCard(
            text: 'SUPORTE',
            backgroundColor: Color.fromARGB(255, 33, 54, 243),
          ),

          SizedBox(height: 24),

          CustomClickableCard(
            text: 'AJUSTES',
            backgroundColor: Color.fromARGB(255, 107, 33, 243),
          ),
        ],)
      ],),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/aula.dart';

class HomeStl extends StatelessWidget {
  const HomeStl({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeStf(),
      routes: {
        '/aula': (context) => const AulaStl(),
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
      ),
      body: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).pushReplacementNamed('/aula');
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

          Container(
            height: 100,
            width: 100, 
            color: Colors.grey,
            child: const Center(child: Text('EXERCICIOS')),
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
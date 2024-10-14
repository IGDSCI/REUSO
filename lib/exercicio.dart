import 'package:flutter/material.dart';

class ExercicioStl extends StatelessWidget {
  const ExercicioStl({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExercicioStf(),
    );
  }
}

class ExercicioStf extends StatefulWidget {
  const ExercicioStf({super.key});
  @override
  State<ExercicioStf> createState() => _ExercicioStfState();
}

class _ExercicioStfState extends State<ExercicioStf> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Execericio'),
    );
  }
}
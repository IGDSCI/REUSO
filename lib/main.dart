import 'package:flutter/material.dart';
import 'package:flutter_application_1/cadastro.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://kjgnhbgtvafpuxoqagsw.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtqZ25oYmd0dmFmcHV4b3FhZ3N3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjg4MzUzNjQsImV4cCI6MjA0NDQxMTM2NH0.XPAe1Qx89wrUWd9SsvxAdRUg4O_23_HFvkdnMPXqOiY',
  );

  runApp(const CadastroStl());
}
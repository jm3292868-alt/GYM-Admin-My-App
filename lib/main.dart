import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_screen.dart'; 

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializamos Supabase con tus datos
  await Supabase.initialize(
    url: 'https://gzzkjmfbvcctjegjgzsv.supabase.co',
    publishableKey: 'sb_publishable_LR29fs4Zpa3o0eyvW49TVQ_ISZbLzf3',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Supabase',
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(), // Pantalla inicial de la app
    );
  }
}

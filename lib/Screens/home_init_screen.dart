import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla de inicio'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Text(
              'Bienvenido a la pantalla de inicio',
              style: TextStyle(
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: 150,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed( 
                    context,
                    '/register',
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'Crear Cuenta',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
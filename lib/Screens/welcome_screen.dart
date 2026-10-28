import 'package:flutter/material.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 242, 242),
      body: SafeArea(
        child: Stack(
          children: [

            // Contenido centrado
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  const Text(
                    'Welcome to GYM Admin.',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 80),

                 Image.asset(
  'assets/logo.png',
  width: 300,
)
                ],
              ),
            ),

            // Botón abajo a la derecha
            Positioned(
              bottom: 40,
              right: 20,
              child: SizedBox(
                width: 130,
                height: 40,
                
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF3B82F6),
                    foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Next'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
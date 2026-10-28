import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/password_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _cargando = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _crearCuenta() async {
  final email = _emailController.text.trim();
  final password = _passwordController.text;

  if (email.isEmpty || password.isEmpty) {
    _mostrarMensaje('Llena todos los campos', Colors.red);
    return;
  }
  if (password.length < 6) {
    _mostrarMensaje('La contraseña debe tener al menos 6 caracteres', Colors.red);
    return;
  }

  setState(() => _cargando = true);

  try {
    await Supabase.instance.client.auth.signUp(
      email: email,
      password: password,
    );

    if (!mounted) return;
    _mostrarMensaje('Cuenta creada correctamente', const Color(0xFF3B82F6));
    Navigator.pushReplacementNamed(context, '/login');
  } on AuthException catch (e) {
    if (!mounted) return;
    _mostrarMensaje(e.message, Colors.red);
  } catch (_) {
    if (!mounted) return;
    _mostrarMensaje('No se pudo conectar. Revisa tu internet.', Colors.red);
  } finally {
    if (mounted) setState(() => _cargando = false);
  }
}

void _mostrarMensaje(String texto, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(texto), backgroundColor: color),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Cuenta'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo.png',
                  width: 150,
                ),

                const SizedBox(height: 35),

                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Correo Electrónico',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),

                const SizedBox(height: 20),

                PasswordField(
                  controller: _passwordController,
                ),

                const SizedBox(height: 35),

                _cargando
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        width: 150,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: _crearCuenta,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3B82F6),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            'Crear Cuenta',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                       TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      '/login',
                    );
                  },
                  child: const Text(
                    'Volver al login',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
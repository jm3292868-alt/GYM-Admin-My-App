import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegistroSocioScreen extends StatefulWidget {
  const RegistroSocioScreen({super.key});

  @override
  State<RegistroSocioScreen> createState() => _RegistroSocioScreenState();
}

class _RegistroSocioScreenState extends State<RegistroSocioScreen> {
  final _nombre = TextEditingController();
  final _apellidos = TextEditingController();
  final _edad = TextEditingController();
  final _padecimientos = TextEditingController();
  final _telefono = TextEditingController();

  String? _genero;
  bool _cargando = false;

  @override
  void dispose() {
    _nombre.dispose();
    _apellidos.dispose();
    _edad.dispose();
    _padecimientos.dispose();
    _telefono.dispose();
    super.dispose();
  }

  // Guarda el socio en Supabase
  Future<void> _registrarSocio() async {
    final edad = int.tryParse(_edad.text.trim());

    if (_nombre.text.isEmpty || _apellidos.text.isEmpty || edad == null) {
      _mostrarMensaje('Llena nombre, apellidos y edad', Colors.red);
      return;
    }

    if (_genero == null) {
      _mostrarMensaje('Selecciona el género', Colors.red);
      return;
    }

    setState(() => _cargando = true);

    try {
      await Supabase.instance.client.from('socios').insert({
        'nombre': _nombre.text.trim(),
        'apellidos': _apellidos.text.trim(),
        'edad': edad,
        'padecimientos': _padecimientos.text.trim(),
        'telefono': _telefono.text.trim(),
        'genero': _genero,
      });

      if (!mounted) return;
      _mostrarMensaje('Socio registrado', const Color(0xFF3B82F6));
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      _mostrarMensaje('Error al registrar: $e', Colors.red);
    } finally {
      if (mounted) setState(() => _cargando = false);
    }
  }

  void _mostrarMensaje(String texto, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(texto), backgroundColor: color),
    );
  }

  // Estilo de los campos (gris como en el Figma)
  InputDecoration _estilo(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: const Color(0xFFD9D9D9),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Socios'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: _nombre, decoration: _estilo('Nombre')),
            const SizedBox(height: 15),
            TextField(controller: _apellidos, decoration: _estilo('Apellidos')),
            const SizedBox(height: 15),
            TextField(
              controller: _edad,
              keyboardType: TextInputType.number,
              decoration: _estilo('Edad'),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _padecimientos,
              decoration: _estilo('Padecimientos'),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _telefono,
              keyboardType: TextInputType.phone,
              decoration: _estilo('Teléfono'),
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: _genero,
              decoration: _estilo('Género'),
              items: ['Masculino', 'Femenino', 'Otro']
                  .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                  .toList(),
              onChanged: (valor) => setState(() => _genero = valor),
            ),
            const SizedBox(height: 30),
            _cargando
                ? const CircularProgressIndicator()
                : SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: _registrarSocio,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B82F6),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Registrar Socio'),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
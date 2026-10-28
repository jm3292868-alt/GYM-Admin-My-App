import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserMenu {
  static void show(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Perfil Activo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Correo: ${user?.email ?? " "}',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.logout),
            label: const Text('Cerrar sesión'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              await Supabase.instance.client.auth.signOut();

              if (context.mounted) {
                Navigator.pop(context);

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
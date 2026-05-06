import 'package:flutter/material.dart';

class ConfermaOrdinePage extends StatelessWidget {
  const ConfermaOrdinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle_outline, size: 100, color: Colors.green),
            const SizedBox(height: 24),
            const Text('Ordine Ricevuto!', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text('Il tuo panino è in preparazione. Guarda lo schermo per gli aggiornamenti.', textAlign: TextAlign.center),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false),
              child: const Text('Torna al Menu'),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/api_service.dart';

class CarrelloPage extends StatefulWidget {
  const CarrelloPage({super.key});

  @override
  State<CarrelloPage> createState() => _CarrelloPageState();
}

class _CarrelloPageState extends State<CarrelloPage> {
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    final List<CarrelloItem> carrello = ModalRoute.of(context)!.settings.arguments as List<CarrelloItem>;
    double totale = carrello.fold(0, (sum, item) => sum + (item.prodotto.prezzo * item.quantita));

    return Scaffold(
      appBar: AppBar(title: const Text('Il Tuo Carrello'), backgroundColor: Colors.orange),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: carrello.length,
              itemBuilder: (context, index) {
                final item = carrello[index];
                return ListTile(
                  leading: Image.network(item.prodotto.immagineUrl, width: 50),
                  title: Text(item.prodotto.nome),
                  subtitle: Text('€${item.prodotto.prezzo} x ${item.quantita}'),
                  trailing: Text('€${(item.prodotto.prezzo * item.quantita).toStringAsFixed(2)}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('TOTALE', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('€${totale.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange)),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, padding: const EdgeInsets.symmetric(vertical: 16)),
                    onPressed: carrello.isEmpty ? null : () async {
                      bool success = await _apiService.inviaOrdine(carrello, totale);
                      if (success) {
                        Navigator.pushReplacementNamed(context, '/conferma');
                      }
                    },
                    child: const Text('INVIA ORDINE', style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

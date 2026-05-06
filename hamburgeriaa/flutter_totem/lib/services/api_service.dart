import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:5000/api';

  Future<List<Prodotto>> fetchProdotti() async {
    final response = await http.get(Uri.parse('$baseUrl/prodotti'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Prodotto.fromJson(data)).toList();
    } else {
      throw Exception('Errore caricamento prodotti');
    }
  }

  Future<bool> inviaOrdine(List<CarrelloItem> items, double totale) async {
    final response = await http.post(
      Uri.parse('$baseUrl/ordini'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "totale": totale,
        "prodotti": items.map((i) => {
          "prodotto_id": i.prodotto.id,
          "quantita": i.quantita
        }).toList()
      }),
    );
    return response.statusCode == 200;
  }
}

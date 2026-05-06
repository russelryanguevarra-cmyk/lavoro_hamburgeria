import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/models.dart';
import '../widgets/product_card.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final ApiService _apiService = ApiService();
  late Future<List<Prodotto>> _prodottiFuture;
  List<CarrelloItem> carrello = [];
  String categoriaSelezionata = 'panini';

  @override
  void initState() {
    super.initState();
    _prodottiFuture = _apiService.fetchProdotti();
  }

  void _aggiungiAlCarrello(Prodotto p) {
    setState(() {
      final index = carrello.indexWhere((item) => item.prodotto.id == p.id);
      if (index != -1) {
        carrello[index].quantita++;
      } else {
        carrello.add(CarrelloItem(prodotto: p));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // SIDEBAR CATEGORIE
          Container(
            width: 250,
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text(
                    'FIX\nBURGERS',
                    style: TextStyle(fontFamily: 'Anton', fontSize: 40, color: Colors.white, height: 0.9),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: ['panini', 'bevande', 'contorni', 'menu'].map((cat) {
                      bool isActive = categoriaSelezionata == cat;
                      return InkWell(
                        onTap: () => setState(() => categoriaSelezionata = cat),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                          decoration: BoxDecoration(
                            color: isActive ? const Color(0xFFCBFF00) : Colors.transparent,
                            border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.1))),
                          ),
                          child: Text(
                            cat.toUpperCase(),
                            style: TextStyle(
                              fontFamily: 'Anton',
                              fontSize: 24,
                              color: isActive ? Colors.black : Colors.white,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(32),
                  color: const Color(0xFFCBFF00),
                  child: const Text(
                    'TOTEM v1.0',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                )
              ],
            ),
          ),

          // GRID PRODOTTI
          Expanded(
            child: Container(
              color: const Color(0xFF111111),
              child: FutureBuilder<List<Prodotto>>(
                future: _prodottiFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Errore: ${snapshot.error}', style: const TextStyle(color: Colors.white)));
                  } else {
                    final prodotti = snapshot.data!.where((p) => p.categoria == categoriaSelezionata).toList();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Text(
                            categoriaSelezionata.toUpperCase(),
                            style: const TextStyle(fontFamily: 'Anton', fontSize: 40, color: Colors.white),
                          ),
                        ),
                        Expanded(
                          child: GridView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.8,
                              crossAxisSpacing: 24,
                              mainAxisSpacing: 24,
                            ),
                            itemCount: prodotti.length,
                            itemBuilder: (context, index) {
                              return ProductCard(
                                prodotto: prodotti[index],
                                onAdd: () => _aggiungiAlCarrello(prodotti[index]),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),

          // CARRELLO LATERALE
          Container(
            width: 300,
            color: Colors.white,
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'IL TUO ORDINE',
                  style: TextStyle(fontFamily: 'Anton', fontSize: 32, color: Colors.black),
                ),
                const Divider(thickness: 4, color: Colors.black),
                Expanded(
                  child: ListView.builder(
                    itemCount: carrello.length,
                    itemBuilder: (context, index) {
                      final item = carrello[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              color: Colors.black,
                              alignment: Alignment.center,
                              child: Text('${item.quantita}', style: const TextStyle(color: Color(0xFFCBFF00), fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(width: 12),
                            Expanded(child: Text(item.prodotto.nome.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                            Text('€${(item.prodotto.prezzo * item.quantita).toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const Divider(thickness: 4, color: Colors.black),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('TOTALE', style: TextStyle(fontFamily: 'Anton', fontSize: 24)),
                    Text('€${carrello.fold(0.0, (sum, item) => sum + (item.prodotto.prezzo * item.quantita)).toStringAsFixed(2)}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFCBFF00),
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      shape: const RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black, width: 4),
                      ),
                    ),
                    onPressed: carrello.isEmpty ? null : () => Navigator.pushNamed(context, '/carrello', arguments: carrello),
                    child: const Text('CASSA', style: TextStyle(fontFamily: 'Anton', fontSize: 32, color: Colors.black)),
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

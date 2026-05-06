class Prodotto {
  final int id;
  final String nome;
  final String descrizione;
  final double prezzo;
  final String categoria;
  final String immagineUrl;

  Prodotto({
    required this.id,
    required this.nome,
    required this.descrizione,
    required this.prezzo,
    required this.categoria,
    required this.immagineUrl,
  });

  factory Prodotto.fromJson(Map<String, dynamic> json) {
    return Prodotto(
      id: json['id'],
      nome: json['nome'],
      descrizione: json['descrizione'],
      prezzo: double.parse(json['prezzo'].toString()),
      categoria: json['categoria'],
      immagineUrl: json['immagine_url'],
    );
  }
}

class CarrelloItem {
  final Prodotto prodotto;
  int quantita;

  CarrelloItem({required this.prodotto, this.quantita = 1});
}

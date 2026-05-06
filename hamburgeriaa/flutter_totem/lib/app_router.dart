import 'package:flutter/material.dart';
import 'pages/menu_page.dart';
import 'pages/carrello_page.dart';
import 'pages/conferma_ordine_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const MenuPage());
      case '/carrello':
        return MaterialPageRoute(builder: (_) => const CarrelloPage());
      case '/conferma':
        return MaterialPageRoute(builder: (_) => const ConfermaOrdinePage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Nessuna rotta definita per ${settings.name}')),
          ),
        );
    }
  }
}

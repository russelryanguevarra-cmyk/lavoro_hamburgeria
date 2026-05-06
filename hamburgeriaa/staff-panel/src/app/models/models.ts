export interface Prodotto {
  id?: number;
  nome: string;
  descrizione: string;
  prezzo: number;
  categoria: 'panini' | 'bevande' | 'contorni' | 'menu';
  immagine_url: string;
}

export interface Ordine {
  id: number;
  stato: 'in_attesa' | 'in_preparazione' | 'pronto' | 'consegnato';
  totale: number;
  data_ordine: string;
  prodotti_lista: string;
}

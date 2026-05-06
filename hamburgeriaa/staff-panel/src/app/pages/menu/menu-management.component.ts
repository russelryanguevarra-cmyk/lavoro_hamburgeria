import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ApiService } from '../../services/api.service';
import { Prodotto } from '../../models/models';

@Component({
  selector: 'app-menu-management',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './menu-management.component.html',
  styleUrls: ['./menu-management.component.css']
})
export class MenuManagementComponent implements OnInit {
  prodotti: Prodotto[] = [];
  nuovoProdotto: Prodotto = this.resetProdotto();

  constructor(private apiService: ApiService) {}

  ngOnInit() {
    this.caricaProdotti();
  }

  caricaProdotti() {
    this.apiService.getProdotti().subscribe(data => this.prodotti = data);
  }

  resetProdotto(): Prodotto {
    return { nome: '', descrizione: '', prezzo: 0, categoria: 'panini', immagine_url: '' };
  }

  salvaProdotto() {
    if (this.nuovoProdotto.id) {
      this.apiService.updateProdotto(this.nuovoProdotto.id, this.nuovoProdotto).subscribe(() => {
        this.caricaProdotti();
        this.nuovoProdotto = this.resetProdotto();
      });
    } else {
      this.apiService.addProdotto(this.nuovoProdotto).subscribe(() => {
        this.caricaProdotti();
        this.nuovoProdotto = this.resetProdotto();
      });
    }
  }

  modifica(p: Prodotto) {
    this.nuovoProdotto = { ...p };
  }

  elimina(id: number | undefined) {
    if (id && confirm('Sicuro di voler eliminare questo prodotto?')) {
      this.apiService.deleteProdotto(id).subscribe(() => this.caricaProdotti());
    }
  }
}

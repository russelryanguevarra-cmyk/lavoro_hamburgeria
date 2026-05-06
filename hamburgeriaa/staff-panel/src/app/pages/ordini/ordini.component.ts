import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ApiService } from '../../services/api.service';
import { Ordine } from '../../models/models';

@Component({
  selector: 'app-ordini',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './ordini.component.html',
  styleUrls: ['./ordini.component.css']
})
export class OrdiniComponent implements OnInit {
  ordini: Ordine[] = [];

  constructor(private apiService: ApiService) {}

  ngOnInit() {
    this.caricaOrdini();
    // Refresh ogni 10 secondi per il monitoraggio real-time
    setInterval(() => this.caricaOrdini(), 10000);
  }

  caricaOrdini() {
    this.apiService.getOrdini().subscribe(data => {
      this.ordini = data;
    });
  }

  cambiaStato(ordine: Ordine, nuovoStato: string) {
    this.apiService.updateOrdineStato(ordine.id, nuovoStato).subscribe(() => {
      this.caricaOrdini();
    });
  }
}

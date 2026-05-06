import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Ordine, Prodotto } from '../models/models';

@Injectable({
  providedIn: 'root'
})
export class ApiService {
  private baseUrl = 'http://localhost:5000/api';

  constructor(private http: HttpClient) {}

  getOrdini(): Observable<Ordine[]> {
    return this.http.get<Ordine[]>(`${this.baseUrl}/ordini`);
  }

  updateOrdineStato(id: number, stato: string): Observable<any> {
    return this.http.patch(`${this.baseUrl}/ordini/${id}/stato`, { stato });
  }

  getProdotti(): Observable<Prodotto[]> {
    return this.http.get<Prodotto[]>(`${this.baseUrl}/prodotti`);
  }

  addProdotto(prodotto: Prodotto): Observable<any> {
    return this.http.post(`${this.baseUrl}/prodotti`, prodotto);
  }

  updateProdotto(id: number, prodotto: Prodotto): Observable<any> {
    return this.http.put(`${this.baseUrl}/prodotti/${id}`, prodotto);
  }

  deleteProdotto(id: number): Observable<any> {
    return this.http.delete(`${this.baseUrl}/prodotti/${id}`);
  }
}

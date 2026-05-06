import { Routes } from '@angular/router';
import { OrdiniComponent } from './pages/ordini/ordini.component';
import { MenuManagementComponent } from './pages/menu/menu-management.component';

export const routes: Routes = [
  { path: 'ordini', component: OrdiniComponent },
  { path: 'menu', component: MenuManagementComponent },
  { path: '', redirectTo: '/ordini', pathMatch: 'full' }
];

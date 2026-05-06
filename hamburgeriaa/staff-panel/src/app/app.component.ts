import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterModule],
  template: `
    <nav class="navbar navbar-expand-lg navbar-dark border-bottom border-white/10 mb-4" style="background: #000; font-family: 'Anton', sans-serif; text-transform: uppercase;">
      <div class="container">
        <a class="navbar-brand text-neon" href="#" style="color: #CBFF00; font-size: 2rem;">FIX STAFF</a>
        <div class="navbar-nav">
          <a class="nav-link" routerLink="/ordini" routerLinkActive="text-neon" style="letter-spacing: 1px;">Monitor</a>
          <a class="nav-link" routerLink="/menu" routerLinkActive="text-neon" style="letter-spacing: 1px;">Magazzino</a>
        </div>
      </div>
    </nav>
    <div class="container pb-5">
      <router-outlet></router-outlet>
    </div>
  `,
  styles: [`
    .text-neon { color: #CBFF00 !important; }
    .nav-link { color: #fff; margin-left: 20px; }
    .nav-link:hover { color: #CBFF00; }
  `]
})
export class AppComponent {}

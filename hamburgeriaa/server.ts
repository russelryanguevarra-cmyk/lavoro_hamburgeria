import express from 'express';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();
const PORT = 3000;

// Middleware per i file statici delle build (quando saranno compilate)
app.use('/staff', express.static(path.join(__dirname, 'staff-panel/dist')));
app.use('/totem', express.static(path.join(__dirname, 'flutter_totem/build/web')));

// Landing page per scegliere quale parte avviare
app.get('/', (req, res) => {
    res.send(`
        <!DOCTYPE html>
        <html lang="it">
        <head>
            <meta charset="UTF-8">
            <title>Fix Burgers Launcher</title>
            <link href="https://fonts.googleapis.com/css2?family=Anton&display=swap" rel="stylesheet">
            <style>
                body { 
                    background: #000; 
                    color: #fff; 
                    font-family: Arial, sans-serif; 
                    display: flex; 
                    flex-direction: column; 
                    align-items: center; 
                    justify-content: center; 
                    height: 100vh; 
                    margin: 0;
                }
                h1 { 
                    font-family: 'Anton', sans-serif; 
                    font-size: 6rem; 
                    color: #CBFF00; 
                    margin-bottom: 50px;
                    letter-spacing: -2px;
                }
                .grid { 
                    display: grid; 
                    grid-template-columns: repeat(2, 1fr); 
                    gap: 30px; 
                    max-width: 800px;
                }
                .card {
                    background: #fff;
                    color: #000;
                    padding: 40px;
                    text-decoration: none;
                    text-align: center;
                    border: 4px solid #000;
                    box-shadow: 8px 8px 0px #CBFF00;
                    transition: all 0.2s;
                }
                .card:hover {
                    transform: translate(2px, 2px);
                    box-shadow: 4px 4px 0px #CBFF00;
                }
                .card h2 { 
                    font-family: 'Anton', sans-serif; 
                    margin: 0; 
                    font-size: 2.5rem; 
                }
                .card p { 
                    font-size: 0.9rem; 
                    opacity: 0.7; 
                    margin-top: 10px;
                }
                .status {
                    margin-top: 40px;
                    color: #CBFF00;
                    font-family: monospace;
                    font-size: 0.8rem;
                }
            </style>
        </head>
        <body>
            <h1>FIX BURGERS</h1>
            <div class="grid">
                <a href="/totem" class="card">
                    <h2>TOTEM CLIENTE</h2>
                    <p>Avvia l'interfaccia di ordinazione (Flutter)</p>
                </a>
                <a href="/staff" class="card">
                    <h2>PANNELLO STAFF</h2>
                    <p>Gestione ordini e magazzino (Angular)</p>
                </a>
            </div>
            <div class="status">
                SYSTEM STATUS: BACKEND ONLINE | CODESPACE READY
            </div>
        </body>
        </html>
    `);
});

app.listen(PORT, '0.0.0.0', () => {
    console.log(`Launcher running at http://localhost:${PORT}`);
});

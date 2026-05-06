CREATE TABLE IF NOT EXISTS prodotti (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descrizione TEXT,
    prezzo DECIMAL(10, 2) NOT NULL,
    categoria ENUM('panini', 'bevande', 'contorni', 'menu') NOT NULL,
    immagine_url TEXT
);

CREATE TABLE IF NOT EXISTS ordini (
    id INT AUTO_INCREMENT PRIMARY KEY,
    stato ENUM('in_attesa', 'in_preparazione', 'pronto', 'consegnato') DEFAULT 'in_attesa',
    totale DECIMAL(10, 2) NOT NULL,
    data_ordine TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS dettagli_ordine (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ordine_id INT,
    prodotto_id INT,
    quantita INT NOT NULL,
    FOREIGN KEY (ordine_id) REFERENCES ordini(id),
    FOREIGN KEY (prodotto_id) REFERENCES prodotti(id)
);

-- Dati di esempio
INSERT INTO prodotti (nome, descrizione, prezzo, categoria, immagine_url) VALUES 
('Classic Burger', 'Manzo, lattuga, pomodoro, salsa burger', 8.50, 'panini', 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500'),
('Cheeseburger', 'Manzo, cheddar, cetriolini, senape', 9.00, 'panini', 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=500'),
('Coca Cola', 'Lattina 33cl', 2.50, 'bevande', 'https://images.unsplash.com/photo-1622483767028-3f66f32aef97?w=500'),
('Patatine Fritte', 'Porzione regular', 3.50, 'contorni', 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=500');

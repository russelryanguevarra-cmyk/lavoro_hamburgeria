import pymysql
import os
from flask import jsonify

class DatabaseWrapper:
    def __init__(self):
        # Questi parametri dovrebbero essere nelle variabili d'ambiente su Aiven/Codespace
        self.host = os.getenv('MYSQL_HOST')
        self.user = os.getenv('MYSQL_USER')
        self.password = os.getenv('MYSQL_PASSWORD')
        self.db = os.getenv('MYSQL_DB')
        self.port = int(os.getenv('MYSQL_PORT', 3306))

    def get_connection(self):
        return pymysql.connect(
            host=self.host,
            user=self.user,
            password=self.password,
            database=self.db,
            port=self.port,
            cursorclass=pymysql.cursors.DictCursor
        )

    def get_all_products(self):
        connection = self.get_connection()
        try:
            with connection.cursor() as cursor:
                cursor.execute("SELECT * FROM prodotti")
                return cursor.fetchall()
        finally:
            connection.close()

    def add_product(self, data):
        connection = self.get_connection()
        try:
            with connection.cursor() as cursor:
                sql = "INSERT INTO prodotti (nome, descrizione, prezzo, categoria, immagine_url) VALUES (%s, %s, %s, %s, %s)"
                cursor.execute(sql, (data['nome'], data['descrizione'], data['prezzo'], data['categoria'], data['immagine_url']))
            connection.commit()
            return True
        finally:
            connection.close()

    def update_product(self, product_id, data):
        connection = self.get_connection()
        try:
            with connection.cursor() as cursor:
                sql = "UPDATE prodotti SET nome=%s, descrizione=%s, prezzo=%s, categoria=%s, immagine_url=%s WHERE id=%s"
                cursor.execute(sql, (data['nome'], data['descrizione'], data['prezzo'], data['categoria'], data['immagine_url'], product_id))
            connection.commit()
            return True
        finally:
            connection.close()

    def delete_product(self, product_id):
        connection = self.get_connection()
        try:
            with connection.cursor() as cursor:
                cursor.execute("DELETE FROM prodotti WHERE id=%s", (product_id,))
            connection.commit()
            return True
        finally:
            connection.close()

    def create_order(self, data):
        connection = self.get_connection()
        try:
            with connection.cursor() as cursor:
                # Crea l'ordine
                cursor.execute("INSERT INTO ordini (totale) VALUES (%s)", (data['totale'],))
                ordine_id = cursor.lastrowid
                
                # Aggiungi dettagli
                for item in data['prodotti']:
                    cursor.execute(
                        "INSERT INTO dettagli_ordine (ordine_id, prodotto_id, quantita) VALUES (%s, %s, %s)",
                        (ordine_id, item['prodotto_id'], item['quantita'])
                    )
            connection.commit()
            return ordine_id
        finally:
            connection.close()

    def get_orders(self):
        connection = self.get_connection()
        try:
            with connection.cursor() as cursor:
                cursor.execute("""
                    SELECT o.*, GROUP_CONCAT(p.nome, ' x', d.quantita) as prodotti_lista
                    FROM ordini o
                    JOIN dettagli_ordine d ON o.id = d.ordine_id
                    JOIN prodotti p ON d.prodotto_id = p.id
                    GROUP BY o.id
                    ORDER BY o.data_ordine DESC
                """)
                return cursor.fetchall()
        finally:
            connection.close()

    def update_order_status(self, order_id, status):
        connection = self.get_connection()
        try:
            with connection.cursor() as cursor:
                cursor.execute("UPDATE ordini SET stato=%s WHERE id=%s", (status, order_id))
            connection.commit()
            return True
        finally:
            connection.close()

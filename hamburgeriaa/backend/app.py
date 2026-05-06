from flask import Flask, request, jsonify
from flask_cors import CORS
from database_wrapper import DatabaseWrapper
import os
from dotenv import load_dotenv

load_dotenv()

app = Flask(__name__)
CORS(app)
db = DatabaseWrapper()

@app.route('/api/prodotti', methods=['GET'])
def get_prodotti():
    return jsonify(db.get_all_products())

@app.route('/api/prodotti', methods=['POST'])
def add_prodotto():
    data = request.json
    db.add_product(data)
    return jsonify({"status": "success"})

@app.route('/api/prodotti/<int:id>', methods=['PUT', 'DELETE'])
def manage_prodotto(id):
    if request.method == 'PUT':
        db.update_product(id, request.json)
        return jsonify({"status": "updated"})
    else:
        db.delete_product(id)
        return jsonify({"status": "deleted"})

@app.route('/api/ordini', methods=['GET', 'POST'])
def manage_ordini():
    if request.method == 'POST':
        order_id = db.create_order(request.json)
        return jsonify({"status": "success", "order_id": order_id})
    else:
        return jsonify(db.get_orders())

@app.route('/api/ordini/<int:id>/stato', methods=['PATCH'])
def update_ordine_stato(id):
    data = request.json
    db.update_order_status(id, data['stato'])
    return jsonify({"status": "status updated"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)

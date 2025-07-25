from flask import Flask, request, jsonify, render_template
import sqlite3
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

DATABASE = 'database.bd'

def get_db_connection():
    conn = sqlite3.connect(DATABASE)
    conn.row_factory = sqlite3.Row
    return conn

@app.route('/')
def index():
    return render_template('index.html')

# GET all products
@app.route('/api/products', methods=['GET'])
def get_products():
    conn = get_db_connection()
    rows = conn.execute('SELECT * FROM products').fetchall()
    conn.close()
    return jsonify([dict(row) for row in rows])

# ADD product
@app.route('/api/add', methods=['POST'])
def add_product():
    data = request.get_json()
    keys = ['name', 'description', 'price', 'batch_no', 'expiry_date', 'quantity', 'subtype']
    if not all(k in data for k in keys):
        return jsonify({'message': 'Missing fields'}), 400

    image_url = data.get('image_url', '')
    price_usd = data.get('price_usd', 0)

    conn = get_db_connection()
    conn.execute('''
        INSERT INTO products (name, description, price, batch_no, expiry_date, quantity, subtype, image_url, price_usd)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    ''', (
        data['name'], data['description'], data['price'], data['batch_no'],
        data['expiry_date'], data['quantity'], data['subtype'],
        image_url, price_usd
    ))
    conn.commit()
    conn.close()
    return jsonify({'message': 'Product added successfully'})

# EDIT product
@app.route('/api/edit/<int:id>', methods=['POST'])  # JS is using POST, not PUT
def update_product(id):
    data = request.get_json()
    keys = ['name', 'description', 'price', 'batch_no', 'expiry_date', 'quantity', 'subtype']
    if not all(k in data for k in keys):
        return jsonify({'message': 'Missing fields'}), 400

    image_url = data.get('image_url', '')
    price_usd = data.get('price_usd', 0)

    conn = get_db_connection()
    conn.execute('''
        UPDATE products
        SET name=?, description=?, price=?, batch_no=?, expiry_date=?, quantity=?, subtype=?, image_url=?, price_usd=?
        WHERE id=?
    ''', (
        data['name'], data['description'], data['price'], data['batch_no'],
        data['expiry_date'], data['quantity'], data['subtype'],
        image_url, price_usd, id
    ))
    conn.commit()
    conn.close()
    return jsonify({'message': 'Product updated successfully'})

# DELETE product
@app.route('/api/delete/<int:id>', methods=['DELETE'])
def delete_product(id):
    conn = get_db_connection()
    conn.execute('DELETE FROM products WHERE id=?', (id,))
    conn.commit()
    conn.close()
    return jsonify({'message': 'Product deleted successfully'})

if __name__ == '__main__':
    app.run(debug=True)

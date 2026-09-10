import sqlite3
import os
from flask import Flask, request

app = Flask(__name__)

# Sample vulnerable endpoint for SAST scanner testing (intentional SQL Injection)
@app.route("/user")
def get_user():
    user_id = request.args.get("id")
    conn = sqlite3.connect("app.db")
    cursor = conn.cursor()
    query = "SELECT * FROM users WHERE id = '" + user_id + "'"
    cursor.execute(query)
    return str(cursor.fetchall())

# Sample vulnerable endpoint for SAST scanner testing (intentional Command Injection)
@app.route("/ping")
def ping_host():
    host = request.args.get("host")
    os.system("ping -c 1 " + host)
    return "pinged " + host

if __name__ == "__main__":
    app.run(debug=True)

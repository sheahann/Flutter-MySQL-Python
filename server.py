from flask import Flask, jsonify
import mysql.connector

db = mysql.connector.connect(
    host = "localhost",
    user = "root",
    passwd = "",
    database = "server"
)

handler = db.cursor()
handler.execute("SELECT * FROM players")
result = []
for x in handler:
    result.append(x[0])

app = Flask(__name__)

@app.route('/')
def main():
    json_file = {}
    json_file['players'] = result,
    return jsonify(json_file)

if __name__ == '__main__':
    app.run()
# Flutter-MySQL-Python
An example of using mysql and python as a backend for flutter mobile apps

`server.py`
```python
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
```

`main.dart`
```dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class PythonPage extends StatefulWidget {
  const PythonPage({Key? key}) : super(key: key);

  @override
  State<PythonPage> createState() => _PythonPageState();
}

class _PythonPageState extends State<PythonPage> {
  Future getData(url) async {
    Response response = await get(url);
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: FutureBuilder(
          future: getData(Uri(scheme: 'http', port: 5000, host: '10.0.2.2')),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('something went wrong'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Text("loading..."));
            }

            var players = jsonDecode(snapshot.data)['players'][0];
            return ListView(
              children: List.generate(
                players.length,
                (index) => Center(
                  child: Container(
                    height: 50,
                    width: 200,
                    margin: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      players[index].toString(),
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
```

`database`

![db](https://user-images.githubusercontent.com/61119848/169573228-c126f95b-dccd-413e-81b8-e9f1500e6058.PNG)

## Final result ##

![Screenshot_1653064650](https://user-images.githubusercontent.com/61119848/169573626-06c455f0-3bcc-4279-ad56-54261d183d58.png)

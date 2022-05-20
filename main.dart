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

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './detail.dart';
import './adddata.dart';
import 'env.dart';


void main() {
  runApp(const MaterialApp(
    title: "My Store",
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List> getData() async {
    final response = await http.get(Uri.parse("${Env.URL_PREFIX}/getdata.php"));
    return json.decode(response.body);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MY STORE"),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: ()=> Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context)=> AddData(),
          )),
      ),
      body: FutureBuilder<List>(
        future: getData(),
          builder: (context, snapshot){
            if(snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ItemList(
              list: snapshot.requireData,
            )
                : Center(
              child: CircularProgressIndicator(),
            );
          },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  const ItemList({Key? key, required this.list}) : super(key: key);
  final List list;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, i) {
          return Container(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context)=> Detail(
                      list: list,
                      index: i,
                  ))),
              child: Card(
                child: ListTile(
                  title: Text(list[i]['item_name']),
                  leading: const Icon(Icons.widgets),
                  subtitle: Text("Stock : ${list[i]['stock']}"),
                ),
              ),
            ),
          );
        },
        );
  }
}

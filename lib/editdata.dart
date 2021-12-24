import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './main.dart';
import 'env.dart';

class EditData extends StatefulWidget {
  const EditData({Key? key, required this.list, required this.index}) : super(key: key);
  final List list;
  final int index;
  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  late TextEditingController controllerCode;
  late TextEditingController controllerName;
  late TextEditingController controllerPrice;
  late TextEditingController controllerStock;

  void editData(){
    http.post(Uri.parse("${Env.URL_PREFIX}/editdata.php"),
        body: {
      "id": widget.list[widget.index]['id'],
          "itemcode": controllerCode.text,
          "itemname": controllerName.text,
          "price": controllerPrice.text,
          "stock": controllerStock.text,
        });
  }

  @override
  void initState(){
    controllerCode =
        TextEditingController(text: widget.list[widget.index]['item_code']);
    controllerName =
        TextEditingController(text: widget.list[widget.index]['item_name']);
    controllerPrice =
        TextEditingController(text: widget.list[widget.index]['price']);
    controllerStock =
        TextEditingController(text: widget.list[widget.index]['stock']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EDIT DATA"),
      ),
      body: Padding(
          padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                TextField(
                  controller: controllerCode,
                  decoration: InputDecoration(
                    hintText: "Item Code", labelText: "Item Code"),
                ),
                TextField(
                  controller: controllerName,
                  decoration: InputDecoration(
                      hintText: "Item Name", labelText: "Item Name"),
                ),
                TextField(
                  controller: controllerPrice,
                  decoration: InputDecoration(
                      hintText: "Price", labelText: "Price"),
                ),
                TextField(
                  controller: controllerStock,
                  decoration: InputDecoration(
                      hintText: "Stock", labelText: "Stock"),
                ),
                Padding(padding: EdgeInsets.all(10.0),
                ),
                RaisedButton(
                    child: Text("EDIT DATA"),
                    color: Colors.blueAccent,
                    onPressed: (){
                      editData();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => Home()));
                    },)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

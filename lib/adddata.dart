import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'env.dart';


class AddData extends StatefulWidget {
  // const AddData({Key? key}) : super(key: key);

  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController controllerCode = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();
  TextEditingController controllerStock = TextEditingController();

  void addData(){
    http.post(Uri.parse("${Env.URL_PREFIX}/adddata.php"),
        body: {
      "itemcode": controllerCode.text,
          "itemname": controllerName.text,
          "price": controllerPrice.text,
          "stock": controllerStock.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADD DATA"),
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
                    child: Text("ADD DATA"),
                    color: Colors.blueAccent,
                    onPressed:(){
                      addData();
                      Navigator.pop(context);
                    },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './editdata.dart';
import './main.dart';
import 'env.dart';

class Detail extends StatefulWidget {
  Detail({Key? key,required this.list, required this.index,}) : super(key: key);
  List list;
  int index;
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  void deleteData(){
    var url = '"${Env.URL_PREFIX}/deleteData.php';
    http.post(Uri.parse(url), body: {'id': widget.list[widget.index]['id']});
  }
  void confirm(){
    AlertDialog alertDialog = AlertDialog(
      content: Text("Are You Sure Want TO Delete'${widget.list[widget.index]
      ['item_name']}'"),
      actions: <Widget>[
        RaisedButton(
          child: Text(
            "OK DELETE",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: (){
            deleteData();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context)=> Home(),
            ));
          },
        ),
        RaisedButton(
          child: Text("CANCEL", style: TextStyle(color: Colors.black)),
            onPressed: ()=> Navigator.pop(context),
        ),
      ],
    );
    showDialog(builder: (context)=> alertDialog, context: context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.list[widget.index]['item_name']}")),
      body: Container(
        height: 270.0,
        padding: EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 30.0),
                ),
                Text(
                    widget.list[widget.index]['item_name'],
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(
                  "Code: ${widget.list[widget.index]['item_code']}",
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  "Price: ${widget.list[widget.index]['price']}",
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  "Stock: ${widget.list[widget.index]['stock']}",
                  style: TextStyle(fontSize: 18.0),
                ),
                Padding(
                  padding: EdgeInsets.only(top:30.0),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    RaisedButton(
                      child: Text("EDIT"),
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context)=> EditData(
                                  list: widget.list,
                                  index: widget.index
                              ),
                          )),
                    ),
                    RaisedButton(
                      child: Text("DELETE"),
                      color: Colors.red,
                      onPressed: () => confirm(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

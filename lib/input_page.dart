import 'package:flutter/material.dart';
import 'package:laxly_account/row.dart';
import 'package:laxly_account/scripts.dart';

class InputPage extends StatefulWidget {
  InputPage(this._scripts, {Key key}) : super(key: key);

  final Scripts _scripts;

  @override
  State<StatefulWidget> createState() => _InputPageState(_scripts);
}

class _InputPageState extends State<InputPage> {
  _InputPageState(this._scripts);

  final Scripts _scripts;
  final TextEditingController _priceController = TextEditingController();
  DateTime _dateTime = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Input"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
                controller: _priceController,
                decoration: InputDecoration(
                    labelText: "Price", border: OutlineInputBorder())),
            RaisedButton(
              child: Text("SELECT DATE"),
              onPressed: () async {
                var current = new DateTime.now();
                var first = current.add(Duration(days: -7));
                var last = current.add(Duration(days: 1));
                _dateTime = await showDatePicker(
                    context: context,
                    initialDate: current,
                    firstDate: first,
                    lastDate: last);
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _scripts.append(SheetRow(_dateTime.year, _dateTime.month,
              int.parse(_priceController.text)));
          Navigator.pop(context);
        },
        tooltip: "Save",
        child: Icon(Icons.add),
      ),
    );
  }
}

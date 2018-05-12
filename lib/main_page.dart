import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:laxly_account/app_key.dart';
import 'package:laxly_account/row.dart';
import 'package:laxly_account/scripts.dart';

class MainPage extends StatefulWidget {
  MainPage(this._client, {Key key}) : super(key: key);

  final http.Client _client;

  @override
  State<StatefulWidget> createState() => new _MainPageState(_client);
}

class _MainPageState extends State<MainPage> {
  _MainPageState(http.Client client) {
    _fetch(client);
  }

  void _fetch(http.Client client) async {
    Scripts scripts = new Scripts(client, AppKey.SHEET_ID);
    var rows = await scripts.get();
    setState(() {
      _rows.addAll(rows);
    });
  }

  List<SheetRow> _rows = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Laxly account"),
        ),
        body: ListView.builder(
            itemCount: _rows.length,
            itemBuilder: (BuildContext context, int index) =>
                RowItem(_rows[index])));
  }
}

class RowItem extends StatelessWidget {
  const RowItem(this._row);

  final SheetRow _row;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("¥ ${_row.price}"),
      subtitle: Text("${_row.year} - ${_row.month}"),
    );
  }
}
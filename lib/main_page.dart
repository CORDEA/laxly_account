import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:laxly_account/app_key.dart';
import 'package:laxly_account/input_page.dart';
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
    _scripts = new Scripts(client, AppKey.SHEET_ID);
    _fetch();
  }

  Scripts _scripts;
  List<SheetRow> _rows = [];

  void _fetch() async {
    var rows = await _scripts.get();
    setState(() {
      _rows.addAll(rows);
    });
  }

  int _calculateTotalPrice() {
    return _rows.map((row) => row.price).reduce((x, y) => x + y);
  }

  SimpleDialog _buildDialog(BuildContext context) {
    return new SimpleDialog(
      title: const Text("title"),
      children: <Widget>[
        new Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: new Text("¥ ${_calculateTotalPrice()}"),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Laxly account"),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            ListView.builder(
              itemCount: _rows.length,
              itemBuilder: (BuildContext context, int index) =>
                  RowItem(_rows[index]),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: new EdgeInsets.only(right: 16.0, bottom: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new InputPage(_scripts)));
                      },
                      tooltip: "Save",
                      child: Icon(Icons.add),
                    ),
                    SizedBox(height: 16.0),
                    FloatingActionButton(
                      heroTag: "Second FloatingActionButton",
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: _buildDialog,
                        );
                      },
                      tooltip: "Sum",
                      child: Icon(Icons.assessment),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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

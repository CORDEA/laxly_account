import 'dart:async';

import 'package:googleapis/script/v1.dart';
import 'package:http/http.dart' as http;
import 'package:laxly_account/app_key.dart';
import 'package:laxly_account/row.dart';

class Scripts {

  ScriptApi _api;
  final String _sheetId;

  Scripts(http.Client client, this._sheetId) {
    _api = new ScriptApi(client);
  }

  Future<Operation> _run(String name, List<Object> data) {
    var request = ExecutionRequest();
    request.devMode = true;
    request.function = name;
    request.parameters = [
      _sheetId,
      data
    ];

    return _api.scripts.run(request, AppKey.SCRIPT_ID);
  }

  Future<List<SheetRow>> get() {
    return _run("get", []).then((operation) {
      return (operation.response["result"] as List)
          .map((item) {
        var list = item as List;
        return SheetRow(list[0], list[1], list[2]);
      }).toList();
    });
  }

  Future append(SheetRow row) {
    return _run("append", [
      row.year,
      row.month,
      row.price
    ]);
  }
}

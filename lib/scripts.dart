import 'dart:async';

import 'package:googleapis/script/v1.dart';
import 'package:http/http.dart' as http;
import 'package:laxly_account/row.dart';
import 'package:laxly_account/app_key.dart';

class Scripts {

  ScriptApi _api;
  final String _id;

  Scripts(http.Client client, this._id) {
    _api = new ScriptApi(client);
  }

  Future<Operation> _run(String name, List<Object> data) {
    var request = ExecutionRequest();
    request.devMode = false;
    request.function = name;
    request.parameters = [
      AppKey.sheet_id,
      data
    ];

    return _api.scripts.run(request, _id);
  }

  Future<List<Row>> get() {
    return _run("get", []).then((operation) {
      return (operation.response["result"] as List)
          .map((item) {
        var list = item as List;
        return Row(list[0], list[1], list[2]);
      }).toList();
    });
  }

  Future append(int price) {
    return _run("append", [price]);
  }
}

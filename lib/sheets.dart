import 'dart:async';

import 'package:googleapis/sheets/v4.dart';
import 'package:http/http.dart' as http;

class Sheets {

  SheetsApi _api;

  Sheets(http.Client client) {
    _api = new SheetsApi(client);
  }

  Future<Spreadsheet> get(String id) {
    return _api.spreadsheets.get(id);
  }

  Future<AppendValuesResponse> append(ValueRange request, String id,
      String range) {
    return _api.spreadsheets.values.append(request, id, range);
  }
}

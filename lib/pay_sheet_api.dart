import 'package:gsheets/gsheets.dart';
//import 'package:untitled/user.dart';
import 'Payusers.dart';
import 'payment.dart';

class expenseManagerSheetApi1 {
  static const _credentials = r'''
 {
  "type": " /*add your credentials*/",
  "project_id": "/*add your credentials*/",
  "private_key_id": "/*add your credentials*/",
  "private_key": "/*add your credentials*/",
  "client_email": "/*add your credentials*/",
  "client_id": "/*add your credentials*/",
  "auth_uri": "/*add your credentials*/",
  "token_uri": "/*add your credentials*/",
  "auth_provider_x509_cert_url": "/*add your credentials*/",
  "client_x509_cert_url": "/*add your credentials*/"
}
''';
  static final _spreadSheetId = '/*add your credentials*/';
  static final _gSheets = GSheets(_credentials);
  static Worksheet? _usersheet;
  //static Worksheet? _usersheet2;
  static Future init() async {
    try {
      final spreadsheet = await _gSheets.spreadsheet(_spreadSheetId);
      _usersheet = await _getWorkSheet(spreadsheet, title: 'PaymentManager');
        final firstRow = PayFields.getFields();
        _usersheet!.values.insertRow(1,firstRow);

      } catch (e) {
      print("Init Error: $e");
    }
  }
    static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required String title,
    }) async {
    try{
    return await spreadsheet.addWorksheet(title);
    } catch (e){
    return spreadsheet.worksheetByTitle(title)!;
    }
    }
    static Future<User?> getByID(int id) async{
    if (_usersheet == null) return null;
    final json = await _usersheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null? null : User.fromJson(json);
    }

    static Future insert(List<Map<String, dynamic>> rowList) async{
    if(_usersheet == null) return;
    _usersheet!.values.map.appendRows(rowList);
    }
  }

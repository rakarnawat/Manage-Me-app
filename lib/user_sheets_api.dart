import 'package:gsheets/gsheets.dart';
import 'package:untitled/user.dart';
//import 'Payusers.dart';

class expenseManagerSheetApi {
  static const _credentials = r'''
 {
  "type": "service_account",
  "project_id": "quantum-balm-327605",
  "private_key_id": "e4788d148ed271833ee610be9416fa882993bad7",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCM64cC4/UjEAKT\nDTiGvLhnwM5fqgFmactcAVWrfMklEQBJ+taB54wv5eUxxIhF8EDwmHlKeePBcSLp\nyxIrXAF6Yp/QH4ezLhMckH/Gs6Uc0CcmefTk1AC/O/jy5p4KNe39ECT+UgMy/zCz\neh+d+t+n5s6JsN7wP5Atl53X5XmSza6zNM01wU5iTNKNKX0701I4EtES42VdpUz4\nVU7g7438OxJI5xOez1fEovvRWxndwG2T+LT/ixcoMD1brPfiFAXRvcERYhqU4yxA\nUbZAUc2GpYO3tkfkQYu6bOmP60tbO4YrPhhZRISHJ+9H4eLYw865ypgl9hMnjjh+\naKjjgGrTAgMBAAECggEAP13LbI/P06/n0HMR93hWHYVz5019aq1o3drVyJKIqku+\nSwXpvik9/u3MBXh/5J8XvHh7lfNAaGQ01FdVuLybB4rgnQgIj5hIzL/nTRTLyqyI\n5kLRzbHNEjDoDWWJLEM63GANmnSLbruUjSf9np7IQmpFdmHbpcGXVgEG36WW6N08\ndXSsUU+6qqnocgb2qCjHvRNAIN+PmzgAV7463ibdMwmG5OAZuyunLuTGbp0B5IHk\nO+F3CXBjzc099jnF5l2GaUtFISx08O2aCm/4q6vem9qbhkShY0QS70iXse08oMTv\nX/1lQUYWBnhwWBVYZIe1KQyCbyiQGUUC/wr6Xg0ziQKBgQDCI+lj/HDZkacf8nOc\nkE4IhFWYaB/qkHZLApHBhdu8yjgQ6dSFXayHCFHbswu2opx/g8BzaCxW+d1Bk0Js\nUVMdOgUqxzR5wU+IEsXQGvqCWUi1pnD1ejqgRvdMC0HwGAC5LExfAb2m3hSBdAaa\nj/gqi/M6FsoU1Wp+DrWpUzvL6wKBgQC50mv8FebK9cdqRMjIfSMijSFOZpUaxyQT\nGOSsrpMHtg5DpRtQx2XrQac5Kw3sOD7AzU+nvNMUcVOAoNhY28iKv8eB782GBh30\nhe1ot9d3llenlvdFz3BUaqjJNGdHXFsr4lGCLIlX6DMtVMTsICg1MUD3UlXDLEJY\n8lM3f6CquQKBgQCfaEVXKAyxWPtVLArp30NzktWFktnCDGRVKwLrWDIZTiHDIXyz\nFTt4lMhCET3o9JRzz4bSPBNMR1X5ZiUAM7Z/JQjhGzhnUOcw39k1CzHunckp/kR6\nC6bfu+WKtyOpNMxDP7BlwlQrE+badJ6HgvdOWCOa6uN7P9F1ODbJleJfiQKBgC0y\n3qtJlILHt8LEimYh8hrkYzaTwy7pQ4AVrQHH0OGuSdfwYC2M4uCPbqJ8M33CzJjP\nF9IAHwO48Qu3lAhBJY2CSn/zmXVBJaYlsXKoTRO8kQOlt+3WIEeYTgfq5Dg6Yb7R\n5OuZ86pbQ5+CIAgjZkRR/7Bo6Y14xYanItC8DZOZAoGAYi/lE7Gv6OUjY8yZQpaD\nLpdpB/6wwRSD5oUkdMMnSjrgRvrk6bLwXw9rWnYnshh/tWtDK36h7hgvwAEn0L4h\nH3GWMueq26M74uSwuMpBqzh5QmJzHYXFhZDF3JOCuGEJ7qo5REIjGCGU6DW/acMt\nh9Hg10K+7F6h5ZrZPQ1HQMQ=\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@quantum-balm-327605.iam.gserviceaccount.com",
  "client_id": "108520003407664713841",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40quantum-balm-327605.iam.gserviceaccount.com"
}
''';
  static final _spreadSheetId = '1nj57s2Pz6D3PxUAmOFBgcRWZfuINKBCWH2ddNQae_lY';
  static final _gSheets = GSheets(_credentials);
  static Worksheet? _usersheet;
  static Worksheet? _usersheet2;
  static Future init() async {
    try {
      final spreadsheet = await _gSheets.spreadsheet(_spreadSheetId);
      _usersheet = await _getWorkSheet(spreadsheet, title: 'AttendanceManager');
        final firstRow = UserFields.getFields();
        _usersheet!.values.insertRow(1, firstRow);


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
    if(_usersheet2 == null) return;
    _usersheet2!.values.map.appendRows(rowList);

  }
}
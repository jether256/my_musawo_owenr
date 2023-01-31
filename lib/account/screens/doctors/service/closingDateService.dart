import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../models/closinddate.dart';

class ClosingDateService {


  //const apiUrl = "https://domain.com/myclinic/api";



  static const _viewUrl = "get_closing_date";
  static const _deleteUrl = "deleted_updated";

  static List<ClosingDateModel> dataFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<ClosingDateModel>.from(
        data.map((item) => ClosingDateModel.fromJson(item)));
  }
  static deleteData(String id) async {
    final res = await http
        .post(Uri.parse(_deleteUrl), body: {"id": id, "dbName": "closing_date"});
    if (res.statusCode == 200) {
      return res.body;
    } else
      return "error";
  }
  static Future<List<ClosingDateModel>> getData(String doctId) async {
    final response = await http.get(Uri.parse("$_viewUrl?doctId=$doctId"));
    if (response.statusCode == 200) {
      List<ClosingDateModel> list = dataFromJson(response.body);
      return list;
    } else {
      return []; //if any error occurs then it return a blank list
    }
  }


}

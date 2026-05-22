import 'dart:convert';

import 'package:http/http.dart' as http;

class Crud {
  Future<dynamic> GET(String url) async {
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("request Failed ${response.statusCode}");
    }
  }

  // POST(String url, Map data) async {
  //   var response = await http.post(Uri.parse(url), body: data);

  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     print('Request failed with status: ${response.statusCode}');
  //     return {"status": "error"};
  //   }
  // }

  Future<dynamic> POST(String url, Map data) async {
    try {
      var response = await http.post(Uri.parse(url), body: data);

      print("Response body: ${response.body}"); // 👈 مهم جدًا

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {"status": "error", "msg": "Status code ${response.statusCode}"};
      }
    } catch (e) {
      print("Exception: $e"); // 👈 ده اللي هيفضح المشكلة
      return {"status": "error", "msg": e.toString()};
    }
  }
}

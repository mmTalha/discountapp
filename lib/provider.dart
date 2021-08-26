



import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';

class EligiblityScreenProvider extends ChangeNotifier{
  Future<List> search(brandname) async {
    var data = {
      'brand_name': brandname,
    };
    final response = await http.post(
        Uri.parse(
          'https://discounthub.uptreedevelopers.com/api/search_brand.php',
        ),
        body: data);

    if (response.statusCode == 200) {
      var datas = (jsonDecode(response.body));

      print(datas);
      notifyListeners();
      return datas;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');

    }
  }
}
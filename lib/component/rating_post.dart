import 'dart:async';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;



  Future rate(int _rating) async {
    var url = "http://localhost:8090/rating";
    Map<String, dynamic> data = {
      "userId": 3,
      "placeId": 3,
      "rating": _rating
    };
    try {
      http.Response res = await http.post(url,
          body: jsonEncode(data),
          headers: {HttpHeaders.CONTENT_TYPE: 'application/json'});
          print(jsonEncode(data));

      if (res.statusCode == 200) {
        print("rated successfully");
      }
    } catch (exception) {}
  }


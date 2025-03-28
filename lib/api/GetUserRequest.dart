import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/UserModel.dart';

Future<UserModel?> makePayRequest(String url) async {
   try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  } catch (e) {
    print('Exception: $e');
    return null;
  }
}


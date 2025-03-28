import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> sendPayment({required int userId, required int balance_change, required int terminal}) async {
  final url = Uri.parse('http://95.163.251.146/payment/${userId}'); // Замените на ваш URL
  final body = {
    "balance_change": balance_change,
    "id_user": userId,
    "id_terminal": terminal
  };

 try {
    final response = await http.put(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      // Если статус 200, возвращаем тело ответа и статус-код
      return {
        "statusCode": response.statusCode,
        "body": jsonDecode(response.body),
      };
    } else {
      // Если статус не 200, выбрасываем исключение с деталями
      throw Exception('Failed with status: ${response.statusCode}, ${response.body}');
    }
  } catch (e) {
    throw Exception('Error during PUT request: $e');
  }
}
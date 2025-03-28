import 'package:bous_pam_terminal/Entities/Terminal.dart';
import 'package:flutter/material.dart';
import 'nfc_reader_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _idController = TextEditingController();
  String _errorText = '';

  Future<void> _onLoginPressed() async {
    String enteredId = _idController.text.trim();
    if (enteredId == '1') {
      // Используем импортированную функцию setLoggedIn
      await setLoggedIn(true); // Сохраняем статус авторизации

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NfcReaderScreen()),
      );
      final terminal = Terminal();
      terminal.setId(1);  
    } else {
      setState(() {
        _errorText = 'Неверный ID. Попробуйте еще раз.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Регистрация'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Введите ID терминала',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'ID терминала',
                errorText: _errorText.isNotEmpty ? _errorText : null,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _onLoginPressed,
              child: Text('Войти'),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> setLoggedIn(bool isLoggedIn) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', isLoggedIn);
}

Future<bool> isLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
}
}

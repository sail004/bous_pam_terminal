import 'package:bous_pam_terminal/nfc_reader_screen.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:bous_pam_terminal/setLoggedIn.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isUserLoggedIn = await isLoggedIn();
  
  runApp(MyApp(isUserLoggedIn: isUserLoggedIn));
}  

class MyApp extends StatelessWidget {
  final bool isUserLoggedIn;
  
  const MyApp({Key? key, required this.isUserLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: isUserLoggedIn ? NfcReaderScreen() : LoginScreen(),
    );
  }
}
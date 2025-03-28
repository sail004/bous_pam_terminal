import 'package:bous_pam_terminal/Entities/Terminal.Dart';
import 'package:bous_pam_terminal/api/PaymentRequest.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'dart:convert';
import 'api/GetUserRequest.dart';


class NfcReaderScreen extends StatefulWidget {
  @override
  _NfcReaderScreenState createState() => _NfcReaderScreenState();
}

class _NfcReaderScreenState extends State<NfcReaderScreen> {
  String _nfcTagData = 'Waiting for NFC tag...';

  @override
  void initState() {
    super.initState();
    startNfcSession();
  }

  void startNfcSession() {
    // Запуск NFC-сессии
    NfcManager.instance.startSession(onDiscovered: handleNfcTag);
  }

  Future<void> handleNfcTag(NfcTag tag) async {
    try {
      // Пример обработки тега
      Ndef? ndef = Ndef.from(tag);
      final payload = tag.data['ndef']['cachedMessage']['records'][0]['payload'];
      final IdFromNfc = utf8.decode(payload.sublist(1)).substring(2);
      final user = await makePayRequest('http://95.163.251.146/user/${IdFromNfc}');
      final terminal = Terminal();
      final terminalId = terminal.getId();
      // Пример отправки данных (здесь нужно заменить на ваш реальный запрос)
      final response = await  sendPayment(
        userId: user!.userId, // Замените на реальное значение
        balance_change: 100,
        terminal: terminalId, // Замените на реальное значение
      );

      // Обновление UI
      setState(() {
        if (response['statusCode'] == 200) {
          _nfcTagData = 'Оплата 100, остаток: ${response['body']} на счету ${user.name}';
        } else {
          _nfcTagData = 'Ошибка: ${response['body']}';
        }
      });

      // Задержка перед возвратом к ожиданию
      await Future.delayed(Duration(seconds: 5));

      // Возврат в режим ожидания
      setState(() {
        _nfcTagData = 'Waiting for NFC tag...';
      });

      // Перезапуск сессии
      startNfcSession();
    } catch (e) {
      // Обработка ошибки
      setState(() {
        _nfcTagData = 'Ошибка: $e';
      });

      // Возврат в режим ожидания после ошибки
      await Future.delayed(Duration(seconds: 5));
      setState(() {
        _nfcTagData = 'Waiting for NFC tag...';
      });

      // Перезапуск сессии
      startNfcSession();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NFC Reader'),
      ),
      body: Center(
        child: Text(_nfcTagData),
      ),
    );
  }

  @override
  void dispose() {
    NfcManager.instance.stopSession();
    super.dispose();
  }
}
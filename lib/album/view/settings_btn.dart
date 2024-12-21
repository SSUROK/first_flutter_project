import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsBtn extends StatelessWidget {
  const SettingsBtn({super.key,required this.shares,
    required this.buttonText,
    required this.onPressed,
    required this.skey,
    required this.value
  });
  final Future<SharedPreferences> shares;
  final Function onPressed;
  final String buttonText;
  final String skey;
  final Object value;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(8.0),
        child:
        FutureBuilder(
            future: shares,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ElevatedButton(
                  onPressed: () => onPressed(skey, value),
                  child: Text(buttonText),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}"); // Обработка ошибок
              } else {
                return Text("Unknown state"); // Непредвиденная ситуация
              }
            }
        )
    );
  }

}
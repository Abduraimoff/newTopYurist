import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            LocaleText("register"),
          ],
        ),
      ),
    );
  }
}

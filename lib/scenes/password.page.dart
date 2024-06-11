import 'package:flutter/material.dart';

class PasswordPage extends StatelessWidget {
  PasswordPage({super.key});

  final TextEditingController _txtPassword = TextEditingController();

  final String password = '7185';

  void _checkPassword(BuildContext context) {
    if (_txtPassword.text == password) {
      Navigator.pushReplacementNamed(context, '/webpage');
    } else {
      Navigator.pushReplacementNamed(context, '/room1');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 240,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextField(
                controller: _txtPassword,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: const Text('Insira a senha'),
                    onPressed: () {
                      _checkPassword(context);
                    },
                  ),
                  ElevatedButton(
                    child: const Text('Voltar'),
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, '/room1'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AbajurPage extends StatefulWidget {
  const AbajurPage({super.key});

  @override
  _AbajurPageState createState() => _AbajurPageState();
}

class _AbajurPageState extends State<AbajurPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/cena-abajur.png'), fit: BoxFit.fill),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    child: const Text("Voltar"),
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, '/room1')),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

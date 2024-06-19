import 'package:flutter/material.dart';

class BookPage2 extends StatelessWidget {
  const BookPage2 ({Key, key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/papel.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Outros dois pacientes demonstraram resultados '
                  'que vão muito além do esperado. É quase milagroso '
                  'o que estamos fazendo aqui dentro, me atrevo a '
                  'dizer que podemos estar levando a humanidade para '
                  'outro nível. Podem questionar quais são os meus '
                  'meios, mas não os meus resultados.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/past');
                },
                child: Text('Voltar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

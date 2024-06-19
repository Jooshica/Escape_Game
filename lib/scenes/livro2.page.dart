import 'package:flutter/material.dart';

class BookPage extends StatelessWidget {
  const BookPage({Key, key}) : super(key: key);

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
                  'Os experimentos tiveram início hoje. Uma parte '
                  'considerável dos participantes respondeu bem ao '
                  'reagente, apontando que há uma grande chance de '
                  'tudo ocorrer conforme o esperado.\n'
                  'Existe um investimento enorme neste projeto e '
                  'falhar é algo inadmissível.',
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

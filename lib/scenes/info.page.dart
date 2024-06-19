import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre'),
        // Adicionando um botão de seta na AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed('/start'); // Navega de volta para '/start'
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/parede.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Desenvolvido por: \n'
                  'Adnan, Diego, Guilherme, Isadora, Jéssica e Matheus',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontWeight: FontWeight.bold), // Texto em negrito
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

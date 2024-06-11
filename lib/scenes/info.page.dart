import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sobre o jogo"),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/start'),
            icon: const Icon(Icons.arrow_back),
          )
        ],
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                """Antes de se tornar o que hoje é conhecida na região como a 
                  Faculdade de Tecnologia de São José do Rio Preto, ou FATEC Rio Preto,
                  o lugar era uma prisão pública conhecida como Cadeião, que moldava
                  todo o entorno do bairro. Esse período foi marcante por bastante
                  insegurança dos moradores locais.""",
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

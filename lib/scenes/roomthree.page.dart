import 'package:flutter/material.dart';

class RoomthreePage extends StatelessWidget {
  const RoomthreePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtém as dimensões da tela
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Define as coordenadas do livro
    final double bookLeft =
        screenWidth * 0.38; // Posição horizontal da esquerda
    final double bookTop = screenHeight * 0.66; // Posição vertical do topo

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/teste9.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: bookLeft,
            top: bookTop,
            child: Container(
              width: 60, // Ajuste a largura do contêiner conforme necessário
              height: 30, // Ajuste a altura do contêiner conforme necessário
              child: Stack(
                children: [
                  Image.asset(
                    "images/livro2.png",
                    width: 35,
                    height: 35,
                  ),
                  Positioned(
                    top: 5, // Ajuste a posição vertical do primeiro texto
                    left: 3, // Ajuste a posição horizontal do primeiro texto
                    child: Text(
                      "fatec \n fatec \n fatec",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 4,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5, // Ajuste a posição vertical do segundo texto
                    left: 18, // Ajuste a posição horizontal do segundo texto
                    child: Text(
                      "cadeião \n cadeião \n cadeião",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      floatingActionButton: SizedBox(
        width: 25,
        height: 2,
        child: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(255, 0, 0, 1.0),
          tooltip: 'Sair',
          onPressed: () => Navigator.pushReplacementNamed(context, '/start'),
          child: Icon(Icons.arrow_back, color: Colors.white, size: 10),
        ),
      ),
    );
  }
}

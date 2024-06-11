import 'package:flutter/material.dart';
import 'package:escape_fatec/inventory/item.dart'; // Importa a classe Item

class RoomonePage extends StatefulWidget {
  @override
  _RoomonePageWidgetState createState() => _RoomonePageWidgetState();
}

class _RoomonePageWidgetState extends State<RoomonePage> {
  List<Item> inventory = [];
  double x = 0.0;
  double y = 0.0;
  double livroPositionTop = 500.0; // Coordenada Y inicial do livro
  bool livroMovido = false; // Variável para rastrear se o livro foi movido
  bool chaveNoInventario = false;
  bool frascoNoInventario = false;
  bool mochilaVerificada = false;

  @override
  Widget build(BuildContext context) {
    Item chave = Item(name: 'Chave', imagePath: 'assets/images/chave.png');
    Item frasco = Item(name: 'Frasco', imagePath: 'assets/images/frasco.webp');

    final double sceneWidth =
        1280.0; // Defina o tamanho do cenário conforme necessário
    final double sceneHeight =
        720.0; // Defina o tamanho do cenário conforme necessário

    final scaleX = MediaQuery.of(context).size.width / sceneWidth;
    final scaleY = MediaQuery.of(context).size.height / sceneHeight;

    // Posições dos elementos em relação ao cenário
    double chavePosX = 50.0 * scaleX;
    double chavePosY = 495.0 * scaleY;
    double livroPosX = 38.0 * scaleX;
    double livroPosY = livroPositionTop * scaleY;

    return Scaffold(
      body: Stack(
        children: [
          DecoratedBox(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/teste.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: GestureDetector(
              onTapUp: (details) {
                setState(() {
                  x = details.localPosition.dx / scaleX;
                  y = details.localPosition.dy / scaleY;

                  if (x > 430 && x < 485 && y > 275 && y < 320) {
                    Navigator.pushNamed(context, '/computer');
                  }
                  if (x > 110 && x < 125 && y > 275 && y < 320) {
                    Navigator.pushNamed(context, '/livro');
                  }
                  if (x > 114 && x < 125 && y > 385 && y < 416) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(chave.name),
                          content: const Text(
                              'Uma chave? Me pergunto se isso tem alguma utilidade.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Fechar'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  if (x > 1225 && x < 1280 && y > 400 && y < 490) {
                    Navigator.pushNamed(context, '/abajur');
                  }
                  if (x > 1000 && x < 1120 && y > 150 && y < 350) {
                    Navigator.pushNamed(context, '/password');
                  }
                  if (x > 230 &&
                      x < 280 &&
                      y > 310 &&
                      y < 390 &&
                      !frascoNoInventario &&
                      !mochilaVerificada) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(frasco.name),
                          content:
                              const Text('Isso é... Um frasco de luminol?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  frascoNoInventario = true;
                                  inventory.add(frasco);
                                  Navigator.of(context).pop();
                                });
                              },
                              child: const Text('Fechar'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                });
              },
            ),
          ),
          Positioned(
            left: livroPosX,
            top: livroPosY,
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Cadeião/fatec'),
                      content: const Text('história do cadeião/fatec aqui'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            setState(
                              () {
                                if (!livroMovido) {
                                  livroPositionTop += 68.0 * scaleY;
                                  livroMovido = true;
                                }
                              },
                            );
                          },
                          child: const Text('Fechar'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Image.asset(
                "images/livro.png",
                width: 65.0 * scaleX,
                height: 65.0 * scaleY,
              ),
            ),
          ),
          if (livroMovido && !chaveNoInventario)
            Positioned(
              left: chavePosX,
              top: chavePosY,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    chaveNoInventario = true;
                    inventory.add(chave);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(chave.name),
                          content: const Text(
                              'Uma chave? Me pergunto se isso tem alguma utilidade.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Fechar'),
                            ),
                          ],
                        );
                      },
                    );
                  });
                },
                child: Image.asset(
                  chave.imagePath,
                  width: 50.0 * scaleX,
                  height: 50.0 * scaleY,
                ),
              ),
            ),
          Positioned(
            bottom: 10,
            left: 100,
            child: SizedBox(
              width: 800 * scaleY,
              height: 100 * scaleX,
              child: DecoratedBox(
                position: DecorationPosition.background,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage('assets/images/inventario-horizontal.png'),
                    fit: BoxFit.contain,
                  ),
                ),
                child: Row(
                  children: inventory.map((item) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          inventory.remove(item);
                        });
                      },
                      child: Image.asset(
                        item.imagePath,
                        width: 25.0,
                        height: 25.0,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: const Color.fromRGBO(255, 0, 0, 1.0),
        tooltip: 'Sair',
        onPressed: () => Navigator.pushReplacementNamed(context, '/start'),
        child: const Icon(Icons.arrow_back, color: Colors.white, size: 15),
      ),
    );
  }
}

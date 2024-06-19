import 'dart:math';
import 'package:flutter/material.dart';
import 'package:escape_fatec/inventory/item.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:audioplayers/audioplayers.dart';

class PastPage extends StatefulWidget {
  @override
  _PastPageState createState() => _PastPageState();
}

class _PastPageState extends State<PastPage> {
  List<Item> inventory = [];
  List<Item> selectedItems = [];
  bool chaveNoInventario = false;
  bool colaNoInventario = false;
  bool chave2NoInventario = false;

  @override
  void initState() {
    super.initState();
    loadGameState();
  }

  Future<void> loadGameState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      chaveNoInventario = prefs.getBool('pastChaveNoInventario') ?? false;
      colaNoInventario = prefs.getBool('pastColaNoInventario') ?? false;
      chave2NoInventario = prefs.getBool('pastChave2NoInventario') ?? false;

      List<String>? savedInventory = prefs.getStringList('pastInventory');
      if (savedInventory != null) {
        inventory = savedInventory
            .map((itemString) => Item.fromString(itemString))
            .toList();
      }
    });
  }

  Future<void> saveGameState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('pastChaveNoInventario', chaveNoInventario);
    await prefs.setBool('pastColaNoInventario', colaNoInventario);
    await prefs.setBool('pastChave2NoInventario', chave2NoInventario);

    List<String> inventoryToSave =
        inventory.map((item) => item.toString()).toList();
    await prefs.setStringList('pastInventory', inventoryToSave);
  }

  Future<void> resetGameState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('pastChaveNoInventario');
    await prefs.remove('pastColaNoInventario');
    await prefs.remove('pastChave2NoInventario');
    await prefs.remove('pastInventory');
    setState(() {
      chaveNoInventario = false;
      colaNoInventario = false;
      chave2NoInventario = false;
      inventory = [];
      selectedItems = [];
    });
  }

  void addItem(Item item) {
    setState(() {
      inventory.add(item);
    });
    saveGameState();
  }

  void removeItem(Item item) {
    setState(() {
      inventory.remove(item);
    });
    saveGameState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final double bookLeft = screenWidth * 0.38;
    final double bookTop = screenHeight * 0.66;

    final double colaLeft = screenWidth * 0.10;
    final double colaTop = screenHeight * 0.40;

    final double chave1Left = screenWidth * 0.712;
    final double chave1Top = screenHeight * 0.40;

    final double chave2Left = screenWidth * 0.448;
    final double chave2Top = screenHeight * 0.35;

    final double inventoryWidth = screenWidth * 0.40;
    final double inventoryHeight = 40;
    final double inventoryLeft = screenWidth * 0.25;
    final double inventoryBottom = screenHeight * 0.01;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/alçapão.png"),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            left: bookLeft,
            top: bookTop,
            child: Container(
              width: 60,
              height: 30,
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/livro2.png",
                    width: 35,
                    height: 35,
                  ),
                  Positioned(
                    top: 5,
                    left: 3,
                    child: Text(
                      "Experimento1 \n Experimento1 \n Experimento1 \n Experimento1 \n Experimento1 \n Experimento1",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 2,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    left: 19,
                    child: Text(
                      "Experimento2 \n Experimento2 \n Experimento2 \n Experimento2 \n Experimento2 \n Experimento2",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 2,
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
          Positioned(
            left: screenWidth * 0.38,
            top: screenHeight * 0.67 ,
            child: GestureDetector(
              onTap: () {
                // Navegar para outra página aqui
                Navigator.pushReplacementNamed(context, '/livro2');
              },
              child: Container(
                width: 16,
                height: 20,
                color: Colors.transparent, // Tornar semi-transparente para visualizar melhor
              ),
            ),
          ),
          Positioned(
            left: screenWidth * 0.416,
            top: screenHeight * 0.67 ,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/livro3');
              },
              child: Container(
                width: 16,
                height: 20,
                color: Colors.transparent, 
              ),
            ),
          ),
          Positioned(
            left: colaLeft,
            top: colaTop,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (!colaNoInventario) {
                    colaNoInventario = true;
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Cola Encontrada'),
                          content: Text('Você encontrou um tubo de cola'),
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
                    inventory.add(Item(
                      name: 'Cola',
                      description: 'Um tubo de cola',
                      imagePath: 'assets/images/cola.png',
                      inventoryImageSize: 20,
                      isVertical: true,
                    ));
                    saveGameState();
                  }
                });
              },
              child: !colaNoInventario
                  ? Image.asset(
                      "assets/images/cola.png",
                      width: 16,
                      height: 16,
                    )
                  : Container(),
            ),
          ),
          Positioned(
            left: chave1Left,
            top: chave1Top,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (!chaveNoInventario) {
                    chaveNoInventario = true;
                    inventory.add(Item(
                      name: 'Chave Quebrada 1',
                      description: 'Metade de uma chave quebrada',
                      imagePath: 'assets/images/chave1.png',
                      inventoryImageSize: 50,
                      isVertical: false,
                    ));
                    saveGameState();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Chave Encontrada'),
                          content: Text('Você encontrou uma chave quebrada!'),
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
                });
              },
              child: chaveNoInventario
                  ? Container()
                  : ClipRect(
                      child: Align(
                        alignment: Alignment.topCenter,
                        heightFactor: 0.1,
                        child: Image.asset(
                          "assets/images/chave1.png",
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
            ),
          ),
          Positioned(
            left: chave2Left,
            top: chave2Top,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (!chave2NoInventario) {
                    chave2NoInventario = true;
                    inventory.add(Item(
                      name: 'Chave Quebrada 2',
                      description: 'Uma metade de uma chave quebrada',
                      imagePath: 'assets/images/chave2.png',
                      inventoryImageSize: 50,
                      isVertical: false,
                    ));
                    saveGameState();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Chave Encontrada'),
                          content: Text('Você encontrou a metade de uma chave'),
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
                });
              },
              child: chave2NoInventario
                  ? Container()
                  : ClipRect(
                      child: Align(
                        alignment: Alignment.topCenter,
                        heightFactor: 0.2,
                        child: Image.asset(
                          "assets/images/chave2.png",
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
            ),
          ),
          Positioned(
            left: inventoryLeft,
            bottom: inventoryBottom,
            child: Container(
              width: inventoryWidth,
              height: inventoryHeight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/inventory.png'),
                  fit: BoxFit.contain,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: inventory.map((item) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selectedItems.contains(item)) {
                          selectedItems.remove(item);
                        } else {
                          selectedItems.add(item);
                        }
                        verificarEColarChave();
                      });
                    },
                    child: Transform.rotate(
                      angle: item.isVertical ? 1.5 * pi : 0,
                      child: Image.asset(
                        item.imagePath,
                        width: item.inventoryImageSize.toDouble(),
                        height: item.isVertical ? 30 : 50,
                        color:
                            selectedItems.contains(item) ? Colors.blue : null,
                        colorBlendMode: selectedItems.contains(item)
                            ? BlendMode.modulate
                            : null,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Stack(
            children: [
              Positioned(
                left: screenWidth * 0.92,
                top: screenHeight * 0.005,
                child: GestureDetector(
                  onTap: () {
                    bool temChaveCompleta =
                        inventory.any((item) => item.name == 'Chave');
                    if (temChaveCompleta) {
                      Navigator.pushReplacementNamed(context, '/present');
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Alçapão'),
                            content: Text(
                                'Isso é um alçapão? Parece que está trancado...Preciso encontrar uma chave!'),
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
                  },
                  child: Container(
                    width: 50,
                    height: 20,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      floatingActionButton: SizedBox(
        width: 25,
        height: 20,
        child: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(255, 0, 0, 1.0),
          tooltip: 'Sair',
          onPressed: () => Navigator.pushReplacementNamed(context, '/start'),
          child: Icon(Icons.arrow_back, color: Colors.white, size: 10),
        ),
      ),
    );
  }

  void verificarEColarChave() {
    bool temChave1 =
        selectedItems.any((item) => item.name == 'Chave Quebrada 1');
    bool temChave2 =
        selectedItems.any((item) => item.name == 'Chave Quebrada 2');
    bool temCola = selectedItems.any((item) => item.name == 'Cola');

    if (temChave1 && temChave2 && temCola) {
      setState(() {
        inventory.removeWhere((item) =>
            item.name == 'Chave Quebrada 1' ||
            item.name == 'Chave Quebrada 2' ||
            item.name == 'Cola');
        selectedItems.removeWhere((item) =>
            item.name == 'Chave Quebrada 1' ||
            item.name == 'Chave Quebrada 2' ||
            item.name == 'Cola');

        inventory.add(Item(
          name: 'Chave',
          description: 'Uma chave completa',
          imagePath: 'assets/images/chave.png',
          inventoryImageSize: 50,
          isVertical: false,
        ));
      });

      saveGameState();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Chave'),
            content: Text(
                'Você colou as duas metades da chave e obteve uma chave completa!'),
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

      bool temChaveCompleta = inventory.any((item) => item.name == 'Chave');
      if (temChaveCompleta) {
        Navigator.pushReplacementNamed(context, 'room3');
      }
    }
  }
}

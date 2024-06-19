// ignore_for_file: prefer_conditional_assignment

import 'package:escape_fatec/inventory/inventory.dart';
import 'package:flutter/material.dart';
import 'package:escape_fatec/inventory/item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';

class PresentPage extends StatefulWidget {
  @override
  _PresentPageWidgetState createState() => _PresentPageWidgetState();
}

class _PresentPageWidgetState extends State<PresentPage> {
  Inventory inventory = Inventory(items: []);

  double x = 0.0;
  double y = 0.0;
  double livroPositionTop = 500.0;
  bool livroMovido = false;
  bool mochilaVerificada = false;
  bool verificarChave = false;
  bool verificarParede = false;
  bool frascoColetado = false;
  bool chaveColetada = false;
  final TextEditingController _passwordController = TextEditingController();
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    inventory = Inventory(items: []);
    inventory.loadInventory();
    loadGameState();
  }

  void selectItem(Item item) {
  
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: Text(item.name),
    //       content: Text(item.description),
    //       actions: <Widget>[
    //         TextButton(
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //          },
    //          child: const Text('Fechar'),
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  Future<void> loadGameState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      livroMovido = prefs.getBool('bookMoved') ?? false;
      mochilaVerificada = prefs.getBool('mochilaVerificada') ?? false;
      verificarChave = prefs.getBool('verificarChave') ?? false;
      verificarParede = prefs.getBool('verificarParede') ?? false;
      frascoColetado = prefs.getBool('frascoColetado') ?? false;
      chaveColetada = prefs.getBool('chaveColetada') ?? false;
      if (livroMovido) {
        livroPositionTop += 34.0;
      }
      inventory.loadInventory();
    });
  }

  Future<void> saveGameState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('bookMoved', livroMovido);
    await prefs.setBool('mochilaVerificada', mochilaVerificada);
    await prefs.setBool('verificarChave', verificarChave);
    await prefs.setBool('verificarParede', verificarParede);
    await prefs.setBool('frascoColetado', frascoColetado);
    await prefs.setBool('chaveColetada', chaveColetada);
    inventory.saveInventory();
  }

  Future<void> resetGameState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    setState(() {
      livroMovido = false;
      mochilaVerificada = false;
      verificarChave = false;
      verificarParede = false;
      frascoColetado = false;
      chaveColetada = false;
      livroPositionTop = 500.0;
      inventory = Inventory(items: []);
    });
  }

  void addItem(Item item) {
    setState(() {
      inventory.addItem(item);
    });
  }

  // void removeItem(Item item) {
  //   setState(() {
  //     inventory.removeItem(item);
  //   });
  // }

 void _showPasswordDialog() {
  if (inventory.containsItem('Chave')) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Insira a senha:'),
          content: TextField(
            controller: _passwordController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (_passwordController.text == '7185') {
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Finalmente!'),
                        content: const Text('Agora posso voltar aos estudos'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/start');
                            },
                            child: const Text('Sair'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Erro'),
                        content: const Text('Senha incorreta'),
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
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atenção'),
          content: const Text('Você precisa da chave para inserir a senha.'),
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
}


  void _confirmMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmação'),
          content: const Text('Deseja voltar ao menu inicial?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Não'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  saveGameState();
                });
                Navigator.pushReplacementNamed(context, '/start');
              },
              child: const Text('Sim'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //Carregando os itens
    Item chave = Item(
        name: 'Chave',
        description: 'Uma chave? Me pergunto se isso tem alguma utilidade.',
        imagePath: 'assets/images/chave.png',
        inInventory: false);
    Item frasco = Item(
        name: 'Frasco',
        description: 'Isso é... Um frasco de luminol?',
        imagePath: 'assets/images/frasco.webp',
        inInventory: false);

    const double sceneWidth =
        1280.0; // Defina o tamanho do cenário conforme necessário
    const double sceneHeight =
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
                fit: BoxFit.contain,
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
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Jornal D\'ouro, Edição 15'),
                          content: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                RichText(
                                  text: const TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'O RENASCER DE UM LUGAR DE DORES',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                    'Após muitos anos de medo e preocupação, um novo começo traz '
                                    'esperanças aos moradores do bairro. O projeto de lei que autoriza'
                                    ' a desativação da cadeia pública e propõe que seja transformada em'
                                    ' uma Faculdade de Tecnologia foi aprovada! Por anos os moradores '
                                    'da vizinhança sofreram com as constantes fugas e casos de violência '
                                    'nos arredores, mas agora um novo começo promete trazer desenvolvimento '
                                    'para o lugar.')
                              ],
                            ),
                          ),
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
                  if (x > 1225 &&
                      x < 1280 &&
                      y > 400 &&
                      y < 490 &&
                      verificarParede == true) {
                    Navigator.pushNamed(context, '/abajur');
                  }
                  if (x > 1000 &&
                      x < 1120 &&
                      y > 150 &&
                      y < 350 &&
                      verificarChave == true &&
                      verificarParede == true) {
                    _showPasswordDialog();
                  }
                  if (x > 230 &&
                      x < 280 &&
                      y > 310 &&
                      y < 390 &&
                      !frasco.inInventory &&
                      !mochilaVerificada) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(frasco.name),
                          content: Text(frasco.description),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  addItem(frasco);
                                  frascoColetado = true;
                                  mochilaVerificada = true;
                                  saveGameState();
                                  Navigator.of(context).pop();
                                });
                              },
                              child: const Text('Pegar'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  if (x > 540 &&
                      x < 740 &&
                      y > 100 &&
                      y < 300 &&
                      frascoColetado &&
                      verificarParede == false) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Parede'),
                          content: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                RichText(
                                  text: const TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Espera, tem algo estranho nessa parede.\n\n',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic)),
                                      TextSpan(
                                        text:
                                            'E se eu borrifar o luminol aqui...\n\n',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                      TextSpan(
                                        text:
                                            'Eureka! Deu certo, estou conseguindo uma reação!\n\n',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                      TextSpan(
                                        text: 'Tem uma mensagem aqui...\n\n',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                      TextSpan(
                                        text:
                                            'O VERDADEIRO CAMINHO É A LUZ\n\n',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text:
                                            'Eu me pergunto o que isso quer dizer...',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  verificarParede = true;
                                  //removeItem(frasco);
                                  saveGameState();
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
                  if (x > 1150 && x < 1190 && y > 320 && y < 380) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                              'Algoritmo e Lógica de Programação, 27/02'),
                          content: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                RichText(
                                  text: const TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              'ALGORITMO: É uma sequência de passos, descritos de forma ',
                                          style: TextStyle(
                                              fontStyle: FontStyle.normal)),
                                      TextSpan(
                                        text:
                                            'lógica, que visam atingir um objetivo bem definido.\n\n',
                                        style: TextStyle(
                                            fontStyle: FontStyle.normal),
                                      ),
                                      TextSpan(
                                        text: 'Regras:\n',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text:
                                            '1. Identificar o início e o fim do algoritmo.\n',
                                        style: TextStyle(
                                            fontStyle: FontStyle.normal),
                                      ),
                                      TextSpan(
                                        text:
                                            '2. Descrever cada passo em uma linha.\n',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal),
                                      ),
                                      TextSpan(
                                        text:
                                            '3. Usar verbos no infinitivo/impessoal.\n\n',
                                        style: TextStyle(
                                            fontStyle: FontStyle.normal),
                                      ),
                                      TextSpan(
                                        text: 'Exercício:\n',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text:
                                            'Elabore um ALGORITMO para resolver a Torre de Hanói\n',
                                        style: TextStyle(
                                            fontStyle: FontStyle.normal),
                                      ),
                                      TextSpan(
                                        text:
                                            '(O que será que é uma torre de Hanói???)',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                setState(() {
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
                  if (x > 780 &&
                      x < 1000 &&
                      y > 480 &&
                      y < 580 &&
                      chaveColetada == true) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Jornal MegaByte'),
                          content: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                RichText(
                                  text: const TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            'EVENTO QUE INCENTIVA A TECNOLOGIA TEM INÍCIO',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Considerado por muitos que trabalham na área como '
                                  'o maior evento de tecnologia da cidade, esse ano '
                                  'tem sua terceira edição, com muitas novidades e '
                                  'palestrantes de diversas áreas e diferentes países!\n'
                                  'Valeriana, estudante, veio prestigiar um renomado '
                                  'professor da área de hardware.\n'
                                  'Ele é uma verdadeira fonte de inspiração, não posso '
                                  'deixar de ficar encantada com tudo o que ele diz!\n\n ',
                                ),
                                RichText(
                                  text: const TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            'Por que tem esse trecho dessa entrevista vergonhosa ',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                      TextSpan(
                                        text:
                                            'que eu dei nessa gaveta? Queria esquecer desse dia!',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                setState(
                                  () {
                                    if (!livroMovido) {
                                      livroPositionTop += 68.0 * scaleY;
                                      livroMovido = true;
                                      saveGameState();
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
                      title: const Text('Dia 15/06'),
                      content: const SingleChildScrollView(
                        child: Column(children: <Widget>[
                          Text('Hoje foi mais um dia difícil para mim, não '
                              'consegui terminar meu projeto, todos estavam '
                              'contando comigo e falhei. Sei que não é fácil '
                              'pois escolhi esse caminho, mas não imaginei '
                              'que poderia dar tão errado assim. De qualquer '
                              'forma, ainda é cedo para desistir, não posso me '
                              'deixar abalar pela opinão de outros, e muito menos '
                              'do que eu penso de mim mesma.')
                        ]),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            setState(
                              () {
                                if (!livroMovido) {
                                  livroPositionTop += 68.0 * scaleY;
                                  livroMovido = true;
                                  saveGameState();
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
          if (livroMovido && !chave.inInventory && !verificarChave)
            Positioned(
              left: chavePosX,
              top: chavePosY,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    verificarChave = true;
                    addItem(chave);
                    chaveColetada = true;
                    saveGameState();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(chave.name),
                          content: Text(chave.description),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Pegar'),
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
            bottom: 1 * scaleY,
            left: 470 * scaleX,
            child: SizedBox(
              width: 400 * scaleY,
              height: 100 * scaleX,
              child: DecoratedBox(
                position: DecorationPosition.background,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/inventory.png'),
                    fit: BoxFit.contain,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 20),
                  child: Row(
                    children: inventory.items.map((item) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectItem(item);
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
          ),
          Positioned(
  bottom: 325 * scaleY,
  left: 940 * scaleX,
  child: IgnorePointer(
    ignoring: true, // Isso garante que a imagem da porta não intercepte toques
    child: SizedBox(
      width: 230 * scaleY,
      height: 230 * scaleX,
      child: DecoratedBox(
        position: DecorationPosition.background,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/porta.png'),
            fit: BoxFit.contain,
          ),
        ),
      ),
    ),
  ),
)

        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: const Color.fromRGBO(255, 0, 0, 1.0),
        tooltip: 'Sair',
        onPressed: () => _confirmMenu(context),
        child: const Icon(Icons.arrow_back, color: Colors.white, size: 15),
      ),
    );
  }
}

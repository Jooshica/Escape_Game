import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  Future<void> resetGame(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacementNamed(context, '/past');
  }

  Future<void> continueGame(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasSavedGame =
        prefs.containsKey('bookMoved') || prefs.containsKey('inventory');
    if (hasSavedGame) {
      Navigator.pushReplacementNamed(context, '/present');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Nenhum jogo salvo'),
        ),
      );
    }
  }

  void _confirmExit(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmação'),
          content: Text('Deseja mesmo sair?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Não'),
            ),
            TextButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: Text('Sim'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/inicial.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  alignment: AlignmentDirectional.bottomCenter,
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      overlayColor: MaterialStateProperty.all<Color>(
                          Colors.black.withOpacity(0.1)),
                    ),
                    child: Text(
                      "Novo Jogo",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => resetGame(context),
                  )),
              Container(
                  alignment: AlignmentDirectional.bottomCenter,
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white)),
                    child: Text("Continuar",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () => continueGame(context),
                  )),
              Container(
                alignment: AlignmentDirectional.bottomCenter,
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Text("Configurações",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  onPressed: () => Navigator.pushNamed(context, '/config'),
                ),
              ),
              Container(
                alignment: AlignmentDirectional.bottomCenter,
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white)),
                  child: Text("Sair",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  onPressed: () => _confirmExit(context),
                ),
              ),
              Container(
                alignment: AlignmentDirectional.bottomCenter,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, '/info'),
                      icon: const Icon(Icons.question_mark_outlined),
                      color: Colors.white,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

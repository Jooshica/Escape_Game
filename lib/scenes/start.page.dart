import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

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
          height: 240,
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
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, '/room3'),
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
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, '/room3'),
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
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/room1'),
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

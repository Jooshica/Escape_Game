import 'package:flutter/material.dart';

class ComputerPage extends StatefulWidget {
  const ComputerPage({super.key});

  @override
  _ComputerPageState createState() => _ComputerPageState();
}

class _ComputerPageState extends State<ComputerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/wallpaper.png'), fit: BoxFit.fill),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: GestureDetector(
                    onTap: () =>
                        Navigator.pushReplacementNamed(context, '/room1'),
                  ),
                ),
                ElevatedButton(
                  child: const Text("Navegador"),
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/webpage'),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: const Color.fromRGBO(255, 0, 0, 1.0),
        tooltip: 'Voltar',
        onPressed: () => Navigator.pushReplacementNamed(context, '/room1'),
        child: const Icon(Icons.arrow_back, color: Colors.white, size: 15),
      ),
    );
  }
}

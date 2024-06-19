import 'package:flutter/material.dart';

class WebpagePage extends StatefulWidget {
  const WebpagePage({super.key});

  @override
  _WebpagePageState createState() => _WebpagePageState();
}

class _WebpagePageState extends State<WebpagePage> {
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
                Image.asset('images/websurfer.png', width: 200, height: 200),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: const Color.fromRGBO(255, 0, 0, 1.0),
        tooltip: 'Voltar',
        onPressed: () => Navigator.pushReplacementNamed(context, '/computer'),
        child: const Icon(Icons.arrow_back, color: Colors.white, size: 15),
      ),
    );
  }
}

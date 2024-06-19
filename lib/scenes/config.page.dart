import 'package:flutter/material.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/save0.png'),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Configurações',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SoundCheckbox(
                label: 'Ativar Som',
                initialValue: true,
                labelColor: Colors.white,
                checkColor: Colors.white,
                activeColor: Colors.grey, // Defina a cor ativa do Checkbox
                onChanged: (value) {},
              ),
              const SizedBox(
                height: 10,
              ),
              SoundCheckbox(
                label: 'Ativar Música',
                initialValue: true,
                labelColor: Colors.white,
                checkColor: Colors.white,
                activeColor: Colors.grey,
                onChanged: (value) {},
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    child: const Text(
                      'Salvar',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/start');
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    child: const Text(
                      'Voltar',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SoundCheckbox extends StatefulWidget {
  final String label;
  final bool initialValue;
  final Color? labelColor;
  final Color? checkColor;
  final Color? activeColor; // Adicionando a cor ativa do Checkbox
  final ValueChanged<bool>? onChanged;

  const SoundCheckbox({
    Key? key,
    required this.label,
    required this.initialValue,
    this.labelColor,
    this.checkColor,
    this.activeColor,
    this.onChanged,
  }) : super(key: key);

  @override
  _SoundCheckboxState createState() => _SoundCheckboxState();
}

class _SoundCheckboxState extends State<SoundCheckbox> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: _value,
          onChanged: (newValue) {
            setState(() {
              _value = newValue!;
            });
            widget.onChanged?.call(newValue!);
          },
          checkColor: widget.checkColor,
          activeColor: widget.activeColor, // Defina a cor ativa do Checkbox
        ),
        Text(
          widget.label,
          style: TextStyle(
            color: widget.labelColor ?? Colors.white,
          ),
        ),
      ],
    );
  }
}

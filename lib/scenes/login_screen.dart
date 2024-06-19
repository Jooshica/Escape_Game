import 'package:flutter/material.dart';
import 'package:escape_fatec/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService(); // Crie uma instância do AuthService

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Image.asset(
            'assets/images/save0.png', // Coloque o caminho da sua imagem aqui
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login', // Texto "Login" no topo da tela
                  style: TextStyle(
                    fontSize: 24, // Tamanho da fonte
                    fontWeight: FontWeight.bold, // Negrito
                    color: Colors.white, // Cor do texto
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7), // Cor de fundo do campo de texto
                  ),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7), // Cor de fundo do campo de texto
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: _signInWithEmailAndPassword,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        return Colors.brown; // Cor do botão habilitado
                      },
                    ),
                    textStyle: MaterialStateProperty.resolveWith<TextStyle>(
                      (Set<MaterialState> states) {
                        return TextStyle(color: Colors.white); // Cor do texto do botão
                      },
                    ),
                  ),
                  child: Text('Login'),
                ),
                SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: _navigateToRegister,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        return Colors.brown; // Cor do botão habilitado
                      },
                    ),
                    textStyle: MaterialStateProperty.resolveWith<TextStyle>(
                      (Set<MaterialState> states) {
                        return TextStyle(color: Colors.white); // Cor do texto do botão
                      },
                    ),
                  ),
                  child: Text('Cadastre-se aqui'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      await _authService.signInWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );

      // Login successful, navigate to '/start' and remove all previous routes
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/start',
        (Route<dynamic> route) => false, // Remove all previous routes
      );
    } catch (e) {
      // Handle login errors, e.g., display an error message
      print('Error: $e');
    }
  }

  void _navigateToRegister() {
    Navigator.pushNamed(context, '/register'); // Navigate to registration page
  }
}

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Cadastro bem-sucedido, pode realizar outras ações se necessário
    } catch (e) {
      // Tratar erros de cadastro, por exemplo, exibir uma mensagem de erro
      print('Error registering user: $e');
      throw e; // Relançar a exceção para lidar com ela em outro lugar, se necessário
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Login bem-sucedido, pode realizar outras ações se necessário
    } catch (e) {
      // Tratar erros de login, por exemplo, exibir uma mensagem de erro
      print('Error signing in: $e');
      throw e; // Relançar a exceção para lidar com ela em outro lugar, se necessário
    }
  }

  // Adicione outros métodos de autenticação conforme necessário, como signOut, etc.
}

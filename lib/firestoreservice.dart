import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveGameState(Map<String, dynamic> gameState) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _db
          .collection('users')
          .doc(user.uid)
          .set(gameState, SetOptions(merge: true));
    }
  }

  Future<Map<String, dynamic>?> getGameState() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await _db.collection('users').doc(user.uid).get();
      return doc.data() as Map<String, dynamic>?;
    }
    return null;
  }

  Future<void> saveAchievement(String achievement) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _db.collection('users').doc(user.uid).update({
        'achievements': FieldValue.arrayUnion([achievement])
      });
    }
  }

  Future<List<String>?> getAchievements() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await _db.collection('users').doc(user.uid).get();
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      return List<String>.from(data?['achievements'] ?? []);
    }
    return null;
  }
}

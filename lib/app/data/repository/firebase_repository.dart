import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class FirestoreRepository {
  Future<void> addUser(
      String userId, String email, String displayName, String? photoURL);
  Future<void> changePassword(String newPassword);
  Future<Map<String, String>?> getUserDetails(String userId);
}

@Injectable(as: FirestoreRepository)
class FirestoreRepositoryImpl implements FirestoreRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  FirestoreRepositoryImpl(this.firestore, this.auth);

  @override
  Future<void> addUser(
      String userId, String email, String displayName, String? photoURL) async {
    try {
      await firestore.collection('users').doc(userId).set({
        'email': email,
        'displayName': displayName,
        'photoURL':
            photoURL ?? '', // Adiciona a URL da foto de perfil, se disponível
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, String>?> getUserDetails(String userId) async {
    try {
      final docSnapshot = await firestore.collection('users').doc(userId).get();
      if (docSnapshot.exists) {
        final userData = docSnapshot.data() as Map<String, dynamic>;
        String? photoURL = userData['photoURL'];

        // Se tiver uma URL de foto, retorne junto com outros detalhes
        return {
          'displayName': userData['displayName'],
          'email': userData['email'],
          'photoURL':
              photoURL ?? '', // Pode ser vazio se não houver URL de foto
        };
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> changePassword(String newPassword) async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
      } else {
        throw FirebaseAuthException(
            code: 'user-not-logged-in', message: 'User is not logged in.');
      }
    } catch (e) {
      rethrow;
    }
  }
}

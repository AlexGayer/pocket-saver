import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_pocket_saver/app/domain/model/usuario.dart';
import 'package:injectable/injectable.dart';

abstract class FirestoreRepository {
  Future<void> addUser(Usuario usuario);
  Future<void> changePassword(String newPassword);
  Future<Usuario?> getUserDetails(String userId);
  Future<void> updateUserDetails(Usuario usuario);
  Future<void> uploadUserImage(String userId, File imageFile);
}

@Injectable(as: FirestoreRepository)
class FirestoreRepositoryImpl implements FirestoreRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  FirestoreRepositoryImpl(this.firestore, this.auth);

  @override
  Future<void> addUser(Usuario usuario) async {
    try {
      await firestore.collection('users').doc(usuario.id).set(usuario.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Usuario?> getUserDetails(String userId) async {
    try {
      final docSnapshot = await firestore.collection('users').doc(userId).get();
      if (docSnapshot.exists) {
        return Usuario.fromJson(docSnapshot.data()!);
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

  @override
  Future<void> updateUserDetails(Usuario usuario) async {
    try {
      await firestore
          .collection('users')
          .doc(usuario.id)
          .update(usuario.toJson());

      User? currentUser = auth.currentUser;
      if (currentUser != null) {
        await currentUser.verifyBeforeUpdateEmail(usuario.email);
        await currentUser.updateProfile(
            displayName: usuario.name, photoURL: usuario.photoURL);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> uploadUserImage(String userId, File imageFile) async {
    try {
      final storageRef = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('user_images/$userId.jpg');

      final uploadTask = await storageRef.putFile(imageFile);
      final snapshot = await uploadTask;

      if (snapshot.state == firebase_storage.TaskState.success) {
        print('Upload bem-sucedido');

        final imageUrl = await storageRef.getDownloadURL();
        print('URL da imagem: $imageUrl');

        await firestore.collection('users').doc(userId).update({
          'photoURL': imageUrl,
        });
        print('URL da imagem atualizada no Firestore');

        User? currentUser = auth.currentUser;
        if (currentUser != null) {
          await currentUser.updateProfile(photoURL: imageUrl);
        }
      } else {
        print('Erro durante o upload: ${snapshot.state}');
      }
    } catch (e) {
      print('Erro ao fazer upload da imagem para o Firebase Storage: $e');
      rethrow;
    }
  }
}

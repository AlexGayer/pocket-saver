import 'dart:io';

import 'package:flutter_pocket_saver/app/data/repository/firebase_repository.dart';
import 'package:flutter_pocket_saver/app/domain/model/usuario.dart';
import 'package:injectable/injectable.dart';

abstract class FirebaseUsecase {
  Future<void> registerUser(Usuario usuario);
  Future<void> updatePassword(String newPassword);
  Future<Usuario?> getUserDetails(String userId);
  Future<void> updateUserDetails(Usuario usuario);
  Future<void> uploadUserImage(String userId, File imageFile);
}

@Injectable(as: FirebaseUsecase)
class FirebaseUsecaseImpl implements FirebaseUsecase {
  final FirestoreRepository firestoreRepository;

  FirebaseUsecaseImpl(this.firestoreRepository);

  @override
  Future<void> registerUser(Usuario usuario) async {
    try {
      await firestoreRepository.addUser(usuario);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    try {
      await firestoreRepository.changePassword(newPassword);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Usuario?> getUserDetails(String userId) async {
    try {
      return await firestoreRepository.getUserDetails(userId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateUserDetails(Usuario usuario) async {
    try {
      await firestoreRepository.updateUserDetails(usuario);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> uploadUserImage(String userId, File imageFile) async {
    try {
      await firestoreRepository.uploadUserImage(userId, imageFile);
    } catch (e) {
      rethrow;
    }
  }
}

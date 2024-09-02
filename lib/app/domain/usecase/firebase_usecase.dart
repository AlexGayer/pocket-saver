import 'package:flutter_pocket_saver/app/data/repository/firebase_repository.dart';
import 'package:injectable/injectable.dart';

abstract class FirebaseUsecase {
  Future<void> registerUser(String userId, String email, String displayName);
  Future<void> updatePassword(String newPassword);
  Future<Map<String, String>?> getUserDetails(String userId);
}

@Injectable(as: FirebaseUsecase)
class FirebaseUsecaseImpl implements FirebaseUsecase {
  final FirestoreRepository firestoreRepository;

  FirebaseUsecaseImpl(this.firestoreRepository);

  @override
  Future<void> registerUser(
      String userId, String email, String displayName) async {
    try {
      await firestoreRepository.addUser(userId, email, displayName);
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
  Future<Map<String, String>?> getUserDetails(String userId) async {
    try {
      return await firestoreRepository.getUserDetails(userId);
    } catch (e) {
      rethrow;
    }
  }
}

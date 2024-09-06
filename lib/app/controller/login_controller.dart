// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, avoid_print, unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/constant/app_shared_preferences.dart';
import 'package:flutter_pocket_saver/app/domain/usecase/firebase_usecase.dart';
import 'package:flutter_pocket_saver/app/constant/dialog_helper.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

@injectable
class LoginController = _LoginControllerrBase with _$LoginController;

abstract class _LoginControllerrBase with Store {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseUsecase _firebaseUsecase;

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final pwdCtrl = TextEditingController();
  final newPwdCtrl = TextEditingController();
  final focusName = FocusNode();
  final focusEmail = FocusNode();
  final focusPwd = FocusNode();
  final focusNewPwd = FocusNode();
  final formKey = GlobalKey<FormState>();
  final handler = AppSharedPreferences();
  final helper = DialogHelper();

  _LoginControllerrBase(this._firebaseUsecase);

  @observable
  bool _loading = false;

  @observable
  bool _firstLogin = false;

  @observable
  String? userPhotoURL;

  @computed
  bool get loading => _loading;

  @computed
  bool get firstLogin => _firstLogin;

  @action
  initState() async {
    _loading = false;
  }

  @action
  Future login(BuildContext context) async {
    try {
      if (formKey.currentState != null && formKey.currentState!.validate()) {
        if (_firstLogin) {
          await _signUp(context);
        } else {
          await _signIn(context);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @action
  Future<void> _signIn(BuildContext context) async {
    _loading = true;

    showMessage(context, "Realizando acesso, aguarde...");

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailCtrl.text, password: pwdCtrl.text);

      Map<String, String>? userDetails =
          await _firebaseUsecase.getUserDetails(userCredential.user!.uid);
      if (userDetails != null) {
        nameCtrl.text = userDetails['displayName'] ?? '';
        emailCtrl.text = userDetails['email'] ?? '';
        userPhotoURL = userDetails['photoURL'] ?? '';
      }

      await saveCampos();

      Navigator.of(context).pushNamed("/home");
    } on FirebaseAuthException catch (e) {
      print(e);
      await helper.showErrorDialog(
          context, "Erro ao fazer login: ${e.message}");
    } finally {
      _loading = false;
    }
  }

  @action
  Future<void> _signUp(BuildContext context) async {
    _loading = true;

    showMessage(context, "Realizando cadastro, aguarde...");

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: emailCtrl.text, password: pwdCtrl.text);

      await userCredential.user!.updateProfile(displayName: nameCtrl.text);

      await _firebaseUsecase.registerUser(
        userCredential.user!.uid,
        emailCtrl.text,
        nameCtrl.text,
        userPhotoURL,
      );

      await saveCampos();

      await helper.showSuccessDialog(
        context,
        "Cadastro realizado com sucesso! Realize o login novamente!",
        onConfirm: () => Navigator.of(context).pushNamed("/login"),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      await helper.showErrorDialog(
          context, "O endereço de e-mail já está sendo usado por outra conta!");
      _loading = false;
    } finally {
      _loading = false;
    }
  }

  @action
  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    _loading = true;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        throw Exception('Login com Google foi cancelado.');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      if (googleAuth.accessToken == null && googleAuth.idToken == null) {
        throw Exception('Falha ao obter accessToken e idToken.');
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential != null) {
        final User? user = userCredential.user;

        if (user != null) {
          nameCtrl.text = user.displayName ?? '';
          emailCtrl.text = user.email ?? '';
          userPhotoURL = user.photoURL ?? '';

          await _firebaseUsecase.registerUser(
            user.uid,
            user.email ?? '',
            user.displayName ?? '',
            userPhotoURL,
          );

          await saveCampos();

          Navigator.of(context).pushNamed('/home');
        }
      }

      return userCredential;
    } on Exception catch (e) {
      print('exception->$e');
      await helper.showErrorDialog(
          context, "Erro ao fazer login com Google: ${e.toString()}");
    } finally {
      _loading = false;
    }
    return null;
  }

  Future<bool> signOutFromGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  @action
  void setFirstLogin(bool firstLog) {
    _firstLogin = firstLog;
  }

  @action
  Future<void> saveCampos() async {
    await handler.savePreferences("name", nameCtrl.text.trim());
    await handler.savePreferences("mail", emailCtrl.text.trim());
    await handler.savePreferences("password", pwdCtrl.text);
    if (userPhotoURL != null) {
      await handler.savePreferences("photoURL", userPhotoURL!);
    }
  }

  showMessage(BuildContext context, String message) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 20),
              Text(message),
            ],
          ),
        );
      },
    );
  }
}

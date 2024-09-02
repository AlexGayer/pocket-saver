// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, avoid_print, unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/constant/app_constants.dart';
import 'package:flutter_pocket_saver/app/constant/app_shared_preferences.dart';
import 'package:flutter_pocket_saver/app/domain/usecase/firebase_usecase.dart';
import 'package:flutter_pocket_saver/app/global/widget/custom_dialog_widget.dart';
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
  final helper = CustomDialogWidget();

  _LoginControllerrBase(this._firebaseUsecase);

  @observable
  bool _loading = false;

  @observable
  bool _firstLogin = false;

  @computed
  bool get loading => _loading;

  @computed
  bool get firstLogin => _firstLogin;

  @action
  initState() async {
    try {
      _loading = false;
    } catch (e) {
      _loading = false;
      e;
    }
  }

  @action
  Future login(BuildContext context) async {
    try {
      if (formKey.currentState != null) {
        if (formKey.currentState!.validate()) {
          if (_firstLogin) {
            await _signUp(context);
          } else {
            await _signIn(context);
          }
        }
      }
    } catch (e) {
      return e;
    }
  }

  @action
  Future<void> _signIn(BuildContext context) async {
    _loading = true;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailCtrl.text, password: pwdCtrl.text);

      Map<String, String>? userDetails =
          await _firebaseUsecase.getUserDetails(userCredential.user!.uid);
      if (userDetails != null) {
        nameCtrl.text = userDetails['displayName'] ?? '';
        emailCtrl.text = userDetails['email'] ?? '';

        String? photoURL = userDetails['photoURL'];
        if (photoURL != null && photoURL.isNotEmpty) {
          await saveCampos(photoURL); // Salva a URL da imagem
        }
      }

      saveCampos();

      Navigator.of(context).pushNamed("/home");
      _loading = false;
    } on FirebaseAuthException catch (e) {
      print(e);
      _loading = false;
      rethrow;
    }
  }

  @action
  Future<void> _signUp(BuildContext context) async {
    _loading = true;
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: emailCtrl.text, password: pwdCtrl.text);

      await userCredential.user!.updateProfile(displayName: nameCtrl.text);

      await _firebaseUsecase.registerUser(
          userCredential.user!.uid, emailCtrl.text, nameCtrl.text);

      await saveCampos();
      _loading = false;

      helper.show(context, "Cadastro realizado com sucesso!",
          func: () => Navigator.of(context).pushNamed("/home"));
    } on FirebaseAuthException catch (e) {
      print(e);

      helper.show(
          context, "O endereço de e-mail já está sendo usado por outra conta !",
          func: () => Navigator.of(context).pushNamed("/home"));

      _loading = false;
      rethrow;
    }
  }

  @action
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential != null) {
        Navigator.of(ctx).pushNamed('/home');
      }

      return userCredential;
    } on Exception catch (e) {
      print('exception->$e');
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
  Future<void> saveCampos([String? photoURL]) async {
    await handler.savePreferences("name", nameCtrl.text.trim());
    await handler.savePreferences("mail", emailCtrl.text.trim());
    await handler.savePreferences("password", pwdCtrl.text);
    if (photoURL != null) {
      await handler.savePreferences("photoURL", photoURL);
    }
  }
}

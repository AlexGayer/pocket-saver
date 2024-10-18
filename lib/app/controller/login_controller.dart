// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, avoid_print, unnecessary_null_comparison

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/constant/app_shared_preferences.dart';
import 'package:flutter_pocket_saver/app/domain/model/usuario.dart';
import 'package:flutter_pocket_saver/app/domain/usecase/busca_cep_usecase.dart';
import 'package:flutter_pocket_saver/app/domain/usecase/firebase_usecase.dart';
import 'package:flutter_pocket_saver/app/constant/dialog_helper.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

@Injectable()
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseUsecase _firebaseUsecase;
  final BuscaCepUseCase _buscaCepUseCase;

  _LoginControllerBase(this._firebaseUsecase, this._buscaCepUseCase);

  final formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final pwdCtrl = TextEditingController();
  final newPwdCtrl = TextEditingController();
  final cityCtrl = TextEditingController();
  final stateCtrl = TextEditingController();
  final birthCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final cepCtrl = TextEditingController();
  final cpfCtrl = TextEditingController();
  final _picker = ImagePicker();

  final helper = DialogHelper();
  final handler = AppSharedPreferences();

  TimeOfDay timeOfDay = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();
  DateTime firstDate = DateTime(1900);
  DateTime lastDate = DateTime(2999);

  @observable
  bool _loading = false;

  @observable
  bool _firstLogin = false;

  @observable
  String userName = "";

  @observable
  String userMail = "";

  @observable
  String userPhotoURL = "";

  @observable
  XFile? pickedImage;

  @computed
  bool get loading => _loading;

  @computed
  bool get firstLogin => _firstLogin;

  @action
  Future<void> initState() async {
    _loading = true;
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final userDetails = await _firebaseUsecase.getUserDetails(user.uid);
        userName = userDetails?.name ?? 'Usuário';
        userPhotoURL = userDetails?.photoURL ?? "";
        userMail = userDetails?.email ?? 'E-mail';
        nameCtrl.text = userName;
        emailCtrl.text = userMail;
        cpfCtrl.text = userDetails?.cpf ?? "";
        cepCtrl.text = userDetails?.cep ?? "";
        cepCtrl.text = userDetails?.cep ?? "";
        cityCtrl.text = userDetails?.city ?? "";
        stateCtrl.text = userDetails?.state ?? "";
        birthCtrl.text = userDetails?.birthDate ?? "";
        phoneCtrl.text = userDetails?.phone ?? "";
      }
    } finally {
      _loading = false;
    }
  }

  @action
  Future<void> searchCep(String cep) async {
    try {
      final resultCep = await _buscaCepUseCase.call(cep);
      cityCtrl.text = resultCep.localidade;
      stateCtrl.text = resultCep.uf;
    } catch (e) {
      print('Erro ao buscar CEP: $e');
    }
  }

  @action
  Future<void> login(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
      _firstLogin ? await _signUp(context) : await _signIn(context);
    }
  }

  @action
  Future<void> _signIn(BuildContext context) async {
    _loading = true;
    try {
      helper.showSuccessDialog(context, "Realizando acesso, aguarde...");
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailCtrl.text,
        password: pwdCtrl.text,
      );

      final userDetails =
          await _firebaseUsecase.getUserDetails(userCredential.user!.uid);
      nameCtrl.text = userDetails?.name ?? '';
      emailCtrl.text = userDetails?.email ?? '';
      userPhotoURL = userDetails?.photoURL ?? '';

      await saveCampos();
      Navigator.of(context).pushNamed("/home");
    } on FirebaseAuthException catch (e) {
      await helper.showErrorDialog(
          context, "Erro ao fazer login: ${e.message}");
    } finally {
      _loading = false;
    }
  }

  @action
  Future<void> _signUp(BuildContext context) async {
    _loading = true;
    try {
      helper.showSimpleMessage(context, "Realizando cadastro, aguarde...");
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailCtrl.text,
        password: pwdCtrl.text,
      );

      await userCredential.user?.updateProfile(displayName: nameCtrl.text);

      final usuario = Usuario(
          id: userCredential.user!.uid,
          name: nameCtrl.text,
          email: emailCtrl.text,
          photoURL: userPhotoURL,
          cpf: "",
          birthDate: "",
          phone: "",
          cep: "",
          state: "",
          city: "");

      await _firebaseUsecase.registerUser(usuario);

      await saveCampos();
      await helper.showSuccessDialog(
          context, "Cadastro realizado com sucesso!");
      Navigator.of(context).pushNamed("/home");
    } on FirebaseAuthException catch (e) {
      await helper.showErrorDialog(
        context,
        "Erro ao criar conta: ${e.message}",
      );
    } finally {
      _loading = false;
    }
  }

  @action
  Future<void> signInWithGoogle(BuildContext context) async {
    _loading = true;
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) throw Exception('Login cancelado.');

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      final user = userCredential.user;
      if (user != null) {
        nameCtrl.text = user.displayName ?? '';
        emailCtrl.text = user.email ?? '';
        userPhotoURL = user.photoURL ?? '';

        final usuario = Usuario(
          id: user.uid,
          name: user.displayName ?? '',
          email: user.email ?? '',
          photoURL: user.photoURL,
          cpf: "",
          birthDate: "",
          phone: "",
          cep: "",
          state: "",
          city: "",
        );

        await _firebaseUsecase.registerUser(usuario);

        await saveCampos();
        Navigator.of(context).pushNamed('/home');
      }
    } on Exception catch (e) {
      await helper.showErrorDialog(
          context, "Erro ao fazer login com Google: $e");
    } finally {
      _loading = false;
    }
  }

  @action
  Future<void> saveCampos() async {
    await handler.savePreferences("name", nameCtrl.text.trim());
    await handler.savePreferences("mail", emailCtrl.text.trim());
    await handler.savePreferences("password", pwdCtrl.text.trim());
    if (userPhotoURL.isNotEmpty) {
      await handler.savePreferences("photoURL", userPhotoURL);
    }
  }

  @action
  Future<void> logout(BuildContext context) async {
    await _auth.signOut();
    await handler.clearPreferences();
    Navigator.of(context).pushNamedAndRemoveUntil("/index", (route) => false);
  }

  @action
  Future<void> updateUserDetails(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        _loading = true;
        final user = _auth.currentUser;
        if (user != null) {
          user.updateProfile(displayName: nameCtrl.text.trim());
          user.verifyBeforeUpdateEmail(emailCtrl.text.trim());

          final usuario = Usuario(
            id: user.uid,
            name: nameCtrl.text.trim(),
            email: emailCtrl.text.trim(),
            photoURL: user.photoURL,
            cpf: cpfCtrl.text.trim(),
            birthDate: birthCtrl.text.trim(),
            phone: phoneCtrl.text.trim(),
            cep: cepCtrl.text.trim(),
            state: stateCtrl.text.trim(),
            city: cityCtrl.text.trim(),
          );

          await _firebaseUsecase.updateUserDetails(usuario);

          await helper.showSuccessDialog(
              context, "Dados atualizados com sucesso!");
        }
      } catch (e) {
        await helper.showErrorDialog(context, "Erro ao atualizar dados: $e");
      } finally {
        _loading = false;
      }
    }
  }

  @action
  void setFirstLogin(bool firstLog) {
    _firstLogin = firstLog;
  }

  @action
  Future datePicker(BuildContext context) async {
    final DateTime? datePicked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) => Theme(
        data: ThemeData(timePickerTheme: Theme.of(context).timePickerTheme),
        child: child!,
      ),
    );

    if (datePicked != null && datePicked != selectedDate) {
      selectedDate = datePicked;
      birthCtrl.text = toBRDt(selectedDate);
    }
  }

  @action
  Future<void> getImageGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedImage = XFile(pickedFile.path);
      print('Imagem da galeria selecionada: ${pickedImage!.path}');
    } else {
      print('Nenhuma imagem selecionada.');
    }
  }

  @action
  Future<void> getImageCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      pickedImage = XFile(pickedFile.path);
      print('Imagem da câmera selecionada: ${pickedImage!.path}');
    } else {
      print('Nenhuma imagem selecionada.');
    }
  }

  @action
  Future<void> uploadImageToFirebase() async {
    try {
      if (pickedImage != null) {
        _loading = true;

        // Upload da imagem usando o repositório
        await _firebaseUsecase.uploadUserImage(
          _auth.currentUser!.uid,
          File(pickedImage!.path),
        );

        _loading = false;
      }
    } catch (e) {
      print('Erro ao enviar imagem para o Firebase Storage: $e');
      _loading = false;
    }
  }

  @action
  toBRDt(DateTime? date) {
    if (date != null) {
      final day = date.day.toString();
      final month = date.month.toString();
      final year = date.year.toString();
      return "${day.padLeft(2, "0")}/${month.padLeft(2, "0")}/$year";
    }
    return "";
  }
}

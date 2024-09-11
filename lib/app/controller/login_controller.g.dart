// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginController on _LoginControllerBase, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: '_LoginControllerBase.loading'))
      .value;
  Computed<bool>? _$firstLoginComputed;

  @override
  bool get firstLogin =>
      (_$firstLoginComputed ??= Computed<bool>(() => super.firstLogin,
              name: '_LoginControllerBase.firstLogin'))
          .value;

  late final _$_loadingAtom =
      Atom(name: '_LoginControllerBase._loading', context: context);

  @override
  bool get _loading {
    _$_loadingAtom.reportRead();
    return super._loading;
  }

  @override
  set _loading(bool value) {
    _$_loadingAtom.reportWrite(value, super._loading, () {
      super._loading = value;
    });
  }

  late final _$_firstLoginAtom =
      Atom(name: '_LoginControllerBase._firstLogin', context: context);

  @override
  bool get _firstLogin {
    _$_firstLoginAtom.reportRead();
    return super._firstLogin;
  }

  @override
  set _firstLogin(bool value) {
    _$_firstLoginAtom.reportWrite(value, super._firstLogin, () {
      super._firstLogin = value;
    });
  }

  late final _$userNameAtom =
      Atom(name: '_LoginControllerBase.userName', context: context);

  @override
  String get userName {
    _$userNameAtom.reportRead();
    return super.userName;
  }

  @override
  set userName(String value) {
    _$userNameAtom.reportWrite(value, super.userName, () {
      super.userName = value;
    });
  }

  late final _$userMailAtom =
      Atom(name: '_LoginControllerBase.userMail', context: context);

  @override
  String get userMail {
    _$userMailAtom.reportRead();
    return super.userMail;
  }

  @override
  set userMail(String value) {
    _$userMailAtom.reportWrite(value, super.userMail, () {
      super.userMail = value;
    });
  }

  late final _$userPhotoURLAtom =
      Atom(name: '_LoginControllerBase.userPhotoURL', context: context);

  @override
  String get userPhotoURL {
    _$userPhotoURLAtom.reportRead();
    return super.userPhotoURL;
  }

  @override
  set userPhotoURL(String value) {
    _$userPhotoURLAtom.reportWrite(value, super.userPhotoURL, () {
      super.userPhotoURL = value;
    });
  }

  late final _$pickedImageAtom =
      Atom(name: '_LoginControllerBase.pickedImage', context: context);

  @override
  XFile? get pickedImage {
    _$pickedImageAtom.reportRead();
    return super.pickedImage;
  }

  @override
  set pickedImage(XFile? value) {
    _$pickedImageAtom.reportWrite(value, super.pickedImage, () {
      super.pickedImage = value;
    });
  }

  late final _$initStateAsyncAction =
      AsyncAction('_LoginControllerBase.initState', context: context);

  @override
  Future<void> initState() {
    return _$initStateAsyncAction.run(() => super.initState());
  }

  late final _$searchCepAsyncAction =
      AsyncAction('_LoginControllerBase.searchCep', context: context);

  @override
  Future<void> searchCep(String cep) {
    return _$searchCepAsyncAction.run(() => super.searchCep(cep));
  }

  late final _$loginAsyncAction =
      AsyncAction('_LoginControllerBase.login', context: context);

  @override
  Future<void> login(BuildContext context) {
    return _$loginAsyncAction.run(() => super.login(context));
  }

  late final _$_signInAsyncAction =
      AsyncAction('_LoginControllerBase._signIn', context: context);

  @override
  Future<void> _signIn(BuildContext context) {
    return _$_signInAsyncAction.run(() => super._signIn(context));
  }

  late final _$_signUpAsyncAction =
      AsyncAction('_LoginControllerBase._signUp', context: context);

  @override
  Future<void> _signUp(BuildContext context) {
    return _$_signUpAsyncAction.run(() => super._signUp(context));
  }

  late final _$signInWithGoogleAsyncAction =
      AsyncAction('_LoginControllerBase.signInWithGoogle', context: context);

  @override
  Future<void> signInWithGoogle(BuildContext context) {
    return _$signInWithGoogleAsyncAction
        .run(() => super.signInWithGoogle(context));
  }

  late final _$saveCamposAsyncAction =
      AsyncAction('_LoginControllerBase.saveCampos', context: context);

  @override
  Future<void> saveCampos() {
    return _$saveCamposAsyncAction.run(() => super.saveCampos());
  }

  late final _$logoutAsyncAction =
      AsyncAction('_LoginControllerBase.logout', context: context);

  @override
  Future<void> logout(BuildContext context) {
    return _$logoutAsyncAction.run(() => super.logout(context));
  }

  late final _$updateUserDetailsAsyncAction =
      AsyncAction('_LoginControllerBase.updateUserDetails', context: context);

  @override
  Future<void> updateUserDetails(BuildContext context) {
    return _$updateUserDetailsAsyncAction
        .run(() => super.updateUserDetails(context));
  }

  late final _$datePickerAsyncAction =
      AsyncAction('_LoginControllerBase.datePicker', context: context);

  @override
  Future<dynamic> datePicker(BuildContext context) {
    return _$datePickerAsyncAction.run(() => super.datePicker(context));
  }

  late final _$getImageGalleryAsyncAction =
      AsyncAction('_LoginControllerBase.getImageGallery', context: context);

  @override
  Future<void> getImageGallery() {
    return _$getImageGalleryAsyncAction.run(() => super.getImageGallery());
  }

  late final _$getImageCameraAsyncAction =
      AsyncAction('_LoginControllerBase.getImageCamera', context: context);

  @override
  Future<void> getImageCamera() {
    return _$getImageCameraAsyncAction.run(() => super.getImageCamera());
  }

  late final _$uploadImageToFirebaseAsyncAction = AsyncAction(
      '_LoginControllerBase.uploadImageToFirebase',
      context: context);

  @override
  Future<void> uploadImageToFirebase() {
    return _$uploadImageToFirebaseAsyncAction
        .run(() => super.uploadImageToFirebase());
  }

  late final _$_LoginControllerBaseActionController =
      ActionController(name: '_LoginControllerBase', context: context);

  @override
  void setFirstLogin(bool firstLog) {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction(
        name: '_LoginControllerBase.setFirstLogin');
    try {
      return super.setFirstLogin(firstLog);
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic toBRDt(DateTime? date) {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction(
        name: '_LoginControllerBase.toBRDt');
    try {
      return super.toBRDt(date);
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userName: ${userName},
userMail: ${userMail},
userPhotoURL: ${userPhotoURL},
pickedImage: ${pickedImage},
loading: ${loading},
firstLogin: ${firstLogin}
    ''';
  }
}

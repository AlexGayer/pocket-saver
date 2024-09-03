// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginController on _LoginControllerrBase, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: '_LoginControllerrBase.loading'))
      .value;
  Computed<bool>? _$firstLoginComputed;

  @override
  bool get firstLogin =>
      (_$firstLoginComputed ??= Computed<bool>(() => super.firstLogin,
              name: '_LoginControllerrBase.firstLogin'))
          .value;

  late final _$_loadingAtom =
      Atom(name: '_LoginControllerrBase._loading', context: context);

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
      Atom(name: '_LoginControllerrBase._firstLogin', context: context);

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

  late final _$userPhotoURLAtom =
      Atom(name: '_LoginControllerrBase.userPhotoURL', context: context);

  @override
  String? get userPhotoURL {
    _$userPhotoURLAtom.reportRead();
    return super.userPhotoURL;
  }

  @override
  set userPhotoURL(String? value) {
    _$userPhotoURLAtom.reportWrite(value, super.userPhotoURL, () {
      super.userPhotoURL = value;
    });
  }

  late final _$initStateAsyncAction =
      AsyncAction('_LoginControllerrBase.initState', context: context);

  @override
  Future initState() {
    return _$initStateAsyncAction.run(() => super.initState());
  }

  late final _$loginAsyncAction =
      AsyncAction('_LoginControllerrBase.login', context: context);

  @override
  Future<dynamic> login(BuildContext context) {
    return _$loginAsyncAction.run(() => super.login(context));
  }

  late final _$_signInAsyncAction =
      AsyncAction('_LoginControllerrBase._signIn', context: context);

  @override
  Future<void> _signIn(BuildContext context) {
    return _$_signInAsyncAction.run(() => super._signIn(context));
  }

  late final _$_signUpAsyncAction =
      AsyncAction('_LoginControllerrBase._signUp', context: context);

  @override
  Future<void> _signUp(BuildContext context) {
    return _$_signUpAsyncAction.run(() => super._signUp(context));
  }

  late final _$signInWithGoogleAsyncAction =
      AsyncAction('_LoginControllerrBase.signInWithGoogle', context: context);

  @override
  Future<UserCredential?> signInWithGoogle(BuildContext context) {
    return _$signInWithGoogleAsyncAction
        .run(() => super.signInWithGoogle(context));
  }

  late final _$saveCamposAsyncAction =
      AsyncAction('_LoginControllerrBase.saveCampos', context: context);

  @override
  Future<void> saveCampos() {
    return _$saveCamposAsyncAction.run(() => super.saveCampos());
  }

  late final _$_LoginControllerrBaseActionController =
      ActionController(name: '_LoginControllerrBase', context: context);

  @override
  void setFirstLogin(bool firstLog) {
    final _$actionInfo = _$_LoginControllerrBaseActionController.startAction(
        name: '_LoginControllerrBase.setFirstLogin');
    try {
      return super.setFirstLogin(firstLog);
    } finally {
      _$_LoginControllerrBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userPhotoURL: ${userPhotoURL},
loading: ${loading},
firstLogin: ${firstLogin}
    ''';
  }
}

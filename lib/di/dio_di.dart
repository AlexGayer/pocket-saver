// ignore_for_file: unrelated_type_equality_checks, use_build_context_synchronously

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_pocket_saver/app/constant/app_constants.dart';
import 'package:flutter_pocket_saver/app/constant/dialog_helper.dart';
import 'package:flutter_pocket_saver/app/constant/error_heldper.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioDi {
  final options = BaseOptions(
    baseUrl: '',
    headers: {"accept": "application/json"},
    followRedirects: false,
    validateStatus: (status) {
      return status! < 500;
    },
  );

  @lazySingleton
  Dio dio() {
    final dio = Dio(options);
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          handler.next(options);
        },
        onError: (error, handler) async {
          final dialog = DialogHelper();

          if (error.response == null || error.response!.data == null) {
            dialog.showErrorDialog(
              ctx,
              "Acesso Inválido! Verifique seu usuário ou senha!",
            );
          } else {
            try {
              final responseData = error.response!.data.toString();

              final decodedData = json.decode(responseData);
              final errorCGI = ErrorHeldper(decodedData);
              final retorno = await errorCGI.validaErro();

              dialog.showErrorDialog(ctx, retorno.mensagem);
            } catch (e) {
              dialog.showErrorDialog(
                  ctx, "Erro ao processar resposta do servidor");
            }
          }

          handler.reject(error);
        },
      ),
    );

    return dio;
  }
}

// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

class ErrorHeldper {
  var result;

  ErrorHeldper(this.result);

  Future<Retorno> validaErro() async {
    if (result == 'OK') {
      return Retorno(false, "Não foi encontrado erro");
    }

    if (result ==
        'Não foi possivel verificar as permissões de acesso junto aos servidores da CGI. Verifique o código de acesso nas configurações !') {
      return Retorno(true, result);
    }

    if (result == '') {
      return Retorno(true, "Nada retornou do servidor");
    }

    if (result is String) {
      try {
        final jsonResult = jsonDecode(result);
        if (jsonResult is Map<String, dynamic>) {
          return handleJsonError(jsonResult);
        }
      } catch (e) {
        // Não é um JSON válido, então continue com as outras verificações
      }
    }

    if (result is Map<String, dynamic>) {
      if (result.containsKey('message')) {
        return Retorno(true, "Código de acesso inválido !");
      }

      if (result.containsKey('logErroApp')) {
        final errorList = result['logErroApp'];
        if (errorList is List && errorList.isNotEmpty) {
          final logErroApp = errorList[0]['erro'].toString();
          final parser = ErrorMessageParser(logErroApp);

          if (parser.containsFre001p()) {
            final parsedMessage = parser.parseMessage();
            if (parsedMessage.isNotEmpty) {
              final errorMessage =
                  "Programa: ${parsedMessage['program']}\nMétodo: ${parsedMessage['method']}\nMensagem: ${parsedMessage['message']}";
              return Retorno(true, errorMessage);
            } else {
              return Retorno(true, "Formato de mensagem inesperado");
            }
          } else {
            return Retorno(true, logErroApp);
          }
        } else {
          return Retorno(true, "Erro desconhecido");
        }
      }

      return Retorno(true, "Erro desconhecido");
    }

    return Retorno(true, "Erro desconhecido");
  }

  Retorno handleJsonError(Map<String, dynamic> jsonResult) {
    if (jsonResult.containsKey('posicao')) {
      final posicao = jsonResult['posicao'];
      if (posicao is Map<String, dynamic>) {
        final nomeMotorista =
            posicao['nome_motorista'] ?? 'Nome do motorista não encontrado';
        final observacao = posicao['observacao'] ?? 'Observação não encontrada';
        final errorMessage =
            "Motorista: $nomeMotorista\nObservação: $observacao";
        return Retorno(true, errorMessage);
      }
    }

    return Retorno(true, "Erro desconhecido no formato JSON");
  }
}

class Retorno {
  bool erro;
  String mensagem;

  Retorno(this.erro, this.mensagem);
}

class ErrorMessageParser {
  final String rawMessage;

  ErrorMessageParser(this.rawMessage);

  bool containsFre001p() {
    return rawMessage.contains("fretes/fre001p_v2.r");
  }

  Map<String, String> parseMessage() {
    final startIndex = rawMessage.indexOf("fretes/fre001p_v2.r");
    if (startIndex == -1) {
      return {};
    }

    final fullMessage = rawMessage.substring(startIndex);
    final parts = fullMessage.split("");

    if (parts.length != 2) {
      return {};
    }

    final methodName = parts[0].substring(parts[0].indexOf('(')).trim();
    final errorMessage = parts[1].trim();

    return {
      'program': 'fretes/fre001p_v2.r',
      'method': methodName,
      'message': errorMessage,
    };
  }
}

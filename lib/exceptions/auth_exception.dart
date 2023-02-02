class AuthException implements Exception {
  static const Map<String, String> errors = {
    'EMAIL_EXISTS': 'Email ja cadastrado.',
    'INVALID_PASSWORD': 'Senha informada não confere.',
    'USER_DISABLED': 'A conta do usuário foi desabilitada.',
    'OPERATION_NOT_ALLOWED': 'Operação não permitida!',
    'EMAIL_NOT_FOUND': 'Email não encontrado.',
    'TOO_MANY_ATTEMPTS_TRY_LATER':
        'Acesso bloqueado temporariamente. Tente mais tarde.',
  };
  final String key;
  AuthException(this.key);

  @override
  String toString() {
    return errors[key] ?? 'Ocorreu um erro no processo de autenticação';
  }
}

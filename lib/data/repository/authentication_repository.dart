import 'package:dartz/dartz.dart';

import '/di/di.dart';
import '/utility/api_exeption.dart';
import '/utility/auth_manager.dart';
import '/data/datasource/authentication_datasource.dart';

abstract class IAuthenticationRepositiry {
  Future<Either<String, String>> register(
    String username,
    String password,
    String passwordConfirm,
  );

  Future<Either<String, String>> login(String username, String password);
}

class AuthenticationRepository implements IAuthenticationRepositiry {
  final IAuthenticationDataSource _datasource = locator.get();

  @override
  Future<Either<String, String>> register(
    String username,
    String password,
    String passwordConfirm,
  ) async {
    try {
      await _datasource.register(username, password, passwordConfirm);
      return right('ثبت نام انجام شد');
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, String>> login(String username, String password) async {
    try {
      String token = await _datasource.login(username, password);
      if (token.isNotEmpty) {
        AuthManager.saveToken(token);
        return right('شما با موفقیت وارد شدید!');
      } else {
        return left('خطایی در ورود پیش آمده!');
      }
    } on ApiExeption catch (e) {
      return left(e.message.toString());
    }
  }
}

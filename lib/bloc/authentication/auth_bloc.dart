import 'package:bloc/bloc.dart';

import '/di/di.dart';
import '/bloc/authentication/auth_event.dart';
import '/bloc/authentication/auth_state.dart';
import '/data/repository/authentication_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthenticationRepositiry _repositiry = locator.get();
  AuthBloc() : super(AuthInitiateState()) {
    on<AuthLoginRequest>((event, emit) async {
      emit(AuthLoadingState());
      var response = await _repositiry.login(event.username, event.password);
      emit(AuthResponseState(response));
    });
  }
}

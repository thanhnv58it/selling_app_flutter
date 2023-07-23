import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:selling_app/config/storage.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(Uninitialized()) {
    on<AppStarted>(onAppStarted);
    on<LoggedIn>(onLoggedIn);
    on<LoggedOut>(onLoggedOut);
  }

  Future<void> onAppStarted(
      AppStarted event, Emitter<AuthenticationState> emit) async {
    var token = await _getToken();
    if (token != '') {
      Storage().token = token;
      emit(Authenticated());
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> onLoggedIn(
      LoggedIn event, Emitter<AuthenticationState> emit) async {
    Storage().token = event.token;
    await _saveToken(event.token);
    emit(Authenticated());
  }

  Future<void> onLoggedOut(
      LoggedOut event, Emitter<AuthenticationState> emit) async {
    Storage().token = '';
    await _deleteToken();
    emit(Unauthenticated());
  }

  /// delete from keystore/keychain
  Future<void> _deleteToken() async {
    await Storage().secureStorage.delete(key: 'access_token');
  }

  /// write to keystore/keychain
  Future<void> _saveToken(String token) async {
    await Storage().secureStorage.write(key: 'access_token', value: token);
  }

  /// read to keystore/keychain
  Future<String> _getToken() async {
    return await Storage().secureStorage.read(key: 'access_token') ?? '';
  }
}

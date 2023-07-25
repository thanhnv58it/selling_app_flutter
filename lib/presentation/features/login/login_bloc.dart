import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:selling_app/data/repositories/abstract/user_repository.dart';
import 'package:selling_app/presentation/features/authentication/authentication_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;
  LoginBloc({
    required this.userRepository,
    required this.authenticationBloc,
  }) : super(LoginInitial()) {
    on<LoginPressedEvent>(loginPressed);
  }

  Future<void> loginPressed(
      LoginPressedEvent event, Emitter<LoginState> emit) async {
    emit(LoginProcessingState());
    try {
      var result = await userRepository.signIn(
        email: event.email,
        password: event.password,
      );
      authenticationBloc.add(LoggedIn(result.token));
      emit(LoginFinishedState());
    } catch (error) {
      emit(LoginErrorState(error.toString()));
    }
  }
}

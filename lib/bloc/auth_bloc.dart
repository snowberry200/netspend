import 'package:netspend/bloc/auth_event.dart';
import 'package:netspend/bloc/auth_state.dart';
import 'package:netspend/database/database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Database database;

  AuthBloc({required this.database}) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<SignUpRequested>(_onSignUpRequested);
    on<CheckBoxEvent>(_onCheckBoxState);
    on<SwapEvent>(_onSwapEvent);
  }

  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final db = Database();
      await db.getInfo(event.email, event.password);
      emit(Authenticated(email: event.email, password: event.password));
    } catch (e) {
      emit(Unauthenticated(e.toString()));
    }
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final userId = await database
          .getInfo('', '')
          .then((data) => data['userName'] as String?);
      if (userId != null) {
        emit(const Authenticated(email: '', password: ''));
      } else {
        emit(const Unauthenticated('User not authenticated'));
      }
    } catch (e) {
      emit(Unauthenticated(e.toString()));
    }
  }

  Future<void> _onSignUpRequested(
      SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await database.signUp(
          name: event.name, username: event.email, pass: event.password);
      emit(SignUpSuccess(
          email: event.email, name: event.name, password: event.password));
    } catch (e) {
      emit(AuthError('Sign up failed: ${e.toString()}'));
    }
  }

  Future<void> _onCheckBoxState(
      CheckBoxEvent event, Emitter<AuthState> emit) async {
    try {
      emit(CheckBoxState(isChecked: event.isChecked));
    } catch (e) {
      emit(AuthError('Checkbox state error: ${e.toString()}'));
    }
  }

  Future<void> _onSwapEvent(SwapEvent event, Emitter<AuthState> emit) async {
    emit(SwapState(isSignInMode: !state.isSignedIn));
  }
}

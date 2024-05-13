import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';

import 'package:formz/formz.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository _authenticationRepository;

  LoginCubit(this._authenticationRepository) : super(const LoginState());

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.password]),
      ),
    );
  }

  void otpChanged(String value) {
    final otp = OTP.dirty(value);
    emit(
      state.copyWith(
        otp: otp,
        isValid: Formz.validate([otp]),
      ),
    );
  }

  void phoneChanged(String value) {
    final phone = Phone.dirty(value);
    emit(
      state.copyWith(
        phone: phone,
        isValid: Formz.validate([state.phone]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.email, password]),
      ),
    );
  }

  Future<void> logInWithCredentials() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _authenticationRepository.logInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzSubmissionStatus.failure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  Future<void> logInWithPhone() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _authenticationRepository.logInWithPhoneNumber(
        phone: state.phone.value,
      );
      await Future.delayed(const Duration(seconds: 3));
      emit(state.copyWith(status: FormzSubmissionStatus.success, isSend: true));
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          status: FormzSubmissionStatus.failure,
        ),
      );
    }
  }

  Future<void> verifyOTPCode() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _authenticationRepository.logInWithPhoneNumber(
        phone: state.phone.value,
        otp: state.otp.value,
      );
      await Future.delayed(const Duration(seconds: 4));
      emit(state.copyWith(status: FormzSubmissionStatus.success, isSend: true));
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          status: FormzSubmissionStatus.failure,
        ),
      );
    }
  }
}

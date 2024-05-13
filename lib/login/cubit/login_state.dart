part of 'login_cubit.dart';

final class LoginState extends Equatable {
  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.isSend = false,
    this.otp = const OTP.pure(),
    this.errorMessage,
    this.phone = const Phone.pure(),
  });

  final Email email;
  final Password password;
  final Phone phone;
  final OTP otp;
  final FormzSubmissionStatus status;
  final bool isValid;
  final bool isSend;
  final String? errorMessage;

  @override
  List<Object?> get props =>
      [email, password, phone, status, isValid, isSend, errorMessage, otp];

  LoginState copyWith({
    Email? email,
    Password? password,
    Phone? phone,
    OTP? otp,
    FormzSubmissionStatus? status,
    bool? isValid,
    bool? isSend,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      phone: phone ?? this.phone,
      otp: otp ?? this.otp,
      isValid: isValid ?? this.isValid,
      isSend: isSend ?? this.isSend,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

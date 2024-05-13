import 'package:formz/formz.dart';

/// Validation errors for the [Email] [FormzInput].
enum OTPValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template email}
/// Form input for an email input.
/// {@endtemplate}
class OTP extends FormzInput<String, OTPValidationError> {
  /// {@macro OTP}
  const OTP.pure() : super.pure('');

  /// {@macro OTP}
  const OTP.dirty([super.value = '']) : super.dirty();

  static final RegExp _phoneRegExp = RegExp(
    r'^[0-9]{6}',
  );
  @override
  OTPValidationError? validator(String? value) {
    return _phoneRegExp.hasMatch(value ?? '')
        ? null
        : OTPValidationError.invalid;
  }
}

import 'package:formz/formz.dart';

/// Validation errors for the [Email] [FormzInput].
enum PhoneValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template email}
/// Form input for an email input.
/// {@endtemplate}
class Phone extends FormzInput<String, PhoneValidationError> {
  /// {@macro Phone}
  const Phone.pure() : super.pure('');

  /// {@macro Phone}
  const Phone.dirty([super.value = '']) : super.dirty();

  static final RegExp _phoneRegExp = RegExp(
    r'^[\+][0-9]{3}[\s]?[0-9]{7,8}$',
  );
  @override
  PhoneValidationError? validator(String? value) {
    return _phoneRegExp.hasMatch(value ?? '')
        ? null
        : PhoneValidationError.invalid;
  }
}

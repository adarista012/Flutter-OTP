import 'package:firebase_bloc/login/cubit/login_cubit.dart';
import 'package:firebase_bloc/sign_up/view/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/bloc_logo_small.png',
                height: 120,
              ),
              BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
                return Column(
                  children: [
                    state.isSend ? _OTPInput() : _PhoneInput(),
                    const SizedBox(height: 8),
                    state.isSend ? _VerifyOTPButton() : _LoginWithPhoneButton(),
                    const SizedBox(height: 4),
                  ],
                );
              }),
              // context.read<LoginState>().isSend ? _OTPInput() : _PhoneInput(),
              // const SizedBox(height: 8),
              // context.read<LoginState>().isSend
              //     ? _VerifyOTPButton()
              //     : _LoginWithPhoneButton(),
              // const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}

class _PhoneInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.phone != current.phone,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_phoneInput_textField'),
          onChanged: (phone) => context.read<LoginCubit>().phoneChanged(phone),
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: 'phone',
            helperText: '',
            errorText:
                state.phone.displayError != null ? 'invalid Phone' : null,
          ),
        );
      },
    );
  }
}

class _OTPInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.phone != current.phone,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_otpCode_textField'),
          onChanged: (otp) => context.read<LoginCubit>().otpChanged(otp),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'OTP Code',
            helperText: '',
            errorText: state.phone.displayError != null ? 'invalid' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'password',
            helperText: '',
            errorText:
                state.password.displayError != null ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: const Color(0xFFFFD600),
                ),
                onPressed: state.isValid
                    ? () => context.read<LoginCubit>().logInWithCredentials()
                    : null,
                child: const Text('LOGIN'),
              );
      },
    );
  }
}

class _LoginWithPhoneButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('login_with_phone'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: const Color(0xFFFFD600),
                ),
                onPressed: state.isValid
                    ? () => context.read<LoginCubit>().logInWithPhone()
                    : null,
                child: const Text('LOGIN WITH PHONE'),
              );
      },
    );
  }
}

class _VerifyOTPButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('verify_otp_code'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: const Color(0xFFFFD600),
                ),
                onPressed: state.isValid
                    ? () => context.read<LoginCubit>().verifyOTPCode()
                    : null,
                child: const Text('VERIFY OTP CODE'),
              );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      key: const Key('loginForm_createAccount_flatButton'),
      onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
      child: Text(
        'CREATE ACCOUNT',
        style: TextStyle(color: theme.primaryColor),
      ),
    );
  }
}

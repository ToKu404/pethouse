import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth_cubit/auth_cubit.dart';
import '../../blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../blocs/sign_up_bloc/sign_up_bloc.dart';
import '../../widgets/border_button.dart';
import '../../widgets/gradient_button.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SignUpBloc>(context).add(SignUpInit());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SignUpBloc, SignUpValidate>(
          listener: ((context, state) {
            if (state.errorMessage.isNotEmpty) {
              showDialog(
                  context: context,
                  builder: (context) =>
                      ErrorDialog(errorMessage: state.errorMessage));
            } else if (state.isFormValid && !state.isLoading) {
              context.read<AuthCubit>().loggedIn();
            } else if (state.isFormValidateFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Please fill the data correctly!"),
                ),
              );
            }
          }),
        ),
        BlocListener<SignInBloc, SignInValidate>(
          listener: ((context, state) {
            if (state.isFormValid && !state.isLoading) {
              context.read<AuthCubit>().loggedIn();
            }
          }),
        ),
        BlocListener<AuthCubit, AuthState>(listener: ((context, state) {
          if (state is Authenticated) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                "main-page", (route) => false,
                arguments: state.uid);
          }
        })),
      ],
      child: const Scaffold(
        body: SafeArea(child: RegisterForm()),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(kMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                "REGISTER",
                textAlign: TextAlign.center,
                style: kTextTheme.headline4,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const _NameField(),
            const SizedBox(
              height: 10,
            ),
            const _EmailField(),
            const SizedBox(
              height: 10,
            ),
            const _PasswordField(),
            const SizedBox(
              height: 10,
            ),
            const _ConfirmPasswordField(),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<SignUpBloc, SignUpValidate>(
              builder: ((context, state) {
                return GradientButton(
                    height: 50,
                    width: double.infinity,
                    isClicked: state.isFormValid,
                    onTap: !state.isFormValid
                        ? () async =>
                            context.read<SignUpBloc>().add(SubmitSignUp())
                        : null,
                    text: 'Create Account');
              }),
            ),
            const SizedBox(
              height: 10,
            ),
            BorderIconButton(
              height: 50,
              width: double.infinity,
              onTap: () async {
                BlocProvider.of<SignInBloc>(context).add(SubmitSignInGoogle());
              },
              text: 'Continue with google',
              iconPath: "assets/icons/icon_google.svg",
            ),
            const SizedBox(
              height: 19,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have Account?'),
                SizedBox(
                  width: 4,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, LOGIN_ROUTE_NAME);
                  },
                  child: const Text('Log In',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: kPrimaryColor)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpValidate>(
      builder: (context, state) {
        return TextFormField(
          onChanged: (value) {
            context.read<SignUpBloc>().add(RegisterEmailChanged(value));
          },
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            helperText: 'A complete, valid email e.g. joe@gmail.com',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kPrimaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            errorText: !state.isEmailValid
                ? 'Please ensure the email entered is valid'
                : null,
            labelText: 'Email',
          ),
        );
      },
    );
  }
}

class _NameField extends StatelessWidget {
  const _NameField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpValidate>(
      builder: (context, state) {
        return TextFormField(
          onChanged: (value) {
            context.read<SignUpBloc>().add(NameChanged(value));
          },
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            helperText: 'This field should be fill',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kPrimaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            errorText: !state.isNameValid
                ? 'Please ensure the name entered is valid'
                : null,
            labelText: 'Name',
          ),
        );
      },
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpValidate>(
      builder: (context, state) {
        return TextField(
          onChanged: (value) {
            context.read<SignUpBloc>().add(RegisterPasswordChanged(value));
          },
          obscureText: !state.isPasswordVisible,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () async {
                print(state.isPasswordVisible);
                context.read<SignUpBloc>().add(RegisterShowHidePasswordPress());
              },
              icon: Icon(
                !state.isPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: Colors.grey,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kPrimaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            labelText: "Password",
            helperText:
                '''Password should be at least 8 characters with at least one letter and number''',
            helperMaxLines: 2,
            errorMaxLines: 2,
            errorText: !state.isPasswordValid
                ? '''Password must be at least 8 characters and contain at least one letter and number'''
                : null,
          ),
        );
      },
    );
  }
}

class _ConfirmPasswordField extends StatelessWidget {
  const _ConfirmPasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpValidate>(
      builder: (context, state) {
        return TextField(
          onChanged: (value) {
            context.read<SignUpBloc>().add(ConfirmPasswordChanged(value));
          },
          obscureText: !state.isConfirmPasswordVisible,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () async {
                context.read<SignUpBloc>().add(ShowHideConfirmPasswordPress());
              },
              icon: Icon(
                !state.isConfirmPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: Colors.grey,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kPrimaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            labelText: "Confirm Password",
            helperText: '''Rewrite your password''',
            helperMaxLines: 2,
            errorMaxLines: 2,
            errorText: !state.isConfirmPasswordValid
                ? '''Confirm Password should be same with password field'''
                : null,
          ),
        );
      },
    );
  }
}

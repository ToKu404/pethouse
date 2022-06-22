import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../blocs/auth_cubit/auth_cubit.dart';
import '../../blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../widgets/border_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SignInBloc>(context).add(SignInInit());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(listeners: [
      BlocListener<SignInBloc, SignInValidate>(listener: (context, state) {
        if (state.errorMessage.isNotEmpty) {
          showDialog(
            context: context,
            builder: (context) => ErrorDialog(
              errorMessage: state.errorMessage,
            ),
          );
        } else if (state.isFormValid && !state.isLoading) {
          context.read<AuthCubit>().loggedIn();
        } else if (state.isFormValidateFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Please fill the data correctly!")));
        }
      }),
      BlocListener<AuthCubit, AuthState>(
        listener: ((context, state) {
          if (state is Authenticated) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                MAIN_ROUTE_NAME, (route) => false,
                arguments: state.uid);
          }
        }),
      ),
    ], child: const Scaffold(body: SafeArea(child: LoginForm())));
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(kMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            SvgPicture.asset(
              "assets/icons/pethouse_icon.svg",
              color: kPrimaryColor,
              height: 50,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                "Login",
                textAlign: TextAlign.left,
                style: kTextTheme.headline4,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const _EmailField(),
            const SizedBox(
              height: 20,
            ),
            const _PasswordField(),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () =>
                    Navigator.pushNamed(context, RESET_PASSWORD_ROUTE_NAME),
                child: Text(
                  'Reset Password',
                  style: kTextTheme.subtitle2,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<SignInBloc, SignInValidate>(
              builder: ((context, state) {
                return GradientButton(
                    height: 50,
                    width: double.infinity,
                    isClicked: state.isFormValid,
                    onTap: !state.isFormValid
                        ? () async =>
                            context.read<SignInBloc>().add(SubmitSignIn())
                        : null,
                    text: 'Login');
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
              text: 'Sign in with google',
              iconPath: "assets/icons/icon_google.svg",
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('New to Pethouse?'),
                const SizedBox(
                  width: 4,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, REGISTER_ROUTE_NAME);
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: kPrimaryColor),
                  ),
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
    return BlocBuilder<SignInBloc, SignInValidate>(
      builder: (context, state) {
        return TextFormField(
          onChanged: (value) {
            context.read<SignInBloc>().add(EmailChanged(value));
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

class _PasswordField extends StatelessWidget {
  const _PasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInValidate>(
      builder: (context, state) {
        return TextField(
          onChanged: (value) {
            context.read<SignInBloc>().add(PasswordChanged(value));
          },
          obscureText: !state.isPasswordVisible,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () async {
                context.read<SignInBloc>().add(ShowHidePasswordPress());
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

class ErrorDialog extends StatelessWidget {
  final String? errorMessage;
  const ErrorDialog({Key? key, required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Error"),
      content: Text(errorMessage!),
      actions: [
        TextButton(
          child: const Text("Ok"),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  }
}

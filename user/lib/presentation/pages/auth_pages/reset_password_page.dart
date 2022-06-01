import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/reset_password_bloc/reset_password_bloc.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  static const ROUTE_NAME = "reset-password-page";

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ResetPasswordBloc>(context).add(ResetPasswordInitial());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<ResetPasswordBloc, ResetPasswordValidate>(
        listener: (context, state) {
          if (state.isSubmitResetPassword) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Reset Password'),
                    content: Text(
                        'Link reset password telah kami kirimkan ke ${state.email}'),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text('Okay'),
                      ),
                    ],
                  );
                });
          } else if (state.message != "") {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Error'),
                    content: Text(state.message),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                    ],
                  );
                });
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.message == "") {
            return const _ResetPasswordForm();
          } else {
            return Center();
          }
        },
      ),
    );
  }
}

class _ResetPasswordForm extends StatelessWidget {
  const _ResetPasswordForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const _EmailField(),
            ElevatedButton(
              onPressed: () async {
                context.read<ResetPasswordBloc>().add(SubmitResetPassword());
              },
              child: const Text('Reset Password'),
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
    return BlocBuilder<ResetPasswordBloc, ResetPasswordValidate>(
      builder: (context, state) {
        return TextFormField(
          onChanged: (value) {
            context.read<ResetPasswordBloc>().add(EmailChanged(value));
          },
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            helperText: 'A complete, valid email e.g. joe@gmail.com',
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            errorText: !state.isEmailValid
                ? 'Please ensure the email entered is valid'
                : null,
            label: const Text('Email'),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pethouse/presentation/pages/login_page.dart';
import 'package:pethouse/utils/styles.dart';

import '../widgets/border_button.dart';
import '../widgets/gredient_button.dart';

class RegisterPage extends StatelessWidget {
  static const ROUTE_NAME = 'register';

  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(kMargin),
        child: Form(
          child: ListView(
            children: [
              const SizedBox(
                height: 42,
              ),
              Center(
                child: Text('Sign Up',
                    style: Theme.of(context).textTheme.headline5),
              ),
              const SizedBox(
                height: 24,
              ),
              //USERNAME
              TextFormField(
                decoration: InputDecoration(
                    fillColor: const Color(0xFF929292),
                    // hintText: 'John Doe',
                    labelText: 'Username',
                    border: OutlineInputBorder(borderRadius: kBorderRadius)),
              ),
              const SizedBox(
                height: 19,
              ),
              //  EMAIL ADDRESS
              TextFormField(
                decoration: InputDecoration(
                    fillColor: const Color(0xFF929292),
                    labelText: 'Email Address',
                    border: OutlineInputBorder(borderRadius: kBorderRadius)),
              ),
              //  PASSWORD
              const SizedBox(
                height: 19,
              ),
              const PasswordField(),
              const SizedBox(
                height: 19,
              ),
              const ConfirmPasswordField(),
              const SizedBox(
                height: 19,
              ),
              GradientButton(
                  height: 50, width: 100, onTap: () {}, text: 'Create Account'),
              const SizedBox(
                height: 19,
              ),
              BorderIconButton(
                height: 50,
                width: double.infinity,
                onTap: () {},
                text: 'Continue with google',
                iconPath: "assets/icons/icon_google.svg",
              ),
              const SizedBox(
                height: 19,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have Account ?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, LoginPage.ROUTE_NAME);
                    },
                    child: const Text('Log In'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({Key? key}) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obsecurePassword = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (s) {},
      obscureText: obsecurePassword,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
          fillColor: kPrimaryColor,
          labelText: 'Password',
          suffixIcon: IconButton(
            onPressed: () =>
                setState(() => obsecurePassword = !obsecurePassword),
            icon: Icon(
              obsecurePassword ? Icons.visibility : Icons.visibility_off,
              color: kPrimaryColor,
            ),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }
}

class ConfirmPasswordField extends StatefulWidget {
  const ConfirmPasswordField({Key? key}) : super(key: key);

  @override
  State<ConfirmPasswordField> createState() => _ConfirmPasswordFieldState();
}

class _ConfirmPasswordFieldState extends State<ConfirmPasswordField> {
  bool obsecurePassword = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecurePassword,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
          fillColor: kPrimaryColor,
          labelText: 'Confirm Password',
          suffixIcon: IconButton(
            onPressed: () =>
                setState(() => obsecurePassword = !obsecurePassword),
            icon: Icon(
              obsecurePassword ? Icons.visibility : Icons.visibility_off,
              color: kPrimaryColor,
            ),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pethouse/presentation/pages/home_page.dart';
import 'package:pethouse/presentation/pages/register_page.dart';
import 'package:pethouse/utils/styles.dart';

import '../widgets/border_button.dart';
import '../widgets/gredient_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const ROUTE_NAME = 'login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late bool _passwordVisible;
  late bool? _isRemember;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _isRemember = false;
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(kMargin),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SvgPicture.asset("assets/vectors/login_cat.svg"),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "LOGIN",
                      textAlign: TextAlign.center,
                      style: kTextTheme.headline4,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: kPrimaryColor, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: "Email",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: kPrimaryColor, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: "Password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                        icon: Icon(_passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                    obscureText: !_passwordVisible,
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _isRemember,
                            onChanged: (bool? value) {
                              setState(() {
                                _isRemember = value;
                              });
                            },
                            activeColor: kPrimaryColor,
                          ),
                          Text(
                            'Remember me',
                            style: kTextTheme.subtitle2,
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          'Forgot Password?',
                          style: kTextTheme.subtitle2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  GradientButton(
                      height: 50,
                      width: double.infinity,
                      onTap: () {
                        Navigator.pushNamed(
                            context, HomePage.ROUTE_NAME);
                      },
                      text: 'Login'),
                  const SizedBox(
                    height: 8,
                  ),
                  BorderIconButton(
                    height: 50,
                    width: double.infinity,
                    onTap: () {},
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
                              context, RegisterPage.ROUTE_NAME);
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const ROUTE_NAME = 'login-page';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                SvgPicture.asset("assets/login_cat.svg"),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "LOGIN",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Color(0xFF4B2710),
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
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
                      borderSide: const BorderSide(
                          color: Color(0xFFFF8500), width: 1.0),
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
                      borderSide: const BorderSide(
                          color: Color(0xFFFF8500), width: 1.0),
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
                          activeColor: Color(0xFFFF9331),
                        ),
                        const Text(
                          'Remember me',
                          style: TextStyle(color: Color(0xFF4B2710)),
                        )
                      ],
                    ),
                    InkWell(
                        onTap: () {},
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Color(0xFF4B2710),
                          ),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                GradientButtonMaterial(
                    height: 50,
                    width: double.infinity,
                    onTap: () {},
                    text: 'Login'),
                const SizedBox(
                  height: 8,
                ),
                BorderButton(
                  height: 50,
                  width: double.infinity,
                  onTap: () {},
                  text: 'Sign in with google',
                  icon: Icons.email,
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
                      onTap: () {},
                      child: const Text(
                        'Register',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF8500)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GradientButtonMaterial extends StatelessWidget {
  final double height;
  final double width;
  final VoidCallback onTap;
  final String text;

  const GradientButtonMaterial(
      {super.key,
      required this.height,
      required this.width,
      required this.onTap,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFECA540), Color(0xFFFF8500)],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        onPressed: onTap,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          '${text}',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class BorderButton extends StatelessWidget {
  final double height;
  final double width;
  final VoidCallback onTap;
  final String text;
  final IconData? icon;

  const BorderButton(
      {super.key,
      required this.height,
      required this.width,
      required this.onTap,
      required this.text,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(width: 1, color: Colors.grey)),
        primary: Colors.white,
        elevation: 0,
      ),
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        child: icon != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/flat-color-icons_google.svg"),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    '$text',
                    style: const TextStyle(color: Color(0xFF4B2710)),
                  ),
                ],
              )
            : Text(
                '${text}',
                style: const TextStyle(color: Color(0xFF4B2710)),
              ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FormRegistration extends StatelessWidget {
  static const routeName = '/form_registration';

  const FormRegistration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Registration Form"),
      //   centerTitle: true,
      // ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          child: ListView(
            children: [
              SizedBox(
                height: 42,
              ),
              Center(
                child: Text('Sign Up',
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4B2710))),
              ),
              SizedBox(
                height: 24,
              ),
              //USERNAME
              TextFormField(
                decoration: InputDecoration(
                    fillColor: Color(0xFF929292),
                    // hintText: 'John Doe',
                    labelText: 'Username',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 19,
              ),
              //  EMAIL ADDRESS
              TextFormField(
                decoration: InputDecoration(
                    fillColor: Color(0xFF929292),
                    labelText: 'Email Address',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              //  PASSWORD
              SizedBox(
                height: 19,
              ),
              PasswordField(),
              SizedBox(
                height: 19,
              ),
              ConfirmPasswordField(),
              SizedBox(
                height: 19,
              ),
              GradientButtonMaterial(
                  height: 42, width: 100, onTap: () {}, text: 'Create Account'),
              SizedBox(
                height: 19,
              ),
              MaterialButton(
                onPressed: () {},
                height: 42,
                minWidth: 100,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 24,
                        height: 24,
                        child: SvgPicture.asset('assets/icons/icon_google.svg')),
                    SizedBox(width: 7),
                    Text(
                      'Sign Up with Google',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 19,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have Account ?'),
                  TextButton(
                    onPressed: () {},
                    child: Text('Log In'),
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
          fillColor: Color(0xFF929292),
          labelText: 'Password',
          suffixIcon: IconButton(
            onPressed: () =>
                setState(() => obsecurePassword = !obsecurePassword),
            icon: Icon(
              obsecurePassword ? Icons.visibility : Icons.visibility_off,
              color: Color(0xFF929292),
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
          fillColor: Color(0xFF929292),
          labelText: 'Confirm Password',
          suffixIcon: IconButton(
            onPressed: () =>
                setState(() => obsecurePassword = !obsecurePassword),
            icon: Icon(
              obsecurePassword ? Icons.visibility : Icons.visibility_off,
              color: Color(0xFF929292),
            ),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
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
            colors: [Color(0xFFECA540), Color(0xFFFF8500)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
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
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

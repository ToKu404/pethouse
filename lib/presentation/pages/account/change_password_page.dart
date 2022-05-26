import 'package:flutter/material.dart';
import 'package:pethouse/presentation/pages/auth/register_page.dart';
import 'package:pethouse/presentation/widgets/btnback_decoration.dart';
import 'package:pethouse/presentation/widgets/gredient_button.dart';
import 'package:pethouse/utils/styles.dart';

class ChangePasswordPage extends StatelessWidget {
  static const ROUTE_NAME = 'change_password';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Update Your Password',style: TextStyle(color: Colors.black)),
        leading: btnBack_decoration(),
        centerTitle: true,
        elevation: 5,
        backgroundColor: kWhite,

      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(kMargin),
          child: Center(
            child: Column(
              children: [
                Text('Please enter your existing password and your new password',style: kTextTheme.caption),
                SizedBox(
                  height: 19,
                ),
                const PasswordField(),

                const SizedBox(
                  height: 19,
                ),

               const ConfirmPasswordField(),
                SizedBox(
                  height: 19,
                ),
                GradientButton(
                    height: 60, width: 360,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    text: 'Confirm'),
              ],
            ),
          ),
        ),
      ),

    );
  }
}



import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pethouse/presentation/widgets/gredient_button.dart';
import 'package:core/core.dart';

class CheckInternetPage extends StatelessWidget {
  static const ROUTE_NAME = 'check_internet';

  const CheckInternetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/vectors/dog_sleep.svg',
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 19,
              ),
              Text('Please check your internet connection',style: kTextTheme.subtitle2,),
              const SizedBox(
                height: 19,
              ),
              GradientButton(height: 52, width: 200, onTap: (){
                Navigator.pop(context);
              }, text: 'Reconnect')

            ],
          )
        ),
      ),
    );
  }
}

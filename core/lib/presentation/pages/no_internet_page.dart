import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:core/core.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/vectors/dog_sleep.svg',
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: Center(
                child: Text(
                  'Please check your internet connection',
                  textAlign: TextAlign.center,
                  style: kTextTheme.headline3?.copyWith(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GradientButton(
              height: 52,
              width: 150,
              onTap: () {
                BlocProvider.of<InternetCheckCubit>(context)
                    .onCheckConnectionOnetime();
              },
              text: 'Reconnect',
              isClicked: false,
            )
          ],
        ),
      ),
    );
  }
}

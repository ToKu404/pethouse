import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String message;
  const ErrorView({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'SOMETHING ERROR!',
            maxLines: 1,
            style: kTextTheme.headline5?.copyWith(color: Colors.redAccent),
          ),
          Text(
            message,
            maxLines: 1,
            style: kTextTheme.headline3?.copyWith(color: kGreyTransparant),
          ),
        ],
      ),
    );
  }
}

import 'package:core/core.dart';
import 'package:flutter/material.dart';

class NoPetView extends StatelessWidget {
  const NoPetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text("You haven't added a pet yet",
            style: kTextTheme.bodyText2?.copyWith(fontSize: 14)),
        const SizedBox(
          height: 19,
        ),
        DefaultButton(
          height: 52,
          width: 200,
          onTap: () {
            Navigator.pushNamed(context, ADD_PET_ROUTE_NAME);
          },
          text: 'Add Pet',
          isClicked: false,
        ),
      ],
    );
  }
}

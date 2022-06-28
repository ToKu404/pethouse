import 'package:flutter/material.dart';
import 'package:core/core.dart';

class CardDetailPet extends StatelessWidget {
  final String type;

  const CardDetailPet({Key? key, required this.type, required this.content}) : super(key: key);

  final String content;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(kPadding),
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: kBorderRadius,
          boxShadow: [
            BoxShadow(
                blurRadius: 13,
                color: const Color(0xFF000000).withOpacity(.07)),
            BoxShadow(
                blurRadius: 5, color: const Color(0xFF000000).withOpacity(.05))
          ],
        ),
        height: 68,
        child: Column(
          children: [
            Text(
              type,
              style: kTextTheme.bodyText2,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              content,
              style: kTextTheme.subtitle1?.copyWith(color: kDarkBrown),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}

import 'package:core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  const DefaultAppBar({Key? key, this.title = '', this.actions})
      : preferredSize = const Size.fromHeight(60.0),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(FontAwesomeIcons.arrowLeft),
        color: kPrimaryColor,
      ),
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: kTextTheme.headline5,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

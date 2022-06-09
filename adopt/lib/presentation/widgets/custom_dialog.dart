import 'package:core/core.dart';
import 'package:flutter/material.dart';

class DialogButton {
  final String text;
  final VoidCallback func;
  final String type;

  DialogButton({required this.text, required this.func, required this.type});
}

class CustomDialog extends StatelessWidget {
  final String title;
  final String desc;
  final List<DialogButton> buttons;
  const CustomDialog(
      {Key? key,
      required this.title,
      required this.desc,
      required this.buttons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
              left: kPadding,
              right: kPadding,
              bottom: kPadding,
              top: kPadding + 40),
          margin: const EdgeInsets.only(top: 40),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: kBorderRadius,
              boxShadow: const [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: kTextTheme.headline3
                    ?.copyWith(color: const Color(0xFF414041)),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                desc,
                style: const TextStyle(fontSize: 16, color: Color(0xFFAAACAE)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: buttons.map((button) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: button.type == 'close'
                            ? const Color(0xFFD6E4F8)
                            : const Color(0xFF4DD46B),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: button.func,
                    child: SizedBox(
                      width: 80,
                      child: Center(
                        child: Text(
                          button.text,
                          style: button.type == 'close'
                              ? const TextStyle(color: Color(0xFFA0B3CA))
                              : const TextStyle(color: kWhite),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        const Positioned(
          left: kPadding,
          right: kPadding,
          child: CircleAvatar(
            backgroundColor: Color(0xFF4DD46B),
            radius: 40,
            child: Icon(
              Icons.check,
              color: kWhite,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

showWarningDialog(BuildContext context,
    {required String title, required VoidCallback onTap}) {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.WARNING,
    animType: AnimType.SCALE,
    title: title,
    btnOkText: 'Yes',
    btnCancelColor: Colors.redAccent,
    btnOkColor: Colors.greenAccent,
    btnCancelOnPress: () {},
    btnOkOnPress: onTap,
  ).show();
}

showQuestionDialog(BuildContext context,
    {required String title, required VoidCallback onTap}) {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.QUESTION,
    animType: AnimType.SCALE,
    title: title,
    btnCancelColor: Colors.redAccent,
    btnOkColor: Colors.greenAccent,
    btnCancelOnPress: () {},
    btnOkOnPress: onTap,
  ).show();
}

showSuccessDialog(BuildContext context, {required String title}) {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.SUCCES,
    animType: AnimType.SCALE,
    title: title,
  ).show();
}

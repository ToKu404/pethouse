import 'package:flutter/material.dart';
import 'package:core/core.dart';

class CustomTimePicker extends StatefulWidget {
  final ValueChanged<TimeOfDay> onTimeChanged;
  final String hintText;
  final FocusNode? focusNode;

  CustomTimePicker({
    Key? key,
    this.focusNode,
    required this.onTimeChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  _CustomTimePickerState createState() {
    return _CustomTimePickerState();
  }
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  TimeOfDay defaultTime = TimeOfDay.now();
  late TextEditingController _controllerTime;
  late TimeOfDay _selectedTime;
  @override
  void initState() {
    super.initState();
    _controllerTime = TextEditingController();
    _controllerTime.text = "${defaultTime.hour}:${defaultTime.minute}";
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      focusNode: widget.focusNode,
      controller: _controllerTime,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      onTap: () => _selectTime(context),
      readOnly: true,
    );
  }

  @override
  void dispose() {
    _controllerTime.dispose();
    super.dispose();
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: defaultTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );

    if (pickedTime != null) {
      _selectedTime = pickedTime;
      _controllerTime.text = "${_selectedTime.hour}:${_selectedTime.minute}";
      widget.onTimeChanged(_selectedTime);
    }
  }
}

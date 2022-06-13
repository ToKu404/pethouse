import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  final ValueChanged<DateTime> onDateChanged;
  final DateTime initDate;
  final DateTime tanggalAwal;
  final DateTime tanggalAkhir;
  final DateFormat? formatTanggal;
  final FocusNode? focusNode;
  final Icon? icon;

  CustomDatePicker({
    Key? key,
    this.icon,
    this.focusNode,
    this.formatTanggal,
    required this.tanggalAkhir,
    required this.tanggalAwal,
    required this.initDate,
    required this.onDateChanged,
  })  : assert(initDate != null),
        assert(tanggalAwal != null),
        assert(tanggalAkhir != null),
        assert(!initDate.isBefore(tanggalAwal),
            'Initial Date must be on or after First Date'),
        assert(!initDate.isAfter(tanggalAkhir),
            'Initial Date must be on or before Last Date'),
        assert(!tanggalAwal.isAfter(tanggalAkhir),
            'Last Date must be on or after First Date'),
        assert(onDateChanged != null, 'onDateChanged must not be null'),
        super(key: key);

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late TextEditingController _controllerDate;
  late DateFormat _formatTanggal;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();

    if (widget.formatTanggal != null) {
      _formatTanggal = widget.formatTanggal!;
    } else {
      _formatTanggal = DateFormat.yMMMEd();
    }

    _selectedDate = widget.initDate;

    _controllerDate = TextEditingController();
    _controllerDate.text = _formatTanggal.format(_selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      controller: _controllerDate,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        suffixIcon: widget.icon,
      ),
      onTap: () => _selectDate(context),
      readOnly: true,
    );
  }

  @override
  void dispose() {
    _controllerDate.dispose();
    super.dispose();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: widget.tanggalAwal,
      lastDate: widget.tanggalAkhir,
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      _selectedDate = pickedDate;
      _controllerDate.text = _formatTanggal.format(_selectedDate);
      widget.onDateChanged(_selectedDate);
    }

    if (widget.focusNode != null) {
      widget.focusNode!.nextFocus();
    }
  }
}

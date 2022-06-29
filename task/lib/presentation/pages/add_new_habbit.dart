import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet/domain/entities/pet_entity.dart';
import 'package:intl/intl.dart';
import 'package:task/domain/entities/habbit_entity.dart';
import 'package:task/presentation/blocs/habbit_cubit/habbit_cubit.dart';

class AddHabbitPage extends StatefulWidget {
  final PetEntity petEntity;
  const AddHabbitPage({Key? key, required this.petEntity}) : super(key: key);
  @override
  State<AddHabbitPage> createState() => _AddHabbitPageState();
}

class _AddHabbitPageState extends State<AddHabbitPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _habbitDateController = TextEditingController();
  final TextEditingController _habbitTimeController = TextEditingController();
  DateTime? _habbitDate;
  TimeOfDay? _habbitTime;
  String? _habbitType;
  String _habbitRepeat = 'No Repeat';

  final List<CustomDay> customRepeat = [
    CustomDay('Sun', false),
    CustomDay('Mon', false),
    CustomDay('Tue', false),
    CustomDay('Wed', false),
    CustomDay('Thu', false),
    CustomDay('Fri', false),
    CustomDay('Sat', false),
  ];

  final List<String> repeatDay = [];

  @override
  void initState() {
    super.initState();
    repeatDay.clear();
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
    _habbitDateController.dispose();
    _habbitTimeController.dispose();
  }

  void _submitAddNewTask() {
    final time = Timestamp.fromDate(DateTime(
        _habbitDate!.year,
        _habbitDate!.month,
        _habbitDate!.day,
        _habbitTime!.hour,
        _habbitTime!.minute));
    List<String> repeat = [];
    if (_habbitRepeat == 'Custom') {
      repeat = repeatDay;
    } else if (_habbitRepeat == 'Everyday') {
      for (var element in customRepeat) {
        repeat.add(element.day);
      }
    }
    if (repeat.isEmpty) {
      _habbitRepeat = 'No Repeat';
    } else if (repeat.length == customRepeat.length) {
      _habbitRepeat = 'Everyday';
    }
    HabbitEntity habbit = HabbitEntity(
        petId: widget.petEntity.id,
        activityType: _habbitType,
        time: time,
        title: _titleController.text,
        repeat: _habbitRepeat,
        dayRepeat: repeat);

    BlocProvider.of<HabbitCubit>(context).onAddHabbit(habbit);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HabbitCubit, HabbitState>(
      listener: (context, state) {
        if (state is AddHabbitSuccess) {
          showSuccessDialog(context, title: 'Success Add New Habbit');
          Future.delayed(const Duration(seconds: 2), () async {
            Navigator.pop(context);
            Navigator.pop(context);
          });
        }
      },
      child: Scaffold(
        appBar: DefaultAppBar(
          title: '${widget.petEntity.petName} Habbit',
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPadding * 2),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    _inputHabbitType(),
                    const SizedBox(
                      height: 20,
                    ),
                    _inputHabbitTitle(),
                    const SizedBox(
                      height: 20,
                    ),
                    _inputHabbitDate(),
                    const SizedBox(
                      height: 20,
                    ),
                    _inputHabbitTime(),
                    const SizedBox(
                      height: 20,
                    ),
                    _inputHabbitRepeat(),
                    (_habbitRepeat == 'Custom')
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              _buildCustomDayRepeat(),
                            ],
                          )
                        : Container(),
                    const SizedBox(
                      height: 20,
                    ),
                    DefaultButton(
                      height: 55,
                      width: double.infinity,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          showQuestionDialog(context,
                              title: 'Confirm create new habbit', onTap: () {
                            _submitAddNewTask();
                          });
                        }
                      },
                      text: 'Add Habbit',
                      isClicked: false,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputHabbitType() {
    final List<String> typeActivityList = [
      'Feed',
      'Give Fresh Water',
      'Clean Box',
      'Walk',
      'Vitamin',
      'Play',
      'Bath',
      'Other'
    ];
    return DropdownButtonFormField(
      decoration: InputDecoration(
        labelText: 'Habbit Type',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimaryColor, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      value: _habbitType,
      icon: const Icon(Icons.arrow_drop_down_rounded),
      style: kTextTheme.headline3,
      validator: (value) {
        if (value == null) {
          return "Choice Habbit Type";
        } else {
          return null;
        }
      },
      items: typeActivityList
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: (String? value) {
        setState(() {
          _habbitType = value ?? '';
        });
      },
    );
  }

  _inputHabbitDate() {
    final DateFormat dateFormat = DateFormat.yMMMEd();
    return TextFormField(
      readOnly: true,
      validator: (value) {
        if (value == null || _habbitDate == null) {
          return 'Task Date Cannot Empty';
        } else {
          return null;
        }
      },
      controller: _habbitDateController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          suffixIcon: const Icon(Icons.calendar_month),
          labelText: 'Habbit Date'),
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 366)),
        ).then((pickedDate) {
          // Check if no date is selected
          if (pickedDate == null) {
            return;
          }
          setState(() {
            _habbitDate = pickedDate;
            _habbitDateController.text = dateFormat.format(pickedDate);
          });
        });
      },
    );
  }

  _inputHabbitTime() {
    return TextFormField(
      readOnly: true,
      controller: _habbitTimeController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          suffixIcon: const Icon(Icons.access_time),
          labelText: 'Plan Time'),
      onTap: () {
        showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          initialEntryMode: TimePickerEntryMode.dial,
        ).then((pickTime) {
          setState(() {
            _habbitTime = pickTime!;
            _habbitTimeController.text = "${pickTime.hour}:${pickTime.minute}";
          });
        });
      },
    );
  }

  _inputHabbitRepeat() {
    final List<String> repeatList = [
      'No Repeat',
      'Everyday',
      'Custom',
    ];
    return DropdownButtonFormField(
      decoration: InputDecoration(
        labelText: 'Habbit Repeat',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimaryColor, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      value: _habbitRepeat,
      icon: const Icon(Icons.arrow_drop_down_rounded),
      style: kTextTheme.headline3,
      validator: (value) {
        if (value == null) {
          return "Task Repeat";
        } else {
          return null;
        }
      },
      items: repeatList
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: (String? value) {
        setState(() {
          _habbitRepeat = value ?? '';
        });
      },
    );
  }

  _inputHabbitTitle() {
    return TextFormField(
      controller: _titleController,
      decoration: InputDecoration(
        fillColor: const Color(0xFF929292),
        labelText: 'Habbit Title',
        border: OutlineInputBorder(borderRadius: kBorderRadius),
      ),
      validator: (value) {
        if (value!.isNotEmpty) {
          return null;
        } else {
          return 'Plase enter habbit title';
        }
      },
    );
  }

  _buildCustomDayRepeat() {
    return SizedBox(
      height: 30,
      width: double.infinity,
      child: ListView.builder(
          itemCount: customRepeat.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return _dayChip(
                customRepeat[index].day, customRepeat[index].isSelected, index);
          }),
    );
  }

  Widget _dayChip(String day, bool isSelected, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          customRepeat[index].isSelected = !customRepeat[index].isSelected;
          if (customRepeat[index].isSelected) {
            repeatDay.add(customRepeat[index].day);
          } else {
            repeatDay.remove(customRepeat[index].day);
          }
        });
      },
      child: Container(
        height: 30,
        width: 40,
        margin: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
            color: isSelected ? kPrimaryColor : kWhite,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                width: 1,
                color: isSelected ? kPrimaryColor : kGreyTransparant)),
        child: Center(
          child: Text(
            day,
            style: kTextTheme.overline
                ?.copyWith(color: isSelected ? kWhite : Colors.grey),
          ),
        ),
      ),
    );
  }
}

class CustomDay {
  String day;
  bool isSelected;

  CustomDay(this.day, this.isSelected);
}

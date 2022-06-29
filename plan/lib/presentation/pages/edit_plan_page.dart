import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:plan/domain/entities/plan_entity.dart';
import 'package:plan/presentation/blocs/edit_plan_cubit/edit_plan_cubit.dart';

class EditPlanPage extends StatefulWidget {
  final PlanEntity plan;
  const EditPlanPage({Key? key, required this.plan}) : super(key: key);

  @override
  State<EditPlanPage> createState() => _EditPlanPageState();
}

class _EditPlanPageState extends State<EditPlanPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _planDateController = TextEditingController();
  final TextEditingController _planTimeController = TextEditingController();
  final TextEditingController _otherActivityController =
      TextEditingController();

  bool _statusReminder = false;
  TimeOfDay _planTime = TimeOfDay.now();
  DateTime? _planDate;
  final List<String> _activityTypeList = [
    'Vaccination',
    'Full Check',
    'Rescue',
    'Grooming',
    'Internal Deworming',
    'Fleas & Ticks',
    'Other'
  ];
  String? _selectActivity;
  String? _groomingType;

  void _onEditPlanSubmit() {
    final planDateTime = DateTime(_planDate!.year, _planDate!.month,
        _planDate!.day, _planTime.hour, _planTime.minute);
    final planTime = Timestamp.fromDate(planDateTime);
    String activity = _selectActivity ?? '';
    if (_selectActivity == 'Other') {
      activity = _otherActivityController.text;
    } else if (_selectActivity == 'Grooming') {
      activity = "${_groomingType!} $activity";
    }
    PlanEntity plan = PlanEntity(
        date: _planDateController.text,
        time: planTime,
        activityTitle: activity,
        completeStatus: false,
        activity: _selectActivity,
        location: _locationController.text,
        description: _descriptionController.text,
        reminder: _statusReminder);

    BlocProvider.of<EditPlanCubit>(context).submitUpdatePlan(plan);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _descriptionController.dispose();
    _locationController.dispose();
    _planDateController.dispose();
    _planTimeController.dispose();
    _otherActivityController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final DateTime dt = widget.plan.time!.toDate();
    _selectActivity = widget.plan.activity;
    _statusReminder = widget.plan.reminder!;
    _planTime = TimeOfDay.fromDateTime(dt);
    _planDate = DateTime(dt.year, dt.month, dt.day);

    if (_selectActivity == 'Gromming') {
      _groomingType = widget.plan.activityTitle!.split(' ')[0];
    }
    if (_selectActivity == 'Other') {
      _otherActivityController.text = widget.plan.activityTitle ?? '';
    }
    final format = DateFormat.yMMMEd();
    _locationController.text = widget.plan.location ?? '';
    _descriptionController.text = widget.plan.description ?? '';
    _planDateController.text = widget.plan.date ?? '';
    _planTimeController.text = "${dt.hour}:${dt.minute}";
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditPlanCubit, EditPlanState>(
      listener: (context, state) {
        if (state is EditPlanSuccess) {
          showSuccessDialog(context, title: 'Success Update Plan');
          Future.delayed(const Duration(seconds: 2), () async {
            Navigator.pop(context);
            Navigator.pop(context);
          });
        }
      },
      child: Scaffold(
        appBar: const DefaultAppBar(
          title: 'Edit Plan',
        ),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        _selectActivityBuild(),
                        const SizedBox(
                          height: 20,
                        ),
                        _selectActivity == 'Other'
                            ? Column(
                                children: [
                                  _buildOtherActivity(),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              )
                            : Container(),
                        _selectActivity == 'Grooming'
                            ? Column(
                                children: [
                                  _buildTypeGrooming(),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              )
                            : Container(),
                        _buildInputDate(),
                        const SizedBox(
                          height: 20,
                        ),
                        _buildInputTime(),
                        const SizedBox(
                          height: 20,
                        ),
                        _buildInputLocation(),
                        const SizedBox(
                          height: 20,
                        ),
                        _buildInputDescription(),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildInputReminder(),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      child: DefaultButton(
                        height: 50,
                        width: double.infinity,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            showInfoDialog(context,
                                title: 'Confirm update plan', onTap: () {
                              _onEditPlanSubmit();
                            });
                          }
                        },
                        text: 'Save Plan Activity',
                        isClicked: false,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _buildInputDescription() {
    return TextFormField(
      controller: _descriptionController,
      decoration: InputDecoration(
        fillColor: const Color(0xFF929292),
        labelText: 'Description',
        alignLabelWithHint: true,
        border: OutlineInputBorder(borderRadius: kBorderRadius),
      ),
      maxLines: 3,
    );
  }

  TextFormField _buildInputLocation() {
    return TextFormField(
      controller: _locationController,
      decoration: InputDecoration(
        fillColor: const Color(0xFF929292),
        labelText: 'Location',
        border: OutlineInputBorder(borderRadius: kBorderRadius),
      ),
      validator: (locationController) {
        if (locationController!.isNotEmpty) {
          return null;
        } else {
          return 'Plase enter your location';
        }
      },
    );
  }

  _buildInputDate() {
    final DateFormat _dateFormat = DateFormat.yMMMEd();
    return TextFormField(
      readOnly: true,
      validator: (value) {
        if (value == null || _planDate == null) {
          return 'Task Date Cannot Empty';
        } else {
          return null;
        }
      },
      controller: _planDateController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          suffixIcon: const Icon(Icons.calendar_month),
          labelText: 'Plan Date'),
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
            _planDate = pickedDate;
            _planDateController.text = _dateFormat.format(pickedDate);
          });
        });
      },
    );
  }

  TextFormField _buildOtherActivity() {
    return TextFormField(
      controller: _otherActivityController,
      decoration: InputDecoration(
        fillColor: const Color(0xFF929292),
        labelText: 'Other Activity',
        border: OutlineInputBorder(borderRadius: kBorderRadius),
      ),
      validator: (value) {
        if (value!.isNotEmpty) {
          return null;
        } else {
          return 'Please input other activity type';
        }
      },
    );
  }

  DropdownButtonFormField<String> _selectActivityBuild() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Select Activity',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      icon: const Icon(Icons.arrow_drop_down_rounded),
      style: kTextTheme.headline3?.copyWith(color: kDarkBrown),
      value: _selectActivity,
      items: _activityTypeList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectActivity = newValue!;
        });
      },
      validator: (value) => value == null ? 'Please select activity' : null,
    );
  }

  _buildInputTime() {
    return TextFormField(
      readOnly: true,
      controller: _planTimeController,
      validator: (value) {
        final choiceTime = DateTime(_planDate!.year, _planDate!.month,
            _planDate!.day, _planTime.hour, _planTime.minute);
        if (choiceTime.isBefore(DateTime.now())) {
          return 'Choice Correct Time';
        } else {
          return null;
        }
      },
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
          initialTime: _planTime,
          initialEntryMode: TimePickerEntryMode.dial,
        ).then((pickTime) {
          setState(() {
            _planTime = pickTime!;
            _planTimeController.text = "${pickTime.hour}:${pickTime.minute}";
          });
        });
      },
    );
  }

  _buildInputReminder() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Reminder',
            style: kTextTheme.subtitle1,
          ),
          Switch.adaptive(
              inactiveTrackColor: kGrey,
              activeColor: kPrimaryColor,
              value: _statusReminder,
              onChanged: (value) {
                setState(() => _statusReminder = !_statusReminder);
              })
        ],
      ),
    );
  }

  _buildTypeGrooming() {
    List<String> typeGrooming = ['Hair', 'Ears', 'Nails', 'Teeth'];
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Type Grooming',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      icon: const Icon(Icons.arrow_drop_down_rounded),
      style: kTextTheme.headline3?.copyWith(color: kDarkBrown),
      value: _groomingType,
      items: typeGrooming.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _groomingType = newValue!;
        });
      },
      validator: (value) =>
          value == null ? 'Please select grooming type' : null,
    );
  }
}

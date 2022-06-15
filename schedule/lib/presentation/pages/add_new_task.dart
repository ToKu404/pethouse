import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/presentation/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet/domain/entities/pet_entity.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tzl;
import 'package:timezone/timezone.dart' as tz;
import '../../domain/entities/task_entity.dart';
import '../blocs/task_bloc/task_bloc.dart';
import '../blocs/schedule_task_bloc/schedule_task_bloc.dart';

class AddTaskPage extends StatefulWidget {
  final PetEntity petEntity;
  const AddTaskPage({Key? key, required this.petEntity}) : super(key: key);
  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _taskDateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  Timestamp? _taskDate;
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay? _endTime;
  String? _taskType;
  String _taskRepeat = 'No Repeat';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tzl.initializeTimeZones();
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
    _taskDateController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
  }

  void _submitAddNewTask() {
    final date = _taskDate!.toDate();
    TaskEntity taskEntity = TaskEntity(
      activity: _taskType,
      startTime: Timestamp.fromDate(DateTime(
          date.year, date.month, date.day, _startTime.hour, _startTime.minute)),
      endTime: _endTime != null
          ? Timestamp.fromDate(DateTime(date.year, date.month, date.day,
              _endTime!.hour, _endTime!.minute))
          : null,
      repeat: _taskRepeat,
      description: _descriptionController.text,
      status: 'wating',
      petId: widget.petEntity.id,
      date: DateFormat("yyyy-MM-dd").format(date),
    );
    print(_startTime.hour);
    final start = DateTime(
        date.year, date.month, date.day, _startTime.hour, _startTime.minute);
    final myTime = DateFormat('HH:mm:ss').format(start);

    print(myTime);

    // BlocProvider.of<ScheduleTaskBloc>(context).add(GetScheduleTaskEvent(
    //   value: true,
    //   date: myTime,
    // ));
    // // tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, date.year, date.month,
    // //     date.day, _startTime.hour, _startTime.minute);
    // // NotificationService().showNotification(
    // //     1, _taskType!, _descriptionController.text, scheduledDate);
    context.read<TaskBloc>().add(CreateTask(taskEntity: taskEntity));
  }

  final List<String> taskStatus = ['passed', 'complete', 'waiting'];

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state is TaskSuccess) {
          Future.delayed(Duration(seconds: 1), () {
            Navigator.pop(context);
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(FontAwesomeIcons.arrowLeft),
            color: kPrimaryColor,
          ),
          backgroundColor: Colors.white,
          title: Text(
            '${widget.petEntity.petName} Task',
            style: kTextTheme.headline5,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
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
                    _inputTypeTask(),
                    const SizedBox(
                      height: 20,
                    ),
                    _inputTaskDate(),
                    const SizedBox(
                      height: 20,
                    ),
                    _inputTaskTime(),
                    const SizedBox(
                      height: 20,
                    ),
                    _inputTaskRepeat(),
                    const SizedBox(
                      height: 20,
                    ),
                    _inputDescription(),
                    const SizedBox(
                      height: 20,
                    ),
                    GradientButton(
                      height: 55,
                      width: double.infinity,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          _submitAddNewTask();
                        }
                      },
                      text: 'Save Pet',
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

  Widget _inputTypeTask() {
    final List<String> _typeActivityList = [
      'Feed',
      'Walk',
      'Pee',
      'Vitamin',
      'Shower',
      'Grooming',
      'Weight Scale',
      'Period',
    ];
    return DropdownButtonFormField(
      decoration: InputDecoration(
        labelText: 'Task Type',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimaryColor, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      value: _taskType,
      icon: const Icon(Icons.arrow_drop_down_rounded),
      style: GoogleFonts.poppins(
        color: kDarkBrown,
        fontSize: 16,
      ),
      validator: (value) {
        if (value == null) {
          return "Choice Pet Type";
        } else {
          return null;
        }
      },
      items: _typeActivityList
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: (String? value) {
        setState(() {
          _taskType = value ?? '';
        });
      },
    );
  }

  _inputTaskDate() {
    final DateFormat _dateFormat = DateFormat.yMMMEd();
    return TextFormField(
        readOnly: true,
        validator: (value) {
          if (value == null || _taskDate == null) {
            return 'Task Date Cannot Empty';
          } else {
            return null;
          }
        },
        controller: _taskDateController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kPrimaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            suffixIcon: const Icon(Icons.calendar_month),
            labelText: 'Task Date'),
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
              _taskDate = Timestamp.fromDate(pickedDate);
              _taskDateController.text = _dateFormat.format(pickedDate);
            });
          });
        });
  }

  _inputTaskTime() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            readOnly: true,
            controller: _startTimeController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: kPrimaryColor, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                suffixIcon: const Icon(Icons.access_time),
                labelText: 'Start Time'),
            onTap: () {
              showTimePicker(
                context: context,
                initialTime: _startTime,
                initialEntryMode: TimePickerEntryMode.dial,
              ).then((pickTime) {
                setState(() {
                  _startTime = pickTime!;
                  _startTimeController.text =
                      "${pickTime.hour}:${pickTime.minute}";
                });
              });
            },
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextFormField(
            readOnly: true,
            controller: _endTimeController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: kPrimaryColor, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                suffixIcon: const Icon(Icons.access_time),
                labelText: 'End Time'),
            onTap: () {
              showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
                initialEntryMode: TimePickerEntryMode.dial,
              ).then((pickTime) {
                setState(() {
                  _endTime = pickTime!;
                  _endTimeController.text =
                      "${pickTime.hour}:${pickTime.minute}";
                });
              });
            },
          ),
        ),
      ],
    );
  }

  _inputTaskRepeat() {
    final List<String> _repeatList = [
      'No Repeat',
      'Everyday',
      'Every Week',
      'Every Month',
    ];
    return DropdownButtonFormField(
      decoration: InputDecoration(
        labelText: 'Task Repeat',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimaryColor, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      value: _taskRepeat,
      icon: const Icon(Icons.arrow_drop_down_rounded),
      style: GoogleFonts.poppins(
        color: kDarkBrown,
        fontSize: 16,
      ),
      validator: (value) {
        if (value == null) {
          return "Task Repeat";
        } else {
          return null;
        }
      },
      items: _repeatList
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: (String? value) {
        setState(() {
          _taskRepeat = value ?? '';
        });
      },
    );
  }

  _inputDescription() {
    return TextFormField(
      controller: _descriptionController,
      decoration: InputDecoration(
        fillColor: const Color(0xFF929292),
        alignLabelWithHint: true,
        labelText: 'Task Description',
        border: OutlineInputBorder(borderRadius: kBorderRadius),
      ),
      maxLines: 5,
    );
  }
}

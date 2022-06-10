import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:core/core.dart';
import 'package:schedule/presentation/widgets/btnback_decoration.dart';
import 'package:schedule/presentation/widgets/date_picker.dart';
import 'package:schedule/presentation/widgets/gredient_button.dart';
import 'package:schedule/presentation/widgets/time_picker.dart';
import '../../domain/entities/task_entity.dart';
import '../blocs/addtask_bloc/task_bloc.dart';

class AddNewTaskActivity extends StatefulWidget {
  static const ROUTE_NAME = "add_newTask_activity";
  const AddNewTaskActivity({Key? key}) : super(key: key);
  @override
  State<AddNewTaskActivity> createState() => _AddNewTaskActivityState();
}

class _AddNewTaskActivityState extends State<AddNewTaskActivity> {
  final TextEditingController _descriptionController = TextEditingController();
  DateTime dateTime = DateTime.now();
  TimeOfDay timeOfDayStart = TimeOfDay.now();
  TimeOfDay timeOfDayEnd = TimeOfDay.now();
  final List<String> dropdownList = [
    'Select Activity',
    'Feed',
    'Walk',
    'Pee',
    'Vitamin',
    'Shower',
    'Grooming',
    'Weight Scale',
    'Period',
  ];
  String dropdownHint = 'Select Activity';
  final List<String> dropdownList1 = [
  'Select One',
  'Everyday',
  'Every Week',
  'Every Month',
  ];
  String dropdownHint1 = 'Select One';


  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Task', style: TextStyle(color: Colors.black)),
        leading: btnBack_decoration(),
        centerTitle: true,
        elevation: 5,
        backgroundColor: kWhite,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Ikhsan',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: kDarkBrown,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Your best animal  Activity Medical ',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: const Color(0XFFCCA88A),
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: kDarkBrown,
                          width: 1.0,
                        ),
                        image: const DecorationImage(
                          image: NetworkImage(
                            'https://asset.kompas.com/crops/MzG1rdeLzUk4jJ6KSn-6Sd20igg=/0x0:1920x1280/750x500/data/photo/2021/03/15/604edf099bac9.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Activity',
                      style: GoogleFonts.poppins(
                        color: kDarkBrown,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child:  DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                              value: dropdownHint,
                              icon: const Icon(Icons.arrow_drop_down_rounded),
                              style: GoogleFonts.poppins(
                                color: Color.fromARGB(255, 109, 109, 109),
                                fontSize: 16,
                              ),
                              items:
                              dropdownList.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownHint = newValue!;
                                });
                              }),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 19,
                    ),
                    Text(
                      'Date',
                      style: GoogleFonts.poppins(
                        color: kDarkBrown,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomDatePicker(
                      icon: Icon(Icons.date_range_rounded),
                      tanggalAkhir:
                          DateTime.now().add(Duration(days: 366)),
                      tanggalAwal: DateTime.now(),
                      initDate: DateTime.now().add(Duration(days: 1)),
                      onDateChanged: (selectedDate) {
                        dateTime = selectedDate;
                        print(dateTime);
                        // Aksi yang diperlukan saat mengganti kalender
                      },
                    ),
                    const SizedBox(
                      height: 19,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Start Time',
                              style: GoogleFonts.poppins(
                                color: kDarkBrown,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: kBorderRadius,
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                              width: 136,
                              height: 50,
                              child: Center(
                                child: CustomTimePicker(
                                  hintText: 'Start',
                                  onTimeChanged: (selectedTime) {
                                    timeOfDayStart = selectedTime;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'End Time',
                              style: GoogleFonts.poppins(
                                color: kDarkBrown,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: kBorderRadius,
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                              width: 136,
                              height: 50,
                              child: Center(
                                child: CustomTimePicker(
                                  hintText: 'End',
                                  onTimeChanged: (selectedTime) {
                                    timeOfDayEnd = selectedTime;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 19,
                    ),
                    Text(
                      'Repeat',
                      style: GoogleFonts.poppins(
                        color: kDarkBrown,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                              value: dropdownHint1,
                              icon: const Icon(Icons.arrow_drop_down_rounded),
                              style: GoogleFonts.poppins(
                                color: Color.fromARGB(255, 109, 109, 109),
                                fontSize: 16,
                              ),
                              items:
                              dropdownList1.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownHint1 = newValue!;
                                });
                              }),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 19,
                    ),
                    Text(
                      'Description',
                      style: TextStyle(
                        color: kDarkBrown,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        fillColor: const Color(0xFF929292),
                        hintText: 'Add Activity Description',
                        border: OutlineInputBorder(borderRadius: kBorderRadius),
                      ),
                      maxLines: 3,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: GradientButton(
                      height: 50,
                      width: double.infinity,
                      onTap: () {
                        final description = _descriptionController.text;
                        BlocProvider.of<TaskBloc>(context).add(CreateTask(
                            taskEntity: TaskEntity(
                              activity: dropdownHint,
                              repeat: dropdownHint1,
                              description: description,
                              date: Timestamp.fromDate(dateTime),
                              startTime: Timestamp.fromDate(DateTime(dateTime.year, dateTime.month, dateTime.day, timeOfDayStart.hour, timeOfDayStart.minute)),
                              endTime: Timestamp.fromDate(DateTime(dateTime.year, dateTime.month, dateTime.day, timeOfDayEnd.hour, timeOfDayEnd.minute))
                            )));
                      },
                      text: 'Schedule'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

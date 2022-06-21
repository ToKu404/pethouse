import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/presentation/widgets/gradient_button.dart';
import 'package:core/presentation/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:core/core.dart';
import 'package:intl/intl.dart';
import 'package:pet/domain/entities/pet_entity.dart';
import 'package:plan/presentation/blocs/add_plan_cubit/add_plan_cubit.dart';
import '../../domain/entities/plan_entity.dart';

class AddPlanPage extends StatefulWidget {
  final PetEntity petEntity;
  const AddPlanPage({Key? key, required this.petEntity}) : super(key: key);

  @override
  State<AddPlanPage> createState() => _AddPlanPageState();
}

class _AddPlanPageState extends State<AddPlanPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _planDateController = TextEditingController();
  final TextEditingController _planTimeController = TextEditingController();
  final TextEditingController _otherActivityController =
      TextEditingController();

  final isLoading = true;
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

  void _onAddPlanSubmit() {
    final planTime = Timestamp.fromDate(DateTime(_planDate!.year,
        _planDate!.month, _planDate!.day, _planTime.hour, _planTime.minute));
    String activity = _selectActivity ?? '';
    if (_selectActivity == 'Other') {
      activity = _otherActivityController.text;
    } else if (_selectActivity == 'Grooming') {
      activity = "${_groomingType!} $activity";
    }
    PlanEntity newPlan = PlanEntity(
        date: _planDateController.text,
        time: planTime,
        activityTitle: activity,
        petId: widget.petEntity.id,
        status: 'waiting',
        activity: _selectActivity,
        location: _locationController.text,
        description: _descriptionController.text,
        reminder: _statusReminder);
    BlocProvider.of<AddPlanCubit>(context).addPlan(newPlan);
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _planDateController.dispose();
    _planTimeController.dispose();
    _otherActivityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(FontAwesomeIcons.arrowLeft),
          color: kPrimaryColor,
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Add Plan',
          style: kTextTheme.headline5,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
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
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${widget.petEntity.petName}',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                color: kDarkBrown,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: kSecondaryColor,
                            width: 1.8,
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                              '${widget.petEntity.petPictureUrl}',
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
                    child: GradientButton(
                        height: 50,
                        width: double.infinity,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const LoadingScreen();
                            },
                          );
                          Future.delayed(const Duration(seconds: 1), () {
                            if (!_formKey.currentState!.validate()) {
                              Navigator.pop(context);
                              return;
                            } else {
                              _onAddPlanSubmit();
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }
                          });
                        },
                        text: 'Save Medical Activity', isClicked: false,),
                  )
                ],
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
      style: GoogleFonts.poppins(
        color: const Color.fromARGB(255, 109, 109, 109),
        fontSize: 16,
      ),
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
            style: GoogleFonts.poppins(
              color: kDarkBrown,
              fontSize: 14,
            ),
          ),
          Switch.adaptive(
              inactiveTrackColor: kGrey,
              activeColor: kPrimaryColor,
              value: _statusReminder,
              onChanged: (value) {
                print(value);
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
      style: GoogleFonts.poppins(
        color: const Color.fromARGB(255, 109, 109, 109),
        fontSize: 16,
      ),
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

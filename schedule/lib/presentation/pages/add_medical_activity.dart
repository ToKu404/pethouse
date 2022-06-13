import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:core/core.dart';
import 'package:pet/domain/entities/pet_entity.dart';
import 'package:schedule/domain/entities/medical_entity.dart';
import 'package:schedule/presentation/blocs/addmedical_bloc/medical_bloc.dart';
import 'package:schedule/presentation/widgets/btnback_decoration.dart';
import 'package:schedule/presentation/widgets/date_picker.dart';
import 'package:schedule/presentation/widgets/gredient_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AddMedicalActivity extends StatefulWidget {
  final PetEntity petEntity;
  AddMedicalActivity({required this.petEntity});
  static const ROUTE_NAME = "medical_activity";

  @override
  State<AddMedicalActivity> createState() => _AddMedicalActivityState();
}

class _AddMedicalActivityState extends State<AddMedicalActivity> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime dateTime = DateTime.now();
  final isLoading = true;
  final List<String> dropdownList = [
    'Vaccination',
    'Sick',
    'Full Check',
  ];
  String dropdownHint = 'Select Activity';

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical Activity', style: TextStyle(color: Colors.black)),
        leading: btnBack_decoration(),
        centerTitle: true,
        elevation: 5,
        backgroundColor: kWhite,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Hanan',
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
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Your best animal  Activity Medical ',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                color: const Color(0XFFCCA88A),
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
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
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          'Activity',
                          style: GoogleFonts.poppins(
                            color: kDarkBrown,
                            fontSize: 12,
                          ),
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
                          child: DropdownButtonFormField<String>(
                            hint: Text(dropdownHint),
                            icon: const Icon(Icons.arrow_drop_down_rounded),
                            style: GoogleFonts.poppins(
                              color: Color.fromARGB(255, 109, 109, 109),
                              fontSize: 16,
                            ),
                            items: dropdownList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownHint = newValue!;
                              });
                            },
                            validator: (value) =>
                                value == null ? 'Please select activity' : null,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          bottom: 10,
                          top: 10,
                        ),
                        child: Text(
                          'Expired Date',
                          style: TextStyle(
                            color: kDarkBrown,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: CustomDatePicker(
                              icon: Icon(Icons.date_range_rounded),
                              tanggalAkhir:
                                  DateTime.now().add(Duration(days: 366)),
                              tanggalAwal: DateTime.now(),
                              initDate: DateTime.now().add(Duration(days: 1)),
                              onDateChanged: (selectedDate) {
                                dateTime = selectedDate;
                              },
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          bottom: 10,
                          top: 10,
                        ),
                        child: Text(
                          'Location',
                          style: TextStyle(
                            color: kDarkBrown,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: _locationController,
                        decoration: InputDecoration(
                          fillColor: const Color(0xFF929292),
                          hintText: 'Add Activity Location',
                          border:
                              OutlineInputBorder(borderRadius: kBorderRadius),
                        ),
                        validator: (_locationController) {
                          if (_locationController!.isNotEmpty) {
                            return null;
                          } else {
                            return 'Plase enter your location';
                          }
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          bottom: 10,
                          top: 10,
                        ),
                        child: Text(
                          'Description',
                          style: TextStyle(
                            color: kDarkBrown,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          fillColor: const Color(0xFF929292),
                          hintText: 'Add Activity Description',
                          border:
                              OutlineInputBorder(borderRadius: kBorderRadius),
                        ),
                        validator: (_descriptionController) {
                          if (_descriptionController!.isNotEmpty) {
                            return null;
                          } else {
                            return 'Plase enter your description';
                          }
                        },
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
                          if (!_formKey.currentState!.validate()) {
                            return;
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                               return LoadingScreen();
                              },
                            );
                            Future.delayed(Duration(seconds: 1), (){
                              final description = _descriptionController.text;
                              final location = _locationController.text;
                              BlocProvider.of<MedicalBloc>(context)
                                  .add(CreateMedical(
                                  medicalEntity: MedicalEntity(
                                    pet_id: widget.petEntity.id,
                                    time_publish: Timestamp.fromDate(DateTime.now()),
                                    activity: dropdownHint,
                                    location: location,
                                    description: description,
                                    expired_date: Timestamp.fromDate(dateTime),
                                  )));
                              Navigator.pop(context);
                              Navigator.pop(context);
                            });
                            // Navigator.pop(context);
                          }
                        },
                        text: 'Save Medical Activity'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

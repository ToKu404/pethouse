import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/presentation/widgets/loading_screen.dart';
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
        title: const Text('Medical Activity',
            style: const TextStyle(color: Colors.black)),
        leading: const btnBack_decoration(),
        centerTitle: true,
        elevation: 1,
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
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Your Lovely Animal Medical Activity',
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
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                            labelText: 'Select Activity',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        icon: const Icon(Icons.arrow_drop_down_rounded),
                        style: GoogleFonts.poppins(
                          color: const Color.fromARGB(255, 109, 109, 109),
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
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: CustomDatePicker(
                              icon: const Icon(Icons.date_range_rounded),
                              tanggalAkhir:
                                  DateTime.now().add(const Duration(days: 366)),
                              tanggalAwal: DateTime.now(),
                              initDate:
                                  DateTime.now().add(const Duration(days: 1)),
                              onDateChanged: (selectedDate) {
                                dateTime = selectedDate;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _locationController,
                        decoration: InputDecoration(
                          fillColor: const Color(0xFF929292),
                          labelText: 'Location',
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
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          fillColor: const Color(0xFF929292),
                          labelText: 'Description',
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
                            }
                          });
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

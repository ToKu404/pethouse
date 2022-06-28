// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:adopt/domain/entities/adopt_enitity.dart';
import 'package:adopt/presentation/blocs/open_adopt_bloc/open_adopt_bloc.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class OpenAdoptPage extends StatefulWidget {
  const OpenAdoptPage({Key? key}) : super(key: key);

  @override
  State<OpenAdoptPage> createState() => _OpenAdoptPageState();
}

class _OpenAdoptPageState extends State<OpenAdoptPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _petNameController = TextEditingController();
  final TextEditingController _petBreedController = TextEditingController();
  final TextEditingController _petOtherTypeController = TextEditingController();

  final TextEditingController _petDateBirthController = TextEditingController();
  final TextEditingController _petDescriptionController =
      TextEditingController();
  final TextEditingController _whatsappNumberController =
      TextEditingController();
  final TextEditingController _petCertificateController =
      TextEditingController();
  Gender? _petGender;
  String? _petType;
  String? _petPhotoPath;
  String? _petCertificatePath;
  Timestamp? _petDateOfBirth;

  @override
  void dispose() {
    _petNameController.dispose();
    _petBreedController.dispose();
    _petDescriptionController.dispose();
    _petDateBirthController.dispose();
    _petOtherTypeController.dispose();
    _whatsappNumberController.dispose();
    _petCertificateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<OpenAdoptBloc>(context).add(OpenAdoptInit());
  }

  void _submitOpenAdopt() {
    String petName = _petNameController.text;
    String petType = _petType ?? '';
    String petGender = "";
    if (_petGender != null) {
      petGender = _petGender == Gender.female ? "Female" : "Male";
    }
    String petBreed = _petBreedController.text;

    String petDescription = _petDescriptionController.text;
    String waNumber = _whatsappNumberController.text;
    if (waNumber != '') {
      if (waNumber.startsWith('0')) {
        waNumber = waNumber.replaceFirst(RegExp(r'0'), '');
      }
      if (!waNumber.startsWith('62')) {
        waNumber = '62$waNumber';
      }
    }
    String petTypeText = petType;
    if (_petType == 'Other') {
      petTypeText = _petOtherTypeController.text;
    }
    AdoptEntity adoptEntity = AdoptEntity(
        petName: petName,
        petType: petType,
        petBreed: petBreed,
        dateOfBirth: _petDateOfBirth,
        certificateUrl: _petCertificatePath,
        petPictureUrl: _petPhotoPath,
        gender: petGender,
        petDescription: petDescription,
        petTypeText: petTypeText,
        whatsappNumber: waNumber,
        status: 'open');
    context
        .read<OpenAdoptBloc>()
        .add(SubmitOpenAdopt(adoptEntity: adoptEntity));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        title: 'Open Adopt',
      ),
      body: SafeArea(
          child: BlocConsumer<OpenAdoptBloc, OpenAdoptState>(
        listener: (context, state) {
          if (state is OpenAdoptError) {
          } else if (state is OpenAdoptSuccess) {}
          if (state is UploadPetPhotoSuccess) {
            _petPhotoPath = state.petPhotoPath;
          }
          if (state is UploadPetCertificateSuccess) {
            _petCertificateController.text = state.petCertificateFileName;
            _petCertificatePath = state.petCertificatePath;
          }
        },
        builder: (context, state) {
          if (state is OpenAdoptLoading) {
            return const LoadingView();
          } else {
            return Padding(
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
                      _buildInputPetPicture(),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildInputPetName(),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildInputPetType(),
                      const SizedBox(
                        height: 20,
                      ),
                      _petType == 'Other'
                          ? Column(
                              children: [
                                _buildInputOtherPetType(),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            )
                          : Container(),
                      _buildInputPetGender(),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildInputDateOfBirth(),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildInputPetBreed(),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildInputCertificate(),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildInputPetDescription(),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildInputWhatsappNumber(),
                      const SizedBox(
                        height: 20,
                      ),
                      DefaultButton(
                        height: 55,
                        width: double.infinity,
                        onTap: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.INFO,
                            animType: AnimType.BOTTOMSLIDE,
                            title: 'Apakah Anda Sudah Yakin?',
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const LoadingView();
                                },
                              );
                              Future.delayed(const Duration(seconds: 1), () {
                                if (!formKey.currentState!.validate()) {
                                  Navigator.pop(context);
                                  return;
                                } else {
                                  _submitOpenAdopt();
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }
                              });
                            },
                          ).show();
                          if (formKey.currentState!.validate()) {}
                        },
                        text: 'Save Pet',
                        isClicked: false,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      )),
    );
  }

  Widget _buildInputPetPicture() {
    return InkWell(
      child: BlocBuilder<OpenAdoptBloc, OpenAdoptState>(
        builder: (context, state) {
          if (state is UploadPetPhotoSuccess) {
            return Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                  color: const Color(0XFFF3F3F3),
                  borderRadius: BorderRadius.circular(7),
                  image: DecorationImage(
                      image: FileImage(File(state.petPhotoPath)),
                      fit: BoxFit.cover)),
            );
          } else {
            return Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                color: const Color(0XFFF3F3F3),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.add_photo_alternate_outlined,
                    color: kDarkBrown,
                    size: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child:
                        Text(kOpenAdoptAddPicture, style: kTextTheme.subtitle1),
                  ),
                ],
              ),
            );
          }
        },
      ),
      onTap: () =>
          BlocProvider.of<OpenAdoptBloc>(context).add(UploadPetPhoto()),
    );
  }

  Widget _buildInputPetName() {
    return TextFormField(
      controller: _petNameController,
      decoration: InputDecoration(
          fillColor: const Color(0xFF929292),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelText: 'Pet Name'),
      validator: (value) {
        if (value!.isEmpty || !RegExp(r'^[a-z A-Z 0-9]+$').hasMatch(value)) {
          return "Enter correct name";
        } else {
          return null;
        }
      },
    );
  }

  Widget _buildInputPetGender() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildGenderCard(Gender.male, 'Male', Icons.male, Colors.blue),
        const SizedBox(
          width: 10,
        ),
        _buildGenderCard(Gender.female, 'Female', Icons.female, Colors.red),
      ],
    );
  }

  Widget _buildGenderCard(
      Gender gender, String name, IconData icon, Color color) {
    return Expanded(
      child: InkWell(
        child: Container(
          height: 55,
          decoration: BoxDecoration(
            borderRadius: kBorderRadius,
            border: Border.all(
              color: (_petGender == gender && _petGender != null)
                  ? color
                  : Colors.grey,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  icon,
                  color: color,
                ),
              ),
              Expanded(
                child: Text(name,
                    style: kTextTheme.headline3?.copyWith(color: color)),
              ),
            ],
          ),
        ),
        onTap: () {
          setState(() {
            _petGender = gender;
          });
        },
      ),
    );
  }

  Widget _buildInputDateOfBirth() {
    final DateFormat dateFormat = DateFormat.yMMMEd();
    return TextFormField(
      readOnly: true,
      controller: _petDateBirthController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          suffixIcon: const Icon(Icons.calendar_month),
          labelText: 'Date Of Birth'),
      onTap: () {
        showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now())
            .then((pickedDate) {
          // Check if no date is selected
          if (pickedDate == null) {
            return;
          }
          setState(() {
            _petDateOfBirth = Timestamp.fromDate(pickedDate);
            _petDateBirthController.text = dateFormat.format(pickedDate);
          });
        });
      },
    );
  }

  Widget _buildInputPetType() {
    final petTypeList = [
      'Cat',
      'Dog',
      'Bird',
      'Hamster',
      'Fish',
      'Rabbit',
      'Other'
    ];
    return DropdownButtonFormField(
      decoration: InputDecoration(
        labelText: 'Pet Type',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimaryColor, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      value: _petType,
      icon: const Icon(Icons.arrow_drop_down_rounded),
      style: kTextTheme.headline3?.copyWith(color: kDarkBrown),
      validator: (value) {
        if (value == null) {
          return "Choice Pet Type";
        } else {
          return null;
        }
      },
      items: petTypeList
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: (String? value) {
        setState(() {
          _petType = value ?? '';
        });
      },
    );
  }

  Widget _buildInputPetBreed() {
    return TextFormField(
      controller: _petBreedController,
      decoration: InputDecoration(
        fillColor: const Color(0xFF929292),
        labelText: 'Pet Breed',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimaryColor, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget _buildInputCertificate() {
    return TextFormField(
      controller: _petCertificateController,
      readOnly: true,
      onTap: () {
        BlocProvider.of<OpenAdoptBloc>(context).add(UploadPetCertificate());
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.upload),
        fillColor: const Color(0xFF929292),
        labelText: 'Pet Certificate',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimaryColor, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget _buildInputPetDescription() {
    return TextFormField(
      controller: _petDescriptionController,
      decoration: InputDecoration(
        fillColor: const Color(0xFF929292),
        alignLabelWithHint: true,
        labelText: 'Pet Description',
        border: OutlineInputBorder(borderRadius: kBorderRadius),
      ),
      maxLines: 5,
    );
  }

  Widget _buildInputWhatsappNumber() {
    return TextFormField(
      controller: _whatsappNumberController,
      decoration: InputDecoration(
        prefix: const Text("+62 "),
        prefixIcon: const Icon(Icons.whatsapp),
        fillColor: const Color(0xFF929292),
        labelText: 'Whatsapp Number',
        border: OutlineInputBorder(borderRadius: kBorderRadius),
      ),
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value!.isNotEmpty && !RegExp(r'^[0-9]+$').hasMatch(value)) {
          return "Enter correct phone number";
        } else {
          return null;
        }
      },
    );
  }

  _buildInputOtherPetType() {
    return TextFormField(
      controller: _petOtherTypeController,
      decoration: InputDecoration(
          fillColor: const Color(0xFF929292),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelText: 'Other Pet Type'),
      validator: (value) {
        if (value!.isEmpty || !RegExp(r'^[a-z A-Z 0-9]+$').hasMatch(value)) {
          return "Enter correct pet type";
        } else {
          return null;
        }
      },
    );
  }
}

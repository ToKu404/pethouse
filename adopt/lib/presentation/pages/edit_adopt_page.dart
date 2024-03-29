// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:adopt/domain/entities/adopt_enitity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../blocs/edit_adopt_bloc/edit_adopt_bloc.dart';

class EditAdoptPage extends StatefulWidget {
  final AdoptEntity adoptPet;
  const EditAdoptPage({Key? key, required this.adoptPet}) : super(key: key);
  @override
  State<EditAdoptPage> createState() => _EditAdoptPageState();
}

class _EditAdoptPageState extends State<EditAdoptPage> {
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
  String _petType = '';
  String _petPhotoPath = '';
  String _petCertificatePath = '';
  Timestamp? _petDateOfBirth;

  @override
  void dispose() {
    _petNameController.dispose();
    _petBreedController.dispose();
    _petOtherTypeController.dispose();
    _petDescriptionController.dispose();
    _petDateBirthController.dispose();
    _whatsappNumberController.dispose();
    _petCertificateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _petNameController.text = widget.adoptPet.petName ?? '';
    if (widget.adoptPet.petBreed != null && widget.adoptPet.petBreed != '') {
      _petBreedController.text = widget.adoptPet.petBreed ?? '';
    }
    if (widget.adoptPet.dateOfBirth != null) {
      final format = DateFormat.yMMMEd(); // <- use skeleton here
      _petDateBirthController.text =
          format.format(widget.adoptPet.dateOfBirth!.toDate());
      _petDateOfBirth = widget.adoptPet.dateOfBirth;
    }
    if (widget.adoptPet.petDescription != null &&
        widget.adoptPet.petDescription != '') {
      _petDescriptionController.text = widget.adoptPet.petDescription ?? '';
    }
    if (widget.adoptPet.whatsappNumber != null &&
        widget.adoptPet.whatsappNumber != '') {
      _whatsappNumberController.text = widget.adoptPet.whatsappNumber ?? '';
    }
    if (widget.adoptPet.petTypeText != null &&
        widget.adoptPet.petTypeText != '') {
      _petOtherTypeController.text = widget.adoptPet.petTypeText ?? '';
    }
    if (widget.adoptPet.certificateUrl != null &&
        widget.adoptPet.certificateUrl != '') {
      _petCertificateController.text = widget.adoptPet.certificateUrl ?? '';
    }
    if (widget.adoptPet.gender != null && widget.adoptPet.gender != '') {
      _petGender =
          widget.adoptPet.gender == 'Male' ? Gender.male : Gender.female;
    }
    if (widget.adoptPet.petType != null && widget.adoptPet.petType != '') {
      _petType = widget.adoptPet.petType ?? '';
    }

    if (widget.adoptPet.certificateUrl != null &&
        widget.adoptPet.certificateUrl != '') {
      String url = widget.adoptPet.certificateUrl!;
      final result = TextGeneratorHelper.firestorageLinkRegex
          .allMatches(url)
          .map((e) => e.group(1))
          .toList();
      _petCertificateController.text = result[0] ?? '';
    }
  }

  void _submitEditAdopt() {
    String petName = _petNameController.text;
    String petType = _petType;
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
        petTypeText: petTypeText,
        certificateUrl: _petCertificatePath,
        petPictureUrl: _petPhotoPath,
        gender: petGender,
        petDescription: petDescription,
        whatsappNumber: waNumber,
        status: 'open');

    BlocProvider.of<EditAdoptBloc>(context).add(SubmitUpdateAdopt(
        adoptEntityNew: adoptEntity, adoptEntityOld: widget.adoptPet));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        title: 'Edit Adopt',
      ),
      body: SafeArea(
          child: BlocConsumer<EditAdoptBloc, EditAdoptState>(
              listener: (context, state) {
        if (state is EditAdoptError) {
          print(state.message);
        } else if (state is EditAdoptSuccess) {
          showSuccessDialog(context, title: 'Success Edit Adopt');
          Future.delayed(const Duration(seconds: 2), () async {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
          });
        }
        if (state is EditPetPhotoSuccess) {
          _petPhotoPath = state.petPhotoPath;
        }
        if (state is EditPetCertificateSuccess) {
          _petCertificateController.text = state.petCertificateFileName;
          _petCertificatePath = state.petCertificatePath;
        }
      }, builder: (context, state) {
        if (state is EditAdoptLoading) {
          return const LoadingView();
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPadding * 2),
            child: SingleChildScrollView(
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
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                            if (formKey.currentState!.validate()) {
                              showQuestionDialog(context,
                                  title: 'Confirm Update Open Adopt',
                                  onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const LoadingView();
                                  },
                                );
                                _submitEditAdopt();
                              });
                            }
                          },
                          text: 'Update Pet',
                          isClicked: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      })),
    );
  }

  Widget _buildInputPetPicture() {
    if (_petPhotoPath != '') {
      return InkWell(
        child: Container(
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(
            color: const Color(0XFFF3F3F3),
            borderRadius: BorderRadius.circular(7),
            image: DecorationImage(
                image: FileImage(File(_petPhotoPath)), fit: BoxFit.cover),
          ),
        ),
        onTap: () {
          BlocProvider.of<EditAdoptBloc>(context).add(EditPetPhoto());
        },
      );
    } else {
      if (widget.adoptPet.petPictureUrl == '' ||
          widget.adoptPet.petPictureUrl == null) {
        return InkWell(
          child: Container(
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
          ),
          onTap: () =>
              BlocProvider.of<EditAdoptBloc>(context).add(EditPetPhoto()),
        );
      } else {
        return InkWell(
          child: Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              color: const Color(0XFFF3F3F3),
              borderRadius: BorderRadius.circular(7),
              image: DecorationImage(
                  image: NetworkImage(widget.adoptPet.petPictureUrl ?? ''),
                  fit: BoxFit.cover),
            ),
          ),
          onTap: () =>
              BlocProvider.of<EditAdoptBloc>(context).add(EditPetPhoto()),
        );
      }
    }
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
                initialDate: _petDateOfBirth != null
                    ? _petDateOfBirth!.toDate()
                    : DateTime.now(),
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
        BlocProvider.of<EditAdoptBloc>(context).add(EditPetCertificate());
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

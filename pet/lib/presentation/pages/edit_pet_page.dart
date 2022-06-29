import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pet/domain/entities/pet_entity.dart';

import '../bloc/update_pet/update_pet_bloc.dart';

class EditPetPage extends StatefulWidget {
  final PetEntity pet;
  const EditPetPage({Key? key, required this.pet}) : super(key: key);
  @override
  State<EditPetPage> createState() => _EditPetPageState();
}

class _EditPetPageState extends State<EditPetPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _petNameController = TextEditingController();
  final TextEditingController _petBreedController = TextEditingController();
  final TextEditingController _petDateBirthController = TextEditingController();
  final TextEditingController _petOtherTypeController = TextEditingController();

  final TextEditingController _petDescriptionController =
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
    _petDescriptionController.dispose();
    _petDateBirthController.dispose();
    _petOtherTypeController.dispose();
    _petCertificateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _petNameController.text = widget.pet.petName ?? '';
    if (widget.pet.petBreed != null && widget.pet.petBreed != '') {
      _petBreedController.text = widget.pet.petBreed ?? '';
    }
    if (widget.pet.dateOfBirth != null) {
      final format = DateFormat.yMMMEd(); // <- use skeleton here
      _petDateBirthController.text =
          format.format(widget.pet.dateOfBirth!.toDate());
      _petDateOfBirth = widget.pet.dateOfBirth;
    }
    if (widget.pet.petDescription != null && widget.pet.petDescription != '') {
      _petDescriptionController.text = widget.pet.petDescription ?? '';
    }

    if (widget.pet.petTypeText != null && widget.pet.petTypeText != '') {
      _petOtherTypeController.text = widget.pet.petTypeText ?? '';
    }

    if (widget.pet.certificateUrl != null && widget.pet.certificateUrl != '') {
      _petCertificateController.text = widget.pet.certificateUrl ?? '';
    }
    if (widget.pet.gender != null && widget.pet.gender != '') {
      _petGender = widget.pet.gender == 'Male' ? Gender.male : Gender.female;
    }
    if (widget.pet.petType != null && widget.pet.petType != '') {
      _petType = widget.pet.petType ?? '';
    }

    final firebaseRegex = RegExp(r'%2F([\d\D]*\.[\D]+)\?',
        multiLine: false, caseSensitive: false);

    if (widget.pet.certificateUrl != null && widget.pet.certificateUrl != '') {
      String url = widget.pet.certificateUrl!;
      final result =
          firebaseRegex.allMatches(url).map((e) => e.group(1)).toList();
      _petCertificateController.text = result[0] ?? '';
    }
  }

  void _submitUpdatePet() {
    String petName = _petNameController.text;
    String petType = _petType;
    String petGender = "";
    if (_petGender != null) {
      petGender = _petGender == Gender.female ? "Female" : "Male";
    }
    String petBreed = _petBreedController.text;

    String petDescription = _petDescriptionController.text;

    String petTypeText = petType;
    if (_petType == 'Other') {
      petTypeText = _petOtherTypeController.text;
    }

    PetEntity petEntity = PetEntity(
      petName: petName,
      petType: petType,
      petBreed: petBreed,
      dateOfBirth: _petDateOfBirth,
      petTypeText: petTypeText,
      certificateUrl: _petCertificatePath,
      petPictureUrl: _petPhotoPath,
      gender: petGender,
      petDescription: petDescription,
    );

    context.read<UpdatePetBloc>().add(SubmitUpdatePetEvent(
        petEntityNew: petEntity, petEntityOld: widget.pet));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        title: 'Edit Pet',
      ),
      body: SafeArea(
          child: BlocConsumer<UpdatePetBloc, UpdatePetState>(
              listener: (context, state) {
        if (state is UpdatePetError) {
          print(state.message);
        } else if (state is UpdatePetSuccess) {}
        if (state is UpdatePetPhotoSuccess) {
          _petPhotoPath = state.petPhotoPath;
        }
        if (state is UpdatePetCertificateSuccess) {
          _petCertificateController.text = state.petCertificateFileName;
          _petCertificatePath = state.petCertificatePath;
        }
      }, builder: (context, state) {
        if (state is UpdatePetLoading) {
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
                        DefaultButton(
                          height: 55,
                          width: double.infinity,
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              showInfoDialog(
                                context,
                                title: "Confirm update pet data",
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const LoadingView();
                                    },
                                  );
                                  _submitUpdatePet();
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                              );
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
          BlocProvider.of<UpdatePetBloc>(context).add(UpdatePetPhoto());
        },
      );
    } else {
      if (widget.pet.petPictureUrl == '' || widget.pet.petPictureUrl == null) {
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
                  child: Text(
                    kOpenAdoptAddPicture,
                    style: kTextTheme.subtitle1,
                  ),
                ),
              ],
            ),
          ),
          onTap: () =>
              BlocProvider.of<UpdatePetBloc>(context).add(UpdatePetPhoto()),
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
                  image: NetworkImage(widget.pet.petPictureUrl ?? ''),
                  fit: BoxFit.cover),
            ),
          ),
          onTap: () =>
              BlocProvider.of<UpdatePetBloc>(context).add(UpdatePetPhoto()),
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
        BlocProvider.of<UpdatePetBloc>(context).add(UpdatePetCertificate());
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

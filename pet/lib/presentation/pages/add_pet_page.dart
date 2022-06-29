import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pet/presentation/bloc/add_pet/add_pet_bloc.dart';
import '../../domain/entities/pet_entity.dart';

class AddPetPage extends StatefulWidget {
  const AddPetPage({Key? key}) : super(key: key);

  @override
  State<AddPetPage> createState() => _AddPetPageState();
}

class _AddPetPageState extends State<AddPetPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _petNameController = TextEditingController();
  final TextEditingController _petOtherTypeController = TextEditingController();

  final TextEditingController _petBreedController = TextEditingController();
  final TextEditingController _petDateBirthController = TextEditingController();
  final TextEditingController _petDescriptionController =
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
    _petOtherTypeController.dispose();
    _petDescriptionController.dispose();
    _petDateBirthController.dispose();
    _petCertificateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<AddPetBloc>(context).add(AddPetInitEvent());
  }

  void _submitAddPet() {
    String petName = _petNameController.text;
    String petType = _petType ?? '';
    String petGender = "";
    if (_petGender != null) {
      petGender = _petGender == Gender.female ? "Female" : "Male";
    }
    String petBreed = _petBreedController.text;
    String petTypeText = petType;
    if (_petType == 'Other') {
      petTypeText = _petOtherTypeController.text;
    }

    String petDescription = _petDescriptionController.text;
    PetEntity petEntity = PetEntity(
      petName: petName,
      petType: petType,
      petBreed: petBreed,
      dateOfBirth: _petDateOfBirth,
      certificateUrl: _petCertificatePath,
      petPictureUrl: _petPhotoPath,
      gender: petGender,
      petTypeText: petTypeText,
      petDescription: petDescription,
    );
    context.read<AddPetBloc>().add(SubmitAddPetEvent(petEntity: petEntity));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        title: 'Add Pet',
      ),
      body: SafeArea(
          child: BlocConsumer<AddPetBloc, AddPetState>(
        listener: (context, state) {
          if (state is AddPetError) {
            print(state.message);
          } else if (state is AddPetSuccess) {}
          if (state is AddPetPhotoSuccess) {
            _petPhotoPath = state.petPhotoPath;
          }
          if (state is AddPetCertificateSuccess) {
            _petCertificateController.text = state.petCertificateFileName;
            _petCertificatePath = state.petCertificatePath;
          }
        },
        builder: (context, state) {
          if (state is AddPetLoading) {
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
                      DefaultButton(
                        height: 55,
                        width: double.infinity,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            showInfoDialog(
                              context,
                              title: "Confirm Add New Pet",
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const LoadingView();
                                  },
                                );
                                _submitAddPet();
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            );
                          }
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
      child: BlocBuilder<AddPetBloc, AddPetState>(
        builder: (context, state) {
          if (state is AddPetPhotoSuccess) {
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
      onTap: () => BlocProvider.of<AddPetBloc>(context).add(AddPetPhotoEvent()),
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
                child: Text(name, style: kTextTheme.headline3),
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
        BlocProvider.of<AddPetBloc>(context).add(AddPetCertificateEvent());
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

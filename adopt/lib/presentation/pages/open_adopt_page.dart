import 'dart:io';

import 'package:adopt/domain/entities/adopt_enitity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:core/presentation/widgets/appbar_back_button.dart';
import 'package:core/presentation/widgets/gradient_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../blocs/pet_adopt_bloc/pet_adopt_bloc.dart';

class OpenAdoptPage extends StatefulWidget {
  const OpenAdoptPage({Key? key}) : super(key: key);

  @override
  State<OpenAdoptPage> createState() => _OpenAdoptPageState();
}

class _OpenAdoptPageState extends State<OpenAdoptPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _petNameController = TextEditingController();
  final TextEditingController _petBreedController = TextEditingController();
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
    _whatsappNumberController.dispose();
    _petCertificateController.dispose();

    super.dispose();
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
    if (waNumber.startsWith('0')) {
      waNumber = waNumber.replaceFirst(RegExp(r'0'), '');
    }
    if (!waNumber.startsWith('62')) {
      waNumber = '62$waNumber';
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
      whatsappNumber: waNumber,
    );
    context.read<PetAdoptBloc>().add(SubmitOpenAdopt(adoptEntity: adoptEntity));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text(kOpenAdoptTitle, style: TextStyle(color: Colors.black)),
        leading: const AppBarBackButton(),
        centerTitle: true,
        elevation: 1,
        backgroundColor: kWhite,
      ),
      body: SafeArea(
          child: BlocConsumer<PetAdoptBloc, PetAdoptState>(
        listener: (context, state) {
          if (state is PetAdoptError) {
            print(state.message);
          } else if (state is OpenAdoptSuccess) {
            Future.delayed(Duration(seconds: 1), () {
              Navigator.pop(context);
            });
          }
          if (state is UploadPetPhotoSuccess) {
            _petPhotoPath = state.petPhotoPath;
          }
          if (state is UploadPetCertificateSuccess) {
            _petCertificateController.text = state.petCertificateFileName;
            _petCertificatePath = state.petCertificatePath;
          }
        },
        builder: (context, state) {
          if (state is PetAdoptLoading) {
            return Center(child: CircularProgressIndicator());
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
                      GradientButton(
                        height: 55,
                        width: double.infinity,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            _submitOpenAdopt();
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
      child: BlocBuilder<PetAdoptBloc, PetAdoptState>(
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
                    child: Text(
                      kOpenAdoptAddPicture,
                      style: GoogleFonts.poppins(
                        color: kDarkBrown,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
      onTap: () => BlocProvider.of<PetAdoptBloc>(context).add(UploadPetPhoto()),
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
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  icon,
                  color: color,
                ),
              ),
              Expanded(
                child: Text(
                  name,
                  style: GoogleFonts.poppins(
                    color: color,
                    fontSize: 14,
                  ),
                ),
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
    final DateFormat _dateFormat = DateFormat.yMMMEd();
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
            _petDateBirthController.text = _dateFormat.format(pickedDate);
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
        BlocProvider.of<PetAdoptBloc>(context).add(UploadPetCertificate());
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
}

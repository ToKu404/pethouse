import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet/domain/entities/pet_entity.dart';
import 'package:pet/presentation/bloc/add_pet/add_pet_bloc.dart';

import '../widgets/btnback_decoration.dart';
import '../widgets/date_picker.dart';
import '../widgets/gredient_button.dart';

class AddPet extends StatefulWidget {
  static const ROUTE_NAME = 'add_pet';

  @override
  State<AddPet> createState() => _AddPetState();
}

class _AddPetState extends State<AddPet> {
  DateTime dateTime = DateTime.now();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String imgUrl = '';
  String ctfUrl = '';
  String gender = '';
  bool isPhotoUploaded = false;
  bool isCertificateUploaded = false;
  int _selectedGender = 0;
  String dropdownHint = 'Select Type of Pet';
  final List<String> dropdownPetList = [
    'Select Type of Pet',
    'Cat',
    'Dog',
    'Hamster',
    'Fish',
  ];

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _breedController.dispose();
    _descriptionController.dispose();
    imgUrl = '';
    gender = '';
    isPhotoUploaded = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddPetBloc, AddPetState>(
      listener: (context, state) {
        if (state is UpPhotoSucces) {
          imgUrl = state.imgUrl;
          isPhotoUploaded = true;
        }
        if (state is UpCertificateSucces) {
          ctfUrl = state.ctfUrl;
          isCertificateUploaded = true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add  Pet', style: TextStyle(color: Colors.black)),
          leading: btnBack_decoration(),
          centerTitle: true,
          elevation: 5,
          backgroundColor: kWhite,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      BlocProvider.of<AddPetBloc>(context).add(SetPhoto());
                    },
                    child: Container(
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                        image: (isPhotoUploaded == true)
                            ? DecorationImage(
                                image: NetworkImage(imgUrl),
                                // 'https://asset.kompas.com/crops/SV5q4gPkeD8YJTuzO31BqTr9DEI=/192x128:1728x1152/750x500/data/photo/2021/03/06/60436a28b258b.jpg'),
                                fit: BoxFit.cover,
                              )
                            : null,
                        color: const Color(0XFFF3F3F3),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: (isPhotoUploaded == true)
                          ? null
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.add_photo_alternate_outlined,
                                  color: kDarkBrown,
                                  size: 40,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Text(
                                    'Add Picture',
                                    style: TextStyle(
                                      color: kDarkBrown,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Pet Type',
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                    value: dropdownHint,
                                    icon: const Icon(
                                        Icons.arrow_drop_down_rounded),
                                    style: GoogleFonts.poppins(
                                      color: Color.fromARGB(255, 109, 109, 109),
                                      fontSize: 16,
                                    ),
                                    items: dropdownPetList
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
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
                          const Padding(
                            padding: EdgeInsets.only(
                              bottom: 10,
                            ),
                            child: Text(
                              'Pet Name',
                              style: TextStyle(
                                color: kDarkBrown,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              fillColor: const Color(0xFF929292),
                              hintText: 'Add Pet Name',
                              border: OutlineInputBorder(
                                  borderRadius: kBorderRadius),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                              bottom: 10,
                              top: 10,
                            ),
                            child: Text(
                              'Gender',
                              style: TextStyle(
                                color: kDarkBrown,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomGender(
                                  1, 'Female', Icons.female, false, Colors.red),
                              SizedBox(
                                width: 30,
                              ),
                              CustomGender(
                                  2, 'Male', Icons.male, false, Colors.blue),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                              bottom: 10,
                              top: 10,
                            ),
                            child: Text(
                              'Date of Birth',
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
                                  tanggalAwal: DateTime.utc(1900, 1, 1),
                                  initDate:
                                      DateTime.now().add(Duration(days: 1)),
                                  onDateChanged: (selectedDate) {
                                    dateTime = selectedDate;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            child: Text(
                              'Breed',
                              style: TextStyle(
                                color: kDarkBrown,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: _breedController,
                            decoration: InputDecoration(
                              fillColor: const Color(0xFF929292),
                              hintText: 'Add Pet Breed',
                              border: OutlineInputBorder(
                                  borderRadius: kBorderRadius),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            child: Text(
                              'Certificate',
                              style: TextStyle(
                                color: kDarkBrown,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              BlocProvider.of<AddPetBloc>(context)
                                  .add(SetCertificate());
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: kBorderRadius,
                                border: Border.all(
                                  color: Color(0xFF929292),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.upload,
                                    color: Color(0xFF929292),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Text(
                                    (isCertificateUploaded == true)
                                        ? 'Certificate Has Been Chosen'
                                        : 'Select From Directory',
                                    style: TextStyle(
                                      color: (isCertificateUploaded == true)
                                          ? kSecondaryColor
                                          : Color(0xFF929292),
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
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
                              hintText: 'Add Pet Description',
                              border: OutlineInputBorder(
                                  borderRadius: kBorderRadius),
                            ),
                            maxLines: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                            ),
                            child: GradientButton(
                                height: 50,
                                width: double.infinity,
                                onTap: () {
                                  final name = _nameController.text;
                                  final breed = _breedController.text;
                                  final description =
                                      _descriptionController.text;
                                  BlocProvider.of<AddPetBloc>(context)
                                      .add(CreatePet(
                                          petEntity: PetEntity(
                                    imgUrl: imgUrl,
                                    petType: dropdownHint,
                                    name: name,
                                    gender: gender,
                                    dateOfBirth: dateTime,
                                    breed: breed,
                                    fileUrl: ctfUrl,
                                    description: description,
                                  )));
                                },
                                text: 'Save Pet'),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget CustomGender(
      int Index, String name, IconData icon, bool isSelected, Color color) {
    return Expanded(
      child: InkWell(
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: kBorderRadius,
            border: Border.all(
              color: (_selectedGender == Index) ? kPrimaryColor : Colors.grey,
              width: (_selectedGender == Index) ? 2 : 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                color: color,
              ),
              Text(
                name,
                style: TextStyle(
                  color: color,
                  fontWeight: (_selectedGender == Index)
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          setState(() {
            _selectedGender = Index;
            gender = name;
          });
        },
      ),
    );
  }

// class GenderRadio extends StatefulWidget {
//   @override
//   State<GenderRadio> createState() => _GenderRadioState();
// }

// class _GenderRadioState extends State<GenderRadio> {

//   @override
//   Widget CustomGender(
//       int Index, String name, IconData icon, bool isSelected, Color color) {
//     return Expanded(
//       child: InkWell(
//         child: Container(
//           height: 50,
//           decoration: BoxDecoration(
//             color: kWhite,
//             borderRadius: kBorderRadius,
//             border: Border.all(
//               color: (_selectedGender == Index) ? kPrimaryColor : Colors.grey,
//               width: (_selectedGender == Index) ? 2 : 1,
//             ),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Icon(
//                 icon,
//                 color: color,
//               ),
//               Text(
//                 name,
//                 style: TextStyle(
//                   color: color,
//                   fontWeight: (_selectedGender == Index)
//                       ? FontWeight.bold
//                       : FontWeight.normal,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         onTap: () {
//           setState(() {
//             _selectedGender = Index;
//           });
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         CustomGender(1, 'Female', Icons.female, false, Colors.red),
//         SizedBox(
//           width: 30,
//         ),
//         CustomGender(2, 'Male', Icons.male, false, Colors.blue),
//       ],
//     );
//   }
}

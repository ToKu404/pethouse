import 'package:flutter/material.dart';
import 'package:pethouse/presentation/widgets/btnback_decoration.dart';
import 'package:pethouse/presentation/widgets/date_picker.dart';
import 'package:pethouse/presentation/widgets/gredient_button.dart';
import 'package:core/core.dart';

class AddPet extends StatelessWidget {
  static const ROUTE_NAME = 'add_pet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    color: const Color(0XFFF3F3F3),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: InkWell(
                    child: Column(
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
                          autofocus: true,
                          decoration: InputDecoration(
                            fillColor: const Color(0xFF929292),
                            hintText: 'Add Pet Name',
                            border:
                                OutlineInputBorder(borderRadius: kBorderRadius),
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
                        GenderRadio(),
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
                                tanggalAwal: DateTime.now(),
                                initDate: DateTime.now().add(Duration(days: 1)),
                                onDateChanged: (selectedDate) {
                                  // Aksi yang diperlukan saat mengganti kalender
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
                          decoration: InputDecoration(
                            fillColor: const Color(0xFF929292),
                            hintText: 'Add Pet Breed',
                            border:
                                OutlineInputBorder(borderRadius: kBorderRadius),
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
                                  'Select From Directory',
                                  style: TextStyle(
                                    color: Color(0xFF929292),
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
                          decoration: InputDecoration(
                            fillColor: const Color(0xFF929292),
                            hintText: 'Add Pet Description',
                            border:
                                OutlineInputBorder(borderRadius: kBorderRadius),
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
                              onTap: () {},
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
    );
  }
}

class GenderRadio extends StatefulWidget {
  @override
  State<GenderRadio> createState() => _GenderRadioState();
}

class _GenderRadioState extends State<GenderRadio> {
  int _selectedGender = 0;

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
              width: 1,
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
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomGender(1, 'Female', Icons.female, false, Colors.red),
        SizedBox(
          width: 30,
        ),
        CustomGender(2, 'Male', Icons.male, false, Colors.blue),
      ],
    );
  }
}

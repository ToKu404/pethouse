import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pethouse/presentation/widgets/btnback_decoration.dart';
import 'package:pethouse/presentation/widgets/custom_dropdown.dart';
import 'package:pethouse/presentation/widgets/date_picker.dart';
import 'package:pethouse/presentation/widgets/gredient_button.dart';
import 'package:pethouse/utils/styles.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medical Activity',
      theme: ThemeData(colorScheme: kColorScheme),
      home: const AddMedicalActivity(),
    );
  }
}

class AddMedicalActivity extends StatelessWidget {
  static const ROUTE_NAME = "medical_activity";

  const AddMedicalActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Update Your Password', style: TextStyle(color: Colors.black)),
        leading: btnBack_decoration(),
        centerTitle: true,
        elevation: 5,
        backgroundColor: kWhite,
      ),
      body: SafeArea(
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
                        child: CustomDropDown(
                          dropdownHint: 'Select Activity',
                          dropdownList: [
                            'Select Activity',
                            'Vaccination',
                            'Sick',
                            'Full Check',
                          ],
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
                              // Aksi yang diperlukan saat mengganti kalender
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
                      decoration: InputDecoration(
                        fillColor: const Color(0xFF929292),
                        hintText: 'Add Activity Location',
                        border: OutlineInputBorder(borderRadius: kBorderRadius),
                      ),
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
                      decoration: InputDecoration(
                        fillColor: const Color(0xFF929292),
                        hintText: 'Add Activity Description',
                        border: OutlineInputBorder(borderRadius: kBorderRadius),
                      ),
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
                      onTap: () {},
                      text: 'Save Medical Activity'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pethouse/presentation/widgets/gredient_button.dart';
import 'package:pethouse/presentation/widgets/sub_appbar.dart';
import 'package:pethouse/utils/styles.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pethouse',
      theme: ThemeData(colorScheme: kColorScheme),
      home: const AddMedicalActivity(),
    );
  }
}

class AddMedicalActivity extends StatelessWidget {
  const AddMedicalActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(57),
        child: CustomAppBar('Medical Activity'),
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
                        child: const DropdownActivityHistory(),
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
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: const Color(0xFF929292),
                              hintText: 'Add Expired Date',
                              border: OutlineInputBorder(
                                  borderRadius: kBorderRadius),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.calendar_month,
                            color: Colors.grey,
                            size: 30,
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

class DropdownActivityHistory extends StatefulWidget {
  const DropdownActivityHistory({Key? key}) : super(key: key);

  @override
  State<DropdownActivityHistory> createState() =>
      _DropdownActivityHistoryState();
}

class _DropdownActivityHistoryState extends State<DropdownActivityHistory> {
  String dropdownValue = 'Select Medical Activity';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_drop_down_rounded),
          style: GoogleFonts.poppins(
            color: Color.fromARGB(255, 109, 109, 109),
            fontSize: 16,
          ),
          items: <String>[
            'Select Medical Activity',
            'Vaccination',
            'Sick',
            'Full Check'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          }),
    );
  }
}

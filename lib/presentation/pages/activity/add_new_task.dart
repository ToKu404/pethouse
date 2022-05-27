import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pethouse/presentation/pages/activity/add_medical_activity.dart';
import 'package:pethouse/presentation/widgets/btnback_decoration.dart';
import 'package:pethouse/presentation/widgets/gredient_button.dart';
import 'package:pethouse/utils/styles.dart';

class AddNewTaskActivity extends StatelessWidget {
  static const ROUTE_NAME = "add_newTask_activity";
  const AddNewTaskActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Task',style: TextStyle(color: Colors.black)),
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
                            'Ikhsan',
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
                    Text(
                      'Activity',
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
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const DropdownActivityHistory(),
                      ),
                    ),
                    const SizedBox(
                      height: 19,
                    ),
                    Text(
                      'Date',
                      style: GoogleFonts.poppins(
                        color: kDarkBrown,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: const Color(0xFF929292),
                              labelText: '02 February 2023',
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
                    const SizedBox(
                      height: 19,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Start Time',
                              style: GoogleFonts.poppins(
                                color: kDarkBrown,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 136,
                              height: 42,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '11.00 Am', style: kTextTheme.subtitle2,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'End Time',
                              style: GoogleFonts.poppins(
                                color: kDarkBrown,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 137,
                              height: 42,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '13.00 Pm', style: kTextTheme.subtitle2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 19,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        fillColor: const Color(0xFF929292),
                        labelText: 'Repeat',
                        border: OutlineInputBorder(borderRadius: kBorderRadius),
                      ),
                    ),
                    const SizedBox(
                      height: 19,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        fillColor: const Color(0xFF929292),
                        labelText: 'Description',
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
                      text: 'Schedule'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

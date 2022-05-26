import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/styles.dart';

class ScheduleTaskList extends StatefulWidget {
  const ScheduleTaskList({Key? key}) : super(key: key);

  @override
  State<ScheduleTaskList> createState() => _ScheduleTaskListState();
}

class _ScheduleTaskListState extends State<ScheduleTaskList> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 54,
        width: double.infinity,
        margin: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: kWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 13,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: 37,
              height: 37,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0XFFFFE7C3),
              ),
              child: Icon(
                Icons.cookie_outlined,
                color: kPrimaryColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: 10,
                bottom: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Maam Whiskas",
                    overflow: TextOverflow.fade,
                    maxLines: 2,
                    style: GoogleFonts.poppins(
                      color: kPrimaryColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "09.00",
                        overflow: TextOverflow.fade,
                        maxLines: 2,
                        style: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 8,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "·",
                          overflow: TextOverflow.fade,
                          maxLines: 2,
                          style: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontSize: 8,
                          ),
                        ),
                      ),
                      Text(
                        "Rumah",
                        overflow: TextOverflow.fade,
                        maxLines: 2,
                        style: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 8,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "·",
                          overflow: TextOverflow.fade,
                          maxLines: 2,
                          style: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontSize: 8,
                          ),
                        ),
                      ),
                      Text(
                        "Daily",
                        overflow: TextOverflow.fade,
                        maxLines: 2,
                        style: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: Checkbox(
                  value: this.isChecked,
                  activeColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  onChanged: (bool? isChecked) {
                    setState(() {
                      this.isChecked = isChecked!;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

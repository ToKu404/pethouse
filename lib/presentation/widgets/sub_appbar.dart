import 'package:flutter/material.dart';
import 'package:pethouse/utils/styles.dart';

AppBar CustomAppBar(String name) {
  return AppBar(
    centerTitle: true,
    backgroundColor: kWhite,
    leading: Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        child: Container(
          height: 32,
          width: 32,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(500),
          ),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
    ),
    title: Text(
      name,
      style: TextStyle(
        color: kDarkBrown,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
    actions: [
      Container(
        height: 57,
        decoration: BoxDecoration(
          color: kWhite,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 3,
                offset: const Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [],
        ),
      ),
    ],
  );
}

import 'package:flutter/material.dart';

///styles used in the app
TextStyle kTempTextStyle = const TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 60.0,
);
TextStyle kMessageTextStyle = const TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 40.0,
);
TextStyle kButtonTextStyle = TextStyle(
    fontSize: 30.0, fontFamily: 'Spartan MB', color: Colors.pink.shade900);
TextStyle kConditionTextStyle = const TextStyle(
  fontSize: 80.0,
);
InputDecoration textFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.pink.shade50,
  hintText: 'Enter City name',
  hintStyle: const TextStyle(color: Colors.black),
  border: const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide.none,
  ),
);

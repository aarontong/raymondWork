import 'package:flutter/material.dart';

class genderField extends StatefulWidget {
  static String gender = "M";
  @override
  State<genderField> createState() => genderFieldState();
}

class genderFieldState extends State<genderField> {
  int _value = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('Gender:'),
            Expanded(
              child: ListTile(
                title: Text('M'),
                leading: Radio(
                  value: 1,
                  groupValue: _value,
                  activeColor: Color(0xFF6200EE),
                  onChanged: (value) {
                    valueChanged(value as int);
                  },
                ),
              ),
              flex: 1,
            ),
            Expanded(
              child: ListTile(
                title: Text('F'),
                leading: Radio(
                  value: 2,
                  groupValue: _value,
                  activeColor: Color(0xFF6200EE),
                  onChanged: (value) {
                    valueChanged(value as int);
                  },
                ),
              ),
              flex: 1,
            )
          ],
        )
      ],
      mainAxisAlignment: MainAxisAlignment.start,
    );
  }

  void valueChanged(int value) {
    setState(() {
      _value = value;
      if (value == 1) {
        genderField.gender = "M";
      } else if (value == 2) {
        genderField.gender = "F";
      }
    });
  }
}

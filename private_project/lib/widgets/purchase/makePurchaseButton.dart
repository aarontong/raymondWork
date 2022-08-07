import 'package:flutter/material.dart';

class makePurchaseButton extends StatelessWidget {
  final Function pressedButton;
  const makePurchaseButton({Key? key, required this.pressedButton})
      : super(key: key);

  @override
  Widget build(Object context) {
    // TODO: implement build
    return SizedBox(
      width: 150.0,
      height: 30.0,
      child: DecoratedBox(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.red,
              width: 5,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.red),
        child: TextButton(
            onPressed: () {
              pressedButton();
            },
            child: Text("Make Purchase")),
      ),
    );
  }
}

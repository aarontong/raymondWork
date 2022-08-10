import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class purchaseConfirmDialog{
  factory purchaseConfirmDialog() => _shared;
  static final purchaseConfirmDialog _shared = purchaseConfirmDialog._sharedInstance();
  purchaseConfirmDialog._sharedInstance();
  var overlay = OverlayEntry(builder: (context){
    return Material(
      color: Colors.black.withAlpha(28),
      child: Center(child: Text("hello"),),
    );
  });

  void showOverlay({required BuildContext context}){
    var state = Overlay.of(context);
    state?.insert(overlay);
  }
}
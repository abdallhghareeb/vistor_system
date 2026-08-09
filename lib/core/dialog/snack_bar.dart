import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import '../constants/constants.dart';

void showToast(String text, {Color? color, String? title,bool isSnack = false,Map? action}) {

  if(isSnack){
    ScaffoldMessenger.of(Constants.globalContext()).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: const Duration(seconds: 2),
        action: action==null?null:SnackBarAction(
          label: action['text'],
          onPressed: () {
            action['onTap']();
          },
        ),
      ),
    );
  }else{
    toastification.show(
      context: Constants.globalContext(), // optional if you use ToastificationWrapper
      // title: Text(text),
      description: Text(text.replaceAll('\n', "\n----------------------------\n"),
        style: TextStyle(color: Colors.black, fontSize: 14).copyWith(height: 1.2),),
      autoCloseDuration: const Duration(seconds: 3),
      type: ToastificationType.error,
    );
  }

}

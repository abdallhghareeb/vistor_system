import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class RegisterModel extends Equatable {
  String key;
  String label;
  Widget? suffix;
  TextEditingController controller;
  String? image;
  String? hint;
  bool? next, obscureText;
  TextInputType? keyboard;
  Function(String? val)? validation;

  RegisterModel(
      {required this.key,
      this.suffix,
      required this.label,
      this.hint,
      this.next,
      this.keyboard,
      required this.controller,
      this.image,
      this.obscureText,
      this.validation});

  @override
  List<Object?> get props => [
        key,
        label,
        suffix,
        controller,
        image,
        hint,
        next,
        keyboard,
        obscureText,
        validation
      ];
}

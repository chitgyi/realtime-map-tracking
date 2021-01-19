import 'package:flutter/material.dart';

class LocationTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool enabled;
  final Function onTap;
  LocationTextField({
    this.onTap,
    this.hintText = '',
    this.inputType,
    this.controller,
    this.enabled = true,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(
              offset: Offset(3, 3),
              blurRadius: 6,
              spreadRadius: 2,
              color: Colors.black.withOpacity(0.05),
            )
          ],
        ),
        child: TextField(
          enabled: enabled,
          controller: controller,
          decoration: InputDecoration.collapsed(hintText: hintText),
          keyboardType: inputType,
        ),
      ),
    );
  }
}

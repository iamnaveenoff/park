import 'package:flutter/material.dart';

class ExpTextBox extends StatefulWidget {
  final String text;
  final Color borderColour;
  final Color iconColour;
  final Color hintTextColour;
  final Color textColour;
  final IconData icons;
  final TextEditingController controller;
  final FormFieldValidator<String> validate;
  VoidCallback? onTap;
  ExpTextBox({
    Key? key,
    this.onTap,
    required this.text,
    required this.borderColour,
    required this.iconColour,
    required this.hintTextColour,
    required this.textColour,
    required this.controller,
    required this.icons,
    required this.validate,
  }) : super(key: key);

  @override
  State<ExpTextBox> createState() => _ExpTextBoxState();
}

class _ExpTextBoxState extends State<ExpTextBox> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validate,
      style: TextStyle(color: widget.textColour),
      maxLines: 1,
      onTap: widget.onTap,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: widget.borderColour,
          ),
        ),
        hintStyle: TextStyle(color: widget.hintTextColour),
        hintText: widget.text,
        prefixIcon: Icon(widget.icons, color: widget.iconColour),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

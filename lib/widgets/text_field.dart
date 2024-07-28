import 'package:flutter/material.dart';
class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({super.key, this.onChanged, required this.text,this.obscureText=false});
  final String text;
  bool ?obscureText;
  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText:obscureText! ,
      validator: (data) {
        if (data!.isEmpty) {
          return 'field is required';
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: text,
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }
}

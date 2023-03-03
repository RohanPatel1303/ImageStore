import 'package:flutter/material.dart';

class Dropdownwidget extends StatefulWidget {
  const Dropdownwidget({
    required this.itemList,
    this.hint="Default Value",
    required this.onselect,

  });
  final List<String> itemList;
  final String? hint;
  final Function onselect;

  @override
  State<Dropdownwidget> createState() => _DropdownwidgetState();
}

class _DropdownwidgetState extends State<Dropdownwidget> {
  @override
  Widget build(BuildContext context) {
    return  DropdownButtonFormField<String>(
        icon: Icon(Icons.keyboard_arrow_down),
        borderRadius: BorderRadius.circular(20),
        hint: Text(widget.hint!),
        isExpanded: false,
        elevation: 20,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
        items: widget.itemList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem(
            child: Text(value),
            value: value,
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            widget.onselect(value!);
            var defaultvalue = value;
          });
        });
  }
}

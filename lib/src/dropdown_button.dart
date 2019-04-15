import 'package:flutter/material.dart';
import 'colors.dart';

class MyDropDownButton extends StatefulWidget {
  final List<String> items;
  final Function filter;

  MyDropDownButton({this.items, this.filter});

  @override
  _MyDropDownButtonState createState() => _MyDropDownButtonState();
}

class _MyDropDownButtonState extends State<MyDropDownButton> {
  List<DropdownMenuItem> dropDownMenuItems;
  Value currentItem;

  @override
  void initState() {
    super.initState();
    dropDownMenuItems = createDropDownMenuItems(widget.items);
    currentItem = Value(value: widget.items[0]);
  }

  void onChanged(dynamic newValue) {
    setState(() {
      currentItem = Value(value: newValue);
    });
    widget.filter(newValue);
  }

  @override
  Widget build(BuildContext context) {
    return getButton(currentItem.value, dropDownMenuItems, onChanged);
  }

  Widget getButton(String currentValue, List<DropdownMenuItem> items, ValueChanged<dynamic> onChanged) {
    return Container(
      decoration: BoxDecoration(
        color: cranePurple700,
        borderRadius: BorderRadiusDirectional.circular(5.0),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: cranePurple700,
            brightness: Brightness.dark
        ),
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton(
              value: currentValue,
              items: items,
              onChanged: onChanged,
            ),
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem> createDropDownMenuItems(List<String> values) {
    List<DropdownMenuItem> items = <DropdownMenuItem>[];
    for(String value in values) {
      items.add(DropdownMenuItem(
        value: value,
        child: Container(
          child: Text(
            value,
            softWrap: true,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ));
    }
    return items;
  }
}

class Value {
  final value;
  Value({this.value});
}
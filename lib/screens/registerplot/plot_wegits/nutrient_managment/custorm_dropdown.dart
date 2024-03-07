import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String? selectedValue;
  final Function(String?) onChanged;

  CustomDropdown({required this.items, required this.selectedValue, required this.onChanged});

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  bool isDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isDropdownOpen = !isDropdownOpen;
            });
          },
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.selectedValue ?? 'Select an item'),
                Icon(isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        if (isDropdownOpen)
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: widget.items
                  .map(
                    (item) => GestureDetector(
                      onTap: () {
                        setState(() {
                          isDropdownOpen = false;
                        });
                        widget.onChanged(item);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        color: widget.selectedValue == item ? Colors.blue : null,
                        child: Text(item),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:posilkiapp/Model/ApiClasses.dart';

class CustomDropdownMenu extends StatefulWidget {
  final List<ActivGroup> list;
  final Function(ActivGroup selected)? onSelected;

  const CustomDropdownMenu({Key? key, required this.list, this.onSelected})
    : super(key: key);

  @override
  State<CustomDropdownMenu> createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    final menuEntries =
        widget.list
            .where((a) => a.name != null)
            .map(
              (allergen) => DropdownMenuEntry<String>(
                value: allergen.name!,
                label: allergen.name!,
              ),
            )
            .toList();

    return DropdownMenu<String>(
      initialSelection: dropdownValue,
      onSelected: (String? value) {
        if (value != null) {
          setState(() {
            dropdownValue = value;
          });

          final selected = widget.list.firstWhere(
            (element) => element.name == value,
          );
          print(selected.Id);

          if (widget.onSelected != null) {
            widget.onSelected!(selected);
          }
        }
      },
      dropdownMenuEntries: menuEntries,
    );
  }
}

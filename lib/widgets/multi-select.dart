import 'package:flutter/material.dart';
import 'package:superwoman/model/project.dart';

class MultiSelect extends StatefulWidget {
  final List<Project> items;
  const MultiSelect({Key? key, required this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  final List<Project> _selectedItems = [];

  void _itemChange(Project itemValue, bool? isSelected) {
    setState(() {
      if (isSelected != null) {
        if (isSelected) {
          _selectedItems.add(itemValue);
        } else {
          _selectedItems.remove(itemValue);
        }
      }
    });
  }

  void _cancel() {
    Navigator.pop(context);
  }

  void _submit() {
    Navigator.pop(context, _selectedItems);
  }

  void _all() {
    Navigator.pop(context, widget.items);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text('Select'),
          ElevatedButton(
            child: const Text(
              'All',
              style: TextStyle(fontSize: 12),
            ),
            onPressed: _all,
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => CheckboxListTile(
                    value: _selectedItems.contains(item),
                    title: Text(item.name ?? ""),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isChecked) => _itemChange(item, isChecked),
                  ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          child: const Text(
            'Cancel',
          ),
          onPressed: _cancel,
        ),
        ElevatedButton(
          child: const Text('Acept'),
          onPressed: _submit,
        ),
      ],
    );
  }
}

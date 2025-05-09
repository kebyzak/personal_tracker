import 'package:flutter/material.dart';

class AddHabitDialog extends StatefulWidget {
  const AddHabitDialog({super.key});

  @override
  State<AddHabitDialog> createState() => _AddHabitDialogState();
}

class _AddHabitDialogState extends State<AddHabitDialog> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  String _emoji = '';
  final List<int> _daysOfWeek = [];
  DateTime? _startDate;

  final List<String> _weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Habit'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                onSaved: (value) => _title = value ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (value) => _description = value ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Emoji'),
                onSaved: (value) => _emoji = value ?? '',
                maxLength: 2,
              ),
              const SizedBox(height: 8),
              const Text('Repeat on days:'),
              Wrap(
                spacing: 4,
                children: List.generate(7, (i) => FilterChip(
                  label: Text(_weekdays[i]),
                  selected: _daysOfWeek.contains(i),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _daysOfWeek.add(i);
                      } else {
                        _daysOfWeek.remove(i);
                      }
                    });
                  },
                )),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() {
                      _startDate = picked;
                    });
                  }
                },
                child: Text(_startDate == null ? 'Pick Start Date' : _startDate!.toLocal().toString().split(' ')[0]),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              _formKey.currentState?.save();
              Navigator.of(context).pop({
                'title': _title,
                'description': _description,
                'emoji': _emoji,
                'daysOfWeek': _daysOfWeek,
                'startDate': _startDate ?? DateTime.now(),
              });
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
} 

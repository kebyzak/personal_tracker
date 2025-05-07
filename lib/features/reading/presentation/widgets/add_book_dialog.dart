import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_tracker/features/reading/presentation/bloc/reading_bloc.dart';
import 'package:personal_tracker/features/reading/presentation/bloc/reading_event.dart';
import 'package:personal_tracker/features/reading/domain/entities/book.dart';

class AddBookDialog extends StatefulWidget {
  const AddBookDialog({super.key});

  @override
  State<AddBookDialog> createState() => _AddBookDialogState();
}

class _AddBookDialogState extends State<AddBookDialog> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _author = '';
  String _categories = '';
  String _status = 'to_read';
  int _totalPages = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Book'),
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
                decoration: const InputDecoration(labelText: 'Author'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                onSaved: (value) => _author = value ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Categories (comma separated)'),
                onSaved: (value) => _categories = value ?? '',
              ),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: const InputDecoration(labelText: 'Status'),
                items: const [
                  DropdownMenuItem(value: 'to_read', child: Text('To Read')),
                  DropdownMenuItem(value: 'reading', child: Text('Reading')),
                  DropdownMenuItem(value: 'completed', child: Text('Completed')),
                  DropdownMenuItem(value: 'abandoned', child: Text('Abandoned')),
                ],
                onChanged: (value) => setState(() => _status = value ?? 'to_read'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Total Pages'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _totalPages = int.tryParse(value ?? '') ?? 0,
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
              final book = Book(
                title: _title,
                author: _author,
                categories: _categories.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
                status: _status,
                currentPage: 0,
                totalPages: _totalPages,
                rating: 0.0,
              );
              context.read<ReadingBloc>().add(
                AddBookEvent(book),
              );
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
} 

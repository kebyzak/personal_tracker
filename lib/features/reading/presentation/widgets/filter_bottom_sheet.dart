import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/reading_bloc.dart';
import '../bloc/reading_event.dart';
import '../bloc/reading_state.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String? _selectedStatus;
  String? _selectedCategory;
  String? _selectedAuthor;
  
  final List<String> _statuses = ['to_read', 'reading', 'completed', 'abandoned'];
  late List<String> _categories;
  late List<String> _authors;

  @override
  void initState() {
    super.initState();
    _categories = [];
    _authors = [];
    _loadFilterData();
  }

  void _loadFilterData() {
    final state = context.read<ReadingBloc>().state;
    if (state is ReadingLoaded) {
      final books = state.books;
      
      // Get unique categories
      final allCategories = books.expand((book) => book.categories).toSet().toList();
      allCategories.sort();
      _categories = allCategories;
      
      // Get unique authors
      final allAuthors = books.map((book) => book.author).toSet().toList();
      allAuthors.sort();
      _authors = allAuthors;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filter Books',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Status',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: _statuses.map((status) {
              final isSelected = _selectedStatus == status;
              return FilterChip(
                label: Text(_getStatusLabel(status)),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _selectedStatus = selected ? status : null;
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Category',
              border: OutlineInputBorder(),
            ),
            value: _selectedCategory,
            items: [
              const DropdownMenuItem<String>(
                value: null,
                child: Text('All Categories'),
              ),
              ..._categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }),
            ],
            onChanged: (value) {
              setState(() {
                _selectedCategory = value;
              });
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Author',
              border: OutlineInputBorder(),
            ),
            value: _selectedAuthor,
            items: [
              const DropdownMenuItem<String>(
                value: null,
                child: Text('All Authors'),
              ),
              ..._authors.map((author) {
                return DropdownMenuItem<String>(
                  value: author,
                  child: Text(author),
                );
              }),
            ],
            onChanged: (value) {
              setState(() {
                _selectedAuthor = value;
              });
            },
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedStatus = null;
                    _selectedCategory = null;
                    _selectedAuthor = null;
                  });
                },
                child: const Text('Clear All'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  context.read<ReadingBloc>().add(
                    FilterBooksEvent(
                      status: _selectedStatus,
                      category: _selectedCategory,
                      author: _selectedAuthor,
                    ),
                  );
                  Navigator.pop(context);
                },
                child: const Text('Apply Filters'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'to_read':
        return 'To Read';
      case 'reading':
        return 'Reading';
      case 'completed':
        return 'Completed';
      case 'abandoned':
        return 'Abandoned';
      default:
        return status;
    }
  }
} 

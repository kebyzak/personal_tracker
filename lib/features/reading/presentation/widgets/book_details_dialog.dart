import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_tracker/features/reading/domain/entities/book.dart';
import 'package:personal_tracker/features/reading/presentation/bloc/reading_bloc.dart';
import 'package:personal_tracker/features/reading/presentation/bloc/reading_event.dart';
import 'dart:io';

class BookDetailsDialog extends StatefulWidget {
  final Book book;
  
  const BookDetailsDialog({
    super.key,
    required this.book,
  });

  @override
  State<BookDetailsDialog> createState() => _BookDetailsDialogState();
}

class _BookDetailsDialogState extends State<BookDetailsDialog> {
  late int _currentPage;
  late String _status;
  late double _rating;
  late TextEditingController _reviewController;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.book.currentPage;
    _status = widget.book.status;
    _rating = widget.book.rating;
    _reviewController = TextEditingController(text: widget.book.review);
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  void _updateProgress() {
    final updatedBook = Book(
      id: widget.book.id,
      title: widget.book.title,
      author: widget.book.author,
      coverImage: widget.book.coverImage,
      categories: widget.book.categories,
      status: _status,
      currentPage: _currentPage,
      totalPages: widget.book.totalPages,
      rating: _rating,
      review: _reviewController.text,
    );

    context.read<ReadingBloc>().add(UpdateBookEvent(updatedBook));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.book.title),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.book.coverImage != null)
              Center(
                child: Image.file(
                  File(widget.book.coverImage!),
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 16),
            Text('Author: ${widget.book.author}'),
            const SizedBox(height: 8),
            Text('Categories: ${widget.book.categories.join(", ")}'),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Status: '),
                DropdownButton<String>(
                  value: _status,
                  items: const [
                    DropdownMenuItem(value: 'to_read', child: Text('To Read')),
                    DropdownMenuItem(value: 'reading', child: Text('Reading')),
                    DropdownMenuItem(value: 'completed', child: Text('Completed')),
                    DropdownMenuItem(value: 'abandoned', child: Text('Abandoned')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _status = value);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Progress: '),
                Expanded(
                  child: Slider(
                    value: _currentPage.toDouble(),
                    min: 0,
                    max: widget.book.totalPages.toDouble(),
                    divisions: widget.book.totalPages,
                    label: _currentPage.toString(),
                    onChanged: (value) {
                      setState(() => _currentPage = value.toInt());
                    },
                  ),
                ),
                Text('$_currentPage/${widget.book.totalPages}'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Rating: '),
                Expanded(
                  child: Slider(
                    value: _rating,
                    min: 0,
                    max: 5,
                    divisions: 10,
                    label: _rating.toString(),
                    onChanged: (value) {
                      setState(() => _rating = value);
                    },
                  ),
                ),
                Text(_rating.toStringAsFixed(1)),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _reviewController,
              decoration: const InputDecoration(
                labelText: 'Review',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _updateProgress,
          child: const Text('Save Progress'),
        ),
      ],
    );
  }
} 

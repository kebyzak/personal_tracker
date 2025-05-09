import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
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
  String? _coverImagePath;

  Future<bool> _requestPermissions() async {
    if (Platform.isAndroid) {
      if (await Permission.photos.status.isDenied) {
        final status = await Permission.photos.request();
        if (!status.isGranted) {
          return false;
        }
      }
    } else if (Platform.isIOS) {
      if (await Permission.photos.status.isDenied) {
        final status = await Permission.photos.request();
        if (!status.isGranted) {
          return false;
        }
      }
    }
    return true;
  }

  Future<void> _pickImage() async {
    try {
      final hasPermission = await _requestPermissions();
      if (!hasPermission) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Permission to access photos is required'),
              duration: Duration(seconds: 2),
            ),
          );
        }
        return;
      }

      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 1200,
        imageQuality: 85,
      );
      
      if (image != null) {
        // Get the application documents directory
        final appDir = await getApplicationDocumentsDirectory();
        final fileName = 'book_cover_${DateTime.now().millisecondsSinceEpoch}${p.extension(image.path)}';
        final savedImage = File(p.join(appDir.path, fileName));
        
        // Copy the image to app directory
        await File(image.path).copy(savedImage.path);
        
        if (mounted) {
          setState(() {
            _coverImagePath = savedImage.path;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking image: $e'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

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
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: 120,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    image: _coverImagePath != null
                        ? DecorationImage(
                            image: FileImage(File(_coverImagePath!)),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _coverImagePath == null
                      ? const Icon(Icons.add_photo_alternate, size: 40)
                      : null,
                ),
              ),
              const SizedBox(height: 16),
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
                coverImage: _coverImagePath,
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/book.dart';
import '../bloc/reading_bloc.dart';
import '../bloc/reading_event.dart';
import '../bloc/reading_state.dart';
import '../widgets/add_book_dialog.dart';

class ReadingPage extends StatelessWidget {
  const ReadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ReadingPageView();
  }
}

class _ReadingPageView extends StatelessWidget {
  const _ReadingPageView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reading Tracker'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search books...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (query) {
                      context.read<ReadingBloc>().add(SearchBooksEvent(query));
                    },
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  tooltip: 'Filter',
                  onPressed: () {
                    // TODO: Show filter bottom sheet
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<ReadingBloc, ReadingState>(
              builder: (context, state) {
                if (state is ReadingLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ReadingLoaded) {
                  if (state.books.isEmpty) {
                    return const Center(child: Text('No books found.'));
                  }
                  return ListView.builder(
                    itemCount: state.books.length,
                    itemBuilder: (context, index) {
                      final book = state.books[index];
                      return BookCard(book: book);
                    },
                  );
                } else if (state is ReadingError) {
                  return Center(child: Text('Error: ${state.message}'));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddBookDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final Book book;
  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: book.coverImage != null && book.coverImage!.isNotEmpty
            ? Image.network(book.coverImage!, width: 48, height: 72, fit: BoxFit.cover)
            : Container(width: 48, height: 72, color: Colors.grey[300]),
        title: Text(book.title),
        subtitle: Text(book.author),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(book.status),
            Text('${book.currentPage}/${book.totalPages}'),
          ],
        ),
        onTap: () {
          // TODO: Show book details
        },
      ),
    );
  }
} 

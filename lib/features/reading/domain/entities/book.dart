class Book {
  final int? id;
  final String title;
  final String author;
  final String? coverImage;
  final List<String> categories;
  final String status; // 'to_read', 'reading', 'completed', 'abandoned'
  final int currentPage;
  final int totalPages;
  final double rating;
  final String? review;

  Book({
    this.id,
    required this.title,
    required this.author,
    this.coverImage,
    required this.categories,
    required this.status,
    required this.currentPage,
    required this.totalPages,
    required this.rating,
    this.review,
  });
} 

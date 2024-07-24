import 'package:news_app/article_section.dart';
import 'package:news_app/books_section.dart';
import 'package:news_app/globles.dart';

class BottomNavItemClickedEvent {
  final Section section;
  BottomNavItemClickedEvent(this.section);
}

class TopStoriesLoadedEvent {
  final List<Article> stories;
  TopStoriesLoadedEvent(this.stories);
}

class BookNamesListLoadedEvent {
  final List<BookListItem> bookNamesList;
  BookNamesListLoadedEvent(this.bookNamesList);
}

class BooksLoadedEvent {
  final List<Book> bookList;
  BooksLoadedEvent(this.bookList);
}

class BookListItemClicked {
  final String category;
  BookListItemClicked(this.category);
}
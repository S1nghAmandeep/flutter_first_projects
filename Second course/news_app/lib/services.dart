import 'dart:convert';

import 'package:http/http.dart';
import 'package:news_app/article_section.dart';
import 'package:news_app/books_section.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/events.dart';
import 'package:news_app/globles.dart';

List<Article> cachedArticles = [];
List<BookListItem> cachedBookListItems = [];
dynamic cachedBooks;

Future<Response> getTopArticles() {
  return get(Uri.parse(topStoriesEndPoint));
}

List<Article> getArticles() {
  if (cachedArticles.isEmpty) {
    int maxNumberOfArticles = 4;
    int currentNumberOfArticles = 0;
    getTopArticles().then((value) {
      dynamic json = jsonDecode(value.body);
      List<Article> articles = [];
      for (var element in json[results]) {
        if (currentNumberOfArticles < maxNumberOfArticles &&
            element[title] != "") {
          String articleTitle = element[title];
          String articleSection = element[section];
          String articleByline = element[byline];
          String articleAbstract = element[abstract];
          String articlePublishedDate = element[publishedDate];
          String articleImageURl = element[multimedia][0][url];
          Article article = Article(articleTitle, articleSection, articleByline,
              articleAbstract, articlePublishedDate, articleImageURl);
          articles.add(article);
          cachedArticles.add(article);
          currentNumberOfArticles++;
        }
      }
      eventBus.fire(TopStoriesLoadedEvent(articles));
      return articles;
    });
  }
  return cachedArticles;
}

Future<Response> getBookListNames() {
  return get(Uri.parse(bookListNamesEndpoint));
}

Future<Response> getTop5BooksInEachList() {
  return get(Uri.parse(top5BoksInLotisEndpoint));
}

List<BookListItem> getListItem() {
  if (cachedBookListItems.isEmpty) {
    getBookListNames().then((value) {
      dynamic json = jsonDecode(value.body);
      List<BookListItem> bookListItems = [];
      for (var element in json[results]) {
        String category = element[listName];
        BookListItem bookListItem = BookListItem(
          category: category,
          height: listItemHeight,
          textSize: listItemFontSize,
        );
        bookListItems.add(bookListItem);
        cachedBookListItems.add(bookListItem);
      }
      eventBus.fire(BookNamesListLoadedEvent(bookListItems));
      return bookListItems;
    });
  }
  return cachedBookListItems;
}

void getBooksResponse(String requestedCategory) {
  getTop5BooksInEachList().then((value) {
    dynamic json = jsonDecode(value.body);
    cachedBooks = json;
    List<Book> books = [];
    dynamic result = json[results];
    for (var element in result[lists]) {
      String category = element[listName] ?? "";
      if (category.contains(requestedCategory)) {
        List<dynamic> categoryBooks = element["books"];
        for (var bookJSON in categoryBooks) {
          String bookTitle = bookJSON[title];
          String bookAuthor = bookJSON[author];
          String bookImage = bookJSON[image];
          Book categoryBook = Book(bookTitle, bookAuthor, bookImage);
          books.add(categoryBook);
        }
      }
    }
    eventBus.fire(BooksLoadedEvent(books));
    return books;
  });
}

List<Book> getBooks(String requestedCategory) {
  dynamic json;
  if (cachedBooks == null) {
    getBooksResponse(requestedCategory);
  } else {
    List<Book> books = [];
    dynamic result = json[results];
    for (var element in result[lists]) {
      String category = element[listName] ?? "";
      if (category.contains(requestedCategory)) {
        List<dynamic> cateogryBooks = element["books"];
        for (var bookJSON in cateogryBooks) {
          String bookTitle = bookJSON[title];
          String bookAuthor = bookJSON[author];
          String bookImage = bookJSON[image];
          Book categoryBook = Book(bookTitle, bookAuthor, bookImage);
          books.add(categoryBook);
        }
      }
    }
    eventBus.fire(BooksLoadedEvent(books));
    return books;
  }
  return [];
}
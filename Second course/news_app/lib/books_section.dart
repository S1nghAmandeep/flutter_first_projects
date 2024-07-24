import 'package:flutter/material.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/events.dart';
import 'package:news_app/globles.dart';
import 'package:news_app/services.dart';
import 'package:news_app/top_app_bar.dart';

class Book {
  Book(this.title, this.author, this.image);

  String title = "";
  String author = "";
  String image = "";
}

class BookUI extends StatefulWidget {
  const BookUI({
    super.key,
    required this.widget,
    required this.height,
    required this.title,
    required this.author,
    required this.image,
  });

  final double widget;
  final double height;
  final String title;
  final String author;
  final String image;

  @override
  State<BookUI> createState() => _BookUIState();
}

class _BookUIState extends State<BookUI> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.widget,
      height: widget.height,
      child: Column(
        children: [
          Image.network(
            widget.image,
            height: 180,
            width: 130,
          ),
          const SizedBox(height: 10),
          Text(
            widget.title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.author,
            style: const TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class BookListItem extends StatefulWidget {
  const BookListItem({
    super.key,
    required this.category,
    required this.height,
    required this.textSize,
  });

  final String category;
  final double height;
  final double textSize;

  @override
  State<BookListItem> createState() => _BookListItemState();
}

class _BookListItemState extends State<BookListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        width: double.infinity,
        height: widget.height,
        child: Container(
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(5.0),
          color: Colors.white,
          child: Row(
            children: [
              const SizedBox(
                width: 50,
              ),
              Image.asset(
                stackOfBooksImage,
                width: 75,
                height: 75,
              ),
              Text(
                widget.category.isNotEmpty ? widget.category : "",
                style: TextStyle(
                  fontSize: widget.textSize,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        eventBus.fire(BookListItemClicked(widget.category));
      },
    );
  }
}

class BookListDetails extends StatefulWidget {
  const BookListDetails({super.key, required this.category});

  final String category;

  @override
  State<BookListDetails> createState() => _BookListDetailsState();
}

class _BookListDetailsState extends State<BookListDetails> {
  List<Book> booksInCategory = [];
  var subscription;

  @override
  void initState() {
    super.initState();
    booksInCategory = getBooks(widget.category);
    subscription = eventBus.on<BooksLoadedEvent>().listen((event) { 
      setState(() {
        booksInCategory = event.bookList;
      });
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    subscription = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const TopNavBar(),
      bottomNavigationBar: const BottomAppBar(),
      body: Column(children: [
        const SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            widget.category,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 30,),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            booksInCategory.isNotEmpty ? BookUI(widget: 150, height: 300, title: booksInCategory[0].title, author: booksInCategory[0].author, image: booksInCategory[0].image,) : const SizedBox(width: 150, height: 300, child: Placeholder(),),
            booksInCategory.isNotEmpty ? BookUI(widget: 150, height: 300, title: booksInCategory[1].title, author: booksInCategory[1].author, image: booksInCategory[1].image,) : const SizedBox(width: 150, height: 300, child: Placeholder(),),
            booksInCategory.isNotEmpty ? BookUI(widget: 150, height: 300, title: booksInCategory[2].title, author: booksInCategory[2].author, image: booksInCategory[2].image,) : const SizedBox(width: 150, height: 300, child: Placeholder(),),
            booksInCategory.isNotEmpty ? BookUI(widget: 150, height: 300, title: booksInCategory[3].title, author: booksInCategory[3].author, image: booksInCategory[3].image,) : const SizedBox(width: 150, height: 300, child: Placeholder(),),
            booksInCategory.isNotEmpty ? BookUI(widget: 150, height: 300, title: booksInCategory[4].title, author: booksInCategory[4].author, image: booksInCategory[4].image,) : const SizedBox(width: 150, height: 300, child: Placeholder(),),
          ],
        ),
      ],),
    );
  }
}

class BooksSection extends StatefulWidget {
  const BooksSection({super.key});

  @override
  State<BooksSection> createState() => _BooksSectionState();
}

class _BooksSectionState extends State<BooksSection> {
  List<BookListItem> bookCategory = [];

  var eventHandler1;
  var eventHandler2;

  @override
  void initState() {
    super.initState();
    bookCategory = getListNames();
    eventHandler1 = eventBus.on<BookNamesListLoadedEvent>().listen((event) {
      setState(() {
        bookCategory = event.bookNamesList;
      });
    });
    eventHandler2 = eventBus.on<BookListItemClicked>().listen((event) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => BookListDetails(category: event.category)));
    });
  }

  @override
  void dispose() {
    eventHandler1.cancel();
    eventHandler1 = null;
    eventHandler2.cancel();
    eventHandler2 = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: bookCategory,
    );
  }
}
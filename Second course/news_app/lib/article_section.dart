import 'package:flutter/material.dart';
import 'package:news_app/events.dart';
import 'package:news_app/globles.dart';
import 'package:news_app/services.dart';

class Article {
  Article(this.title, this.section, this.byline, this.abstract,
      this.publishedDate, this.imageURL);

  String title = "";
  String section = "";
  String byline = "";
  String abstract = "";
  String publishedDate = "";
  String imageURL = "";
}

class ArticleUI extends StatefulWidget {
  const ArticleUI({
    super.key,
    required this.width,
    required this.height,
    required this.title,
    required this.byline,
    required this.description,
    required this.publishedDate,
    required this.titleTextSize,
    required this.bylineTextSize,
    required this.descriptionTextSize,
    required this.publishedDateTextSize,
    required this.color,
    required this.content,
  });

  final double width;
  final double height;
  final String title;
  final String byline;
  final String description;
  final String publishedDate;
  final double titleTextSize;
  final double bylineTextSize;
  final double descriptionTextSize;
  final double publishedDateTextSize;
  final Color color;
  final List<dynamic> content;

  @override
  State<ArticleUI> createState() => _ArticleUIState();
}

class _ArticleUIState extends State<ArticleUI> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Container(
        color: widget.color,
        child: Wrap(
          children: [
            Text(
              widget.content.isNotEmpty ? widget.title : "",
              style: TextStyle(
                fontSize: widget.titleTextSize,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              widget.content.isNotEmpty ? widget.byline : "",
              style: TextStyle(
                fontSize: widget.bylineTextSize,
                fontStyle: FontStyle.italic,
              ),
            ),
            Text(
              widget.content.isNotEmpty ? widget.description : "",
              style: TextStyle(
                fontSize: widget.descriptionTextSize,
                fontStyle: FontStyle.italic,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                widget.content.isNotEmpty ? "\n${widget.publishedDate} " : "",
                style: TextStyle(
                  fontSize: widget.publishedDateTextSize,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopStoriesSection extends StatefulWidget {
  const TopStoriesSection({super.key});

  @override
  State<TopStoriesSection> createState() => _TopStoriesSectionState();
}

class _TopStoriesSectionState extends State<TopStoriesSection> {
  List<Article> topstories = [];
  var subscription;

  @override
  void initState() {
    super.initState();
    topstories = getArticles();
    subscription = eventBus.on<TopStoriesLoadedEvent>().listen((event) {
      setState(() {
        topstories = event.stories;
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
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 330,
              height: 200,
              child: topstories.isNotEmpty
                  ? Image.network(topstories[0].imageURL)
                  : const Placeholder(),
            ),
            ArticleUI(
              width: 460,
              height: 200,
              title: topstories.isNotEmpty ? topstories[0].title : "",
              byline: topstories.isNotEmpty ? topstories[0].byline : "",
              description: topstories.isNotEmpty ? topstories[0].abstract : "",
              publishedDate:
                  topstories.isNotEmpty ? topstories[0].publishedDate : "",
              titleTextSize: 25,
              bylineTextSize: 14,
              descriptionTextSize: 14,
              publishedDateTextSize: 14,
              color: Colors.white,
              content: topstories,
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const SizedBox(
              width: 15,
            ),
            ArticleUI(
              width: 230,
              height: 140,
              title: topstories.isNotEmpty ? topstories[1].title : "",
              byline: topstories.isNotEmpty ? topstories[1].byline : "",
              description: "",
              publishedDate:
                  topstories.isNotEmpty ? topstories[1].publishedDate : "",
              titleTextSize: 16,
              bylineTextSize: 12,
              descriptionTextSize: 0,
              publishedDateTextSize: 10,
              color: Colors.white,
              content: topstories,
            ),
            const SizedBox(
              width: 15,
            ),
            ArticleUI(
              width: 230,
              height: 140,
              title: topstories.isNotEmpty ? topstories[2].title : "",
              byline: topstories.isNotEmpty ? topstories[2].byline : "",
              description: "",
              publishedDate:
                  topstories.isNotEmpty ? topstories[2].publishedDate : "",
              titleTextSize: 16,
              bylineTextSize: 12,
              descriptionTextSize: 0,
              publishedDateTextSize: 10,
              color: Colors.white,
              content: topstories,
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:html/dom.dart'as dom;
import 'package:html/parser.dart'as parser;
class QuotesPage extends StatefulWidget {
  final String categoriename;
  QuotesPage(this.categoriename);

  @override
  State<QuotesPage> createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  List<String>Categories = ["love", "inspirational", "life", "humour"];
  List quotes = [];
  List authors = [];
  bool isDataThere = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      getquotes();
    });
  }

  getquotes() async {
    String url = "https://quotes.toscrape.com/tag/${widget.categoriename}/";
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    dom.Document document = parser.parse(response.body);
    final quotesclass = document.getElementsByClassName("quote");

    quotes =
        quotesclass.map((element) => element.getElementsByClassName('Text')[0]
            .innerHtml).toList();
    authors =
        quotesclass.map((element) => element.getElementsByClassName('author')[0]
            .innerHtml).toList();
    setState(() {
      isDataThere = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink,
        body:
        SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 60),
                child: Text('Quotes App', style: TextStyle(
                    fontSize: 50, fontWeight: FontWeight.bold)),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: quotes.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Card(
                      color: Colors.white.withOpacity(0.8),
                      elevation: 10,
                      child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 20, bottom: 20),
                              child: Text(quotes[index],
                                style: TextStyle(color: Colors.black,
                                    fontWeight: FontWeight.w700),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 20, bottom: 20),
                              child: Text(authors[index],
                                style: TextStyle(color: Colors.black,
                                    fontWeight: FontWeight.w700),),
                            ),

                          ]
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        )


    );
  }

}
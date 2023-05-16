import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quotes/QuotesPage.dart';
import 'package:http/http.dart'as http;
import 'package:html/dom.dart'as dom;
import 'package:html/parser.dart'as parser;
class quotes extends StatefulWidget {
  const quotes({Key? key}) : super(key: key);

  @override
  State<quotes> createState() => _quotesState();
}

class _quotesState extends State<quotes> {
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
    String url = "https://quotes.toscrape.com/";
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
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 60),
                child: Text('Quotes App', style: TextStyle(
                    fontSize: 50, fontWeight: FontWeight.bold)),
              ),
              GridView.count(crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: Categories.map((Category) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) =>
                            QuotesPage(Category)));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.pinkAccent.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Center(
                          child: Text(
                            Category.toUpperCase(),
                            style: TextStyle(color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  }).toList()),
              SizedBox(
                height: 40,
              ),

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 8,
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
                              child: Text("dgouftgipoioiu ",
                                style: TextStyle(color: Colors.black,
                                    fontWeight: FontWeight.w700),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 20, bottom: 20),
                              child: Text("fghklklkrwretyi ",
                                style: TextStyle(color: Colors.black,
                                    fontWeight: FontWeight.w700),),
                            ),

                          ]
                      ),
                    ),
                  );
                },
              ),
            ]
        ),
      ),
    );
  }

}
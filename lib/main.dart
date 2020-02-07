import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() => runApp(RootWidget());

class RootWidget extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qiita App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomeWidget(),
    );
  }
}

class HomeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListState();
  }
}

class ListState extends State<HomeWidget> {
  TextEditingController editingController = TextEditingController();
  List listItem;

  Future getData(String query) async{
    if (query.isEmpty) {
      query = 'flutter';
    }
    http.Response response = await http.get("https://qiita.com/api/v2/items?page=1&per_page=20&query=" + query);

    this.setState((){
      listItem = json.decode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    this.getData('');
  }

  void filterSearchResults(String query) {
    this.getData(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Qiita App'),),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onSubmitted: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "記事を検索",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                  ),
                ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black38),
                          ),
                        ),
                        child: ListTile(
                            title: Text(listItem[index]["title"]),
                            onTap: () {

                            }
                        ));},
                  itemCount: listItem == null ? 0: listItem.length,
                ),
              ),
          ],
        )
      )
    );
  }
}

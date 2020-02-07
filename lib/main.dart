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
  String query;
  bool isLoading = false;
  String page = "1";
  bool isAdd = false;

  Future getData(String query) async{
    if (this.isLoading) {
      return;
    }
    this.query = query;
    this.isLoading = true;

    http.Response response = await http.get("https://qiita.com/api/v2/items?page=" + this.page + "&per_page=30&query=" + query);

    this.setState((){
      if (this.isAdd) {
        listItem.insertAll(listItem == null ? 0: listItem.length, json.decode(response.body));
      } else {
        listItem = json.decode(response.body);
      }
      this.isLoading = false;
    });
  }

  Future _onRefresh() async{
    print('refresh');
    this.page = "1";
    this.isAdd = false;
    this.getData(this.query);
  }

  @override
  void initState() {
    super.initState();
    this.page = "1";
    this.isAdd = false;
    this.getData('flutter');
  }

  void filterSearchResults(String query) {
    this.page = "1";
    this.isAdd = false;
    this.getData(query);
  }

  void nextPage() {
    int pageInt = int.tryParse(this.page);
    pageInt = pageInt + 1;
    this.page = pageInt.toString();
    this.isAdd = true;
    this.getData(this.query);
  }

  @override
  Widget build(BuildContext context) {
    if (this.isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text("Loading..."),),
        body: Center(
          child: CircularProgressIndicator()
        )
      );
    }
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
                child: new RefreshIndicator(
                    child: new NotificationListener<ScrollNotification>(
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
                        onNotification: (ScrollNotification value){
                          if (value.metrics.extentAfter == 0.0) {
                            print('ScrollEnd');
                            this.nextPage();
                          }
                            return false;
                        },
                    ),
                    onRefresh: _onRefresh
                )
              ),
          ],
        )
      )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(RootWidget());

class RootWidget extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qiita App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
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
  var listItem = ['a1','a2','a3','a4','a5','a6','a7','a8','a9','a10','a11','a12'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Qiita App'),),
      body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black38),
                ),
              ),
              child: ListTile(
                title: Text('$index'),
                subtitle: Text(listItem[index]),
                onTap: () {

                }
            ));},
          itemCount: listItem.length,
      ),
    );
  }
}

